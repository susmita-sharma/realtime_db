import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/Data%20work/fetchdata.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final name = TextEditingController();
  final id = TextEditingController();
  final designation = TextEditingController();
  final phone = TextEditingController();
  late DatabaseReference ref;
  @override
  void initState(){
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('emp');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height:10),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Input your name'
              ),
            ),
            SizedBox(height:10),
            TextField(
              controller: designation,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Designation',
                  hintText: 'Input your name'
              ),
            ),
            SizedBox(height:10),
            TextField(
              controller: id,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Employee ID',
                  hintText: 'Input your name'
              ),
            ),
            SizedBox(height:10),
            TextField(
              controller: phone,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number ',
                  hintText: 'Input your name'
              ),
            ),
            MaterialButton(onPressed: (){
              Map<dynamic, dynamic> persons = {
                'name' : name.text,
                'designation' : designation.text,
                'id' : id.text,
                'phone' : phone.text};
              ref.push().set(persons);
            },child: TextButton(
              child: Text('Insert'),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));},
            ))
          ]
        )
      )
    );
  }
}
