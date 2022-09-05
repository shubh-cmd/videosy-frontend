import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:videosy/utils/toast.dart';

import '../auth_api_call.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController? pass = TextEditingController();
  TextEditingController? otp = TextEditingController();
  TextEditingController? conPass = TextEditingController();

  bool isLogin = false;
  bool isLoading = false;
  bool onPressLogIn = false;
  bool isPressSubmit = false;

  bool iconPass = true;
  bool iconPassCon = true;
  bool iconPassLog = true;

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
  }

  bool _keyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double screenHeight = _mediaQueryData.size.height;
    double screenWidth = _mediaQueryData.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: _keyboardVisible
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          // padding: const EdgeInsets.all(6.0),
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.15),
            height: screenHeight * 0.9,
            width: screenWidth,
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                  alignment: Alignment.centerLeft,
                  child: Text("Email Verification",
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.06)),
                ),
                SizedBox(height: screenHeight * 0.035),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  alignment: Alignment.centerLeft,
                  child: Text("Enter 6 digit OTP",
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.04)),
                ),
                SizedBox(height: screenHeight * 0.01),
                OTPTextField(
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Color(0x80353a61),
                    borderColor: Color(0xff3cd27d),
                    // enabledBorderColor: Color(0xff3cd27d),
                    focusBorderColor: Color(0xff3cd27d),
                  ),
                  length: 6,
                  width: screenWidth * 0.9,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: screenWidth * 0.125,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 12,
                  style: TextStyle(
                      fontSize: screenWidth * 0.05, color: Color(0xff62678c)),
                  onCompleted: (pin) {
                    setState(() {
                      otp!.text = pin.toString();
                    });
                  },
                  onChanged: (pin) {},
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                isLoading == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isPressSubmit = true;
                          });
                          Future.delayed(const Duration(milliseconds: 350),
                              () async {
                            isPressSubmit = false;
                            // print("**************");
                            print(otp!.text);
                            // print("*******************");
                            // print(pass!.text);
                            // print(conPass!.text);
                            if (otp!.text.isEmpty) {
                              //print(otp!.text);
                              toast(screenWidth, "Wrong OTP");
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              await VerifyEmailAPi(
                                      widget.email,
                                      widget.password,
                                      otp!.text,
                                      context,
                                      screenWidth)
                                  .whenComplete(() {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                            setState(() {});
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.35,
                          decoration: BoxDecoration(
                            color: Color(0xff3CD27D),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
