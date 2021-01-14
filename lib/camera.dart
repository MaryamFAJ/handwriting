import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:handwriting/functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share/share.dart';
import 'package:flutter_tts/flutter_tts.dart';


class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}


class _MyAppsState extends State<MyApps> {
  //TEXT@SPEECH

  //end of TEXT2SPEECH
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
    ProgressDialog pr;
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
              padding: EdgeInsets.all(60),
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

class PictureRoute extends StatefulWidget {
  final File file;

  const PictureRoute({Key key, this.file}) : super(key: key);

  @override
  _PictureRouteState createState() => _PictureRouteState();
}

class _PictureRouteState extends State<PictureRoute> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Image"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            widget.file == null
                ? Container()
                : Image.file(
              widget.file,
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
                    pr.show();

                    var res = await pic2text(widget.file);
                    var resStr = await res.stream.bytesToString();
                    var body = json.decode(resStr);
                    print(body);


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

class ThirdRoute extends StatefulWidget {

   List<dynamic> texts;
  ThirdRoute(this.texts);


  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

enum TtsState { playing, stopped }

class _ThirdRouteState extends State<ThirdRoute> {
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print("Available languages ${languages}");
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    var _newVoiceText = widget.texts.join('');

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);

      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }


  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language);
    });
  }


  @override
  Widget build(BuildContext context) {
    //print(widget.texts);
    return Scaffold(
      appBar: AppBar(
        title: Text("Extracted Text"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  children: widget.texts.map((text) {
                    return ListTile(
                        title: Text(text,
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 20,
                        ),
                    ),
                    );
                  }).toList(),
                ),
              ),
            ),
            //RaisedButton(
            //color: Colors.lightBlueAccent,
            //onPressed: () {
            // Add your onPressed code here!
            //Navigator.pop(context);
            //},
            //child: Text(
            //'Select Another Picture',
            //style: TextStyle(
            //color: Colors.white,
            //letterSpacing: 2.0,
            //fontSize: 20,
            //),
            //),
            // ),
            _buildSliders(),
            Row(
              children: [
                SizedBox(width: 40,),
                bottomBar(),
                SizedBox(width: 40,),
                IconButton(
                  icon: Icon(Icons.share_sharp,
                      color: Colors.lightBlueAccent, size: 50.0),
                  onPressed: () {
                    Share.share( widget.texts.join(''));
                  },
                ),],

            ),

          ],
        ),
      ),

    );

  }
  Widget _buildSliders() {
    return Column(
      children:[
            Text("Pitch",
            style: TextStyle(color: Colors.black, letterSpacing: 2.0, fontSize: 20),
    ),_pitch(),
        Text("Speech Rate",
          style: TextStyle(color: Colors.blue, letterSpacing: 2.0, fontSize: 20),
        ),
        _rate()],
    );
  }

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          title: 'volume';
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $volume");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.2,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $pitch",
      activeColor: Colors.black54,
    );
  }

  Widget _rate() {
    title: 'Speech rate';
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 2.0,
      divisions: 20,
      label: "Rate: $rate",
      activeColor:
      Colors.blue,
    );
  }

  bottomBar() =>Container(
    margin: EdgeInsets.all(10.0),
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: _speak,
          child: Icon(Icons.play_arrow),
          backgroundColor: Colors.green,

        ),
        SizedBox(width: 40),

        FloatingActionButton(
          onPressed: _stop,
          backgroundColor: Colors.red,
          child: Icon(Icons.stop),
        ),
      ],
    ),
  );
}