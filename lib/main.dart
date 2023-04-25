import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'all_emp_list.dart';
import 'emp_form.dart';
import 'emp_detail.dart';

class Person {
  String name;
  String designation;
  String id;
  String phone;

  Person(
      {required this.name, required this.designation, required this.id, required this.phone});
}

void main ()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

late final Person person;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'first',
      routes: {
        'first': (context) => const FirstPageObj(),

        //'secondPage': (context) => SecondPage(person: person),
      },
      debugShowCheckedModeBanner: false,
      title: 'Nepal Telecom',
    );

  }
}





