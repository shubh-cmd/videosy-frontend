import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:videosy/login.dart';
import 'package:videosy/reset_password.dart';
import 'package:videosy/signup.dart';
import 'api.dart';
import 'forgot_password.dart';
import 'home.dart';
import 'join_screen.dart';
import 'meeting_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'models/data.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String meetingId = "";
  bool isMeetingActive = false;
  bool isLoggedIn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  getLogIn() async {
    // SharedPreferences myPrefs = await SharedPreferences.getInstance();
    // if(myPrefs.getString("login") != null) {
    //   setState(() {
    //     Data.token = myPrefs.getString("login")!;
    //   });
    // }
    var box = await Hive.openBox('hive');
    box = Hive.box('hive');
    // setState(() {
    Data.token = box.get('login');
    if (Data.token != null && Data.token != "") {
      setState(() {
        isLoggedIn = true;
      });
    }
    // choose();
  }

  @override
  void initState() {
    super.initState();
    getLogIn();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0x73202442),
          textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Color(0xff3cd27d),
              cursorColor: Color.fromRGBO(98, 103, 140, 1))),
      debugShowCheckedModeBanner: false,
      home: (isLoggedIn) ? HomePage() : Login(),
    );
  }
}
