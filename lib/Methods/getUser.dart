
import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_db/all_emp_list.dart';

Future<Map<String, Person>> getUsers() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("emp");
  var personMap = <String, Person>{};
  ref.onValue.listen((event) {
    String jsonString = json.encode(event.snapshot.value);
    print("@@@@JSONSTRING $jsonString");
    RegExp regex = RegExp(
        r'\{"phone":"(\d+)","name":"([^"]+)","designation":"([^"]+)","id":"(\d+)"\}'
    );
    for (RegExpMatch match in regex.allMatches(jsonString)) {
      personMap[match.group(4)!] = Person(
        name: match.group(2)!,
        designation: match.group(3)!,
        id: match.group(4)!,
        phone: match.group(1)!,
      );
    }
  });
  print('@@@COMPLETER');
  return personMap;
}
