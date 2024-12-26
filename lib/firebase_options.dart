// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDpeLOXF3owhm47fXAeroc8Hzi_4C00yXc',
    appId: '1:167872809951:web:f565d13582ae846840526a',
    messagingSenderId: '167872809951',
    projectId: 'chat-app-c104a',
    authDomain: 'chat-app-c104a.firebaseapp.com',
    storageBucket: 'chat-app-c104a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAA3bI7rcYoHaMjvLDpdGyfitKJg_OdOxw',
    appId: '1:167872809951:android:4db428928c92d35440526a',
    messagingSenderId: '167872809951',
    projectId: 'chat-app-c104a',
    storageBucket: 'chat-app-c104a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbYhN6BsRNDT1OE7nY628lfpAkufV_qks',
    appId: '1:167872809951:ios:adbe194bdd6b5a8340526a',
    messagingSenderId: '167872809951',
    projectId: 'chat-app-c104a',
    storageBucket: 'chat-app-c104a.firebasestorage.app',
    iosBundleId: 'com.example.chattingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbYhN6BsRNDT1OE7nY628lfpAkufV_qks',
    appId: '1:167872809951:ios:adbe194bdd6b5a8340526a',
    messagingSenderId: '167872809951',
    projectId: 'chat-app-c104a',
    storageBucket: 'chat-app-c104a.firebasestorage.app',
    iosBundleId: 'com.example.chattingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDpeLOXF3owhm47fXAeroc8Hzi_4C00yXc',
    appId: '1:167872809951:web:7575a9630bdb547640526a',
    messagingSenderId: '167872809951',
    projectId: 'chat-app-c104a',
    authDomain: 'chat-app-c104a.firebaseapp.com',
    storageBucket: 'chat-app-c104a.firebasestorage.app',
  );
}