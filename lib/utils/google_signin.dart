import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);


Future< GoogleSignInAccount?> handleSignIn() async {
  try {
    GoogleSignInAccount? account= await _googleSignIn.signIn();
    return account;
  } catch (error) {
    print(error);
  }
}

Future<void> handleSignOut() async {
  // print(">>>>>>>>>>>> user logged out >>>>>>>>>>>> ");
  // account?.clearAuthCache();
  // print(account?.email);
  // GoogleSignInAccount? acc;
  // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
  //   acc = account;
  // });
  // check the error here
  // print("before disconnect ${acc?.email}");
  await _googleSignIn.disconnect();
  // print("after disconnect ${acc?.email}");
  // await _googleSignIn.signOut();
  // print("after signout ${acc?.email}");
}