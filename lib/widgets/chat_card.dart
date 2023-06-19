part of 'widgets.dart';

class ChatUserCard extends StatelessWidget {
  final Ai aiModel;
  final String token;

  ChatUserCard(this.aiModel, this.token);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        color: Colors.white,
        // constraints: BoxConstraints(maxWidth: 800),

        // color: 'FFFFFF'.toColor(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          // width: (MediaQuery.of(context).size.width <= 360)
          //     ? (MediaQuery.of(context).size.width - 2 * 20)
          //     : 800,
          // color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/mom.png', scale: 18),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width,
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
        ),
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
      // color: Colors.red,
      color: 'FFF4F4'.toColor(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // width: (MediaQuery.of(context).size.width <= 360)
        //     ? (MediaQuery.of(context).size.width - 2 * 20)
        //     : 800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/parentoday.png', scale: 2),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
