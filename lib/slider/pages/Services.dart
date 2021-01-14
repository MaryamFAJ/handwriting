import 'package:flutter/material.dart';
import 'package:handwriting/navigation_bloc/navigation_bloc.dart';

class Services extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Services",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
