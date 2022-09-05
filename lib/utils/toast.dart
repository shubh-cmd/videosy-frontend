import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
toast(double screenWidth, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0x73202442),
      textColor: Colors.white,
      fontSize: screenWidth * 0.05);
}
