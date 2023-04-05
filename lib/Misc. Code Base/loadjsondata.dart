import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:realtime_db/Misc.%20Code%20Base/addnote.dart';
import 'package:realtime_db/main.dart';
import '../secondPageObjNavigation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import '../adddatanew.dart';
import 'stream.dart';

/*
class Person {
  final String name;
  final String designation;
  final String id;
  final String phone;

  Person({required this.name, required this.designation, required this.id, required this.phone});

}
*/

class FirstPageObj extends StatefulWidget {
  const FirstPageObj({Key? key}) : super(key: key);

  @override
  State<FirstPageObj> createState() => _FirstPageObj();
}

class _FirstPageObj extends State<FirstPageObj> {
  Map<String, Person> _allUsers = {};

  Map<String, Person> _foundUsers = {};

  @override
  void initState() {
//    GetUserData getUserData = GetUserData();
    print("@@@ Entered into the initState and printing  & foundUsers");
    // print(_allUsers);
    print(_foundUsers);

    loadJsonData().then((Persons) {
      print("@@@ trying to loading data at initstate bef set state ");
      setState(() {
        _allUsers = Persons;
        totalCount = _allUsers.length;
        _foundUsers = Persons;
      });
    });

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(dynamic enteredKeyword) {
    int? userInt = int.tryParse(enteredKeyword);
    print("@@@@ user entered value");
    print(userInt);

    Map<String, Person> _runFilter(String enteredKeyword) {
      Map<String, Person> results = {};
      if (enteredKeyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = _allUsers;
      } else if (userInt != null) {
        results = Map.fromEntries(_allUsers.entries.where((entry) =>
            entry.key.contains(enteredKeyword.toString())));
      } else {
        results = Map.fromEntries(_allUsers.entries.where((entry) =>
            entry.value.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase())));
        // we use the toLowerCase() method to make it case-insensitive
      }
      // Refresh the UI
      setState(() {
        _foundUsers = results;
      });
      return results;
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewDataAdd()));
            }, child: Icon(Icons.add)
        ),
        appBar: AppBar(
          title: const Text('Nepal Telecom'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) =>
                      Card(
                        key: ValueKey(_foundUsers.keys.toList()[index]),
                        // Use the keys to get a unique identifier for each item
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers.values.toList()[index].name),
                          // Use values to get the Person object for each item
                          subtitle: Text(_foundUsers.values.toList()[index].id
                              .toString()),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              final DatabaseReference ref = FirebaseDatabase
                                  .instance.ref("emp");
                              ref.child(_foundUsers.keys.toList()[index])
                                  .remove(); // Use the keys to remove the item from the database
                              initState();
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    addnote(
                                      data: _foundUsers.keys.toList()[index],
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                )
                    : const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),

              ),
            ],
          ),
        ),
      );
    }
  }

  Future<Map<String, Person>> loadJsonData() async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
    final completer = Completer<Map<String, Person>>();

    ref.onValue.listen((event) {
      var dataevent = event.snapshot.value;
      Map<String, dynamic> jsonData = json.decode(json.encode(dataevent));
      Map<String, Person> personMap = {};
      jsonData.forEach((key, value) {
        personMap[key.toString()] = Person(
          name: value["name"],
          designation: value["designation"],
          id: value["id"],
          phone: value["phone"],
        );
      });
      completer.complete(personMap);
    });

    print("@@@loadJsonData Method");
    print(completer.future);
    return completer.future;
  }
