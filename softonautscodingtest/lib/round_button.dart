import "package:flutter/material.dart";

class SimpleRoundButton extends StatelessWidget {

  final Color backgroundColor;
  final Text buttonText;
  final Color textColor;
  final Function onPressed;

  SimpleRoundButton({
    required this.backgroundColor,
    required this.buttonText,
    required this.textColor,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7.0),
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
          color: Colors.orange,
           // Set border width//
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
         // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
      ),
      child: new Row(
        children: <Widget>[

          new Expanded(
            child: FlatButton(

              shape: new RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange,width: 3),
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.orange,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: buttonText,
                  ),
                ],
              ),
              onPressed: onPressed(),
            ),
          ),
        ],
      ),
    );
  }
}