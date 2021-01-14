import 'package:flutter/material.dart';
import 'package:handwriting/navigation_bloc/navigation_bloc.dart';



class Notes {
  final String name;
  final String description;

  Notes({@required this.name, @required this.description});
}

class FAQ extends StatelessWidget with NavigationStates {

  List<Notes> notes = [
    Notes(
        name: 'crunchy', description: 'a fierce Alligator with many teeth'
    ),
    Notes(
        name: 'grunchy', description:' too big and hungry looking'
    ),
    Notes(
        name: 'gaunty', description:' too lean and hungry looking'
    ),
    Notes(
        name: 'Loading', description: 'a fierce Alligator with many teeth'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Text(
            "Frequently Asked Questions",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,fontFamily: 'Bilbo'),
          ),
          SizedBox(height: 40),
          Column(
            children: notes.map((Notes notes) => Card(
              child: ListTile(
                title:Text(notes.name),
                subtitle: Text(notes.description),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}


