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

Future<List<UserBadgesStruct>> reorderUserBadges(
  int? oldIndex,
  int? newIndex,
  List<UserBadgesStruct>? badges,
) async {
  // if oldIndex < newIndex, then newIndex -= 1, move item at oldIndex into newIndex
  if (oldIndex != null && newIndex != null && badges != null) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final UserBadgesStruct item = badges.removeAt(oldIndex);
    badges.insert(newIndex, item);
    return badges;
  } else {
    throw Exception('Invalid parameters');
  }
}
