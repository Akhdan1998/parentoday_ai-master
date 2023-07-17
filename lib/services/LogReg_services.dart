import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import '../models/api_return_foto.dart';
import '../models/logreg.dart';
import '../pages/pages.dart';

// File? _pickedImage;

// Future<ApiReturnFoto<String>> uploadPhoto(File photoFile,
//     {String? token, http.MultipartRequest? request}) async {
//   String url = 'https://dashboard.parentoday.com/api/user/photo';
//   var uri = Uri.parse(url);
//
//   if (request == null) {
//     request = http.MultipartRequest('POST', uri)
//       ..headers["Content-Type"] = "application/json"
//       ..headers["Authorization"] = "Bearer ${token}";
//   }
//
//   var multiPartFile = await http.MultipartFile.fromPath('file', photoFile.path);
//   request.files.add(multiPartFile);
//
//   var response = await request.send();
//   String responseBody1 = await response.stream.bytesToString();
//   if (response.statusCode == 200) {
//     String responseBody = await response.stream.bytesToString();
//     var data = jsonDecode(responseBody);
//     String imagePath = data['data'];
//     return ApiReturnFoto(value: imagePath, message: '');
//   } else {
//     return ApiReturnFoto(message: 'Upload Photo Gagal ', value: '');
//   }
// }

void LogRegGoogle(
    String name, String userEmail, String uid, String imageUrl) async {
  Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/login_register');
  var res = await http.post(
    url_,
    body: {
      'nama': name,
      'email': userEmail,
      'uid': uid,
      'profile_photo_url': imageUrl,
    },
  );
  Map<String, dynamic> body = jsonDecode(res.body);
  if (res.statusCode == 200) {
    LoginUser data = LoginUser.fromJson(body['data']);

    // File imageFile = await urlToFile(imageUrl.toString());

    // print('gambar ' + imageFile.toString());

    // uploadPhoto(
    //   imageFile,
    //   token: data.access_token.toString(),
    // );
    Get.off(HomePage(data.access_token!));
  } else {
    throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
  }
}

// Future<File> urlToFile(String imageUrl) async {
//   var rng = Random();
//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;
//   File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
//   http.Response response = await http.get(Uri.parse(imageUrl));
//   await file.writeAsBytes(response.bodyBytes);
//   return file;
// }
