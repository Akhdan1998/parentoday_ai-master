import 'package:equatable/equatable.dart';

class DataUser {
  String? nama;
  String? profile_photo_url;

  DataUser({this.nama, this.profile_photo_url});

  DataUser.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    profile_photo_url = json['profile_photo_url'];
  }
}
