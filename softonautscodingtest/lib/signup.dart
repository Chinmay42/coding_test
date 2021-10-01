import 'package:flutter/material.dart';
import 'package:softonautscodingtest/round_button.dart';
import 'package:softonautscodingtest/ui_util.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
       centerTitle: true,
       backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(padding: EdgeInsets.all(15.0),
        child:SingleChildScrollView(
          child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            textFieldCreate(firstNameController, 'First Name', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),
                            textFieldCreate(firstNameController, 'Middle Name', TextInputType.text, context,true,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Last Name', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Email', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Password', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'BirthDate', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Contact No', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'SSN(Last 4 digits)', TextInputType.text, context,Colors.transparent,false,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Address1', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Address2', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),


                            textFieldCreate(firstNameController, 'City', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Select State', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            textFieldCreate(firstNameController, 'Zipcode', TextInputType.text, context,false,Colors.transparent,iconData: Icons.email),
                            SizedBox(height: 10.0,),

                            /*submitButton('Submit', context,
                              onPressed: () {
                                print('submit details');
                              }
                          ),*/
                            SimpleRoundButton(
                              textColor: Colors.white,
                              backgroundColor: Colors.orange,
                              onPressed: (){},
                              buttonText: Text('Sign Up',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 15.0,),
                          /*  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Forgot Password',style: TextStyle(color: Colors.black),),
                                Text('Sign Up',style: TextStyle(color: Colors.black),),
                              ],
                            ),*/
                            SizedBox(height: 15.0,),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
