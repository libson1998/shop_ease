import 'package:flutter/material.dart';
import 'package:shope_ease/utils/size_config.dart';

const kPrimaryColor = Color(0xFF022f3c);
const kPrimaryLightColor = Color(0xFFFFECDF);
const textColor = Colors.black;
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const backgroundColor = Color(0xFFEEEEEE);
const kAnimationDuration = Duration(milliseconds: 200);
const cardColor = Color(0xffffffff);
const currency = " ₹";
const headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const String baseUrl = "https://newsdata.io/api/1/";
const String authToken = "pub_58013c2be382f234cfc0afadf910c265764a8";
const String query = "sports";
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kFirstNameNullError = "Please Enter your first name";
const String kLastNameNullError = "Please Enter your last name";
const String kLastPhoneNullError = "Please Enter your mobile number";
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kInvalidPhoneError = "Please Enter Valid phone";
const String kInvalidFirstError = "Please Enter Valid first name";
const String kInvalidLastError = "Please Enter Valid last name";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

class PreferenceConstants {
  PreferenceConstants._();

  static const String strUserName = "STR_USER_NAME";

  static const String strUserEmail = "STR_USER_EMAIL";

  static const String strUserPhone = "STR_USER_PHONE";

  static const String imageUrl = "IMAGE_URL";
  static const String isLoggedIn = "isLoggedIn";
  static const String fcmToken = "fcm_token";
}
