import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'insertdata.dart';
import 'fetchdata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyDataApp());
}

class MyDataApp extends StatelessWidget {
  const MyDataApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Data App",
      home: MyDataHomePage(),
    );
  }
}
 class MyDataHomePage extends StatefulWidget {
   const MyDataHomePage({Key? key}) : super(key: key);
 
   @override
   State<MyDataHomePage> createState() => _MyDataHomePageState();
 }
 
 class _MyDataHomePageState extends State<MyDataHomePage> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Realtime DB'),
       ),
       body: Column(
         children: [
           MaterialButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> InsertData()));
           },child: Text('Insert'),),
           MaterialButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchData()));
           },child: Text('Fetch')),
           /*MaterialButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> DeletData()));
           },child: Text('Delete')),*/


         ],
       )
     );
   }
 }
 