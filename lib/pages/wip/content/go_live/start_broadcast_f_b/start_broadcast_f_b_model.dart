import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'start_broadcast_f_b_widget.dart' show StartBroadcastFBWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartBroadcastFBModel extends FlutterFlowModel<StartBroadcastFBWidget> {
  ///  State fields for stateful widgets in this page.

  BroadcastsRecord? startBroadcastFBPreviousSnapshot;
  // Stores action output result for [Backend Call - Read Document] action in StartBroadcast_FB widget.
  BroadcastsRecord? checkIfLive;
  // Stores action output result for [Firestore Query - Query a collection] action in StartBroadcast_FB widget.
  List<UserRecord>? queryGroupUsersGoLive;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
