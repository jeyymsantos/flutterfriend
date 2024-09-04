import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCfBWGZoQerU8E553HXwlxx08_RsE2_JkU",
            authDomain: "flutter-friend-zfkkka.firebaseapp.com",
            projectId: "flutter-friend-zfkkka",
            storageBucket: "flutter-friend-zfkkka.appspot.com",
            messagingSenderId: "716224900630",
            appId: "1:716224900630:web:eb1c40bd53e4695b0a0f37"));
  } else {
    await Firebase.initializeApp();
  }
}
