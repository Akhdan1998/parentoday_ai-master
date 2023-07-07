part of 'pages.dart';

class HomePage extends StatefulWidget {
  final token;

  HomePage(this.token, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      Get.to(
        const LoginPage(),
      );
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  final pertanyaan = TextEditingController();
  final pertanyaanBaru = TextEditingController();
  bool isLoading = false;
  bool showOverlay = false;
  bool show = false;
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

  Future<List<Ai>> cari() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': pertanyaan.text,
        'random_id': time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    print("BAKAKAKA " + res.body.toString());
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(widget.token, time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: CircularProgressIndicator(
          color: 'FF6969'.toColor(),
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Container(
            width: MediaQuery.of(context).size.width,
            constraints: const BoxConstraints(maxWidth: 800),
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
                        color: '5E5E5E'.toColor(),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 290,
                      child: Text(
                        'Menjawab semua masalah parentingmu dengan cepat dan efisien',
                        maxLines: 2,
                        style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.w300,
                          color: '959595'.toColor(),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                  onPressed: _openEndDrawer,
                  child: Icon(
                    Icons.menu,
                    color: '737373'.toColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<DataUserCubit, DataUserState>(
          builder: (context, state) {
            if (state is DataUserLoaded) {
              if (state.dataUser != null) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 60 - 80,
                        padding: const EdgeInsets.only(bottom: 40),
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
                                              ? ChatUserCard(e, widget.token)
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 125,
                        padding: const EdgeInsets.only(
                            top: 11, bottom: 20, right: 16, left: 16),
                        child: Column(
                          children: [
                            (show == true)
                                ? Text(
                                    'Sebentar ya Moms, kami sedang mencarikan jawaban dari pertanyaan kamu...',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: '959595'.toColor(),
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
                                  height: 35,
                                  width: MediaQuery.of(context).size.width - 78,
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
                                            // Navigator.pop(context);
                                          });
                                        });
                                      }
                                    },
                                    focusNode: focusNode,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: 'FF6969'.toColor(),
                                    controller: pertanyaan,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: 'FF6969'.toColor()),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 5, bottom: 5),
                                      hintStyle: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: '989797'.toColor(),
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
                                      color: 'FF6969'.toColor(),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2),
                                            ),
                                          )
                                        : const Icon(Icons.send,
                                            color: Colors.white, size: 20),
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
                                color: '959595'.toColor(),
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
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    BlocBuilder<DataUserCubit, DataUserState>(
                      builder: (context, snapshot) {
                        if (snapshot is DataUserLoaded) {
                          if (snapshot.dataUser != null) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                    .dataUser!
                                                    .profile_photo_url ??
                                                ''),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.dataUser!.nama ?? '',
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: '424242'.toColor(),
                                              fontSize: 11,
                                            ),
                                          ),
                                          Text(
                                            snapshot.dataUser!.email ?? '',
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.w300,
                                              color: '555555'.toColor(),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                      child: Image.asset(
                                        'assets/edit.png',
                                        scale: 2.5,
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
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        cursorColor: 'FF6969'.toColor(),
                        controller: pertanyaanBaru,
                        decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.add, color: '616161'.toColor()),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(width: 1, color: 'FF6969'.toColor()),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          hintStyle: GoogleFonts.poppins().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: '989797'.toColor(),
                          ),
                          hintText: 'Chat Baru',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<HistoryCubit, HistoryState>(
                      builder: (context, headshot) {
                        if (headshot is HistoryLoaded) {
                          if (headshot.history != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: headshot.history!
                                  .map((e) => list_history(e, widget.token))
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
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(
                    thickness: 1.5,
                    color: 'C3C3C3'.toColor(),
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await signOut().then((result) {
                        print(result);
                        logout(widget.token);
                      }).catchError((error) {
                        print('SignOut Error: $error');
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      color: Colors.white,
                      child: (isLoading == true)
                          ? Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: 'FF6969'.toColor(),
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                const Icon(Icons.logout, size: 18),
                                const SizedBox(width: 10),
                                Text(
                                  'Sign Out',
                                  style: GoogleFonts.poppins().copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: '555555'.toColor(),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
