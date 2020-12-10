import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:handwriting/functions.dart';
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
    _image = null;

    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;

      //showImage(){
      if (image == null) {
        print("No Image selected here");
        /* return Text(
          "No Image selected here",
          style: TextStyle(
              color: Colors.grey[400], letterSpacing: 2.0, fontSize: 20),
        ); */
      }
      /* else {
        return Image.file(image, width: 200, height: 400);
      } */
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt_rounded,
                        color: Colors.white, size: 50.0),
                    onPressed: () async {
                      await getImage(true);
                      if (_image != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureRoute(file: _image)),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Take a picture',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2.0, fontSize: 20),
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
                ),
              ),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.insert_photo,
                        color: Colors.white, size: 50.0),
                    onPressed: () async {
                      await getImage(false);

                      if (_image != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureRoute(file: _image)),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'choose from Gallery',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2.0, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    //floatingActionButton: (
    //onPressed: (){},
    //ild: Text('Analyse Image'),
    // backgroundColor: Colors.blue,
  }
}

class PictureRoute extends StatelessWidget {
  final File file;

  const PictureRoute({Key key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Image"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            file == null
                ? Container()
                : Image.file(
                    file,
                    height: 500.0,
                    width: 300.0,
                  ),
            Row(
              //padding: EdgeInsets.all(20),
              children: [
                SizedBox(width: 70),
                IconButton(
                  icon: Icon(Icons.cancel_outlined,
                      color: Colors.red, size: 60.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 100),
                IconButton(
                  icon: Icon(Icons.check_circle_outline_rounded,
                      color: Colors.green, size: 60.0),
                  onPressed: () async {
                    var res = await pic2text(file);
                    var resStr = await res.stream.bytesToString();
                    var body = json.decode(resStr);

                    if (res.statusCode == 422) {
                      return print('an error occurred');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdRoute(body)),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  final List texts;
  ThirdRoute(this.texts);
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
            ListView(
              children: texts.map((text) {
                return ListTile(
                  title: Text(text),
                );
              }).toList(),
            ),
            RaisedButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                // Add your onPressed code here!
                Navigator.pop(context);
              },
              child: Text(
                'Select Another Picture',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
