import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'secondPageObjNavigation.dart';
// 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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

class FirstPageObj extends StatefulWidget {
  const FirstPageObj({Key? key}) : super(key: key);

  @override
  State<FirstPageObj> createState() => _FirstPageObj();
}

class _FirstPageObj extends State<FirstPageObj> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well

  late List<Person> _allUsers;

  // This list holds the data for the list view
  List<Person> _foundUsers = [];
  @override
  void initState() {
    GetUserData getUserData = GetUserData();
    getUserData.loadJsonData().then((Persons) {
      setState(() {
        _allUsers = Persons;
        _foundUsers = Persons;
      });
    });
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(dynamic enteredKeyword) {
    int? userInt = int.tryParse(enteredKeyword);
    print(userInt);

    List<Person> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else if (userInt != null) {
      results = _allUsers
          .where((userData) =>
          (userData.id.toString()).contains(enteredKeyword.toString()))
          .toList();
    } else {
      // else (enteredKeyword.isString) { } elseif { userData["id"] }
      results = _allUsers
          .where((userData) => userData.name
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index].id),
                  color: Colors.amberAccent,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(_foundUsers[index].name),
                    subtitle: Text(
                        '${_foundUsers[index].id.toString()} years old'),
                    trailing: IconButton(
                      icon: Icon(Icons.man),
                      onPressed: () {
                        print('@@button pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(
                              person: Person(
                                name: _foundUsers[index].name,
                                designation: _foundUsers[index].designation,
                                id: _foundUsers[index].id,                                           phone : _foundUsers[index].phone,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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

// _callNumber() async {
//   print('@@_callNumber is called');
//   const number = '9851141621'; //set the number here
//   bool? res = await FlutterPhoneDirectCaller.callNumber(number);
// }

// Future<List<Person>> loadJsonData() async {
//   final jsonString = await rootBundle.loadString("assets/data.json");
//   List<dynamic> jsonList = json.decode(jsonString);
//   List<Person> personList = jsonList
//       .map((jsonsData) => Person(
//       name: jsonsData["name"], designation: jsonsData["designation"], id: jsonsData["id"], phone: jsonsData["phone"]))
//       .toList();
//   print(personList);
//   return personList;
// }

class GetUserData {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  Future <List<Person>> loadJsonData() async {
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