import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'all_emp_list.dart';
import 'emp_form.dart';
import 'emp_detail.dart';

void main ()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//late final Person personObj;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'first',
      routes: {
        'first': (context) => const FirstPageObj(),

        'secondPage': (context) => SecondPage( person: personObj),
      },
      debugShowCheckedModeBanner: false,
      title: 'Nepal Telecom',
    );

  }
}





