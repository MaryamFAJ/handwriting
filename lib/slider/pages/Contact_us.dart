import 'package:flutter/material.dart';
import 'package:handwriting/navigation_bloc/navigation_bloc.dart';

class ContactUs extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ Text(
        "Contact Us",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
        SizedBox(height: 40),
        Text(
            "Contact Us",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40, fontFamily: 'Bilbo'),),
        SizedBox(height: 40),
        Center(
          child: Text('9th Floor, Ibukun House'
              '14 Adetokunbo Ademola Street'
              'Victoria Island, Lagos',
              style: TextStyle( fontSize: 20,)),
        ),
        SizedBox(height: 20),
        Text('Nigeria: +234 706 604 8100',
            style: TextStyle( fontSize: 20,)),
          Text('USA: +1 718 502 4086',
                style: TextStyle( fontSize: 20,))]
    ));
  }
}
