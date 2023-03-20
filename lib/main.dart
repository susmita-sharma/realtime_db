
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'secondPageObjNavigation.dart';
import 'firstPageObjNavigation.dart';

void main  ()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

late final Person personObj;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'firstPageObjNavigation',
      routes: {
        'firstPageObjNavigation': (context) => const FirstPageObj(),
        'secondPage': (context) => SecondPage( person: personObj),
      },
      debugShowCheckedModeBanner: false,
      title: 'Nepal Telecom',
    );

  }
}

