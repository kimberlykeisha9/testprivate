import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'discussion_post_redirect_widget.dart' show DiscussionPostRedirectWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DiscussionPostRedirectModel
    extends FlutterFlowModel<DiscussionPostRedirectWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in DiscussionPostRedirect widget.
  BroadcastsRecord? getBroadcastDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in DiscussionPostRedirect widget.
  TribeGroupsRecord? groupDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
