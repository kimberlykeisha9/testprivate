import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'new_comment_component_widget.dart' show NewCommentComponentWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewCommentComponentModel
    extends FlutterFlowModel<NewCommentComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;
  String? _commentBoxTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Comment cannot be empty';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    commentBoxTextControllerValidator = _commentBoxTextControllerValidator;
  }

  @override
  void dispose() {
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();
  }
}
