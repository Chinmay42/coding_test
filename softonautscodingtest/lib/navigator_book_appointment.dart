import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softonautscodingtest/json_slot.dart';
import 'package:softonautscodingtest/round_button.dart';
import 'package:softonautscodingtest/signup.dart';
import 'package:softonautscodingtest/ui_util.dart';
//import 'package:softonautscodingtest/ui_util.dart';
import 'package:http/http.dart' as http;
//import 'package:toast/toast.dart';

class BookSlotPage extends StatefulWidget {
  BookSlotPage({Key? key,  required this.selectSlot}) : super(key: key);


final String selectSlot;



  @override
  _BookSlotPageState createState() => _BookSlotPageState(selectSlot);
}

class _BookSlotPageState extends State<BookSlotPage> {

  _BookSlotPageState(String selectSlot){
    selectSlot1=this.selectSlot1;

  }

  String selectSlot1='0';

  var searchController = TextEditingController();

  var response;

  String navigatorname="";
  String navigatorloaction="";
  late SharedPreferences prefs;
  late Map<String,dynamic> map1;
  int slotlength=0;
  int i=0;
  //int selectSlot =0;
  int morningslot=0;
  bool slot_timing=false;
  String slot='';

  Autogenerated? mainData;

  void initState(){
    super.initState();
    getSharedPrefs();
    getNavigatorDetails();
    //getTimeSlots();
    //rgetIndex();
    //getNavigatorDetails();
  }

  final List<String> _dropdownValues = [

    "Select a Batch",
    "Morning Batch",
    "Afternoon Batch",
  ];

  String _value= '';


  Future<dynamic> getSharedPrefs() async{
    prefs= await SharedPreferences.getInstance();
    setState(() {
      navigatorname = prefs.getString('navigator_name')!;
      navigatorloaction = prefs.getString('navigator_location')!;
      slot = prefs.getString('slot_final')!;
      print(selectSlot1);
    });
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
    //mainData = json.decode(response.body);
    //rprint(mainData);
    setState(() {
      mainData = Autogenerated.fromJson(map1);
      print(map1['drop_in_navigator_list'][0]['appointment_type'][0]['appointment_type']);
      //print(map1['timeslots']);
      });

    //print(map1['drop_in_navigator_list'][0]['navigator_name']);
    //print(await http.read('https://example.com/foobar.txt'));
  }


String _chosenValue='dssdds';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //title: Text('Drop-In'),r
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(padding: EdgeInsets.all(15.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              SizedBox(height: 5.0,),
              Text('Navigator Details',style:TextStyle(color: Colors.orange,fontWeight: FontWeight.bold
              )),
              //                   textFieldCreate(searchController, 'Search by Name, City, Zipcode', TextInputType.text, context, false,Colors.white,),
              SizedBox(height: 10.0,),
              Card(
                //color: Colors.white,
                elevation: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(

                        leading: Icon(Icons.person,size: 40,),
                        title:Text('$navigatorname'),
                        subtitle:
                        Text('$navigatorloaction',maxLines: 2,),

                        //SizedBox(height: 20.0,),


                      ),
                      SizedBox(height: 30.0,),

                      Text('Appointment Type'),
                      SizedBox(height: 20.0,),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                            border: Border.all(color: Colors.transparent, width: 4),
                            borderRadius: BorderRadius.circular(8),),

                            child: Text('${map1['drop_in_navigator_list'][0]['appointment_type'][0]['appointment_type']}')
                      ),
                      SizedBox(height: 20.0,),

                      Text('Date and Time'),
                      SizedBox(height: 5.0,),
                      Text('$slot',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.0,),
                      FlatButton(

                        shape: new RoundedRectangleBorder(
                            side: BorderSide(color: Colors.orange,width: 3),
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Colors.orange,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text('Book Appointment',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                        onPressed:(){
                            showToast('Congratulations!!\nAppointment Booked Successfully');
                          }
                      ),
                      SizedBox(height: 20.0,),



                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0,),

            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
