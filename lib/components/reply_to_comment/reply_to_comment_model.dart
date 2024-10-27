import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'reply_to_comment_widget.dart' show ReplyToCommentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReplyToCommentModel extends FlutterFlowModel<ReplyToCommentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;
  // Stores action output result for [Backend Call - API (createChat)] action in Button widget.
  ApiCallResponse? chatResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();
  }
}
