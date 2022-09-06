import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:videosdk/videosdk.dart';
import 'meeting_controls.dart';
import 'participant_tile.dart';
import 'package:path_provider/path_provider.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final void Function() leaveMeeting;

  const MeetingScreen(
      {Key? key,
      required this.meetingId,
      required this.token,
      required this.leaveMeeting})
      : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Map<String, Stream?> participantVideoStreams = {};

  bool micEnabled = true;
  bool camEnabled = true;
  late Room room;

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams[participant.id] = stream);
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams.remove(participant.id));
      }
    });
  }

  void setMeetingEventListener(Room _room) {
    setParticipantStreamEvents(_room.localParticipant);
    _room.on(
      Events.participantJoined,
      (Participant participant) => setParticipantStreamEvents(participant),
    );
    _room.on(Events.participantLeft, (String participantId) {
      if (participantVideoStreams.containsKey(participantId)) {
        setState(() => participantVideoStreams.remove(participantId));
      }
    });
    _room.on(Events.roomLeft, () {
      participantVideoStreams.clear();
      widget.leaveMeeting();
    });
  }

  @override
  void initState() {
    super.initState();
    // Create instance of Room (Meeting)
    room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "Shubham Kumar",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      maxResolution: 'hd',
      defaultCameraIndex: 1,
      notification: const NotificationInfo(
        title: "Videosy",
        message: "Vidosy is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );

    setMeetingEventListener(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.06),
            // padding: EdgeInsets.only(left: screenWidth * 0.01),
            alignment: Alignment.center,
            child: Text("Meeting Id: ${room.id}",
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.06)),
          ),
          SizedBox(
            height: screenHeight * 0.08,
          ),
          ...participantVideoStreams.values
              .map(
                (e) => ParticipantTile(
                  stream: e!,
                ),
              )
              .toList(),
          MeetingControls(
            onToggleMicButtonPressed: () {
              micEnabled ? room.muteMic() : room.unmuteMic();
              micEnabled = !micEnabled;
            },
            onToggleCameraButtonPressed: () {
              camEnabled ? room.disableCam() : room.enableCam();
              camEnabled = !camEnabled;
            },
            onLeaveButtonPressed: () => room.leave(),
            micEnabled: micEnabled,
            camEnabled: camEnabled,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: screenWidth * 0.07),
                  primary: Color(0x8062678c),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.055)),
              onPressed: () async {
                await Share.share("${room.id}",subject: "Videosy");
              },
              child: Icon(
                Icons.share,
                color: Colors.red,
                size: screenWidth * 0.08,
              )),
        ],
      ),
    );
  }
}
