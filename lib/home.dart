
import 'package:handwriting/main.dart';
import 'package:flutter/material.dart';
import 'package:handwriting/camera.dart';



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
          SizedBox(height: 30),
          Container(
              height: 150,

              child: DialogWithTextField(),
            ),

        ],
      )
        );
    // Add your onPressed code here!
  }
// Navigate to second route when tapped.

}


