import 'dart:async';
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

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
//  final DatabaseReference reference = FirebaseDatabase.instance.ref("emp").child('suwanObj');
  //await reference.remove().then((_) => print('@@@ suwanObj Node removed successfully.'));




   //saveData(Person(name:"aaaa",designation: "bbbb",id: "7777",phone: "7777"));
  // print("@@@@ SUCCESSFULY ADDED TO THE DATABASE");

   GetUserData getUserData = GetUserData();
   List <Person> getValue= await getUserData.getUsers();
   print("@@@@ AT LAST OF THE CODE");
   print(getValue);
  //printFirebase();

}

// void printFirebase(){
//   final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
//   ref.once().then((DatabaseEvent event) {
//     print('Data : ${event.snapshot.value}');
//   });
// }


class GetUserData {

  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  Future <List<Person>> getUsers() async {

    DatabaseEvent event = await ref.once(); //print(event.snapshot.value); // '{ name: John ...... }'
    String jsonString = json.encode(event.snapshot.value);

    print("@@@ PPRINTING JSONSTRING : EVENT.SNAPSHOT.VALUE");
    print(jsonString); // { "name" : "John" ....}



    List<dynamic> jsonList = json.decode(jsonString);
    print("@@@ PPRINTING JSONLIST : JSON.DECODE(JSONSTRING)");
    print(jsonString);
    List<Person> personList = jsonList.map((jsonsData) =>
        Person(
            name: jsonsData["name"],
            designation: jsonsData["designation"],
            id: jsonsData["id"],
            phone: jsonsData["phone"]))
        .toList();
    print("@@@ PPRINTING personList : LIST<PERSON>");
    print(personList);
    return personList;
//Unhandled Exception: type 'String' is not a subtype of type 'int' of 'index'
  }
}

Map<String, dynamic> toJson(Person p) {
  return {
    "name":p.name,
    "designation":p.designation,
    "id":p.id,
    "phone":p.phone
  };
}

void saveData(Person ppp) {
  final databaseReference = FirebaseDatabase.instance.ref("emp");
  String json = jsonEncode(toJson(ppp));
  databaseReference.child('suwanObj').set(json);
}


