import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softonautscodingtest/json_slot.dart';
import 'package:softonautscodingtest/navigator_book_appointment.dart';
import 'package:softonautscodingtest/round_button.dart';
import 'package:softonautscodingtest/signup.dart';
import 'package:softonautscodingtest/ui_util.dart';
//import 'package:softonautscodingtest/ui_util.dart';
import 'package:http/http.dart' as http;
//import 'package:toast/toast.dart';

class DropInCenterBookPage extends StatefulWidget {
  DropInCenterBookPage({Key? key, }) : super(key: key);





  @override
  _DropInCenterBookPageState createState() => _DropInCenterBookPageState();
}

class _DropInCenterBookPageState extends State<DropInCenterBookPage> {

  var searchController = TextEditingController();

  var response;

  String navigatorname="";
  String navigatorloaction="";
  late SharedPreferences prefs;
  late Map<String,dynamic> map1;
  int slotlength=0;
  int i=0;
  int selectSlot =0;
  int morningslot=0;
  bool slot_timing=false;

  Autogenerated? mainData;

  void initState(){
    super.initState();
    getSharedPrefs();
    getTimeSlots();
    //rgetIndex();
    //getNavigatorDetails();
  }

  Future<dynamic> getSharedPrefs() async{
    prefs= await SharedPreferences.getInstance();
     setState(() {
       navigatorname = prefs.getString('navigator_name')!;
       navigatorloaction = prefs.getString('navigator_location')!;
     });
  }

  Future<dynamic> getTimeSlots() async {
    var url = Uri.parse('https://softonauts.com/clients/Android/get-time-slots');
    response = await http.post(url,
        headers: <String, String>{
          'Authorization' :'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.By2r2BwheJsbrEGrHOaMQwrrmlY7wHVFzWtuEmv39fM'
        },
        body:
        {
          'location_id':'16'
        });
    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    map1 = json.decode(response.body);
    //print(map1['timeslots'][1]);

    setState(() {
      mainData = Autogenerated.fromJson(map1);

          slotlength=map1['timeslots'].length;


    });

    //print(map1['drop_in_navigator_list'][0]['navigator_name']);
    //print(await http.read('https://example.com/foobar.txt'));
  }





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


