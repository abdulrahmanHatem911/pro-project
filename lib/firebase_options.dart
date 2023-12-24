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
    apiKey: 'AIzaSyAOm4aG9-t6wSU7K2z0sUNydlu86D3r8jo',
    appId: '1:126573697599:web:553414b9cc83cdad6af68a',
    messagingSenderId: '126573697599',
    projectId: 'zozz-20f25',
    authDomain: 'zozz-20f25.firebaseapp.com',
    storageBucket: 'zozz-20f25.appspot.com',
    measurementId: 'G-C0P1QKMPP6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCift6npbcaiHBpa_NpNYfl6LNL1hoFZU8',
    appId: '1:126573697599:android:deecab2a6e33cd6d6af68a',
    messagingSenderId: '126573697599',
    projectId: 'zozz-20f25',
    storageBucket: 'zozz-20f25.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6YNpCQzVzQzV_cy_T1IupJAmiKVAxxj0',
    appId: '1:126573697599:ios:3ee3704214eeca7a6af68a',
    messagingSenderId: '126573697599',
    projectId: 'zozz-20f25',
    storageBucket: 'zozz-20f25.appspot.com',
    iosBundleId: 'com.example.pre',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6YNpCQzVzQzV_cy_T1IupJAmiKVAxxj0',
    appId: '1:126573697599:ios:1eeeb9867d2529356af68a',
    messagingSenderId: '126573697599',
    projectId: 'zozz-20f25',
    storageBucket: 'zozz-20f25.appspot.com',
    iosBundleId: 'com.example.pre.RunnerTests',
  );
}