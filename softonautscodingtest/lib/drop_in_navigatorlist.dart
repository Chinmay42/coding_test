import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softonautscodingtest/drop_in_center_book.dart';
import 'package:softonautscodingtest/round_button.dart';
import 'package:softonautscodingtest/signup.dart';
import 'package:softonautscodingtest/ui_util.dart';
//import 'package:softonautscodingtest/ui_util.dart';
import 'package:http/http.dart' as http;
//import 'package:toast/toast.dart';

class DropInNavigatorPage extends StatefulWidget {
  DropInNavigatorPage({Key? key, }) : super(key: key);





  @override
  _DropInNavigatorPageState createState() => _DropInNavigatorPageState();
}

class _DropInNavigatorPageState extends State<DropInNavigatorPage> {

  var searchController = TextEditingController();

  var response;

  String navigatorname="";
  String navigatorcity="";
  String navigatorzipcode="";
  String navigatorloaction='';
  late Map<String,dynamic> map1;
  late SharedPreferences prefs;

  void initState(){
    super.initState();
    getNavigatorDetails();
  }

  Future<dynamic> getNavigatorDetails() async {
    var url = Uri.parse('https://softonauts.com/clients/Android/get-drop-in-navigator-list');
    response = await http.post(url,
        headers: <String, String>{
          'Authorization' :'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.By2r2BwheJsbrEGrHOaMQwrrmlY7wHVFzWtuEmv39fM'
        },
        body:
        {
          'user_id':'96'
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    map1 = json.decode(response.body);
    prefs= await SharedPreferences.getInstance();

    setState(() {
      navigatorname = map1['drop_in_navigator_list'][0]['navigator_name'];
      navigatorcity= map1['drop_in_navigator_list'][0]['navigator_city'][0];
      navigatorzipcode= map1['drop_in_navigator_list'][0]['navigator_zipcode'][0];
      navigatorloaction= map1['drop_in_navigator_list'][0]['navigator_location'][0];
      prefs.setString('navigator_name', navigatorname);
      prefs.setString('navigator_location', navigatorloaction);
    });

    print(map1['drop_in_navigator_list'][0]['navigator_name']);
    //print(await http.read('https://example.com/foobar.txt'));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Drop-In'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(padding: EdgeInsets.all(15.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Drop-In Center',style:TextStyle(color: Colors.orange,fontWeight: FontWeight.bold
                    )),
                    SizedBox(height: 5.0,),
                    textFieldCreate(searchController, 'Search by Name, City, Zipcode', TextInputType.text, context, false,Colors.white,),
                    SizedBox(height: 10.0,),
                    Card(
                      //color: Colors.white,
                      elevation: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: (){
                                      Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DropInCenterBookPage()));
                                  },

                              leading: Icon(Icons.person,size: 40,),
                              title:Text('$navigatorname'),
                              subtitle: Row(
                                children: <Widget>[
                                  Text('$navigatorcity, $navigatorzipcode'),

                                ],

                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
