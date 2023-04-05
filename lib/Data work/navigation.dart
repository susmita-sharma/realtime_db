import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Person {
  final String name;
  final String designation;
  final String id;
  final String phone;
  Person({required this.name, required this.designation, required this.id, required this.phone});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UpdateRecordPage());
}

class UpdateRecordPage extends StatefulWidget {
  @override
  _UpdateRecordPageState createState() => _UpdateRecordPageState();
}

class _UpdateRecordPageState extends State<UpdateRecordPage> {
  late String name;
  late String designation;
  late String id;

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('emp');

  void _updateRecord() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateRecordFormPage(),
      ),
    );

    // Update record in database
    dbRef.child(id).update({
      'name': name,
      'designation': designation,
    });

    // Return to previous page with updated data
    Navigator.pop(context, {
      'Id': id,
      'designation': designation,
      'name': name,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Record'),
        ),
        body: Center(
          child: TextButton(
            child: Text('Update Record'),
            onPressed: _updateRecord,
          ),
        ),
      ),
    );
  }
}

class UpdateRecordFormPage extends StatefulWidget {
  @override
  _UpdateRecordFormPageState createState() => _UpdateRecordFormPageState();
}

class _UpdateRecordFormPageState extends State<UpdateRecordFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record Form'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Field 1'),
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Field 2'),
              onSaved: (value) => designation = value!,
            ),
            TextButton(
              child: Text('Save Changes'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
