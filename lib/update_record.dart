import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_application/view_data_delete_data.dart';



class update_record extends StatefulWidget{
  String name;
  String email;
  String password;
  String id;
  update_record(this.name,this.email,this.password,this.id);
  @override
  State<update_record>createState()=>_update_recordState();

}
class _update_recordState extends State<update_record>{
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController id=TextEditingController();

  Future<void>update_record() async{
    try{
      String uri="http://192.168.103.74/projects/crud_application_api/update_record.php";
      var res=await http.post(Uri.parse(uri),body:{
        "name":name.text,
        "email":email.text,
        "password":password.text,
        "id":id.text,

      });
      //var response=jsonDecode(res.body);

      if(res.statusCode==200){
        print(" data updated successfully");
        name.clear();
        email.clear();
        password.clear();
        id.clear();

        const snackBar = SnackBar(
          content: Text('record updated successfully!!!!'),
          duration:Duration(seconds:1),
          backgroundColor:Color(0xFF0EC1D3),
          closeIconColor:Colors.white,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(

              context,MaterialPageRoute(
              builder: (context)=>view_data()));
        });




      }
      else{
        print("some issue occurred during the updation");
      }
          }

    catch(e){
    print(e);
    }
  }
  void initState(){
    name.text=widget.name;
    email.text=widget.email;
    password.text=widget.password;
    id.text=widget.id;
    super.initState();
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Update data",style: TextStyle(color: Colors.white60)),
          backgroundColor: Color(0xFF235323),
      elevation: 0,),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image2.jpg"),
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
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.1), // Semi-transparent background
                //   borderRadius: BorderRadius.circular(10),
                //   boxShadow: [
                //     BoxShadow(                               //  shows the box
                //       color: Colors.black.withOpacity(0.1),
                //       spreadRadius: 1,
                //       blurRadius: 5,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ],
                // ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [



                    Container(
                        margin:EdgeInsets.all(5),
                        child:TextFormField(
                            controller:name,
                            style: TextStyle(color: Colors.green),
                            decoration:InputDecoration(
                                border:OutlineInputBorder(),label:Text('enter the name'),
                              labelStyle: TextStyle(color: Colors.white),)
                        )
                    ),
                    Container(
                        margin:EdgeInsets.all(5),
                        child:TextFormField(
                            controller:password,
                            style: TextStyle(color: Colors.green),
                            decoration:InputDecoration(
                                border:OutlineInputBorder(),label:Text('enter the pass'),
                                   labelStyle: TextStyle(color: Colors.white),)
                        )
                    ),
                    Container(
                        margin:EdgeInsets.all(5),
                        child:TextFormField(
                            controller: email,style: TextStyle(color: Colors.green),

                            decoration:InputDecoration(
                                border:OutlineInputBorder(),label:Text('enter the email'),
                              labelStyle: TextStyle(color: Colors.white), )
                        )
                    ),
                    Container(
                        margin:EdgeInsets.all(5),
                        child:TextFormField(
                            controller: id,
                            style: TextStyle(color: Colors.blueGrey),
                            readOnly: true,
                            decoration:InputDecoration(
                                border:OutlineInputBorder(),label:Text('id is not editable'),
                              labelStyle: TextStyle(color: Colors.white),)
                        )
                    ),
                    Container(
                        margin:EdgeInsets.all(1),
                        child:Builder(
                          builder:(cntext){
                            return ElevatedButton(
                                onPressed:() {
                                  update_record();
                                },child:Text('Update Record'));
                          },
                        )
                    ),

                    Container(
                        margin:EdgeInsets.all(1),
                        child:Builder(
                          builder:(cntext){
                            return ElevatedButton(
                                onPressed:() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>view_data()));
                                },child:Text('view record'));
                          },
                        )
                    )

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