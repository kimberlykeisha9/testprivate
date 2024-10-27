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

// Define a function called reorderItems that returns a Future of a list of strings.
// It takes in a list of strings, an old index, and a new index as parameters.
Future reorderTribeContentList(
  List<TribeContentRecord> list,
  int oldIndex,
  int newIndex,
) async {
  // If the item is being moved down the list, we adjust the newIndex.
  if (oldIndex < newIndex) {
    newIndex -= 1;
  }

  // Remove the item from its current position in the list.
  final TribeContentRecord item = list.removeAt(oldIndex);

  // Insert the item into its new position.
  list.insert(newIndex, item);

  // Create a batch to combine multiple Firestore operations into one.
  final batch = FirebaseFirestore.instance.batch();

  // Iterate through the list and update the 'position' field for each document in Firestore.
  for (int i = 0; i < list.length; i++) {
    final TribeContentRecord doc = list[i];
    // Update the 'position' field of the document with its new index.
    // This assumes that you have a 'position' field in Firestore where you store the order of the items.
    batch.update(doc.reference, {'position': i});
  }

  // Commit all the batched operations to Firestore.
  return await batch.commit();
}
