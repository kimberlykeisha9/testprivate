import '/acme_chat/general/grey_divider/grey_divider_widget.dart';
import '/acme_chat/overlays/archive_overlay/archive_overlay_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'conversation_container_widget.dart' show ConversationContainerWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ConversationContainerModel
    extends FlutterFlowModel<ConversationContainerWidget> {
  ///  Local state fields for this component.

  bool actionON = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ComponentHover widget.
  bool componentHoverHovered = false;
  // State field(s) for OptionsHover widget.
  bool optionsHoverHovered = false;
  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel;

  @override
  void initState(BuildContext context) {
    greyDividerModel = createModel(context, () => GreyDividerModel());
  }

  @override
  void dispose() {
    greyDividerModel.dispose();
  }
}
