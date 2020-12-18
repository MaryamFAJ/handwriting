import 'dart:convert';
import 'dart:io';

import 'package:handwriting/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<http.StreamedResponse> pic2text(File file) async {
  var url =
      'http://handwriting-extraction.herokuapp.com/predict handwriting local images';
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Accept'] = 'application/json';
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromPath('Image', file.path));
  var res = await request.send();
  return res;
}


Future url2text(String link) async {

  final uri = "https://handwriting-extraction.herokuapp.com/predict handwriting url";
  final headers = {'Content-Type': 'application/json', 'accept': 'application/json'};
  Map<String, dynamic> body = {'url': link};
  String jsonBody = json.encode(body);


  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
  );

  return response;
  //String responseBody = response.body;
}


makePostRequest(String link) async {

  final uri = "https://handwriting-extraction.herokuapp.com/predict handwriting url";
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'url':link};
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;
}