import 'package:flutter/material.dart';
import 'package:handwriting/home.dart';



void main() {
  runApp(MaterialApp(
    title: 'Handwriting Extraction',
    home: Welcome(),
  ));
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        margin:const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        width: 340,
        height: 700,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,

          border: Border.all(

            color: Colors.white,
            width:1.5,

          ),
          borderRadius: BorderRadius.circular(14.0),
        ),

        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Container(

                child: Text('Handwriting Extraction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Bilbo',
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 57,
                  ),
                ),
              ),
              SizedBox(height: 70),


              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),

                ),

                child:

                Text('Get Started',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    letterSpacing: 2.0,
                    fontSize: 25,

                  ),),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstRoute()),
                  );
                },

              ),
              SizedBox(height:20),
            ],
          ),
        ),
      ),
    );
    // Add your onPressed code here!
  }
// Navigate to second route when tapped.
}


