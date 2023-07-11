part of 'pages.dart';

class edit extends StatefulWidget {
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  final namaAndaEditingController = TextEditingController();

  // void saveData(String namaAnak, String tanggalLahir) async {
  //   Uri url = Uri.parse('https://dashboard.parentoday.com/api/anak/create');
  //
  //   String gender = (selectedKelamin == '1') ? "Laki-laki" : "Perempuan";
  //
  //   var response = await http.post(
  //     url,
  //     body: {
  //       'name': namaAnak,
  //       'gender': gender,
  //       'birthday': tanggalLahir + ' ' + '07:00:00',
  //     },
  //     headers: {
  //       "Accept": "application/json",
  //       "Authorization": "Bearer 1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4",
  //     },
  //   );
  //   print(response.body.toString());
  //   Map<String, dynamic> body = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     BuatDataAnak data = BuatDataAnak.fromJson(body['data']);
  //     print(response.body.toString());
  //     Get.off(navigation(
  //       'Bearer 1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4',
  //       index: 4,
  //     ));
  //   } else {
  //     throw 'Error ${response.statusCode} => ${body['meta']['message']}';
  //   }
  // }

  // File? _image;
  //
  // Future getImage() async {
  //   final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (Image == null) return;
  //   final imageTemporary = File(Image.path);
  //   setState(() {
  //     this._image = imageTemporary;
  //   });
  // }

  // static Future<ApiReturnFoto<String>> uploadPhoto(File photoFile,
  //     {String? token, http.MultipartRequest? request}) async {
  //   String url = 'https://dashboard.parentoday.com/api/anak/photo';
  //   var uri = Uri.parse(url);
  //
  //   if (request == null) {
  //     request = http.MultipartRequest('POST', uri)
  //       ..headers["Content-Type"] = "application/json"
  //       ..headers["Authorization"] =
  //           "Bearer 1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4";
  //   }
  //
  //   var multiPartFile =
  //   await http.MultipartFile.fromPath('file', photoFile.path);
  //   request.files.add(multiPartFile);
  //
  //   var response = await request.send();
  //   String responseBody1 = await response.stream.bytesToString();
  //   if (response.statusCode == 200) {
  //     String responseBody = await response.stream.bytesToString();
  //     var data = jsonDecode(responseBody);
  //     print(responseBody.toString());
  //
  //     String imagePath = data['data'];
  //
  //     return ApiReturnFoto(value: imagePath, message: '');
  //   } else {
  //     return ApiReturnFoto(message: 'Upload Photo Gagal ', value: '');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: '888888'.toColor(),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Edit Profil',
              style: GoogleFonts.poppins().copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: '747474'.toColor(),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack(
            //   fit: StackFit.loose,
            //   alignment: Alignment.topCenter,
            //   children: [
            //     Positioned(
            //       child: GestureDetector(
            //         onTap: () {
            //           getImage();
            //         },
            //         child: _image != null
            //             ? Container(
            //                 padding: EdgeInsets.all(10),
            //                 width: 120,
            //                 height: 120,
            //                 decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                     fit: BoxFit.cover,
            //                     image: FileImage(_image!),
            //                   ),
            //                   borderRadius: BorderRadius.circular(100),
            //                 ),
            //               )
            //             : Image.asset('assets/foto.png'),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.only(top: 85, left: 85),
            //       child: Container(
            //         width: 35,
            //         height: 35,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(50),
            //           color: 'FF6969'.toColor(),
            //         ),
            //         child: Icon(Icons.edit, color: Colors.white, size: 18),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Anda',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: '5A5A5A'.toColor(),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: namaAndaEditingController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                            BorderSide(width: 1, color: 'FF6969'.toColor()),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      hintStyle: GoogleFonts.poppins().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: '989797'.toColor(),
                      ),
                      hintText: 'Isi Nama Anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        height: 50,
        child: GestureDetector(
          onTap: () {
            // saveData(namaAndaEditingController.text);
            // uploadPhoto(_image!);
          },
          child: Container(
            // padding: EdgeInsets.only(top: 5, bottom: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: 'FF6969'.toColor(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Simpan Data Pengguna',
              style: GoogleFonts.poppins().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: 'FFFFFF'.toColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
