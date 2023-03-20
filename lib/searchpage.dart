import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search App',
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final databaseReference = FirebaseDatabase.instance.ref().child('emp');
  List<Map<dynamic, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseReference.once().then((DatabaseEvent dataSnapshot) async {
      List<Map<dynamic, dynamic>> list = [];
      String jsonList = json.encode(dataSnapshot.snapshot.value);
      Map<dynamic, dynamic> values = jsonList as Map;
      values.forEach((key, value) {
        list.add(value);
      });
      setState(() {
        _searchResults = list;
      });

    });
  }

  void _onSearchTextChanged(String query) {
    List<Map<dynamic, dynamic>> searchResults = [];

    if (query.isNotEmpty) {
      _searchResults.forEach((result) {
        if (result['name'].toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(result);
        }
      });
    } else {
      searchResults = List.from(_searchResults);
    }

    setState(() {
      _searchResults = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_searchResults[index]['name']),
            subtitle: Text(_searchResults[index]['designation']),
          );
        },
      ),
    );
  }
}
