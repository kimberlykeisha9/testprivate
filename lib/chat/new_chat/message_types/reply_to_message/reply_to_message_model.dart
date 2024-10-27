import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/new_chat/message_types/message_types/message_types_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reply_to_message_widget.dart' show ReplyToMessageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReplyToMessageModel extends FlutterFlowModel<ReplyToMessageWidget> {
  ///  Local state fields for this component.

  bool audioPlaying = false;

  ///  State fields for stateful widgets in this component.

  // Model for MessageTypes component.
  late MessageTypesModel messageTypesModel;

  @override
  void initState(BuildContext context) {
    messageTypesModel = createModel(context, () => MessageTypesModel());
  }

  @override
  void dispose() {
    messageTypesModel.dispose();
  }
}
