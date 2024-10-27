// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart'; // Import for currentUserReference

// Custom Action Code
Future<int> getUnreadNotificationCount() async {
  try {
    // Get the current user's reference
    final userRef = currentUserReference;

    // Check if userRef is not null
    if (userRef == null) {
      print('User is not signed in.');
      return 0;
    }

    // Query Notifications where UserRefList contains the current user
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Notifications') // Use capital 'N'
        .where('UserRefList', arrayContains: userRef)
        .get();

    int count = 0;

    // Iterate through each notification
    for (var doc in querySnapshot.docs) {
      List<dynamic> viewedBy = doc.data()['viewedBy'] ?? [];
      // Check if the current user has not viewed the notification
      if (!viewedBy.contains(userRef)) {
        count++;
      }
    }

    return count;
  } catch (e) {
    print('Error fetching unread notifications: $e');
    return 0;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
