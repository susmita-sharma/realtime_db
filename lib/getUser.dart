import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String designation;
  final String id;
  final String phone;

  User({required this.name, required this.designation, required this.id, required this.phone});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

  await getUserData.getUsers();
}

class GetUserData {
  //List<User> dataList = [];
  //final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");



  /*Future<Map<String, dynamic>> fetchData() async {
    DataSnapshot dataSnapshot = (await _databaseReference.child('emp').once()) as DataSnapshot;
    Map<String, dynamic> data = jsonDecode(dataSnapshot.value);
    return data;
  }
  Map<String, dynamic> myData = await fetchData();*/

 Future<void> getUsers() async {
    print('@@ before dataSnapshot');
   /* DatabaseEvent dataSnapshot = await _databaseReference.child('emp').once();
    Object? jsonString = dataSnapshot.snapshot.value;
    List<dynamic> jsonList = json.decode(jsonString);
    print("@@@ decoded");
    print(jsonList);*/

    // Get the data once
    DatabaseEvent event = await ref.once();


// Print the data of the snapshot
   //print(event.snapshot.value); // { "name": "John" }
   String jsonString = json.encode(event.snapshot.value);
   //List<dynamic> jsonList = json.decode(jsonString);
   print(jsonString);


   List<dynamic> jsonList = json.decode(jsonString);
   List<User> personList = jsonList.map((jsonsData) => User(
       name: jsonsData["name"], designation: jsonsData["designation"], id: jsonsData["id"], phone: jsonsData["phone"]))
       .toList();

 //  print(personList);

   for (User p in personList){
     print(p.name);
   }

   //Map<String, dynamic> data = dataSnapshot.snapshot.value.toString() as Map<String, dynamic>;
    // User user = User.fromJson(data);
    // print(user);




   /* List<Map<dynamic, dynamic>> jsonList = json.decode(jsonString).cast<Map<dynamic, dynamic>>();
    dataList = jsonList.toList(); // convert map to list
    print(dataList);
*/
   // print(jsonList);
//     print("@@@@ trying to map");
// // Convert JSON list to list of Person instances
//     List<Person> personList = jsonList
//         .map((jsonsData) => Person(
//         name: jsonsData["name"], designation: jsonsData["designation"], id: jsonsData["id"], phone: jsonsData["phone"]))
//         .toList();
//     print(personList);
  }
}


// Future<List<Person>> loadJsonData() async {
//   final jsonString = await rootBundle.loadString("assets/data.json");
//   List<dynamic> jsonList = json.decode(jsonString);
//
//   // List<dynamic> jsonString = [
//   //   {"id": 1, "name": "Suwan", "age": 29},
//   //   {"id": 2, "name": "Susmita", "age": 40},
//   //   {"id": 3, "name": "Sanjib", "age": 5},
//   //   {"id": 4, "name": "Barbara", "age": 35}
//   // ];
//   print("@@@@ trying to map");
// // Convert JSON list to list of Person instances
//   List<Person> personList = jsonList
//       .map((jsonsData) => Person(
//       name: jsonsData["name"], designation: jsonsData["designation"], id: jsonsData["id"], phone: jsonsData["phone"]))
//       .toList();
//   print(personList);
//   return personList;
// }