import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';
import 'home.dart';
import 'getUser.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nepal Telecom",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
      ),
      home: Text("hi"),
      debugShowCheckedModeBanner: false,
    );
  }
}
