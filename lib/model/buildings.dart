import 'package:cloud_firestore/cloud_firestore.dart';


class Building{
  final _firestore = FirebaseFirestore.instance;

  final String name;
  final String street;
  final String zone;

  Building(this.name, this.street, this.zone);


  void getAllBuildings(){

  }

  void addBuilding(name, street,zone){
    Map<String, String> add = {
      "name": this.name,
      "street": this.street,
    };
    print(add);
  }


}