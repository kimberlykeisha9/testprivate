import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'reply_to_comment_f_b_widget.dart' show ReplyToCommentFBWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReplyToCommentFBModel extends FlutterFlowModel<ReplyToCommentFBWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();
  }

  /// Action blocks.
  Future notifications(BuildContext context) async {}
}
