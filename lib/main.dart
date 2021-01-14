import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handwriting/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:handwriting/camera.dart';
import 'package:handwriting/functions.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:handwriting/slider/sidebar/sidebar_layout.dart';

void main() {
  runApp(MaterialApp(
    title: 'Handwriting Extraction',
    home: Welcome(),
  ));
}

class DialogWithTextField extends StatefulWidget {
  @override
  _DialogWithTextFieldState createState() => _DialogWithTextFieldState();
}

class _DialogWithTextFieldState extends State<DialogWithTextField> {
  ProgressDialog pr;



  _displayDialog() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    TextEditingController myController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }
  TextEditingController myController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [IconButton(
                    icon: Icon(Icons.cloud_circle,
                        color: Colors.lightBlueAccent, size: 70.0
                    ),
                    onPressed: _displayDialog,
                  ),
          SizedBox(height: 40),
          Center(
            child: Text('URL',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    letterSpacing: 2.0,
                    fontSize: 20)),
          ),

        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_name

TextEditingController myController = new TextEditingController();

@override

Widget _DialogWithTextField(BuildContext context) => Container(



      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),

      child: Column(
        children: <Widget>[
          SizedBox(height: 24),
          Text(
            "Web Address (URL)".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          SizedBox(height: 10),
          Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
              child: TextField(
                controller: myController,

                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,

                decoration: InputDecoration(

                  labelText: 'URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),

              )),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 8),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  "Save".toUpperCase(),
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: ()  async {
                  //pr.show();
                  //final uri = "https://handwriting-extraction.herokuapp.com/predict handwriting url";
                  //final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
                  //Map<String, dynamic> body = {'url': myController.text};
                  //String jsonBody = json.encode(body);


                  //Response response = await post(
                    //uri,
                    //headers: headers,
                    //body: jsonBody,
                  //);
                  //print(response);

                  try{
                    var res = await url2text(myController.text);
                    var response = res.body;
                    var body = json.decode(response);
                    print(body);
                  }
                  catch(e){
                    print('there is an error with the url submitted: $e');

                  }
                  var res = await url2text(myController.text);
                  var response = res.body;
                  var body = json.decode(response);
                  print(body);



                  //if(res.statusCode == 200){
                    //print('error');

                  //}

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdRoute(body)),
                  );
                }
              )
            ],
          ),
        ],
      ),
    );
