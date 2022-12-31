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
    apiKey: 'AIzaSyB1Cq8Mg3FVG2GKSIBxVgFUGxHNvHy9ZOw',
    appId: '1:639705717973:web:7822cf57e1a85fa128d65c',
    messagingSenderId: '639705717973',
    projectId: 'tp3firebase-374ff',
    authDomain: 'tp3firebase-374ff.firebaseapp.com',
    storageBucket: 'tp3firebase-374ff.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzBJQmBJsizw821aQwRHSdcSX_esgAzIE',
    appId: '1:639705717973:android:77765189f7d2d24228d65c',
    messagingSenderId: '639705717973',
    projectId: 'tp3firebase-374ff',
    storageBucket: 'tp3firebase-374ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBh_yylx3RlBHL1rjLk6VGmBF2Khdd02h0',
    appId: '1:639705717973:ios:5eb7d61d73f2673728d65c',
    messagingSenderId: '639705717973',
    projectId: 'tp3firebase-374ff',
    storageBucket: 'tp3firebase-374ff.appspot.com',
    iosClientId: '639705717973-g549qvpmrsn4qciub7vd4lsfuuqcnt6m.apps.googleusercontent.com',
    iosBundleId: 'com.example.tp3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBh_yylx3RlBHL1rjLk6VGmBF2Khdd02h0',
    appId: '1:639705717973:ios:5eb7d61d73f2673728d65c',
    messagingSenderId: '639705717973',
    projectId: 'tp3firebase-374ff',
    storageBucket: 'tp3firebase-374ff.appspot.com',
    iosClientId: '639705717973-g549qvpmrsn4qciub7vd4lsfuuqcnt6m.apps.googleusercontent.com',
    iosBundleId: 'com.example.tp3',
  );
}
