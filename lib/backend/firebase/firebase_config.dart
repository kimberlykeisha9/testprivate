import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDJWAEfDyj8Dj7e0sTJLuMb-0zwxSN9TnA",
            authDomain: "tribe-master-app.firebaseapp.com",
            projectId: "tribe-master-app",
            storageBucket: "tribe-master-app.appspot.com",
            messagingSenderId: "1005726201112",
            appId: "1:1005726201112:web:e3d7f8fb8f2c721760da6d",
            measurementId: "G-LBC8KC9XG7"));
  } else {
    await Firebase.initializeApp();
  }
}
