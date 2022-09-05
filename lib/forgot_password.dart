import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videosy/auth_api_call.dart';
import 'package:videosy/utils/toast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? conPass = TextEditingController();
  TextEditingController? logInEmail = TextEditingController();
  TextEditingController? logInPass = TextEditingController();

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
            // margin: EdgeInsets.only(top: screenHeight * 0.15),
            height: screenHeight * 0.9,
            width: screenWidth,
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: screenHeight * 0.06,),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xff3cd27d),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                  alignment: Alignment.centerLeft,
                  child: Text("Recover Password",
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.06)),
                ),
                SizedBox(height: screenHeight * 0.035),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Color(0xFF62678C),
                    fontSize: screenWidth * 0.05,
                  ),
                  textAlign: TextAlign.left,
                  cursorColor: Color(0xFF62678C),
                  cursorRadius: Radius.circular(50),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0x80353A61),
                      // fillColor: Colors.black45,
                      hintText: "Email address",
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
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff3CD27D),
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                isLoading == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isPressSubmit = true;
                          });
                          Future.delayed(const Duration(milliseconds: 350), () {
                            setState(() async {
                              isPressSubmit = false;
                              if (email!.text.isNotEmpty) {
                                isLoading = true;
                                forgotPassword(
                                        logInEmail!.text, context, screenWidth)
                                    .whenComplete(() {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              } else {
                                toast(screenWidth, "fill every details");
                              }
                            });
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
