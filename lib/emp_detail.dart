import 'package:flutter/material.dart';
import 'all_emp_list.dart';

class SecondPage extends StatelessWidget {
  final MapEntry<String, Person> entry;

  const SecondPage(this.entry );

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
            "Name: ${entry.value.name}\nAge: ${entry.value.designation} \nEmployeeID : ${entry.value.id}  \nPhone : ${entry.value.phone} ", style: TextStyle(color: Colors.red, backgroundColor: Colors.blue, fontWeight: FontWeight.bold), ),
        ),
      ),
    );
  }
}


