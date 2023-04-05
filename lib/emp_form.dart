import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/all_emp_list.dart';

class NewDataAdd extends StatefulWidget {
  const NewDataAdd({Key? key}) : super(key: key);
  @override
  State<NewDataAdd> createState() => _NewDataAddState();
}

class _NewDataAddState extends State<NewDataAdd> {
  var fb = FirebaseDatabase.instance;
  TextEditingController designation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employees')
      ),
      body: Column(
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
          ElevatedButton(
              onPressed: (){
                Map<String, dynamic> mapP ={
                  "id" : id.text,
                  "name" : name.text,
                  "designation" : designation.text,
                  "phone" : phone.text,
                };
                final ref = fb.ref().child('emp').child(mapP["id"]);
                ref.set(mapP);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => FirstPageObj()));
              }, child: Text('ADD'))
      ],
    ),
    );
  }
}