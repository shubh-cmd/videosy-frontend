import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'api.dart';
import 'join_screen.dart';
import 'meeting_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String meetingId = "";
  bool isMeetingActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: isMeetingActive
                ? MeetingScreen(
                    meetingId: meetingId,
                    token: token,
                    leaveMeeting: () {
                      setState(() => isMeetingActive = false);
                    },
                  )
                : JoinScreen(
                    onMeetingIdChanged: (value) => meetingId = value,
                    onCreateMeetingButtonPressed: () async {
                      meetingId = await createMeeting();
                      setState(() => isMeetingActive = true);
                    },
                    onJoinMeetingButtonPressed: () {
                      setState(() => isMeetingActive = true);
                    },
                  ),
        ),
      ),
    );
  }
}
