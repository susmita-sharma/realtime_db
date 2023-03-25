import 'package:flutter/material.dart';

class Person {
  String name;
  String designation;
  String id;
  String phone;

  Person(
      {required this.name,
      required this.designation,
      required this.id,
      required this.phone});
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
      title: 'Nepal Telecom',
    );
  }
}

// first page code started

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Person pfirst;
  //this takes the values popped from page2 screen, using async and await

  _navigateNextPageAndretriveValue(BuildContext context) async {
    final Person pValue = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SecondPage()),
    );
    //  setState(() {  // if we need to refresh the widget or page use setState to update the value
    pfirst = pValue; //first index for 2nd popped value of second container
    // });
    print("@@@ at the first page");
    print(pfirst);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: 150,
            child: TextButton(
                child: Text(
                  'Next Page ->',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  _navigateNextPageAndretriveValue(context);
                }),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}

// second page code started

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController designation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController phone = TextEditingController();

//  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    //   var rng = Random();
    //  var k = rng.nextInt(10000);
    //   final ref = fb.ref().child('todos/$k');

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employees"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: id,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'id',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: designation,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'designation',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'phone',
                ),
              ),
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () {
                Person p = Person(
                    name: name.text,
                    designation: designation.text,
                    id: id.text,
                    phone: phone.text);
                Navigator.pop(context, p);
              },
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
