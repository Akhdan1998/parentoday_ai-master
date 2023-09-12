part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (darkLight != true) ? dasarDark : textDark,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/loginGoogle.png', scale: 2),
            const SizedBox(height: 20),
            Text(
              'Halo Bunda,',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                color: (darkLight != true) ? textDark : textLight9,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Silahkan Login atau Mendaftar untuk melanjutkan fitur parentoday.ai',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: (darkLight != true) ? textDark : textLight10,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await signInWithGoogle().then((result) {
                  LogRegGoogle(
                    name.toString(),
                    userEmail.toString(),
                    uid.toString(),
                    imageUrl.toString(),
                  );
                }).catchError((error) {});
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: (darkLight != true) ? dasarDark : textDark,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: (darkLight != true) ? textDark : shadow,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  width: MediaQuery.of(context).size.width - 78,
                  child: (isLoading == true)
                      ? Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: (darkLight != true) ? textDark : warnaUtama,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google.png', scale: 2),
                            const SizedBox(width: 5),
                            Text(
                              'Masuk/Daftar dengan Google',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: (darkLight != true) ? textDark : textLight11,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
