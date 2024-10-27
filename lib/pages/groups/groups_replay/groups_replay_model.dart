import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'groups_replay_widget.dart' show GroupsReplayWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GroupsReplayModel extends FlutterFlowModel<GroupsReplayWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // Model for GroupSidebar component.
  late GroupSidebarModel groupSidebarModel;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    groupSidebarModel = createModel(context, () => GroupSidebarModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    groupSidebarModel.dispose();
    groupListDrawerContentModel.dispose();
  }
}
