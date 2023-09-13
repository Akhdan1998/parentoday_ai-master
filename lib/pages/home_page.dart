part of 'pages.dart';

class HomePage extends StatefulWidget {
  final token;

  const HomePage(this.token, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tanya1 = TextEditingController(text: 'Menangani tantrum pada anak');
  final tanya2 = TextEditingController(text: 'Resep mpasi untuk bayi');
  final tanya3 = TextEditingController(text: 'Cara mengatasi anak susah makan');
  final pertanyaan = TextEditingController();
  final pertanyaanBaru = TextEditingController();

  bool isLoading = false;
  bool showOverlay = false;
  bool show = false;
  bool showContoh = false;

  String? time;

  FocusNode focusNode = FocusNode();

  ScrollController? controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();

    time = DateTime.now().millisecondsSinceEpoch.toString();
    context.read<AiCubit>().getAi(widget.token, time!);
    context.read<DataUserCubit>().getData(widget.token);
    context.read<HistoryCubit>().getHistory(widget.token);
  }

  //logout
  void logout(String id) async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/logout');
    var res = await http.post(
      url_,
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${widget.token}'
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    print("logout " + res.body.toString());
    if (res.statusCode == 200) {
      bool data = body["data"];
      print("logout sukses ${res.body}");
      print("logout token sukses ${widget.token}");
      Get.offAll(
        const LoginPage(),
      );
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> cari() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': pertanyaan.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    print('jjjjjjjj ' + res.body.toString());
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);
      print('randomId sukses ' + selectedRandomId.toString());
      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh1() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya1.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh2() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya2.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh3() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya3.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);
      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: CircularProgressIndicator(
          color: (darkLight != true) ? textDark : warnaUtama,
        ),
      ),
      child: Scaffold(
        backgroundColor: (darkLight != true) ? dasarDark : dasarLight,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<DataUserCubit, DataUserState>(
          builder: (context, state) {
            if (state is DataUserLoaded) {
              if (state.dataUser != null) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    //appbar
                    Positioned(
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 57.6,
                          decoration: BoxDecoration(
                            color: (darkLight != true) ? navigasiDark : textDark,
                          boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 855),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        color: (darkLight != true) ? navigasiDark : textDark,
                        // color: Colors.blue,
                        // decoration: BoxDecoration(
                        //   color: (darkLight != true) ? navigasiDark : textDark,
                        //   boxShadow: const [
                        //     BoxShadow(
                        //       color: Colors.grey,
                        //       spreadRadius: 1,
                        //       blurRadius: 1,
                        //       offset: Offset(0, 10), // changes position of shadow
                        //     ),
                        //   ],
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'A.I Parentoday',
                                  style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: (darkLight != true)
                                        ? textDark
                                        : textLight1,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Menjawab semua masalah parentingmu dengan cepat dan efisien',
                                  style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: (darkLight != true)
                                        ? textDark
                                        : textLight2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      (darkLight = !darkLight);
                                    });
                                  },
                                  icon: (darkLight != true)
                                      ? Icon(
                                          Icons.wb_sunny,
                                          color: (darkLight != true)
                                              ? textDark
                                              : buttonLight1,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.dark_mode,
                                          color: (darkLight != true)
                                              ? textDark
                                              : buttonLight1,
                                          size: 20,
                                        ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() {
                                //       (darkLight = !darkLight);
                                //     });
                                //   },
                                //   child: Container(
                                //     color: (darkLight != true) ? navigasiDark : textDark,
                                //     child: (darkLight != true)
                                //         ? Icon(
                                //       Icons.wb_sunny,
                                //       color: (darkLight != true)
                                //           ? textDark
                                //           : buttonLight1,
                                //       size: 20,
                                //     )
                                //         : Icon(
                                //       Icons.dark_mode,
                                //       color: (darkLight != true)
                                //           ? textDark
                                //           : buttonLight1,
                                //       size: 20,
                                //     ),
                                //   ),
                                // ),
                                Builder(
                                  builder: (context) => IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: (darkLight != true)
                                          ? textDark
                                          : buttonLight1,
                                    ),
                                    onPressed: () =>
                                        Scaffold.of(context).openEndDrawer(),
                                    tooltip: MaterialLocalizations.of(context)
                                        .openAppDrawerTooltip,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //contoh
                    (showContoh != true)
                        ? Positioned(
                            top: 60,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15),
                              color: (darkLight != true) ? dasarDark : contohLight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/parentoday.png',
                                    scale: 2,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 800),
                                    width:
                                        MediaQuery.of(context).size.width - 78,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Selamat datang di AI Parenting! Saya siap membantu Anda sebagai orang tua dengan saran dan dukungan dalam mengasuh anak-anak Anda dari bayi hingga remaja. Tanya saja tentang nutrisi, jadwal tidur, pengembangan emosional, dan aktivitas bermain yang menyenangkan.',
                                          style: GoogleFonts.poppins().copyWith(
                                            fontSize: 12,
                                            color: (darkLight != true)
                                                ? textDark
                                                : textLight3,
                                          ),
                                        ),
                                        SizedBox(height: 9),
                                        Text(
                                          'Contoh:',
                                          style: GoogleFonts.poppins().copyWith(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: (darkLight != true)
                                                ? textDark
                                                : textLight3,
                                          ),
                                        ),
                                        SizedBox(height: 9),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                focusNode.unfocus();

                                                if (tanya1.text.isNotEmpty) {
                                                  setState(() {
                                                    isLoading = true;
                                                    show = true;
                                                    context.loaderOverlay
                                                        .show();
                                                  });
                                                  await contoh1()
                                                      .whenComplete(() {
                                                    setState(() {
                                                      isLoading = false;
                                                      show = false;
                                                      showContoh = true;
                                                      context.loaderOverlay
                                                          .hide();
                                                    });
                                                  });
                                                }
                                                context
                                                    .read<HistoryCubit>()
                                                    .getHistory(widget.token);
                                              },
                                              child: Chip(
                                                backgroundColor:
                                                    (darkLight != true)
                                                        ? navigasiDark
                                                        : buttonLight2,
                                                label: Text(
                                                  'Menangani tantrum pada anak',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                    fontSize: 11,
                                                    color: (darkLight != true)
                                                        ? textDark
                                                        : textLight3,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                focusNode.unfocus();
                                                if (tanya2.text.isNotEmpty) {
                                                  setState(() {
                                                    isLoading = true;
                                                    show = true;
                                                    context.loaderOverlay
                                                        .show();
                                                  });
                                                  await contoh2()
                                                      .whenComplete(() {
                                                    setState(() {
                                                      isLoading = false;
                                                      show = false;
                                                      showContoh = true;
                                                      context.loaderOverlay
                                                          .hide();
                                                    });
                                                  });
                                                }
                                                context
                                                    .read<HistoryCubit>()
                                                    .getHistory(widget.token);
                                              },
                                              child: Chip(
                                                backgroundColor:
                                                    (darkLight != true)
                                                        ? navigasiDark
                                                        : buttonLight2,
                                                label: Text(
                                                  'Resep mpasi untuk bayi',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                    fontSize: 11,
                                                    color: (darkLight != true)
                                                        ? textDark
                                                        : textLight3,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                focusNode.unfocus();

                                                if (tanya3.text.isNotEmpty) {
                                                  setState(() {
                                                    isLoading = true;
                                                    show = true;
                                                    context.loaderOverlay
                                                        .show();
                                                  });
                                                  await contoh3()
                                                      .whenComplete(() {
                                                    setState(() {
                                                      isLoading = false;
                                                      show = false;
                                                      showContoh = true;
                                                      context.loaderOverlay
                                                          .hide();
                                                    });
                                                  });
                                                }
                                                context
                                                    .read<HistoryCubit>()
                                                    .getHistory(widget.token);
                                              },
                                              child: Chip(
                                                backgroundColor:
                                                    (darkLight != true)
                                                        ? navigasiDark
                                                        : buttonLight2,
                                                label: Text(
                                                  'Cara mengatasi anak susah makan',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                    fontSize: 11,
                                                    color: (darkLight != true)
                                                        ? textDark
                                                        : textLight3,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    //popupChat
                    Positioned(
                      top: 59,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 145,
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: BlocBuilder<AiCubit, AiState>(
                            builder: (context, snapshot) {
                              if (snapshot is AiLoaded) {
                                if (snapshot.ai != null) {
                                  return Column(
                                    children: snapshot.ai!
                                        .mapIndexed(
                                          (int index, e) => (e.role == "user")
                                              ? ChatUserCard(
                                                  e,
                                                  state.dataUser!,
                                                  widget.token,
                                                )
                                              : ChatRobotCard(e, widget.token),
                                        )
                                        .toList(),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    //bottomNavigasi
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: (darkLight != true) ? navigasiDark : textDark,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(
                            top: 11, bottom: 11, right: 16, left: 16),
                        child: Column(
                          children: [
                            (show == true)
                                ? Text(
                                    'Sebentar ya Moms, kami sedang mencarikan jawaban dari pertanyaan kamu...',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: (darkLight != true)
                                          ? textDark
                                          : textLight4,
                                      fontSize: 11,
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  height: 45,
                                  width: MediaQuery.of(context).size.width - 78,
                                  // decoration: BoxDecoration(
                                  //   color: textFieldDark,
                                  //   borderRadius: BorderRadius.circular(5),
                                  // ),
                                  child: TextField(
                                    onSubmitted: (value) async {
                                      focusNode.unfocus();

                                      if (pertanyaan.text.isNotEmpty) {
                                        setState(() {
                                          isLoading = true;
                                          show = true;
                                          context.loaderOverlay.show();
                                        });
                                        await cari().whenComplete(() {
                                          setState(() {
                                            isLoading = false;
                                            show = false;
                                            context.loaderOverlay.hide();
                                            pertanyaan.text = '';
                                            showContoh = true;
                                          });
                                        });
                                      }
                                      context
                                          .read<HistoryCubit>()
                                          .getHistory(widget.token);
                                    },
                                    style: TextStyle(
                                        color: (darkLight != true)
                                            ? textDark
                                            : textLight5),
                                    focusNode: focusNode,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: (darkLight != true)
                                        ? textDark
                                        : warnaUtama,
                                    controller: pertanyaan,
                                    decoration: InputDecoration(
                                      fillColor: (darkLight != true)
                                          ? textFieldDark
                                          : textFieldLight,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: (darkLight != true)
                                              ? textFieldDark
                                              : textFieldLight,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: (darkLight != true)
                                              ? dasarDark
                                              : warnaUtama,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 5, bottom: 5),
                                      hintStyle: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: (darkLight != true)
                                            ? textDark
                                            : textLight6,
                                      ),
                                      hintText: 'Tanya seputar parenting...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    focusNode.unfocus();
                                    if (pertanyaan.text.isNotEmpty) {
                                      setState(() {
                                        isLoading = true;
                                        show = true;
                                        context.loaderOverlay.show();
                                      });
                                      await cari().whenComplete(() {
                                        setState(() {
                                          isLoading = false;
                                          show = false;
                                          context.loaderOverlay.hide();
                                          pertanyaan.text = '';
                                          showContoh = true;
                                        });
                                      });
                                    }
                                    context
                                        .read<HistoryCubit>()
                                        .getHistory(widget.token);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: (darkLight != true)
                                          ? dasarDark
                                          : warnaUtama,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: isLoading
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: textDark,
                                                  strokeWidth: 2),
                                            ),
                                          )
                                        : Icon(Icons.send,
                                            color: textDark, size: 20),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Do not completely rely on the answers provided by this AI without confirming them with other reliable sources.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w300,
                                color:
                                    (darkLight != true) ? textDark : textLight4,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        endDrawer: Drawer(
          backgroundColor: (darkLight != true) ? navigasiDark : textDark,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 15,
                right: 15,
                child: BlocBuilder<DataUserCubit, DataUserState>(
                  builder: (context, snapshot) {
                    if (snapshot is DataUserLoaded) {
                      if (snapshot.dataUser != null) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                        snapshot.dataUser!.profile_photo_url ??
                                            ''),
                                    backgroundColor: (darkLight != true)
                                        ? navigasiDark
                                        : textDark,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.dataUser!.nama ?? '',
                                        style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: (darkLight != true)
                                              ? textDark
                                              : textLight7,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        snapshot.dataUser!.email ?? '',
                                        style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: (darkLight != true)
                                              ? textDark
                                              : textLight8,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    edit(
                                      snapshot.dataUser!,
                                      widget.token,
                                    ),
                                  );
                                },
                                child: Container(
                                  color: (darkLight != true)
                                      ? navigasiDark
                                      : textDark,
                                  child: Image.asset(
                                    'assets/edit.png',
                                    scale: 2.5,
                                    color: (darkLight != true)
                                        ? textDark
                                        : buttonLight1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Positioned(
                right: 15,
                left: 15,
                top: 63,
                child: GestureDetector(
                  onTap: () {
                    context.read<AiCubit>().getAi(widget.token, '');

                    setState(() {
                      time = DateTime.now().millisecondsSinceEpoch.toString();
                      selectedRandomId = null;
                      showChat = false;
                      showContoh = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: 10, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: (darkLight != true) ? navigasiDark : textDark,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: (darkLight != true) ? textDark : shadow,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pertanyaan Baru',
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: (darkLight != true) ? textDark : textLight3,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.add,
                          color: (darkLight != true) ? textDark : textLight3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 105,
                left: 15,
                right: 15,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: BlocBuilder<HistoryCubit, HistoryState>(
                      builder: (context, headshot) {
                        if (headshot is HistoryLoaded) {
                          if (headshot.history != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: headshot.history!
                                  .map(
                                    (e) => list_history(
                                      e,
                                      widget.token,
                                      isShowContoh: (value) {
                                        setState(() {
                                          showContoh = value;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1.5,
                      color: (darkLight != true) ? textDark : divider,
                      height: 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor:
                                    (darkLight != true) ? dasarDark : textDark,
                                content: Text(
                                  'Yakin akan keluar?',
                                  style: GoogleFonts.poppins().copyWith(
                                    fontSize: 12,
                                    color: (darkLight != true)
                                        ? textDark
                                        : textLight5,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'Tidak',
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        color: (darkLight != true)
                                            ? textDark
                                            : warnaUtama,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Ya',
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        color: (darkLight != true)
                                            ? textDark
                                            : warnaUtama,
                                      ),
                                    ),
                                    onPressed: () {
                                      signOut().then((result) {
                                        print(result);
                                        logout(widget.token);
                                      }).catchError((error) {
                                        print('SignOut Error: $error');
                                      });
                                    },
                                  ),
                                ]);
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        color: (darkLight != true) ? navigasiDark : textDark,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 18,
                              color:
                                  (darkLight != true) ? textDark : textLight3,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign Out',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w300,
                                color:
                                    (darkLight != true) ? textDark : textLight3,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
