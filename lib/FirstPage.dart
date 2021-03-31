import 'package:flutter/material.dart';
import 'package:notification/navbar.dart';

import 'SecondPage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
 
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Business Crisis Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Business Crisis Management System',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Choice> items = const <Choice>[
    const Choice("Fire", "images/check.jpeg"),
    const Choice("Information Technology", "images/computer.png"),
    const Choice("Cyber Attack", "images/hacker.png"),
    const Choice("Health", "images/heart.png"),
    const Choice("Data Server", "images/server-storage.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color(0xFFBA0167),
        title: Text(widget.title),
      ),
      endDrawer: navbar(),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            items.length,
            (index) => Center(
              child: GestureDetector(
                onTap: () {
                  print(items[index].getName());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(
                        text: items[index].getName(),
                        imglnk: items[index].imglink,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: GridTile(
                    child: new Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(items[index].imglink),
                            fit: BoxFit.scaleDown,
                            scale: 5,
                          ),
                        ),
                      ),
                    ),
                    footer: Center(
                      child: Text(
                        items[index].name,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //
            ),
          ),
        ),
      ),
    );
  }
}

class Choice {
  final String name;
  final String imglink;

  const Choice(this.name, this.imglink);

  String getName() {
    return this.name;
  }
}
