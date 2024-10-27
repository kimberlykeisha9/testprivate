import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/alert_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'course_invite_member_dialog_widget.dart'
    show CourseInviteMemberDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CourseInviteMemberDialogModel
    extends FlutterFlowModel<CourseInviteMemberDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for filterTextField widget.
  FocusNode? filterTextFieldFocusNode;
  TextEditingController? filterTextFieldTextController;
  String? Function(BuildContext, String?)?
      filterTextFieldTextControllerValidator;
  List<UserRecord> simpleSearchResults = [];
  // Stores action output result for [Alert Dialog - Custom Dialog] action in inviteUserButton widget.
  bool? addUserDialog;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    filterTextFieldFocusNode?.dispose();
    filterTextFieldTextController?.dispose();
  }
}
