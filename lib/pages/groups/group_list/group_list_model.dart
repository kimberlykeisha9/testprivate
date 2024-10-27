import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bottom_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/explore_groups_c_t_a/explore_groups_c_t_a_widget.dart';
import 'dart:math';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'group_list_widget.dart' show GroupListWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupListModel extends FlutterFlowModel<GroupListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for ExploreGroupsCTA component.
  late ExploreGroupsCTAModel exploreGroupsCTAModel1;
  // Model for ExploreGroupsCTA component.
  late ExploreGroupsCTAModel exploreGroupsCTAModel2;
  // Model for BottomNav component.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    exploreGroupsCTAModel1 =
        createModel(context, () => ExploreGroupsCTAModel());
    exploreGroupsCTAModel2 =
        createModel(context, () => ExploreGroupsCTAModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    exploreGroupsCTAModel1.dispose();
    exploreGroupsCTAModel2.dispose();
    bottomNavModel.dispose();
  }
}
