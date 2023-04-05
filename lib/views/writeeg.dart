import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({Key? key}) : super(key: key);

  @override
  State<WriteExamples> createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final nameRef = database.child('emp/name');
    return Scaffold(
      appBar: AppBar(
        title: Text('Write')
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async {
            await nameRef
                .set({'firstname': 'suwaniiiiiiii', 'lastname': 'bastola'})
                .then((_)=> print('name written'))
                .catchError((error)=> print('you catch an error! $error'));
          },
              child: Text('Add Value'))

        ],
      )
    );
  }
}

