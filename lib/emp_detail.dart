import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realtime_db/image_upload.dart';
import 'all_emp_list.dart';
import 'loadimage.dart';

class SecondPage extends StatelessWidget {
  final Person person;

  const SecondPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Detail Page"),
      ),
      body: Card(
        elevation: 2,
        margin: EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          height:400,
          width: 350,
          child: Column(
            children: [
              SizedBox(height:10),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: FirebaseImage(imagePath: 'images/${person.phone}.jpg'),
              ),
              SizedBox(height:10),
              Text("Name: " + person.name, style: TextStyle(fontSize: 20),),
              SizedBox(height:10),
              Text("Designation: " + person.designation,style: TextStyle(fontSize: 20),),
              SizedBox(height:10),
              Text("Employee ID: " + person.id,style: TextStyle(fontSize: 20),),
              SizedBox(height:10),
              TextButton(onPressed: () {_callNumber(person.phone);},
              child: Text("Contact No: "+ person.phone,style: TextStyle(fontSize: 20),),),
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 40,)),
                  SizedBox(width:250),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete,size:40)),
                ],
              ),
              IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageUploads(phoneNo: person.phone)));}, icon: Icon(Icons.upload_file_outlined,size: 40,))
            ],
          ),
        ),
      )
    );
  }
}

_callNumber(String number) async{
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

