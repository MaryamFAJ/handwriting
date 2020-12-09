import 'dart:io';

import 'package:http/http.dart' as http;

Future<http.StreamedResponse> pic2text(File file) async {
  var url =
      'http://handwriting-extraction.herokuapp.com/predict handwriting local images';
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Accept'] = 'application/json';
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromPath('image', file.path));
  var res = await request.send();
  return res;
}
