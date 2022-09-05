import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:videosy/auth_api_call.dart';
import 'package:videosy/forgot_password.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videosy/signup.dart';
import 'package:videosy/utils/google_signin.dart';
import 'package:videosy/utils/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? conPass = TextEditingController();
  TextEditingController? logInEmail = TextEditingController();
  TextEditingController? logInPass = TextEditingController();

  bool isLogin = false;
  bool isLoading = false;
  bool onPressLogIn = false;
  bool onPressSignIn = false;
  bool isGoogleLoading = false;
  bool isShowPassword = true;
  bool isShowPasswordCon = true;
  bool isShowPasswordLog = true;

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
                  child: Text("Sign In",
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
                SizedBox(height: screenHeight * 0.04),
                TextField(
                  controller: password,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: isShowPassword,
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
                    hintText: "Password",
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
                    suffixIcon: isShowPassword == true
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowPassword = false;
                              });
                            },
                            child: Icon(
                              Icons.visibility,
                              color: Color(0xff3cd27d),
                            ))
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowPassword = true;
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ForgotPassword();
                      },
                    ));
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: screenHeight * 0.0001),
                    padding: EdgeInsets.only(right: screenWidth * 0.01),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3CD27D),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                isLoading == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            onPressSignIn = true;
                          });
                          Future.delayed(const Duration(milliseconds: 350), () {
                            setState(() async {
                              onPressSignIn = false;
                              if (email!.text.isNotEmpty &&
                                  password!.text.isNotEmpty) {
                                logInApi(email!.text, password!.text, context,
                                    screenWidth, false);
                              } else {
                                toast(screenWidth, "Fill Each details");
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
                            "Sign In",
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
                Text(
                  "OR",
                  style: TextStyle(
                      color: Color(0xff3cd27d), fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: screenWidth * 0.07),
                      primary: Color(0x8062678c),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      minimumSize:
                          Size(screenWidth * 0.2, screenHeight * 0.055)),
                  onPressed: () async {
                    isGoogleLoading = true;
                    setState(() {});
                    GoogleSignInAccount? account = await handleSignIn();
                    if (account != null) {
                      print(account.id);
                      String emailidG = account.email;
                      String passG = "google_signin";
                      bool isOk = false;
                      isOk = await signUpApi(
                          emailidG, passG, context, screenWidth, true);
                      if (isOk == true) {
                        await logInApi(
                            emailidG, passG, context, screenWidth, true);
                      }
                    }
                    isGoogleLoading = false;
                    setState(() {});
                  },
                  child: isGoogleLoading
                      ? Container(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const Text(
                          'G',
                          style: TextStyle(
                              color: Color(0xff3cd27d),
                              fontWeight: FontWeight.w700),
                        ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  children: <Widget>[
                    Text("Don't have an account?",
                        style: TextStyle(
                            fontSize: screenWidth * 0.042,
                            color: Color(0xff62678c),
                            fontWeight: FontWeight.w600)),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color(0xff00bfff),
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUp();
                          },
                        ));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
