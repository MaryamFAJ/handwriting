import 'package:flutter/material.dart';
import 'package:handwriting/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Handwriting Extraction',
    home: Home(),
  ));
}

class DialogWithTextField extends StatefulWidget {
  @override
  _DialogWithTextFieldState createState() => _DialogWithTextFieldState();
}

class _DialogWithTextFieldState extends State<DialogWithTextField> {
  _displayDialog() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.lightBlueAccent,
          child: Text(
            "URL",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _displayDialog,
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
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
              child: TextFormField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Text Form Field 1',
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
                onPressed: () {
                  print('Update the user info');
                  // return Navigator.of(context).pop(true);
                },
              )
            ],
          ),
        ],
      ),
    );

