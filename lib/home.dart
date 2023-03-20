
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';
import 'getUser.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController designation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController phone = TextEditingController();
  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {




    final ref = fb.ref().child('todos');
    //final databaseRef = FirebaseDatabase.instance.reference().child('todos');
    /*List<Map<dynamic, dynamic>> searchResults = [];
    final searchFilter = TextEditingController();*/

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Employee Details',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: Column(
        children: [

          Expanded(
            child: FirebaseAnimatedList(
              query: ref,

              shrinkWrap: true,
              itemBuilder: (context, snapshot, animation, index) {
                var v =
                snapshot.value.toString();
                //(v);// {subtitle: webfun, title: subscribe}

                g = v.replaceAll(
                    RegExp("{|}|name: |designation: |id: |phone "), "");
                //   print(g);// webfun, subscribe
                g.trim();

                l = g.split(',');


                return GestureDetector(
                  onTap: () {
                    setState(() {
                      k = snapshot.key;
                    });

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: TextField(
                            controller: name,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'name',
                            ),
                          ),
                        ),
                        content: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: TextField(
                            controller: id,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Employee ID',
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: designation,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'designation',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextField(
                              controller: phone,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Phone',
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            color: Color.fromARGB(255, 0, 22, 145),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              await upd();
                              Navigator.of(ctx).pop();
                            },
                            color: Color.fromARGB(255, 0, 22, 145),
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.indigo[100],
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          onPressed: () {
                            ref.child(snapshot.key!).remove();
                          },
                        ),
                        title: Text(
                          l[1],
                          // 'dd',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          l[0],
                          // 'dd',

                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "id" : id.text,
      "name" : name.text,
      "designation" : designation.text,
      "phone" : phone,
    });
    id.clear();
    name.clear();
    designation.clear();
    phone.clear();
  }



}



