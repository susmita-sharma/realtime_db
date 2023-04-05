import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InsertDataPage());
}

class InsertDataPage extends StatefulWidget {
  @override
  _InsertDataPageState createState() => _InsertDataPageState();
}

class _InsertDataPageState extends State<InsertDataPage> {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('data');
  final TextEditingController _dataController = TextEditingController();

  void _insertData() {
    String data = _dataController.text.trim();
    if (data.isNotEmpty) {
      _database.push().set({'value': data}).then((_) {
        _dataController.clear();
       // print(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data inserted successfully.'),
          duration: Duration(seconds: 2),
        ));print('@@snackbar');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Insert Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _dataController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _insertData,
                child: Text('Insert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('data');

  List<String> _dataList = [];

  @override
  void initState() {
    super.initState();
    _database.onValue.listen((event) {
      String jsonMap = jsonEncode(event.snapshot.value);
      Map<dynamic, dynamic> map = json.decode(jsonMap);
      List<String> dataList = [];
      if (map != null) {
        map.forEach((key, value) {
          dataList.add(value['value']);
        });
      }
      setState(() {
        _dataList = dataList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_dataList[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => InsertDataPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
