import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

textFieldCreate(controller,hint,textType,context,bool,color,{IconData? iconData})
{
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: TextFormField(

      keyboardType: textType,
      controller: controller,
      obscureText: bool,
      cursorColor: Colors.black,
      autofocus: false,
      inputFormatters: _inputFormater(textType),
      decoration: InputDecoration(
        fillColor:Colors.white,
          border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(32.0)),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize:
            MediaQuery.of(context).size.height / 55,
            color: Colors.black,
          ),
          suffixIcon: Icon(
            iconData?? Icons.error,
            color: Colors.grey,
            size: MediaQuery.of(context).size.height / 30,
          )),
    ),
  );
}

_inputFormater(TextInputType textType)
{



  if(textType==TextInputType.number || textType== TextInputType.phone)
  {
    return [FilteringTextInputFormatter.allow(RegExp("[0-9]"))];
  }



}

submitButton(title,context,{Function? onPressed}) {

  return Container(
    margin: const EdgeInsets.only(top: 7.0),
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    //decoration: InputDecoration() ,
    color: Colors.white,
    child: new Row(
      children: <Widget>[

        new Expanded(

          child: RaisedButton(

            shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.white,width: 3),
                borderRadius: new BorderRadius.circular(30.0)
                ),
            color: Colors.orange,
            child: new Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:
                    MediaQuery.of(context).size.height / 50),
              ),
            ),
            onPressed:onPressed!(),
        ),
        ),
      ],
    ),
  );
}

showToast(String? message,{ToastGravity? gravity, Toast? lenghtShot})
{
  Fluttertoast.showToast(
      msg: message??'',
      toastLength: lenghtShot??Toast.LENGTH_SHORT,
      gravity: gravity??ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      textColor: Colors.white

  );
}