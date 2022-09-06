import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restart_app/restart_app.dart';
import 'package:videosy/utils/google_signin.dart';

import 'models/data.dart';

class JoinScreen extends StatefulWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;

  const JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
  }) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  TextEditingController? meeting_id = TextEditingController();
  var myMenuItems = <String>[
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Color(0x73202442),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x73202442),
        actions: <Widget>[
          PopupMenuButton<String>(onSelected: (item) async {
            Data.token = "";
            Data.cartList = [];
            var box = await Hive.openBox('hive');
            box.put('login', Data.token!);
            box.put('cartlist', []);
            try {
              await handleSignOut();
            } catch (e) {
              print(e);
            }
            Restart.restartApp();
            setState(() {});
          }, itemBuilder: (BuildContext context) {
            return myMenuItems.map((String choice) {
              return PopupMenuItem<String>(
                child: Text(choice),
                value: choice,
                height: screenHeight * 0.04,
              );
            }).toList();
          })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.045),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: screenWidth * 0.07),
                  primary: Color(0xff3cd27d),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  minimumSize: Size(screenWidth * 0.4, screenHeight * 0.06)),
              child: Text(
                "Create Meeting",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
              onPressed: widget.onCreateMeetingButtonPressed,
            ),
            SizedBox(height: screenHeight * 0.05),
            TextField(
              onChanged: widget.onMeetingIdChanged,
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
                hintText: "Enter Meeting ID",
                hintStyle: TextStyle(
                  color: Color(0xff62678C),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: screenWidth * 0.07),
                  primary: Color(0xff3cd27d),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.06)),
              child: Text(
                "Join",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
              onPressed: widget.onJoinMeetingButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
