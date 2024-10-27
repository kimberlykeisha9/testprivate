import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'group_training_list_user_widget.dart' show GroupTrainingListUserWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupTrainingListUserModel
    extends FlutterFlowModel<GroupTrainingListUserWidget> {
  ///  Local state fields for this component.

  DocumentReference? courseRef;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  /// Query cache managers for this widget.

  final _getCourseModuleContentsManager =
      FutureRequestManager<List<TribeContentRecord>>();
  Future<List<TribeContentRecord>> getCourseModuleContents({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TribeContentRecord>> Function() requestFn,
  }) =>
      _getCourseModuleContentsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetCourseModuleContentsCache() =>
      _getCourseModuleContentsManager.clear();
  void clearGetCourseModuleContentsCacheKey(String? uniqueKey) =>
      _getCourseModuleContentsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();

    /// Dispose query cache managers for this widget.

    clearGetCourseModuleContentsCache();
  }
}
