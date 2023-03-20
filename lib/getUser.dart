import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Person {
  final String name;
  final String designation;
  final String id;
  final String phone;

  Person({required this.name, required this.designation, required this.id, required this.phone});
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      designation: json['designation'],
      id: json['id'],
      phone: json['phone']
    );
  }

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetUserData getUserData = GetUserData();
  List <Person> getValue= await getUserData.getUsers();
  print(getValue);
}

class GetUserData {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  Future <List<Person>> getUsers() async {
    // Get the data once
    DatabaseEvent event = await ref.once();
// Print the data of the snapshot
    //print(event.snapshot.value); // '{ name: John ...... }'

    String jsonString = json.encode(event.snapshot.value);
    print(jsonString); // { "name" : "John" ....}
// to get the List to convert into
    List<dynamic> jsonList = json.decode(jsonString);
    List<Person> personList = jsonList.map((jsonsData) =>
        Person(
            name: jsonsData["name"],
            designation: jsonsData["designation"],
            id: jsonsData["id"],
            phone: jsonsData["phone"]))
        .toList();
    return personList;
  }
}