                    Text('Drop-In Center',style:TextStyle(color: Colors.orange,fontWeight: FontWeight.bold
                    )),
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
                          children: <Widget>[
                            ListTile(

                                leading: Icon(Icons.person,size: 40,),
                                title:Text('$navigatorname'),
                                subtitle:
                                    Text('$navigatorloaction',maxLines: 2,),

                              //SizedBox(height: 20.0,),


                            ),



                          ],
                        ),
                      ),
                    ),
            SizedBox(height: 10.0,),
            Flexible(
             child:
             Container(
               //padding: EdgeInsets.all(0.0),
               height: 100,//MediaQuery.of(context).size.height * 0.35,
               //width: 50,
               child: ListView.builder(

                   scrollDirection: Axis.horizontal,
                   itemCount: slotlength, itemBuilder: (context, index) {
                 return Container(
                   width: MediaQuery.of(context).size.width * 0.6,
                   child: Card(
                     color: Colors.white,
                     child: Container(
                       width: 50,
                       child: ListTile(
                         onTap: (){

                           //print('${mainData?.timeslots[index].showDate.toString()}');
                           if(map1['timeslots'][index]['count'] > 0){
                             //showToast('no slots available');
                             setState(() {
                               selectSlot=index;
                               print('Print Value : $i');
                               slot_timing = true;
                               //print(slot_timing);

                             });
                             }
                           else
                             setState(() {
                               slot_timing=false;
                               //print(slot_timing);
                             });

                         },
                       title: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                       children:<Widget>[
                          Text(map1['timeslots'][index]['show_date'].toString(), style: TextStyle(color: Colors.black, fontSize: 15.0),),
                          SizedBox(height: 5.0,),
                          Text( map1['timeslots'][index]['count'].toString() == '0'
                            ? 'No Slots Available'
                            : '${map1['timeslots'][index]['count'].toString()} Slots Available',
                            style: TextStyle(color: Colors.orange, fontSize: 15.0,fontWeight: FontWeight.bold),)
                      ]
                 )
                       )
                   ),
                 )
                 );
               }),
             ),
            ),
            SizedBox(height: 10.0,),
          // map1['timeslots'][i]['count'] == '0'
           //?
          Visibility(
            visible: slot_timing,
              replacement: Text(''),
              // ignore: unnecessary_null_comparison
              child: Text(mainData?.timeslots[selectSlot].showDate.toString() != null
                 ? '${mainData!.timeslots[selectSlot].showDate.toString()}, Morning' : '' )),
          Visibility(
            visible: slot_timing,
              replacement: Container(),
              child:
              Flexible(
                flex: 2,
                child:  GridView.count(
                  crossAxisCount: 4,
                  children: new List<Widget>.generate(mainData?.timeslots?[selectSlot]?.slotes?.morning?.length??0, (index) {
                    print(slot_timing);
                    //if(map1['timeslots'][index]['count'] > 0) {
                      return new GridTile(
                        child: Card(
                        child: ListTile(
                          onTap: () async{
                            prefs= await SharedPreferences.getInstance();
                            String slot = '${mainData!.timeslots[selectSlot].showDate.toString()}, ${mainData?.timeslots?[selectSlot]?.slotes?.morning?[index]}';
                              prefs.setString('slot_final', slot) ;


                            //String slot = prefs.setString('slot_final', mainData!.timeslots[selectSlot].showDate.toString()) as String;
                            print("${mainData!.timeslots[selectSlot].showDate.toString()}, ${mainData?.timeslots?[selectSlot]?.slotes?.morning?[index]} ");
                            print('${mainData?.timeslots?[selectSlot]?.slotes?.morning?[index]}');
                            print(selectSlot);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => BookSlotPage(selectSlot: 's')));
                                },

                            title: Center(
                              child:Text(
                                  '${mainData?.timeslots?[selectSlot]?.slotes?.morning?[index]}',style: TextStyle(fontSize: 12.0),),
                            )
                        )
                        )
                      );
                    //}
                    //else{
                      return Text('');
                    //}
                  }),
                ),
            )

             // :  Container(),
          ),
            SizedBox(height: 10.0,),
            Visibility(
                visible: slot_timing,
                replacement: Text(''),
                child: Text('${mainData!.timeslots[selectSlot].showDate.toString()}, Afternoon')),


            Visibility(
                visible: slot_timing,
                replacement: Container(),
                child:
                Flexible(
                  flex: 2,
                  child:  GridView.count(

                    crossAxisCount: 4,
                    children: new List<Widget>.generate(mainData?.timeslots?[selectSlot]?.slotes?.afternoon?.length??0, (index) {
                      print(slot_timing);
                      //if(map1['timeslots'][index]['count'] > 0) {
                      return new GridTile(
                        child: new Card(
                            color: Colors.white,
                            child: ListTile(
                                onTap: (){
                                  String slot = '${mainData!.timeslots[selectSlot].showDate.toString()}, ${mainData?.timeslots?[selectSlot]?.slotes?.afternoon?[index]}';
                                  prefs.setString('slot_final', slot) ;

                                  //String slot = mainData?.timeslots?[selectSlot]?.slotes?.morning!?[index];
                                  print('${mainData?.timeslots?[selectSlot]?.slotes?.afternoon?[index]}');
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => BookSlotPage(selectSlot: 's')));

                                },
                              title: Center(
                              child:Text(
                                  '${mainData?.timeslots?[selectSlot]?.slotes?.afternoon?[index]}',style: TextStyle(fontSize: 12.0)),
                            )
                                  )
                        ),
                      );
                      //}
                      //else{
                      return Text('');
                      //}
                    }),
                  ),
                )

              // :  Container(),r
            ),
            SizedBox(height: 10.0,),
            /*Visibility(
                visible: slot_timing,
                replacement: Text(''),
                child: Text('${mainData!.timeslots[0].showDate.toString()}, Evening')),

            Visibility(
                visible: slot_timing,
                replacement: Container(),
                child:
                Flexible(
                  child:  GridView.count(
                    crossAxisCount: 4,
                    children: new List<Widget>.generate(mainData?.timeslots?[4]?.slotes?.evening?.length??0, (index) {
                      print(slot_timing);
                      //if(map1['timeslots'][index]['count'] > 0) {
                      return new GridTile(
                        child: new Card(
                            color: Colors.white,
                            child: new Center(
                              child: new Text(
                                  '${mainData?.timeslots?[4]?.slotes?.evening?[index]}'),
                            )
                        ),
                      );
                      //}
                      //else{
                      return Text('');
                      //}
                    }),
                  ),
                )

              // :  Container(),
            ),*/
            //SizedBox(height: 50.0,)
          ],
                )),
          // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
