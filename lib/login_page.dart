// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';
import './varify_otp.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "\\login_with_phone";
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  Future<String> formatNumber(PhoneNumber phone) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        phone.phoneNumber.toString());
    String? formattedNumber = await PhoneNumberUtil.formatAsYouType(
      number.phoneNumber!,
      number.isoCode!,
    );
     if (formattedNumber == null) return "123456780";
    return formattedNumber;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          /**
           * Overall Page
           */
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            color: const Color(0xFFF5F5F5),
            child: Column(
              children: [
                /**
                 * Build the login screen Star on top
                 */
                LoginScreenStar(deviceSize: deviceSize),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Welcome!',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
                /**
                 * Center Image and Text
                 */
                CenterImageText(deviceSize: deviceSize),
                const SizedBox(
                  height: 30,
                ),
                /**
                 * Phone Number Input Text Box
                 */
                Container(
                  margin: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(
                          0xFFeeeeee,
                        ),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.13),
                    ),
                  ),
                  child: Stack(
                    children: [
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber value) {
                          number = value;
                        },
                        //autoFocus:true ,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.black,
                        formatInput: true,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        inputDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            bottom: 15,
                            left: 0,
                          ),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey[500],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ignoreBlank: false,
                      ),
                      /**
                       * Seperator line between number and country code
                       */
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /**
                 * Submit Button
                 */
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      /**
                       * Snack Bar
                       */
                      final snackBar = SnackBar(
                        elevation: 0,
                        width: double.infinity,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Success',
                          message:
                              'Your details has been submitted. Redirecting to Varify OTP.',
                          contentType: ContentType.success,
                          inMaterialBanner: true,
                        ),
                        duration: const Duration(milliseconds: 1800),
                        //showCloseIcon: true,
                        dismissDirection: DismissDirection.down,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      String fnum = await formatNumber(number);
                      /**
                       * Named Route
                       */
                      await Future.delayed(
                        const Duration(milliseconds: 2000),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed(
                          VarifyOTP.routeName,
                          arguments: fnum);
                    },
                    color: const Color(0xFF163343),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                    ),
                    minWidth: double.infinity,
                    child: Text(
                      'Get OTP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.85),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: deviceSize.width - 100,
                  child: Text(
                    'By signing up, you agree with our Terms and Conditions',
                    maxLines: 2,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
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

// Text with Center Image
class CenterImageText extends StatelessWidget {
  const CenterImageText({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceSize.height * 0.32,
      width: deviceSize.width * 0.95,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/login_page_middle_svg.svg',
              height: deviceSize.height * 0.29,
              alignment: Alignment.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //color: Colors.red,
              width: deviceSize.width,
              height: 80,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Text(
                'Enter your number to continue, We will\nsend you OTP to varify',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Star Image top of the screen
class LoginScreenStar extends StatelessWidget {
  const LoginScreenStar({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: deviceSize.height * 0.20,
          width: deviceSize.width,
        ),
        Positioned(
          right: deviceSize.width * 0.06,
          top: deviceSize.height * 0.05,
          child: SvgPicture.asset(
            'assets/login_screen_top_svg.svg',
            height: deviceSize.height * 0.15,
            width: deviceSize.height * 0.14,
          ),
        ),
      ],
    );
  }
}
