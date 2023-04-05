import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _allUsers = <String, Person>{};
var _foundUsers = <String, Person>{};

class Person {
  final String name;
  final String designation;
  final String id;
  final String phone;
  Person(
      {required this.name,
        required this.designation,
        required this.id,
        required this.phone});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Iterable<MapEntry<String, Person>> results = {};

  @override
  void initState() {
    getUsers().then((mapP) {
      setState(() {
        print("@@@ AT SETSTATE OF INITSTATE AND UPDATEING _FOUNDUSERS");
        _allUsers = mapP;
        _foundUsers = mapP;
      });
    });
    super.initState();
  }

  void _runFilter(dynamic enteredKeyword) {
    //  int? userInt = int.tryParse(enteredKeyword);
    var results = <String, Person>{};
    print("@@@ RUNFLINTER WITH ENTERED KEYWORD");
    print(enteredKeyword);
    if (enteredKeyword.isEmpty) {

      results = _allUsers;
    }
    else if (int.tryParse(enteredKeyword)!= null){
      print("@@@@ INSIDE THE ELSE IF ");
      results = _allUsers.entries
          .where((entry) =>
      entry.value.phone.contains(enteredKeyword)||entry.value.id.contains(enteredKeyword)).fold({}, (map, entry) => map..[entry.key] = entry.value);
    }


    else {
      print("@@@@ INSIDE THE ELSE ");
      // Map<String, Person> results = _allUsers.entries
      //     .where((entry) => entry.value.name.toLowerCase().contains(userInt.toLowerCase()))
      //     .fold({}, (map, entry) => map..[entry.key] = entry.value);

      results = _allUsers.entries
          .where((entry) =>
          entry.value.name.toLowerCase().contains(enteredKeyword.toLowerCase())).fold({}, (map, entry) => map..[entry.key] = entry.value);
    }

    // Iterate over the values using a for-in loop
    for (Person person in results.values) {
      print(
          "Name: ${person.name}, Designation: ${person.designation}, ID: ${person.id}, Phone: ${person.phone}");
    }
    setState(() {
      getUsers().then((mapP) {_allUsers = mapP;});
      _foundUsers = results;
      print("@@@ SETSTATE _FOUNTUSERS");
      print(_foundUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Suwan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children:[
                SizedBox(height:10),
                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
                SizedBox(height:10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry = _foundUsers.entries.elementAt(index);
                      final key = entry.key;
                      final value = entry.value;
                      return ListTile(
                        title: Text(value.name),
                        subtitle: Text(value.designation),
                        trailing: Text(value.phone),
                        onTap: () {

                          // Handle onTap event
                        },
                      );
                    },
                  ),
                )
              ]),
        ),

      ), );
  }
}

/*Future<Map<String, Person>> getUsers() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  DatabaseEvent event = await ref
      .once(); //print(event.snapshot.value); // '{ name: John ...... }'
  String jsonString = json.encode(event.snapshot.value);

  List<dynamic> jsonList = json.decode(jsonString);
  var personMap = <String, Person>{};

  List<Person> personList = jsonList
      .map((jsonsData) => Person(
          name: jsonsData["name"],
          designation: jsonsData["designation"],
          id: jsonsData["id"],
          phone: jsonsData["phone"]))
      .toList();

  personList.forEach((person) {
    personMap[person.id] = person;
  });
  return personMap;
}*/

/*
Future <Map <String,Person>> getUsers() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  final completer = Completer<Map<String, Person>>();
  ref.onValue.listen((event) {
    var personMap = <String, Person>{};
    //DatabaseEvent event = await ref.once(); //print(event.snapshot.value); // '{ name: John ...... }'
    String jsonString = json.encode(event.snapshot.value);
    print("@@@ PRINTING JSONSTRING after encode");
    print(jsonString);
    Map<String, dynamic> jsonData = json.decode(jsonString) ;
    jsonData.forEach((key, value) {
      personMap[key.toString()] = Person(
          name: value["name"],
          designation: value["designation"],
          id: value["id"],
          phone: value["phone"],);
    });
    completer.complete(personMap);
  });
  return completer.future;

}*/

Future<Map<String, Person>> getUsers() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  // var completer = Completer<Map<String, Person>>();
  var personMap = <String, Person>{};

  ref.onValue.listen((event) {
    String jsonString = json.encode(event.snapshot.value);
    print("@@@@  JSONSTRING INSIDE GETUSER METHOD");
    print(jsonString);
    RegExp regex = RegExp(
        r'\{"phone":"(\d+)","name":"([^"]+)","designation":"([^"]+)","id":"(\d+)"\}'
    );
    for (RegExpMatch match in regex.allMatches(jsonString)) {
      personMap[match.group(4)!] = Person(
        name: match.group(2)!,
        designation: match.group(3)!,
        id: match.group(4)!,
        phone: match.group(1)!,
      );
    }
    //   completer.complete(personMap);
  });
  print('@@@  COMPLETER INSIDE GETUSER METHOD');
//  print(completer.future);
  // var Returncompleter = Completer<Map<String, Person>>() ;
//  completer = Completer<Map<String, Person>>();
  // return Returncompleter.future;
  return personMap;

}