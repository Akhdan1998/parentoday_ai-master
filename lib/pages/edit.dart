part of 'pages.dart';

class edit extends StatefulWidget {
  DataUser dataUser;
  final token;

  edit(this.dataUser, this.token);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  bool isLoading = false;

  final namaAndaEditingController = TextEditingController();

  void saveData(String namaAnda) async {
    Uri url = Uri.parse('https://dashboard.parentoday.com/api/user');
    var response = await http.post(
      url,
      body: {
        'nama': namaAndaEditingController.text,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    print(response.body.toString());
    Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      EditProfil data = EditProfil.fromJson(body['data']);
      // Get.off(HomePage(widget.token));
    } else {
      throw 'Error ${response.statusCode} => ${body['meta']['message']}';
    }
  }

  // File? _pickedImage;
  // Uint8List webImage = Uint8List(8);
  //
  // Future<void> _pickImage() async {
  //   if (!kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var selected = File(image.path);
  //       setState(() {
  //         _pickedImage = selected;
  //       });
  //     } else {
  //       print('No Image has been picked');
  //     }
  //   } else if (kIsWeb) {
  //     final ImagePicker picker = ImagePicker();
  //     XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var f = await image.readAsBytes();
  //       setState(() {
  //         webImage = f;
  //         _pickedImage = File(image.path);
  //       });
  //     } else {
  //       print('No Image has been picked');
  //     }
  //   } else {
  //     print('Something when wrong');
  //   }
  // }

  // static Future<ApiReturnFoto<String>> uploadPhoto(File photoFile,
  //     {String? token, http.MultipartRequest? request}) async {
  //   String url = 'https://dashboard.parentoday.com/api/user/photo';
  //   var uri = Uri.parse(url);
  //
  //   request ??= http.MultipartRequest('POST', uri)
  //     ..headers["Content-Type"] = "application/json"
  //     ..headers["Authorization"] = "Bearer $token";
  //
  //   var multiPartFile =
  //       await http.MultipartFile.fromPath('file', photoFile.path);
  //   request.files.add(multiPartFile);
  //
  //   var response = await request.send();
  //
  //   // HttpClient httpClient = newUniversalHttpClient(); // Recommended way of creating HttpClient.
  //   // final request = await httpClient.getUrl(Uri.parse("https://dashboard.parentoday.com/api/user/photo"));
  //   // final response = await request.a();
  //
  //   // var multiPartFile =
  //   //     await http.MultipartFile.fromPath('file', photoFile.path);
  //   // request.files.add(multiPartFile);
  //
  //   // String responseBody1 = await response.stream.bytesToString();
  //   if (response.statusCode == 200) {
  //     String responseBody = await response.stream.bytesToString();
  //     var data = jsonDecode(request.toString());
  //     String imagePath = data['data'];
  //     Fluttertoast.showToast(
  //         msg: "This is Center Short Toast",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //     );
  //     print('Image' + request.toString());
  //     print('ImagePath' + responseBody.toString());
  //     return ApiReturnFoto(value: imagePath, message: '');
  //   } else {
  //     return ApiReturnFoto(message: 'Upload Photo Gagal ', value: '');
  //   }
  // }

  // Uint8List? _bytesData;
  // List<int>? _selectedFile;

  // startWebFilePicker() async {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     final file = files![0];
  //     final reader = html.FileReader();
  //
  //     reader.onLoadEnd.listen((event) {
  //       setState(() {
  //         _bytesData =
  //             Base64Decoder().convert(reader.result.toString().split(",").last);
  //         _selectedFile = _bytesData;
  //       });
  //     });
  //     reader.readAsDataUrl(file);
  //   });
  // }

  // Future uploadImage() async {
  //   var url = Uri.parse('https://dashboard.parentoday.com/api/user/photo');
  //   var request = http.MultipartRequest('POST', url);
  //   request.files.add(
  //     await http.MultipartFile.fromBytes(
  //       'file',
  //       _selectedFile!,
  //       contentType: MediaType('application', 'json'),
  //       filename: 'Any_name',
  //     ),
  //   );
  //   request.send().then((response) {
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfull');
  //     } else {
  //       print('File uploaded failed');
  //     }
  //   });
  // }

  // Future<void> main() async {
  //   // HttpClient can be used in browser too!
  //   HttpClient httpClient = newUniversalHttpClient(); // Recommended way of creating HttpClient.
  //   final request = await httpClient.getUrl(Uri.parse("https://dashboard.parentoday.com/api/user/photo"));
  //   final response = await request.close();
  //   print('coba ' + request.toString());
  // }

  // Future<void> main() async {
  //   // HttpClient can be used in browser too!
  //   HttpClient httpClient = newUniversalHttpClient(); // Recommended way of creating HttpClient.
  //   final request = await httpClient.getUrl(Uri.parse("https://dart.dev/"));
  //   final response = await request.close();
  // }

  // Uint8List? _imageData;
  //
  // Future<void> _pickImage() async {
  //   final pickedImage = await ImagePickerWeb.getImageInfo;
  //   if (pickedImage != null) {
  //     setState(() {
  //       _imageData = pickedImage.data;
  //     });
  //
  //     // Upload the image to the backend
  //     await _uploadImageToBackend(_imageData!);
  //   }
  // }

  // Future<void> _uploadImageToBackend() async {
  //   final url =
  //       'https://dashboard.parentoday.com/api/user/photo'; // Replace with your actual backend endpoint
  //   var response = await http.post(
  //     Uri.parse(url),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully');
  //   } else {
  //     print('Failed to upload image. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    namaAndaEditingController.text = widget.dataUser.nama!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: '888888'.toColor(),
          ),
        ),
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins().copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: '747474'.toColor(),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      // startWebFilePicker();
                      // _pickImage();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageUrl ?? ''),
                          // image: NetworkImage(snapshot
                          //         .dataUser!
                          //         .profile_photo_url ??
                          //     ''),
                        ),
                      ),
                    ),
                    // _pickedImage == null ?
                    // Container(
                    //         width: 120,
                    //         height: 120,
                    //         decoration: BoxDecoration(
                    //           // color: Colors.red,
                    //           borderRadius: BorderRadius.circular(100),
                    //           image: const DecorationImage(
                    //             fit: BoxFit.cover,
                    //             // image: AssetImage('assets/mom.png'),
                    //             image: NetworkImage(imageUrl ?? ''),
                    //             // image: NetworkImage(
                    //             //     widget.dataUser.profile_photo_url ?? '',
                    //             //     ),
                    //           ),
                    //         ),
                    //       ),
                        // : Container(
                        //     width: 120,
                        //     height: 120,
                        //     decoration: BoxDecoration(
                        //       // color: Colors.red,
                        //       borderRadius: BorderRadius.circular(100),
                        //       image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: MemoryImage(webImage),
                        //         // image: NetworkImage(webImage.toString()),
                        //       ),
                        //     ),
                        //   ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: 'FF6969'.toColor(),
                    ),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height - 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    width: MediaQuery.of(context).size.width - 78,
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
                        const SizedBox(height: 5),
                        TextField(
                          cursorColor: 'FF6969'.toColor(),
                          controller: namaAndaEditingController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  width: 1, color: 'FF6969'.toColor()),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 10, top: 5, bottom: 5),
                            hintStyle: GoogleFonts.poppins().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: '989797'.toColor(),
                            ),
                            hintText: 'Nama panggilan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      saveData(namaAndaEditingController.text);
                      // uploadPhoto(_pickedImage!);
                      // _uploadImageToBackend();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: MediaQuery.of(context).size.width - 78,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: 'FF6969'.toColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: (isLoading = true)
                          ? Text(
                              'Simpan Data Pengguna',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: 'FFFFFF'.toColor(),
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: 'FF6969'.toColor(),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
