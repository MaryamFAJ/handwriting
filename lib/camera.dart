import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class MyApps extends StatefulWidget {

  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  File _image;
  Future getImage(bool isCamera) async {
    File image;

    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState((){
      _image = image;

      showImage(){
        if(image == null){
          return Text("No Image selected here",
            style: TextStyle(
                color: Colors.grey[400],
                letterSpacing: 2.0,
                fontSize: 20),
          );



        }else {
          Image.file(image,width:200,height:400);
        }
      }
    });
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70.0),
            Row(
              children:<Widget> [



                Container(
                  color:Colors.lightBlueAccent,
                  padding: EdgeInsets.all(20),
                  child: Text('Select Image from Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 15 ,
                    ),),
                ),
                Container(
                  width: 50,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    border: Border(
                      right: BorderSide.none,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.insert_drive_file,
                        color: Colors.white,
                        size: 37.0),
                    onPressed: (){
                      getImage(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdRoute(file:_image )),
                      );
                      //


                    },
                  ),
                ),


              ],),





            SizedBox(height: 70.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt,
                      color: Colors.grey[500],
                      size: 38.0),
                  onPressed: (){
                    getImage(true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdRoute(file:_image )));
                  },

                ),
                Text('Take a picture',
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      letterSpacing: 2.0,
                      fontSize: 20),
                ),
                //_image == null? Container() : Image.file(_image, height: 200.0, width: 300.0,),

              ],
            ),

            SizedBox(height: 70.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Paste URL of your Image',
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      letterSpacing: 2.0,
                      fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons. public,
                      color: Colors.grey[500],
                      size: 38.0),
                  onPressed: (){
                    getImage(true);
                  },

                ),




              ],
            ),
          ], ),
      ), );

    //floatingActionButton: (
    //onPressed: (){},
    //ild: Text('Analyse Image'),
    // backgroundColor: Colors.blue,







  }
}

class PictureRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),

    );
  }
}



class ThirdRoute extends StatelessWidget {
  final File file;

  const ThirdRoute({Key key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Column(
          children: [
            file == null? Container() : Image.file(file, height: 500.0, width: 300.0,),
            RaisedButton(
              color: Colors.lightBlueAccent,
              onPressed: (){

                // Add your onPressed code here!
                Navigator.pop(context);
              },
              child:
              Text('Select Another Picture',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 20,
                ),),

            )],
        ),
      ),
    );
  }
}