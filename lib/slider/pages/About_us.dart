import 'package:flutter/material.dart';
import 'package:handwriting/navigation_bloc/navigation_bloc.dart';

class AboutUs extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Center(
            child: Text(
              "Who Are We?",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, fontFamily: 'Bilbo'),
            ),
          ),
          SizedBox(height: 40),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "We are an "
                      "IT-Business Process Outsourcing service provider leveraging the power of artificial intelligence,"
                      " data mining, and predictive analytics to unlock value and achieve business transformation for clients "
                      "around the world through services that boost process and operational efficiencies. We help businesses "
                      "achieve digital transformation by turning data into actionable insight and business intelligence.",
                  style: TextStyle( fontSize: 18, letterSpacing: 1.0),
      ),
            ),
          ),
        ],
      ),
    );
  }
}
