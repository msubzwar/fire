import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'FirstPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for various sign-in flows with Firebase.
class SignInPage extends StatefulWidget {
  /// The page title.
  final String title = 'Sign In & Out';

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _signOut();

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('$uid has successfully signed out.'),
                ));
              },
              child: const Text('Sign out'),
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            _EmailPasswordForm(),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in with email and password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: SignInButton(
                    Buttons.Email,
                    text: 'Sign In',
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _signInWithEmailAndPassword();
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User user) {
                          if (user == null) {
                            print('User is currently signed out!');
                          } else {
                            print('User is signed in!');
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} signed in'),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password'),
        ),
      );
    }
  }
}
