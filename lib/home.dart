import 'dart:io';
import 'package:handwriting/main.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/foundation.dart';
import 'package:handwriting/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


void main() {
  runApp(MaterialApp(
    title: 'Handwriting Extraction',
    home: FirstRoute(),
  ));
}
class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Upload Image ',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu,),
              onPressed: () { Scaffold.of(context).openDrawer();},
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),

      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: <Widget>[
          Container(
            height: 400,
            child: MyApps(),
          ),
          Container(
            height: 50,

            child: DialogWithTextField(),
          ),
        ],
      )
        );
    // Add your onPressed code here!
  }
// Navigate to second route when tapped.

}























class Notes {
  final String name;
  final String description;

  Notes({@required this.name, @required this.description});
}

class SecondRoute extends StatelessWidget{


  List<Notes> notes = [
    Notes(
        name: 'crunchy', description: 'a fierce Alligator with many teeth'
    ),
    Notes(
        name: 'grunchy', description:' too big and hungry looking'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[900],
      appBar: AppBar(

          title: Text('Share Appbar '),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0.0),
      body: Column(
        children: notes.map((Notes notes) => Card(
          child: ListTile(
            title:Text(notes.name),
            subtitle: Text(notes.description),
            onTap: ()=>share(context, notes),
          ),
        )).toList(),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Share.share('jiiii');
          // Add your onPressed code here!
        },

        label: Text('Share'),
        icon: Icon(Icons.share),
        backgroundColor: Colors.amber,
      ),
    );


  }
  void share(BuildContext context, Notes notes) {
    final RenderBox box = context.findRenderObject();
    final String text = '${notes.name} - ${notes.description}';

    Share.share(
      text, subject: notes.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}



