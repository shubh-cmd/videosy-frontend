import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
// import 'package:localse/sign_in_wrapper/authenticate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:videosy/join_screen.dart';
import 'package:videosy/main.dart';
import 'package:videosy/reset_password.dart';
import 'package:videosy/utils/toast.dart';
import 'home.dart';
import 'login.dart';
import 'meeting_screen.dart';
import 'meeting_controls.dart';
// import '../models/user_model.dart';
// import '../screens/data/data.dart';
// import '../screens/home.dart';
import '../utils/api_endpoints.dart';
import 'api.dart';
import 'models/data.dart';
// import '../widgets/snack.dart';
// import 'forgot_password/change_password.dart';

Future<dynamic> signUpApi(String email, String pass, BuildContext context,
    double screenWidth, bool verified) async {
  String fetchOrderBookingUrl = Urls.SignUp;
  print("email: $email");
  print("pass: $pass");
  try {
    final response = await http.post(
      Uri.parse(fetchOrderBookingUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": pass,
        "is_verified": verified,
      }),
    );
    var responseJson = json.decode(response.body);
    // print(response.statusCode);
    //print(response.body);
    // print(">>>>>>>>>");
    //print(responseJson);
    //print(">>>>>>>>>");
    if (response.statusCode == 200) {
      if (responseJson['message'] == "user exists" && verified == false) {
        toast(screenWidth, "User with this email already exists.");
        return false;
      }
      return true;

      // response.body;
    } else if (response.statusCode == 400) {
      print(response.body);
      var responseJson = json.decode(response.body);
      if (responseJson["email"] != null) {
        toast(
            screenWidth,
            responseJson["email"]
                .toString()
                .substring(1, responseJson["email"].toString().length - 1));
        return false;
      } else {
        toast(screenWidth, "User with this email already exists.");
        return false;
      }
    } else {
      // print("Hmmmmm");
      toast(screenWidth, "Invalid Email or Password");
      return false;
    }
  } on Exception catch (e) {
    // snackBar("$e", _scaffoldKey, context);
    return false;
  }
  ;
}

Future<dynamic> logInApi(String email, String pass, BuildContext context,
    double screenWidth, bool is_google_signin) async {
  print("email: $email");
  print("pass: $pass");
  String loginUrl = Urls.Login;
  String meetingId = "";
  bool isMeetingActive = false;
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": pass,
        "is_google_signin": is_google_signin
      }),
    );
    var responseJson2 = json.decode(response.body);
    if (response.statusCode == 200) {
      // print("Complete<<<<<<<<<<LogIn");
      Data.token = responseJson2["token"];
      //   await registerFireBaseDevice ();
      setToken().whenComplete(() {
        Navigator.pushReplacement(
            context,
            PageTransition(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeft,
              child: HomePage(),
            ));
      });
    } else {
      toast(screenWidth, "Invalid Email & Password");
    }
  } on Exception catch (e) {
    print("Error: $e");
    toast(screenWidth, "Invalid Email & Password");
  }
}

// Future<dynamic> getUserProfile(
//     token, BuildContext context, GlobalKey _scaffoldKey) async {
//   print("getUserProfile");
//   String fetchUrl = Urls.getUserProfile;
//   print(fetchUrl);
//   try {
//     final response = await http.get(
//       Uri.parse(fetchUrl),
//       headers: <String, String>{
//         "Accept": "application/json",
//         'Authorization': token
//       },
//     );
//     if (response.statusCode == 200) {
//       User user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
//       UserProvider.aUser(user);
//       Data.userName =user.username!;
//       setToken().whenComplete(() {
//         if (Data.userName!="" ) {
//           //Notifier.initForeGround();
//         }});
//     } else {
//       User user = User(name: "guest");
//       UserProvider.aUser(user);
//     //  snackBar("Error", _scaffoldKey, context);
//     }
//   } catch (e) {
//     User user = User(name: "guest");
//     UserProvider.aUser(user);
//   //  snackBar("Error", _scaffoldKey, context);
//    // snackBar(e.toString(), _scaffoldKey, context);
//   }
// }

setToken() async {
  // SharedPreferences myPrefs = await SharedPreferences.getInstance();
  // setState(() {
  //   myPrefs.setString("login", Data.token!);
  // });

  var box = await Hive.openBox('hive');
  box.put('login', Data.token!);
  box.put("userName", Data.userName);
}

// Future<dynamic> patchUserProfile(token, BuildContext context,
//     GlobalKey _scaffoldKey, Map<String, String> bodyMap) async {
//   print("getUserProfile");
//   String fetchUrl = Urls.getUserProfile;

//   try {
//     final response =
//         await http.patch(Uri.parse(fetchUrl), headers: <String, String>{
//       "Accept": "application/json",
//       'Authorization': token
//     }, body: bodyMap);
//     print(response.statusCode);
//     print(response.body);

//     if (response.statusCode == 200) {
//       User user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
//       UserProvider.aUser(user);
//     } else {
//       User user = User(name: "guest");
//       UserProvider.aUser(user);
//     //  snackBar("Error", _scaffoldKey, context);
//     }
//   } catch (e) {
//     User user = User(name: "guest");
//     UserProvider.aUser(user);
//    // snackBar("Error", _scaffoldKey, context);
//    // snackBar(e.toString(), _scaffoldKey, context);
//   }
// }

Future<dynamic> resetPassword(
    String otp, String pass, String conPass, context, screenWidth) async {
  String fetchOrderBookingUrl = Urls.reset;
  // try {
  final response = await http.post(
    Uri.parse(fetchOrderBookingUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "otp": otp,
      "password": pass,
      "password_confirm": conPass,
    }),
  );
  //var responseJson = json.decode(response.body);
  //print(responseJson);
  print(response.statusCode);
  if (response.statusCode == 200) {
    toast(screenWidth, "Password is reset, Login with New Password");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));

    // return responseJson;
  } else {
    // snackBar("Error ",scaffoldKey, context);
  }
  // } on Exception catch (e) {
  //   snackBar("e",scaffoldKey, context);
  // }
}

Future<dynamic> forgotPassword(String email, context, screenWidth) async {
  String fetchOrderBookingUrl = Urls.forgot;
  try {
    final response = await http.post(
      Uri.parse(fetchOrderBookingUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
      }),
    );

    var responseJson = json.decode(response.body);
    print(responseJson);

    if (response.statusCode == 200) {
      if (responseJson["message"] == "please check your email!") {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ResetPassword(
              email: email,
            );
          },
        ));
      } else {
        toast(screenWidth, "Email does not exist");
      }
    } else {
      toast(screenWidth, "Email does not exist");
    }
  } on Exception catch (e) {
    print("Error: $e");
    toast(screenWidth, "Email does not exist");
  }
}

Future VerifyEmailAPi(email, pass, String otp, context, screenWidth) async {
  print(otp);

  try {
    String fetchUrl = Urls.verifyEmail;
    final response = await http.post(
      Uri.parse(fetchUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"otp": otp.toString()}),
    );
    print("**********************");
    print(response.statusCode);
    if (response.statusCode == 200) {
      await logInApi(email, pass, context, screenWidth, false);
    } else {
      toast(screenWidth, "Wrong OTP ");
    }
  } catch (e) {
    toast(screenWidth, "Error");
  }
}
