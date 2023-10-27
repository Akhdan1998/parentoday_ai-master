part of 'widgets.dart';

class ChatUserCard extends StatefulWidget {
  final Ai aiModel;

  final DataUser userData;
  final String token;

  const ChatUserCard(this.aiModel, this.userData, this.token, {super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: (darkLight != true) ? chatUserDark : textDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageNetwork(
            onPointer: true,
            debugPrint: false,
            fullScreen: false,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.cover,
            onLoading: Center(
              child: CircularProgressIndicator(
                color: (dasarLight != true) ? textDark : warnaUtama,
              ),
            ),
            onError: Image.asset('assets/mom.png'),
            image: widget.userData.profile_photo_url ?? '',
            height: 26,
            width: 26,
            curve: Curves.fastLinearToSlowEaseIn,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(width: 10),
          SelectionArea(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              width: MediaQuery.of(context).size.width - 69,
              child: Text(
                widget.aiModel.content ?? '',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.w300,
                  color: (darkLight != true) ? textDark : textLight3,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRobotCard extends StatefulWidget {
  final Ai aiModel;
  final String token;

  const ChatRobotCard(this.aiModel, this.token, {super.key});

  @override
  State<ChatRobotCard> createState() => _ChatRobotCardState();
}

class _ChatRobotCardState extends State<ChatRobotCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: (darkLight != true) ? dasarDark : chatUserLight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/parentoday.png', scale: 2),
              const SizedBox(width: 10),
              SelectionArea(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  width: MediaQuery.of(context).size.width - 69,
                  child: TypeWriterText.builder(
                    widget.aiModel.content ?? '',
                    duration: const Duration(milliseconds: 10),
                    builder: (context, value) {
                      return AutoSizeText(
                        value,
                        style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.w300,
                          color: (darkLight != true) ? textDark : textLight3,
                          height: 1.7,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // OverlayTooltipItem(
              //   // tooltipHorizontalPosition: TooltipHorizontalPosition.WITH_WIDGET,
              //   tooltipVerticalPosition: TooltipVerticalPosition.TOP,
              //   displayIndex: 0,
              //   tooltip: (controller) => TextButton(
              //     onPressed: () {
              //       controller.dismiss();
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Colors.transparent,
              //       ),
              //       child: Text(
              //         'Salin',
              //         style: GoogleFonts.poppins().copyWith(
              //             color: Colors.white,
              //             // color: '414141'.toColor(),
              //             fontSize: 13,
              //             fontWeight: FontWeight.w300),
              //       ),
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       OverlayTooltipScaffold.of(context)?.controller.start();
              //     },
              //     child: Container(
              //       constraints: const BoxConstraints(maxWidth: 800),
              //       width: MediaQuery.of(context).size.width - 69,
              //       child: TypeWriterText.builder(
              //         widget.aiModel.content ?? '',
              //         duration: const Duration(milliseconds: 10),
              //         builder: (context, value) {
              //           return AutoSizeText(
              //             value,
              //             style: GoogleFonts.poppins().copyWith(
              //               fontWeight: FontWeight.w300,
              //               color: (darkLight != true) ? textDark : textLight3,
              //               height: 1.7,
              //               fontSize: 12,
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          (kosong == true)
              ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
          )
              : Container(),
        ],
      ),
    );
  }
}
