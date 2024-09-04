import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_application/update_record.dart';



class view_data extends StatefulWidget{
  view_data({Key?key}):super(key:key);
  @override
  State<view_data> createState()=>_view_dataState();

}
class _view_dataState extends State<view_data>{
  List userdata=[];



  Future<void>delrecord( var id) async{

    try{
      String uri="http://192.168.103.74/projects/crud_application_api/del_record.php";
      var res=await http.post(Uri.parse(uri),body:{"id":id});
      print(" response=${res.body}");
      if (res.statusCode==200){
        print("data deleted successfully");
      }

      else{
        print("some error occurred during the deletion process");
      }
      const snackBar = SnackBar(
        content: Text('record Deleted successfully!!!!'),
        duration:Duration(seconds:1),
        backgroundColor:Color(0xFF1A237E),
        closeIconColor:Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getrecord();
        /*var response;
      response=jsonDecode(res.body);                     // if data is coming from the api it throughs an exception name "FormatException: Unexpected character (at character 1)"
      print("Response body: ${res.body}");
      if(response.containsKey("success") && res==200){
        print("record deleted successfully");

      ///showing the error  "catch an exception FormatException: Unexpected character (at character 1)
      // I/flutter (22389): data inserted succesfully{"success":"true"}"

      }
      else{
        print("some issue occurred");
      }*/
    }

    catch(e){
    print("catch is running $e");
    }


  }

  Future<void> getrecord() async{

    String uri="http://192.168.103.74/projects/crud_application_api/view_data.php";
    try{
      var response=await http.get(Uri.parse(uri));
      if(response.statusCode==200){
        print("data fetched successfully");
      }
      else {
        print(" fetching data is not success fully done some error occurred");
      }
     setState(() {

       userdata=jsonDecode(response.body);

     });
    }
    catch(e){
        print(e);
    }

  }
  @override
  void initState(){
    getrecord();
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Text("View Data",
          style: TextStyle(color: Colors.white60)
      ),
          backgroundColor: Color(0xFF121111),
      elevation: 0,
      ),
      body: Stack(
        children: [
          // Optional: Background image or other widgets
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_image3.jpg', // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content: ListView
          Positioned.fill(
            child: ListView.builder(
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                 int count=index;
                return Card(
                  margin: EdgeInsets.all(10), // Styling of card
                  color: Colors.white,
                    //elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xFF1A237E),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => update_record(
                             userdata[index]["name"],
                             userdata[index]["email"],
                            userdata[index]["password"],
                            userdata[index]["id"],
                          ),
                        ),
                      );
                    },
                    leading: Icon(CupertinoIcons.arrow_right_arrow_left_circle_fill),
                    title: Text('${++count}  '+"name: "+
                      userdata[index]["name"]!,
                      style: TextStyle(color: Color(0xFF42A5F5)),
                    ),
                    subtitle: Text(
                      style: TextStyle(color: Colors.green),
                      '${"email: "+userdata[index]["email"]}\n${"id: "+userdata[index]["id"]}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        delrecord(userdata[index]["id"]!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
