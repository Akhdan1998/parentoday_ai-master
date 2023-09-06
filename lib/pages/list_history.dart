part of 'pages.dart';

class list_history extends StatefulWidget {
  final HistoryModel? history;
  final token;
  final ValueChanged<bool>? isShowContoh;

  const list_history(this.history, this.token, {super.key, this.isShowContoh});

  @override
  State<list_history> createState() => _list_historyState();
}

class _list_historyState extends State<list_history> {
  void deleted() async {
    Uri url_ = Uri.parse(
        'https://dashboard.parentoday.com/api/chat/ai/history/delete');
    var res = await http.post(
      url_,
      body: {
        'id': widget.history!.id.toString(),
      },
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${widget.token}',
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      bool data = body["data"];

      context.read<HistoryCubit>().getHistory(widget.token);

      Navigator.of(context).pop();

      Flushbar(
        backgroundColor: 'FF6969'.toColor(),
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        message: "Berhasil menghapus history!",
      ).show(context);
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRandomId = widget.history!.random_id;
                  widget.isShowContoh!(true);
                });
                context
                    .read<AiCubit>()
                    .getAi(widget.token, widget.history!.random_id ?? '');
                Navigator.of(context).pop();
              },
              child: Container(
                constraints: const BoxConstraints(minWidth: 232),
                color: Colors.white,
                width: MediaQuery.of(context).size.width - 1208,
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.chat_outlined, size: 20),
                    const SizedBox(width: 7),
                    Container(
                      constraints: const BoxConstraints(minWidth: 195),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 1245,
                      child: Text(
                        widget.history!.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.w300,
                          color: '555555'.toColor(),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: Text(
                          'Yakin mau menghapus history?',
                          style: GoogleFonts.poppins().copyWith(fontSize: 12),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Tidak',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                color: 'FF8182'.toColor(),
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
                                color: 'FF8182'.toColor(),
                              ),
                            ),
                            onPressed: () {
                              deleted();
                            },
                          ),
                        ]);
                  },
                );
              },
              child: Container(
                color: Colors.white,
                child: Icon(
                  Icons.delete,
                  color: '555555'.toColor(),
                  size: 18,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: '555555'.toColor(),
            ),
          ],
        ),
        Divider(
          thickness: 1.5,
          color: 'ECECEC'.toColor(),
          height: 5,
        ),
      ],
    );
  }
}
