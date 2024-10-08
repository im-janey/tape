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
    apiKey: 'AIzaSyDUt-DXM0oO3jKQ6xArrnEDGfxTtWYSsW4',
    appId: '1:859756951077:web:e8fec9c5485a0032b671cc',
    messagingSenderId: '859756951077',
    projectId: 'tape-64f67',
    authDomain: 'tape-64f67.firebaseapp.com',
    databaseURL:
        'https://tape-64f67-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tape-64f67.appspot.com',
    measurementId: 'G-GS1KGNBJND',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_CP_C_YKdfph6wWD0ooFXwekV5f8hv7o',
    appId: '1:859756951077:ios:3f1cc21d46d41e0cb671cc',
    messagingSenderId: '859756951077',
    projectId: 'tape-64f67',
    databaseURL:
        'https://tape-64f67-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tape-64f67.appspot.com',
    iosBundleId: 'com.app.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_CP_C_YKdfph6wWD0ooFXwekV5f8hv7o',
    appId: '1:859756951077:ios:76cf6943c6292032b671cc',
    messagingSenderId: '859756951077',
    projectId: 'tape-64f67',
    databaseURL:
        'https://tape-64f67-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tape-64f67.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDUt-DXM0oO3jKQ6xArrnEDGfxTtWYSsW4',
    appId: '1:859756951077:web:2682a08aa0372bd7b671cc',
    messagingSenderId: '859756951077',
    projectId: 'tape-64f67',
    authDomain: 'tape-64f67.firebaseapp.com',
    databaseURL:
        'https://tape-64f67-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tape-64f67.appspot.com',
    measurementId: 'G-E4QLYJ5BP8',
  );
}
