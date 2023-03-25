import 'package:flutter/material.dart';
import 'firstPageObjNavigation.dart';

class SecondPage extends StatelessWidget {
  final Person person;

  const SecondPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Detail Page"),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child:Text(
            "Name: ${person.name}\nAge: ${person.designation} \nEmployeeID : ${person.id}  \nPhone : ${person.phone} ", style: TextStyle(color: Colors.red, backgroundColor: Colors.blue, fontWeight: FontWeight.bold), ),
        ),
      ),
    );
  }
}


