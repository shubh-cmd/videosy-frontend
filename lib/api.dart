import 'dart:convert';
import 'package:http/http.dart' as http;

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJmMTdlZWJmMy0yODlmLTQ5Y2YtOTIwMC04M2U0ZWZlYjkyOGUiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY2MjI2OTE1NywiZXhwIjoxNjYyODczOTU3fQ._TQucVZCFAvnO48Cy2Y32kkV46vv6VTaSe4oXmy0-I0";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}