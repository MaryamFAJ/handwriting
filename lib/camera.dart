import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:handwriting/handwriting_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';




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
      _image = File(image.path);
      //instantiate service class
      Service test = Service(_image);

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


  //var response = await http.post(url, body: _image);


  @override

  Widget build(BuildContext context){


    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Container(
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/blur.jfif"),
          fit: BoxFit.cover,
        ),),
              child:
              Column(
                children: [
                  IconButton(
                      icon: Icon(Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 50.0),
                      onPressed: (){
                        getImage(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PictureRoute(picture:_image )),
                        );

                        },

                  ),
                  SizedBox(height:20),
                  Text('Take a picture',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 20),
                  ),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bl.jfif"),
                  fit: BoxFit.cover,
                ),),
              child:
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.insert_photo,
                        color: Colors.white,
                        size: 50.0),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PictureRoute(picture:_image )),
                      );
                      getImage(false);
                      },

                  ),
                  SizedBox(height:20),
                  Text('choose from Gallery',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
],
    ), ),);

    //floatingActionButton: (
    //onPressed: (){},
    //ild: Text('Analyse Image'),
    // backgroundColor: Colors.blue,







  }
}

class PictureRoute extends StatefulWidget {
  final File picture;

  const PictureRoute({Key key, this.picture}) : super(key: key);


  @override

  _PictureRouteState createState() => _PictureRouteState();
}

class _PictureRouteState extends State<PictureRoute> {
  File picture;




  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Image"),
      backgroundColor: Colors.lightBlueAccent,),


      body: Center(
        child: Column(
          children: [
            widget.picture == null? Container() : Image.file(widget.picture, height: 500.0, width: 300.0,),

            Row(
              //padding: EdgeInsets.all(20),
              children: [
                SizedBox(width: 70),
                IconButton(
            icon: Icon(Icons.cancel_outlined,
                color: Colors.red,
                size: 60.0),
      onPressed: (){
        Navigator.pop(context);
      },

    ),
                SizedBox(width: 100),

                IconButton(
                  icon: Icon(Icons.check_circle_outline_rounded,
                      color: Colors.green,
                      size: 60.0),
                  onPressed: (){
                    handwritingService().addService(Service(picture));

                  },)
              ],
            )],
        ),
      ),


    );
  }
}


class ThirdRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extracted Text"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
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


//diaglog
