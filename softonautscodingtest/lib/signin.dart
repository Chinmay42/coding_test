import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:softonautscodingtest/drop_in_navigatorlist.dart';
import 'package:softonautscodingtest/round_button.dart';
import 'package:softonautscodingtest/signup.dart';
import 'package:softonautscodingtest/ui_util.dart';
//import 'package:softonautscodingtest/ui_util.dart';
import 'package:http/http.dart' as http;
//import 'package:toast/toast.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key, }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

var emailController = TextEditingController();
var passController= TextEditingController();
late Map<String,dynamic> map;



Future<dynamic> login() async {
  var url = Uri.parse('https://softonauts.com/clients/Android/users-login');
  var response = await http.post(url,
      headers: <String, String>{
        'Authorization' :'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.By2r2BwheJsbrEGrHOaMQwrrmlY7wHVFzWtuEmv39fM'
      },
      body:
  {
    'username': '${emailController.text}',
    'password': '${passController.text}',
    'fcm_id' :''
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body.toString()}');
  //print('${response.body['data']}');
  map = json.decode(response.body);
  print(map['data']);
  //print(map['data']['email']);

    if(map['code'] == 200) {
      showToast('login successful');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DropInNavigatorPage()));
    }
    else{
      showToast('${map['message']}');
    }

  //print(await http.read('https://example.com/foobar.txt'));
}



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(padding: EdgeInsets.all(15.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    //color: Colors.white,
                    elevation: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          textFieldCreate(emailController, 'Email', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                          SizedBox(height: 10.0,),
                          textFieldCreate(passController, 'Password', TextInputType.text, context,true,Colors.transparent,iconData: Icons.email),
                          SizedBox(height: 10.0,),
                          /*submitButton('Submit', context,
                              onPressed: () {
                                print('submit details');
                              }
                          ),*/
                          SizedBox(height: 10.0,),
                          FlatButton(

                            shape: new RoundedRectangleBorder(
                                side: BorderSide(color: Colors.orange,width: 3),
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.orange,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  child: Text('Sign In',style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                            onPressed:(){
                              if(emailController.text.isEmpty && passController.text.isEmpty)
                                {
                                  print('enter credentials');
                                  showToast('enter credentials');
                                  //Toast.show('Enter Credentials', context,gravity: Toast.BOTTOM,duration: Toast.LENGTH_LONG);
                                }
                              else {
                                login();
                                //showToast('Login Successful');

                                //Toast.show('Login Successful', context,gravity: Toast.BOTTOM,duration: Toast.LENGTH_LONG);
                              }                            },
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Forgot Password',style: TextStyle(color: Colors.black),),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage()));

                                },
                              child:Text('Sign Up',style: TextStyle(color: Colors.black),),
                              ),],
                          ),
                          SizedBox(height: 15.0,),
                          Text('Terms of Use',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),),
                          SizedBox(height: 15.0,),
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
