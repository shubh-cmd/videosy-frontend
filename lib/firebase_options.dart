// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3Nz-3VLM8WLiHzfrUfuPtXh7Gw31ROMI',
    appId: '1:276393410352:web:c3e0f953f764d5938bd2f5',
    messagingSenderId: '276393410352',
    projectId: 'videosy-8b620',
    authDomain: 'videosy-8b620.firebaseapp.com',
    storageBucket: 'videosy-8b620.appspot.com',
    measurementId: 'G-CVZLVRXQ0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSo0_-6EH9-nVX71OQAvai1zbx3ZVhsSQ',
    appId: '1:276393410352:android:0e3e64a281fb91698bd2f5',
    messagingSenderId: '276393410352',
    projectId: 'videosy-8b620',
    storageBucket: 'videosy-8b620.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0lTIVHzsKmcWeUg5mYFCQhT_PqcG9zec',
    appId: '1:276393410352:ios:3c9f963efd991c748bd2f5',
    messagingSenderId: '276393410352',
    projectId: 'videosy-8b620',
    storageBucket: 'videosy-8b620.appspot.com',
    androidClientId: '276393410352-r64miq1kf25agvig0eghmt9j2tjnr2q6.apps.googleusercontent.com',
    iosClientId: '276393410352-jbclquosqkv26n596e9urfa0cnev2k05.apps.googleusercontent.com',
    iosBundleId: 'com.example.videosy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0lTIVHzsKmcWeUg5mYFCQhT_PqcG9zec',
    appId: '1:276393410352:ios:3c9f963efd991c748bd2f5',
    messagingSenderId: '276393410352',
    projectId: 'videosy-8b620',
    storageBucket: 'videosy-8b620.appspot.com',
    androidClientId: '276393410352-r64miq1kf25agvig0eghmt9j2tjnr2q6.apps.googleusercontent.com',
    iosClientId: '276393410352-jbclquosqkv26n596e9urfa0cnev2k05.apps.googleusercontent.com',
    iosBundleId: 'com.example.videosy',
  );
}