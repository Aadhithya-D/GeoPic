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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAo7mRjf46ONMlYx5EBjuoY3gaw9u5-toA',
    appId: '1:18014732791:web:7e656da9e28614f0c0aef2',
    messagingSenderId: '18014732791',
    projectId: 'os-app-979bd',
    authDomain: 'os-app-979bd.firebaseapp.com',
    storageBucket: 'os-app-979bd.appspot.com',
    measurementId: 'G-FD7DET84MC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC46b4iTZBXfj0cJHSn5MXvppgKnOqbpJI',
    appId: '1:18014732791:android:56e675d24b3de399c0aef2',
    messagingSenderId: '18014732791',
    projectId: 'os-app-979bd',
    storageBucket: 'os-app-979bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApPpZw6dvOc_AC8j3tjw38IiqxA-6ORV8',
    appId: '1:18014732791:ios:fca2e6256e263cddc0aef2',
    messagingSenderId: '18014732791',
    projectId: 'os-app-979bd',
    storageBucket: 'os-app-979bd.appspot.com',
    iosClientId: '18014732791-eulnofnkanje2gpssqa1eh2f433rl801.apps.googleusercontent.com',
    iosBundleId: 'com.example.osApp',
  );
}
