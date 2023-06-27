import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parentoday_ai/models/auth.dart';

import '../models/logreg.dart';

Future<List<DataLogReg>> LogRegGoogle() async {
  Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/login_register');
  var res = await http.post(
    url_,
    body: {
      'nama': name,
      'email': userEmail,
      'uid': uid,
      'profile_photo_url': imageUrl,
    },
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer 1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4",
    },
  );
  Map<String, dynamic> body = jsonDecode(res.body);
  print("CKCKCK " + res.body.toString());
  if (res.statusCode == 200) {
    List<DataLogReg> value =
        (body['data'] as Iterable).map((e) => DataLogReg.fromJson(e)).toList();

    return value;
  } else {
    throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
  }
}
