part of 'pages.dart';

class HomePage extends StatefulWidget {
  final String token;

  HomePage(this.token);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pertanyaan = TextEditingController();
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

    context.read<AiCubit>().getAi('${widget.token}', time!);
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

      await context.read<AiCubit>().getAi('${widget.token}', time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(maxWidth: 800),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A.I. Parentoday',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.bold,
                        color: '5E5E5E'.toColor(),
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      // constraints: BoxConstraints(maxWidth: 800),
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
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: '80B541'.toColor(),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Online',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w300,
                        color: '80B541'.toColor(),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<DataUserCubit, DataUserState>(
          builder: (context, state) {
            if (state is DataUserLoaded) {
              if (state.dataUser != null) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 60 - 80,
                          padding: EdgeInsets.only(bottom: 40),
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
                                                ? ChatUserCard(e, '')
                                                : ChatRobotCard(e, ''),
                                          )
                                          .toList(),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                } else {
                                  return SizedBox();
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
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 125,
                          padding: EdgeInsets.only(
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
                                  : SizedBox(),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 800),
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width - 78,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: 'FF6969'.toColor()),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 10, top: 5, bottom: 5),
                                        hintStyle:
                                            GoogleFonts.poppins().copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: '989797'.toColor(),
                                        ),
                                        hintText: 'Tanya seputar parenting...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
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
                                            // Navigator.pop(context);
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: 'FF6969'.toColor(),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: isLoading
                                          ? Container(
                                              width: 20,
                                              height: 20,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2),
                                              ),
                                            )
                                          : Icon(Icons.send,
                                              color: Colors.white, size: 20),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
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
                  ),
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          },
        ),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.5),
        //         spreadRadius: 1,
        //         blurRadius: 1,
        //         offset: Offset(0, 0), // changes position of shadow
        //       ),
        //     ],
        //   ),
        //   height: 122,
        //   padding: EdgeInsets.only(top: 11, bottom: 20, right: 16, left: 16),
        //   child: Column(
        //     children: [
        //       (show == true)
        //           ? Text(
        //         'Sebentar ya Moms, kami sedang mencarikan jawaban dari pertanyaan kamu...',
        //         textAlign: TextAlign.center,
        //         style: GoogleFonts.poppins().copyWith(
        //           fontWeight: FontWeight.w300,
        //           color: '959595'.toColor(),
        //           fontSize: 10,
        //         ),
        //       )
        //           : SizedBox(),
        //       SizedBox(height: 5),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //             alignment: Alignment.topCenter,
        //             constraints: BoxConstraints(maxWidth: 800),
        //             height: 35,
        //             width: MediaQuery.of(context).size.width - 78,
        //             child: TextField(
        //               onTap: () {
        //                 FocusScopeNode currentFocus = FocusScope.of(context);
        //
        //                 if (!currentFocus.hasPrimaryFocus) {
        //                   currentFocus.unfocus();
        //                 }
        //               },
        //               textCapitalization: TextCapitalization.characters,
        //               cursorColor: 'FF6969'.toColor(),
        //               controller: pertanyaan,
        //               decoration: InputDecoration(
        //                 focusedBorder: OutlineInputBorder(
        //                   borderRadius: BorderRadius.all(Radius.circular(5)),
        //                   borderSide:
        //                   BorderSide(width: 1, color: 'FF6969'.toColor()),
        //                 ),
        //                 contentPadding:
        //                 EdgeInsets.only(left: 10, top: 5, bottom: 5),
        //                 hintStyle: GoogleFonts.poppins().copyWith(
        //                   fontSize: 12,
        //                   fontWeight: FontWeight.w300,
        //                   color: '989797'.toColor(),
        //                 ),
        //                 hintText: 'Tanya seputar parenting...',
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(width: 10),
        //           GestureDetector(
        //             onTap: () async {
        //               if (pertanyaan.text.isNotEmpty) {
        //                 setState(() {
        //                   isLoading = true;
        //                   show = true;
        //                   context.loaderOverlay.show();
        //                 });
        //                 await cari().whenComplete(() {
        //                   setState(() {
        //                     isLoading = false;
        //                     show = false;
        //                     context.loaderOverlay.hide();
        //                     pertanyaan.text = '';
        //                   });
        //                 });
        //               }
        //             },
        //             child: Container(
        //               padding: EdgeInsets.all(8),
        //               decoration: BoxDecoration(
        //                 color: 'FF6969'.toColor(),
        //                 borderRadius: BorderRadius.circular(50),
        //               ),
        //               child: isLoading
        //                   ? Container(
        //                 width: 20,
        //                 height: 20,
        //                 child: Center(
        //                   child: CircularProgressIndicator(
        //                       color: Colors.white, strokeWidth: 2),
        //                 ),
        //               )
        //                   : Icon(Icons.send, color: Colors.white, size: 20),
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 5),
        //       Text(
        //         'Do not completely rely on the answers provided by this AI without confirming them with other reliable sources.',
        //         textAlign: TextAlign.center,
        //         style: GoogleFonts.poppins().copyWith(
        //           fontWeight: FontWeight.w300,
        //           color: '959595'.toColor(),
        //           fontSize: 10,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
