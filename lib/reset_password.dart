import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:videosy/utils/toast.dart';

import 'auth_api_call.dart';

class ResetPassword extends StatefulWidget {
  String? email = "";

  ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                  child: Text("Reset Password",
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
                  height: screenHeight * 0.02,
                ),
                Column(children: [
                  TextField(
                    controller: pass,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: iconPass,
                    style: TextStyle(
                      color: Color(0xFF62678C),
                      fontSize: screenWidth * 0.05,
                    ),
                    textAlign: TextAlign.left,
                    cursorColor: Color(0xFF62678C),
                    cursorRadius: Radius.circular(50),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff3cd27d),
                      ),
                      filled: true,
                      fillColor: Color(0x80353A61),
                      // fillColor: Colors.black45,
                      hintText: "New Password",
                      hintStyle: TextStyle(
                        color: Color(0xff62678C),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      suffixIcon: iconPass == true
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconPass = false;
                                });
                              },
                              child: Icon(
                                Icons.visibility,
                                color: Color(0xff3cd27d),
                              ))
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconPass = true;
                                });
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: Color(0xff3cd27d),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextField(
                    controller: conPass,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: iconPassCon,
                    style: TextStyle(
                      color: Color(0xFF62678C),
                      fontSize: screenWidth * 0.05,
                    ),
                    textAlign: TextAlign.left,
                    cursorColor: Color(0xFF62678C),
                    cursorRadius: Radius.circular(50),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff3cd27d),
                      ),
                      filled: true,
                      fillColor: Color(0x80353A61),
                      // fillColor: Colors.black45,
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Color(0xff62678C),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      suffixIcon: iconPassCon == true
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconPassCon = false;
                                });
                              },
                              child: Icon(
                                Icons.visibility,
                                color: Color(0xff3cd27d),
                              ))
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconPassCon = true;
                                });
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: Color(0xff3cd27d),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      toast(screenWidth, "OTP Sent");
                      print(widget.email);
                      forgotPassword(widget.email!, context, screenWidth);
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: Color(0xff3cd27d),
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                              if (otp!.text.isEmpty) {
                                print(otp!.text);
                                toast(screenWidth, "Wrong OTP");
                              } else if (pass!.text.isNotEmpty &&
                                  conPass!.text.isNotEmpty &&
                                  pass!.text == conPass!.text) {
                                setState(() {
                                  isLoading = true;
                                });
                                await resetPassword(otp!.text, pass!.text,
                                        conPass!.text, context, screenWidth)
                                    .whenComplete(() {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              } else {
                                toast(screenWidth, "Confirm Password is Wrong");
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
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
