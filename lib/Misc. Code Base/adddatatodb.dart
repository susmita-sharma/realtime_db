import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class Person {
  final String name;
  final String designation;
  final String id;
  final String phone;
  Person({required this.name, required this.designation, required this.id, required this.phone});
}

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final name = TextEditingController();
final id = TextEditingController();
final designation = TextEditingController();
final phone = TextEditingController();
late DatabaseReference ref;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDataPage(),
    );
  }
}


class MyDataPage extends StatefulWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {

  @override
  void initState(){
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('emp');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime DB'),
      ),
      body: InsertData(),
      /*Column(
          children: [
          MaterialButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> InsertData()));
            },child: Text('Insert'),),*/
            /*MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchData()));
              },child: Text('Fetch')),],),*/


    );
  }
}

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height:5),
            TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name'
              ),
            ),
            SizedBox(height:5),
            TextField(
              controller: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone'
              ),
            ),
            MaterialButton(onPressed: (){
              Map<dynamic, dynamic> Persons = {
                'name': name.text,
                'phone' : phone.text};
              ref.push().set(Persons);
            },child: Text('Insert'))
          ],
        )
      ),
    );
  }
}
