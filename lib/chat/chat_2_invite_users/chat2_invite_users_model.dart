import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/empty_state_simple/empty_state_simple_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'chat2_invite_users_widget.dart' show Chat2InviteUsersWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class Chat2InviteUsersModel extends FlutterFlowModel<Chat2InviteUsersWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> userPair = [];
  void addToUserPair(DocumentReference item) => userPair.add(item);
  void removeFromUserPair(DocumentReference item) => userPair.remove(item);
  void removeAtIndexFromUserPair(int index) => userPair.removeAt(index);
  void insertAtIndexInUserPair(int index, DocumentReference item) =>
      userPair.insert(index, item);
  void updateUserPairAtIndex(int index, Function(DocumentReference) updateFn) =>
      userPair[index] = updateFn(userPair[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<UserRecord> simpleSearchResults = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  DirectMessagesChatRecord? updatedChatThread;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  DirectMessagesChatRecord? newChatThread;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
