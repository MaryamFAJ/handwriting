import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Service{
  File image;
  Service(this.image);
}


// ignore: camel_case_types
class handwritingService extends StatefulWidget {
  @override
  _handwritingServiceState createState() => _handwritingServiceState();

  void addService(Service test) async {
    var url = 'https://handwriting-extraction.herokuapp.com/predict handwriting local images';
    try {
      final response = await http.post(url, body: json.encode(test));
    }
    catch (e) {
    }
  }
}

class _handwritingServiceState extends State<handwritingService> {
  Future<void> addService(Service test) async {
    var url = 'https://handwriting-extraction.herokuapp.com/docs#/default/predict__predict_handwriting_local_images_post';
    try {
      final response = await http.post(url, body: json.encode(test));
    }
    catch (e) {
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
