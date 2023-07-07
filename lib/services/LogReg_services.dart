import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../models/logreg.dart';
import '../pages/pages.dart';

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
  print("login " + res.body.toString());
  if (res.statusCode == 200) {
    LoginUser data = LoginUser.fromJson(body['data']);
    print("token " + data.access_token.toString());
    Get.off(HomePage(data.access_token!));
  } else {
    throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
  }
}
