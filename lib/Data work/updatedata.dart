import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateRecord extends StatefulWidget {

  const UpdateRecord({Key? key, required this.empKey}) : super(key: key);

  final String empKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {

  final name = TextEditingController();
  final id = TextEditingController();
  final designation = TextEditingController();
  final phone = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('emp');
    getPersonData();
  }

  void getPersonData() async {
    DataSnapshot snapshot = await dbRef.child(widget.empKey).get();

    Map person = snapshot.value as Map;

    name.text = person['name'];
    designation.text = person['designation'];
    phone.text = person['phone'];
    id.text = person['id'];


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Updating data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: name,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: designation,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Designation',
                  hintText: 'Enter Your Age',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  hintText: 'Enter Your Salary',
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              MaterialButton(
                onPressed: () {

                  Map<String, String> persons = {
                    'name': name.text,
                    'designation': designation.text,
                    'id': id.text
                  };

                  dbRef.child(widget.empKey).update(persons)
                      .then((value) => {
                    Navigator.pop(context)
                  });

                },
                child: const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 30,
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
