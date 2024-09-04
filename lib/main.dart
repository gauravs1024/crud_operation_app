import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_application/view_data_delete_data.dart';
import 'package:crud_application/new_view_data.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud Application',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();


  Future <void> insert_record() async {
    if (name.text != "" || email.text != "" || password != "") {
      try {
        String uri = "http://192.168.103.74/projects/crud_application_api/insert_record.php";
        final res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text,
        },);
        final a = res.statusCode;
        print("response code======$a");
        var response = jsonDecode(res.body);
        print(" response=${res.body}");
        if (res.statusCode == 200) {
          print("record Inserted response ${res.body}");

          /// snackbar is used to show the userdefine messages as a prompt

        }
        else {
          print(
              "response to sahi aaya  nhi to tu check kar kahi kuch gadbad hai");
        }
        print("try is running");
      }

      catch (e, stackTrace) {
        print('aa gya exception $e');
        print('stack trace:$stackTrace');
      }
      const snackBar = SnackBar(
        content: Text('record inserted successfully!!!!'),
        duration:Duration(seconds:1),
        backgroundColor:Color(0xFF39E229),
        closeIconColor:Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      name.clear();
      email.clear();
      password.clear();
    }
    else {
      print("please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page", style: TextStyle(color: Colors.white38)),
        backgroundColor: Color(0xFF121111),
        elevation: 0,),


      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center the form
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.5), // Semi-transparent background
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(                               //  shows the box
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [




                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: name,
                          style: TextStyle(color: Colors.green),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the name',
                          labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: password,
                        style: TextStyle(color: Colors.green),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the pass',
                          labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: email,
                        style: TextStyle(color: Colors.green),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the email',
                          labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          insert_record();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white38,

                          // elevation: 0,
                        ),
                        child: const Text(
                          'Insert',
                          style: TextStyle(color: Colors.white),


                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => view_data()),
                          );


                          /// this navigator will remove the stack part from the app which holds the previous screen inside the stack
                          //   Navigator.of(context).pushAndRemoveUntil(
                          //       MaterialPageRoute(
                          //           builder: (context)=>view_data()),
                          //           (Route<dynamic> route)=>false);
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white38,
                        ),
                        child: const Text(
                          'View Data',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),




                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}