//import 'dart:async';
import 'dart:convert';
//import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/adddatanew.dart';

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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('emp');
  var _allUsers = <String, Person>{};
  var _foundUsers = <String, Person>{};
  Iterable<MapEntry<String, Person>> results = {};

  @override
  void initState() {
    setStateMeth();
    super.initState();
  }

  void setStateMeth() {
    getUsers().then((mapP) {
      setState(() {
        _allUsers = mapP;
        _foundUsers = mapP;
      });
    });
  }

  void _runFilter(dynamic enteredKeyword) {
    int? userInt = int.tryParse(enteredKeyword);
    var results = <String, Person>{};
    print(enteredKeyword);
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else if (userInt != null) {
      results = _allUsers.entries
          .where((entry) =>
              entry.value.phone.contains(enteredKeyword) ||
              entry.value.id.contains(enteredKeyword))
          .fold({}, (map, entry) => map..[entry.key] = entry.value);
    } else {
      results = _allUsers.entries
          .where((entry) => entry.value.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .fold({}, (map, entry) => map..[entry.key] = entry.value);
    }

    for (Person person in results.values) {
      print(
          "Name: ${person.name}, Designation: ${person.designation}, ID: ${person.id}, Phone: ${person.phone}");
    }

    setState(() {
      getUsers().then((mapP) {
        _allUsers = mapP;
      });
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
          child: Column(children: [
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: FirebaseAnimatedList(
            //     query: ref,
            //     shrinkWrap: true,
            //     //itemCount: _foundUsers.length,
            //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
            //         Animation<double> animation, int index) {
            //       final entry = _foundUsers.entries.elementAt(index);
            //       final key = entry.key;
            //       final value = entry.value;
            //       return Card(
            //         color: Colors.amberAccent,
            //         elevation: 4,
            //         margin: const EdgeInsets.symmetric(vertical: 10),
            //         child: ListTile(
            //           //leading: Text(value.id),
            //           leading: Text(
            //             (index + 1).toString(),
            //             style: const TextStyle(fontSize: 24),
            //           ),
            //           title: Text(value.name),
            //           subtitle: Text(value.designation),
            //           trailing: IconButton(
            //             onPressed: () {
            //               ref.child(snapshot.key!).remove();
            //               setStateMeth();
            //             },
            //             icon: Icon(Icons.delete),
            //             //Navigator.pop(context);},
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => NewDataAdd()));
                },
                child: Icon(Icons.add)),
          ]),
        ),
      ),
    );
  }
}

Future<Map<String, Person>> getUsers() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  var personMap = <String, Person>{};
  ref.onValue.listen((event) {
    String jsonString = json.encode(event.snapshot.value);
    print("@@@@JSONSTRING");
    print(jsonString);
    RegExp regex = RegExp(
        r'\{"phone":"(\d+)","name":"([^"]+)","designation":"([^"]+)","id":"(\d+)"\}');
    for (RegExpMatch match in regex.allMatches(jsonString)) {
      personMap[match.group(4)!] = Person(
        name: match.group(2)!,
        designation: match.group(3)!,
        id: match.group(4)!,
        phone: match.group(1)!,
      );
    }
  });
  print('@@@COMPLETER');
  return personMap;
}
