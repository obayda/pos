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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAcfF7YKBcVUBdeBC_nHONbcBsGYev8a5k',
    appId: '1:262434042868:web:43656a545c369ac07d7fa1',
    messagingSenderId: '262434042868',
    projectId: 'supermarket-83594',
    authDomain: 'supermarket-83594.firebaseapp.com',
    storageBucket: 'supermarket-83594.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOFXIxXseHp3sZzSgfXOdW1bz4gS7Xb0c',
    appId: '1:262434042868:ios:999439aff0b056ac7d7fa1',
    messagingSenderId: '262434042868',
    projectId: 'supermarket-83594',
    storageBucket: 'supermarket-83594.firebasestorage.app',
    iosBundleId: 'com.example.pos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAcfF7YKBcVUBdeBC_nHONbcBsGYev8a5k',
    appId: '1:262434042868:web:d203e22cee0ba8dc7d7fa1',
    messagingSenderId: '262434042868',
    projectId: 'supermarket-83594',
    authDomain: 'supermarket-83594.firebaseapp.com',
    storageBucket: 'supermarket-83594.firebasestorage.app',
  );
}
