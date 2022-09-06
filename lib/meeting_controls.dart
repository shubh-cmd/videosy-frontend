// import 'dart:html';

import 'package:flutter/material.dart';

class MeetingControls extends StatefulWidget {
  final bool Function() onToggleMicButtonPressed;
  final bool Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;
  
  MeetingControls(
      {Key? key,
      required this.onToggleMicButtonPressed,
      required this.onToggleCameraButtonPressed,
      required this.onLeaveButtonPressed})
      : super(key: key);

  @override
  State<MeetingControls> createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool micEnabled = true;
  bool camEnabled = true;
  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: screenWidth * 0.07),
                primary: Color(0x8062678c),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                minimumSize: Size(screenWidth * 0.2, screenHeight * 0.055)),
            onPressed: widget.onLeaveButtonPressed,
            child: Icon(
              Icons.call_end,
              color: Colors.red,
              size: screenWidth * 0.08,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: screenWidth * 0.07),
                primary: Color(0x8062678c),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                minimumSize: Size(screenWidth * 0.2, screenHeight * 0.055)),
            onPressed: () {
              bool tmp = widget.onToggleMicButtonPressed();
              setState(() {
                micEnabled = tmp;
              });
            },
            child: (micEnabled)
                ? Icon(
                    Icons.mic,
                    color: Colors.red,
                    size: screenWidth * 0.08,
                  )
                : Icon(
                    Icons.mic_off,
                    color: Colors.red,
                    size: screenWidth * 0.08,
                  ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: screenWidth * 0.07),
                primary: Color(0x8062678c),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                minimumSize: Size(screenWidth * 0.2, screenHeight * 0.055)),
            onPressed: () {
              bool tmp = widget.onToggleCameraButtonPressed();
              setState(() {
                camEnabled = tmp;
              });
            },
            child: (camEnabled)
                ? Icon(
                    Icons.videocam,
                    color: Colors.red,
                    size: screenWidth * 0.08,
                  )
                : Icon(
                    Icons.videocam_off,
                    color: Colors.red,
                    size: screenWidth * 0.08,
                  ),
          ),
        ],
      ),
    );
  }
}
