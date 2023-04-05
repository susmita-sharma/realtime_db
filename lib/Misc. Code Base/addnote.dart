import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/main.dart';

import '../firstPageObjNavigation.dart';

class addnote extends StatefulWidget {

  final String data;
  addnote({required this.data});

  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {

  TextEditingController designation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController phone = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    //var k = totalCount;
    //var rng = Random();
   // var k = rng.nextInt(10000); // for the unique identification of the data

    final ref = fb.ref().child('emp');

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Employees Details"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: id,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Employee ID',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'phone',
                ),
              ),
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () {
                print("@@@ WIDGET.DATA FOR index THE SELECTION OF ITEM IN DB");
                print(widget.data);
                ref.child(widget.data).update({
                  "id" : id.text,
                  "name" : name.text,
                  "designation" : designation.text,
                  "phone" : phone.text,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => FirstPageObj()));
              },
              child: Text(
                "UPDATE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}