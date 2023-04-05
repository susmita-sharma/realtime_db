import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({Key? key}) : super(key: key);

  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = 'Results here';
  final _database = FirebaseDatabase.instance.ref();
  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

  void _activateListeners(){
    _database.child('emp/name/firstname').onValue.listen((event) {
      String name = jsonEncode(event.snapshot.value);
      print(name);
      String name1 = jsonDecode(name);
      setState(() {
        _displayText = 'Today: $name1';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Read')
        ),
        body: Column(
          children: [

          ],
        )
    );
  }
}
