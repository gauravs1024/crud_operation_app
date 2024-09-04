// detail_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Item {
  final String id;
  final String name;
  final String password;

  Item({required this.id, required this.name, required this.password});
}


class new_view_data extends StatelessWidget {
  @override




  Future<List<Item>> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.144.74/projects/crud_application_api/view_data.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Item(
        id: item['id'],
        name: item['name'],
        password: item['email'],
      )).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Record in Database'),
      toolbarHeight: 40,),
      body: FutureBuilder<List<Item>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final items = snapshot.data!;
            int i=0;
            var arr=[];
            
            return ListView.builder(
             // padding: const EdgeInsets.all(8),

              itemCount: items.length,

              itemBuilder: (context, index) {
                return Card(
                    /// for the 'ListView()' you can also use below and for the 'Card' the code is written belwo
                    // leading:Icon(CupertinoIcons.rectangle_stack_badge_person_crop),
                    // title: Text(items[index].name,style: TextStyle(color:Color(0xFF42A5F5),backgroundColor: Color(0xFF1A237E))),
                    //
                    // subtitle: Text(items[index].password+"\n "+items[index].id),


                  margin: EdgeInsets.all(5),                      // styling of card
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xFF1A237E),
                      width:5
                    )
                  ),
                    child: ListTile(
                      leading:Icon(CupertinoIcons.arrow_right_arrow_left_circle_fill),
                      title: Text(items[index].name,style: TextStyle(color:Color(0xFF42A5F5),/*backgroundColor: Color(0xFF1A237E)*/)),
                      subtitle: Text(items[index].password+"\n "+items[index].id),
                      trailing:IconButton(
                        icon:Icon(Icons.delete),
                        onPressed:(){

                        },),
                    ) ,

                );
              },
            );

          }
        },
      ),
    );
  }
}
