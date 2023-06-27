class DataLogReg {
  String? user_id;
  String? nama;
  String? profile_photo_url;
  String? email;
  String? nomor;

  DataLogReg(
      {this.user_id,
      this.nama,
      this.profile_photo_url,
      this.email,
      this.nomor});

  DataLogReg.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    nama = json['nama'];
    profile_photo_url = json['profile_photo_url'];
    email = json['email'];
    nomor = json['nomor'];
  }
}
