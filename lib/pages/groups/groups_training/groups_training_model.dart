import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/group_training_list/group_training_list_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'groups_training_widget.dart' show GroupsTrainingWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GroupsTrainingModel extends FlutterFlowModel<GroupsTrainingWidget> {
  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // Models for GroupTrainingList dynamic component.
  late FlutterFlowDynamicModels<GroupTrainingListModel> groupTrainingListModels;
  // Model for GroupSidebar component.
  late GroupSidebarModel groupSidebarModel;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    groupTrainingListModels =
        FlutterFlowDynamicModels(() => GroupTrainingListModel());
    groupSidebarModel = createModel(context, () => GroupSidebarModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    groupTrainingListModels.dispose();
    groupSidebarModel.dispose();
    groupListDrawerContentModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
