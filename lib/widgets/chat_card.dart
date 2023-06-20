part of 'widgets.dart';

class ChatUserCard extends StatelessWidget {
  final Ai aiModel;
  final String token;

  ChatUserCard(this.aiModel, this.token);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/mom.png', scale: 18),
          SizedBox(width: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            // width: MediaQuery.of(context).size.width - 640,
            width: MediaQuery.of(context).size.width - 69,
            child: Text(
              '${aiModel.content ?? ''}',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: '484848'.toColor(),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRobotCard extends StatelessWidget {
  final Ai aiModel;
  final String token;

  ChatRobotCard(this.aiModel, this.token);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      color: 'FFF4F4'.toColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/parentoday.png', scale: 2),
          SizedBox(width: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            width: MediaQuery.of(context).size.width - 69,
            child: Text(
              aiModel.content ?? '',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: '484848'.toColor(),
                height: 1.7,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
