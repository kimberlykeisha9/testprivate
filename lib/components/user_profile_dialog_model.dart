import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'user_profile_dialog_widget.dart' show UserProfileDialogWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class UserProfileDialogModel extends FlutterFlowModel<UserProfileDialogWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> userPair = [];
  void addToUserPair(DocumentReference item) => userPair.add(item);
  void removeFromUserPair(DocumentReference item) => userPair.remove(item);
  void removeAtIndexFromUserPair(int index) => userPair.removeAt(index);
  void insertAtIndexInUserPair(int index, DocumentReference item) =>
      userPair.insert(index, item);
  void updateUserPairAtIndex(int index, Function(DocumentReference) updateFn) =>
      userPair[index] = updateFn(userPair[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in chatWithUserButton widget.
  ConversationsRecord? newConversation;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
