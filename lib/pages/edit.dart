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
      context.read<DataUserCubit>().getData(widget.token);
      Get.off(HomePage(widget.token));
      Flushbar(
        backgroundColor: (darkLight != true) ? dasarDark : warnaUtama,
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        message: "Berhasil Menyimpan Data",
      ).show(context);
    } else {
      throw 'Error ${response.statusCode} => ${body['meta']['message']}';
    }
  }

  Uint8List? _bytesData;
  List<int>? _selectedFile;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadImage() async {
    var url = Uri.parse("https://dashboard.parentoday.com/api/user/photo");
    var uri = Uri.parse(url.toString());
    var request = http.MultipartRequest("POST", uri)
      ..headers["Content-Type"] = "application/json"
      ..headers["Authorization"] = "Bearer ${widget.token}";
    request.files.add(
      await http.MultipartFile.fromBytes('file', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: "Any_name"),
    );
    request.send().then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(request.toString());
        String imagePath = data['data'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<DataUserCubit>().getData(widget.token);
    namaAndaEditingController.text = widget.dataUser.nama!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (darkLight != true) ? dasarDark : textDark,
      appBar: AppBar(
        backgroundColor: (darkLight != true) ? navigasiDark : textDark,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: (darkLight != true) ? textDark : textLight7,
          ),
        ),
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins().copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: (darkLight != true) ? textDark : textLight7,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      startWebFilePicker();
                    },
                    child: _bytesData != null
                        ? Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(_bytesData!),
                              ),
                            ),
                          )
                        : (widget.dataUser.profile_photo_url ==
                                "https://dashboard.parentoday.com/storage/")
                            ? Container(
                                width: 135,
                                height: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/mom.png'),
                                  ),
                                ),
                              )
                            : Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.dataUser.profile_photo_url ??
                                  ''),
                        ),
                      ),
                    ),
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
                      color: (darkLight != true) ? navigasiDark : warnaUtama,
                    ),
                    child: Icon(Icons.edit, color: textDark, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                            color: (darkLight != true) ? textDark : textLight7,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(5),
                          //   color: textFieldDark,
                          // ),
                          child: TextField(
                            style: TextStyle(color: (darkLight != true)
                                ? textDark
                                : textLight5,
                            ),
                            cursorColor: (darkLight != true) ? textDark : warnaUtama,
                            controller: namaAndaEditingController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: (darkLight != true) ? textFieldDark : border,
                                ),
                              ),
                              fillColor: (darkLight != true)
                                  ? textFieldDark
                                  : textDark,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: (darkLight != true) ? textDark : warnaUtama,),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 10, top: 5, bottom: 5),
                              hintStyle: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: textLight10,
                              ),
                              hintText: 'Nama panggilan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                      uploadImage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: MediaQuery.of(context).size.width - 78,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: (darkLight != true) ? navigasiDark : warnaUtama,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: (isLoading = true)
                          ? Text(
                              'Simpan Data Pengguna',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: textDark,
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
