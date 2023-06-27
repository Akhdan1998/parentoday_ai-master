import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:parentoday_ai/models/data_user.dart';

import '../models/api_return_data.dart';

class DataUserServices {
  static Future<ApiReturnData<DataUser>?> getData(String token,
      {http.Client? client}) async {
    String baseUrl = 'https://dashboard.parentoday.com/api/user';
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl;
    var response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    print('hahah' + response.body.toString());

    if (response.statusCode != 200) {
      return ApiReturnData(message: 'Please try Again');
    }
    var data = jsonDecode(response.body);
//jika backand berbentuk list
//     List<DataUser> value =
//         (data['data'] as Iterable).map((e) => DataUser.fromJson(e)).toList();
//jika backand tidak berbentuk list
    DataUser value = DataUser.fromJson(data['data']);
    return ApiReturnData(value: value);
  }
}
