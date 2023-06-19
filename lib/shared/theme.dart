part of 'shared.dart';

Color mainColor = "F27C7D".toColor();
Color secondaryColor = "45AB9C".toColor();
Color tersierColor = "F0B3B6".toColor();
Color greyColor = "A4A4A4".toColor();
Color greyColor2 = "F1F1F1".toColor();
Color blueFBColor = "3B5998".toColor();
Color blackColor = "424242".toColor();
Color lightYellowColor = "F9D1D1".toColor();
Color greyYellowColor = "F7F7F7".toColor();
// Color mainColor = "E3B626".toColor();
// Color lightYellowColor = "F9EFD1".toColor();
Color bcgGreyColor = "F8F8F8".toColor();
Color bcgGreyColor2 = "E0E0E0".toColor();

Color bcgRedColor = "F8F8F8".toColor();
Widget loadingIndicator = CircularProgressIndicator(
    color: mainColor
);

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle = GoogleFonts.poppins().copyWith(color: blackColor, fontSize: 12, fontWeight: FontWeight.w400);
TextStyle blackFontStyle2 = GoogleFonts.poppins().copyWith(color: blackColor, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: blackColor, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle whiteFontStyle = GoogleFonts.poppins().copyWith( fontSize: 14, fontWeight: FontWeight.w500);

TextStyle yellowFontStyle = GoogleFonts.poppins().copyWith(color: mainColor, fontSize: 12, fontWeight: FontWeight.w400);

const double defaultMargin = 15;
const double defaultMargin2 = 15;

String? token_message_flutter;

List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 2,
    offset: Offset(0, 0),
  )
];

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

List<String> listTemp = ['','','','',''];
