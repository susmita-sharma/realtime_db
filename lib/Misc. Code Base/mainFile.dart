import 'package:flutter/material.dart';
import 'package:realtime_db/adddatanew.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Suwan'),
        ),
        body: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => NewDataAdd()));
                },
                child: Icon(Icons.add)),
          ), );  }
}
