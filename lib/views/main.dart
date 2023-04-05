import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/views/readeg.dart';
import 'writeeg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('My DB'),
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteExamples()));}, child: Text('Write')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ReadExamples()));}, child: Text('Read'))
            ],
          ),
    );
  }
}

