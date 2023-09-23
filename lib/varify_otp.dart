// ignore_for_file: must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern/login_page.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VarifyOTP extends StatelessWidget {
  static String routeName = "\\varifyOTP";
  VarifyOTP({super.key});
  String? pin;
  @override
  Widget build(BuildContext context) {
    final phoneNumber = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /**
               * Picture and Text
               */
              SizedBox(
                height: 350,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        'assets/VarifyOTP.svg',
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      left: 110,
                      top: 280,
                      child: Text(
                        'Varify OTP',
                        style: GoogleFonts.montserrat(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /**
               * OTP Send To Text
               */
              SizedBox(
                width: double.infinity,
                child: Text(
                  'OTP Sent to',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              /**
               * Phone Number print
               */
              SizedBox(
                width: double.infinity,
                child: Text(
                  phoneNumber,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: Colors.grey[800],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /**
               * OTP Taking feild
               */
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width - 100,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                keyboardType: TextInputType.text,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 17),
                onCompleted: (pin2) {
                  //print("Completed: " + pin2);
                  pin = pin2;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              /**
               * Varify button with logic
               */
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: MaterialButton(
                  onPressed: () async {
                    if (pin == null) return;
                    /**
                     * This Regex will only allow any number with 6 digit
                     */
                    String otpPattern = r'^\d{6}$';
                    RegExp regex = RegExp(otpPattern);
                    /**
                     * Compare the regex pattern
                     * If Sucess -> Sucess Snackbar with redirect to Login Screen
                     * If Error -> Error snackbar to tell user to re enter the varification code
                     */
                    if (regex.hasMatch(pin.toString())) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        width: double.infinity,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Success',
                          message:
                              'Your details has been submitted. Redirecting Login Screen.',
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
                      await await Future.delayed(
                        const Duration(milliseconds: 2000),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginPage.routeName, (route) => false);
                    } else {
                      final snackBar = SnackBar(
                        elevation: 0,
                        width: double.infinity,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error',
                          message:
                              'Your OTP is not valid. Please check your OTP.',
                          contentType: ContentType.failure,
                          inMaterialBanner: true,
                        ),
                        duration: const Duration(milliseconds: 1800),
                        //showCloseIcon: true,
                        dismissDirection: DismissDirection.down,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
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
                    'Varify OTP',
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
                width: MediaQuery.of(context).size.width - 100,
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
    );
  }
}
