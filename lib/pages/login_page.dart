part of 'pages.dart';

class LoginPage extends StatefulWidget {
  final String token;

  const LoginPage(this.token, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/loginGoogle.png', scale: 2),
            const SizedBox(height: 20),
            Text(
              'Halo Bunda,',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                color: '323232'.toColor(),
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Silahkan Login atau Mendaftar untuk melanjutkan fitur parentoday.ai',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: '989797'.toColor(),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding:
            const EdgeInsets.only(top: 11, bottom: 20, right: 16, left: 16),
        child: GestureDetector(
          onTap: () async {
            LogRegGoogle();
            await signInWithGoogle().then((result) {
              print(result);
              if (result != null) {
                Get.to(
                  const HomePage(
                      '1354|r5uOe7c4yC14CDvrkeTfP73s0AIrkG01EKos4lC4'),
                );
              }
            }).catchError((error) {
              print('Registration Error: $error');
            });
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            // width: MediaQuery
            //     .of(context)
            //     .size
            //     .width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/google.png', scale: 2),
                const SizedBox(width: 5),
                Text(
                  'Masuk/Daftar dengan Google',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: '6D6D6D'.toColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
