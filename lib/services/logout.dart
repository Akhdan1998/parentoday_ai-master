import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:parentoday_ai/pages/pages.dart';

void logout(String id) async {
  Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/logout');
  var res = await http.post(url_);
  Map<String, dynamic> body = jsonDecode(res.body);
  print("logout " + res.body.toString());
  if (res.statusCode == 200) {
    bool data = body["data"];
    Get.to(
       LoginPage(''),
    );
  } else {
    throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
  }
}
