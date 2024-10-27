import '/acme_chat/message_types/message_types/message_types_widget.dart';
import '/acme_chat/message_types/reply_to_message/reply_to_message_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'sent_message_widget.dart' show SentMessageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SentMessageModel extends FlutterFlowModel<SentMessageWidget> {
  ///  Local state fields for this component.

  bool audioPlaying = false;

  bool audioReplyPlaying = false;

  ///  State fields for stateful widgets in this component.

  // Model for ReplyToMessage component.
  late ReplyToMessageModel replyToMessageModel;
  // Model for MessageTypes component.
  late MessageTypesModel messageTypesModel;

  @override
  void initState(BuildContext context) {
    replyToMessageModel = createModel(context, () => ReplyToMessageModel());
    messageTypesModel = createModel(context, () => MessageTypesModel());
  }

  @override
  void dispose() {
    replyToMessageModel.dispose();
    messageTypesModel.dispose();
  }
}
