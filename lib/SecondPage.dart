import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification/model/alerts.dart';
import 'package:notification/navbar.dart';


class SecondPage extends StatelessWidget {

  final String text;
  final String imglnk;
  SecondPage({Key key, @required this.text, this.imglnk}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Business Crisis Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActionPage(text: this.text ,title: 'Business Crisis Management System', imglink: imglnk),
    );

  }
}

class ActionPage extends StatefulWidget {
  final String title;
  final String imglink;

  ActionPage({Key key, @required this.text,this.title,this.imglink}) : super(key: key);
  final String text;

  @override
  _ActionPageState createState() => _ActionPageState(this.text,this.imglink);

}
class _ActionPageState extends State<ActionPage> {
  final String text;
  final String imglink;
  int $radio =  1;
  List building=[
    "Al-Sadd",
    "Wakrah",
    "Souq Waqif",
  ];
  String valueChoose = "Al-Sadd";
  String floorChoose = "1";
  _ActionPageState(this.text,this.imglink);

  @override
  void initState()  {
    super.initState();
    print("started");
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
setSelectRadio(int val){
    setState(() {
      $radio = val;
    });
}



  @override
  Widget build(BuildContext context) {
    CollectionReference buildings = FirebaseFirestore.instance.collection("Building");

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFBA0167),
        title: new Center(
          child: Text("Send Alert", textAlign: TextAlign.center,),
      ),
      ),
      endDrawer: navbar(),
      body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/bg.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          //height: 900,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.only(left: 10, right: 10),

            child: Column(
              children: <Widget>[
                Text(
                "Crisis Managment System",
                style: TextStyle(
                  color: Color(0xFFBA1076),
                  fontSize: 40,
                  fontFamily: "Lucida Sans",
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              new Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        "Generate an Alert",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Lucida Sans",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(this.text,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25,bottom: 20,top: 10),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(this.imglink),
                              fit: BoxFit.cover,
                              scale: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            value: 1,
                            groupValue: $radio,
                            onChanged: (value) {
                              print("High is pressed");
                              setSelectRadio(value);
                            }
                        ),
                        Text("High"),
                        Radio(
                            value: 2,
                            groupValue: $radio,
                            onChanged: (value) {
                              print("Medium is pressed");
                              setSelectRadio(value);
                            }
                        ),
                        Text("Medium"),
                        Radio(
                            value: 3,
                            groupValue: $radio,
                            onChanged: (value) {
                              print("Low is pressed");
                              setSelectRadio(value);
                            }
                        ),
                        Text("Low"),
                      ],
                    ),
                    Container(
                      width: 250,
                      height: 70,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton(
                              hint: Text("Select Building"),
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: building.map((valueItem) {
                                return DropdownMenuItem(
                                    value: valueItem, child: Text(valueItem));
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 100.0,
                    ),
                    // StreamBuilder(
                    //     stream: buildings.snapshots(),
                    //     builder: (context, snapshot) {
                    //         width: 150,
                    //         color: Theme.of(context).primaryColor,
                    //           child: new DropdownButton(
                    //           items:  snapshot.data.map<DropdownMenuItem<String>>((value) =>
                    //           return DropdownMenuItem<String>(
                    //             value: value["distance"],
                    //             child: new Text(value["distance"]),
                    //           )
                    //           ).
                    //         ),
                    //     }),
                    Container(
                      width: 250,
                      height: 50,
                    margin: EdgeInsets.only(top:20,bottom: 20),
                    child: ElevatedButton(
                      onPressed: (){
                        print("Pressed");
                        String $choice = "";
                        if ($radio == 1) $choice = "high";
                        if ($radio == 2) $choice = "medium";
                        if ($radio == 3) $choice = "low";

                        List<String> ret = [
                          this.text, $choice,valueChoose
                        ];
                        Alerts addAlert = new Alerts(this.text,$choice,valueChoose);
                        addAlert.addAlert();
                        print(ret.toString());
                      },
                      child: Text("Send Alert",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Open Sans",
                          fontSize: 30
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onSurface: Colors.blue,
                        elevation: 5,
                      ),
                    ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }
}
