import 'dart:io';

import 'package:http/http.dart' as http;

Future<http.StreamedResponse> pic2text(File file) async {
  var url =
      'https://handwriting-extraction.herokuapp.com/docs#/default/predict__predict_handwriting_local_images_post';
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Accept'] = 'application/json';
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromPath('image', file.path));
  var res = await request.send();
  return res;
}
