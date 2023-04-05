import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/main.dart';
import 'emp_form.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'Misc. Code Base/stream.dart';


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
  DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  var _allUsers = <String, Person>{};
  var _foundUsers = <String, Person>{};
  Iterable<MapEntry<String, Person>> results = {};
  @override
  void initState() {
    getUsers().then((mapP) {
      setState(() {
        _allUsers = mapP;
        _foundUsers = mapP;
      });
    });
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(dynamic enteredKeyword) {
    //  int? userInt = int.tryParse(enteredKeyword);
    var results = <String, Person>{};
    print("@@@ RUNFLINTER WITH ENTERED KEYWORD");
    print(enteredKeyword);
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else if (int.tryParse(enteredKeyword) != null){
      print("@@@@ INSIDE THE ELSE IF ");
      results = _allUsers.entries
          .where((entry) =>
      entry.value.phone.contains(enteredKeyword)||entry.value.id.contains(enteredKeyword)).fold({}, (map, entry) => map..[entry.key] = entry.value);
    }else {
      print("@@@@ INSIDE THE ELSE ");
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

  void setStateMeth() {
    getUsers().then((mapP) {
      setState(() {
        _allUsers = mapP;
        _foundUsers = mapP;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewDataAdd()));},child: Icon(Icons.add)
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
              child: FirebaseAnimatedList(
                query: ref,
                shrinkWrap: true,
                //itemCount: _foundUsers.length,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  final entry = _foundUsers.entries.elementAt(index);
                  final key = entry.key;
                  final value = entry.value;
                  return GestureDetector(
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage()));
                    },
                    child: Card(
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(value.id,style: TextStyle(fontWeight: FontWeight.bold),),
                          title: Text(value.name,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.designation),
                              Text(value.phone)
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),

                                    SizedBox(width: 8.0),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 8.0),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(Icons.share),
                                    SizedBox(width: 8.0),
                                    Text('Share'),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (String value) {
                              // Handle menu item selection
                            },
                            icon: Icon(Icons.more_vert),
                          )
                          ,
                          /*trailing: IconButton(
                            onPressed: (){
                              ref.child(snapshot.key!).remove();
                              setStateMeth();
                            }, icon: Icon(Icons.delete),
                          ),*/
                        ),
                    ),
                  );
                },
              ),
            ),
          ],
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
  });
  print('@@@COMPLETER');
  return personMap;
}

