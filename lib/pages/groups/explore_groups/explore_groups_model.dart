import '/backend/backend.dart';
import '/components/group_info_bottom_sheet_widget.dart';
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
import '/flutter_flow/custom_functions.dart' as functions;
import 'explore_groups_widget.dart' show ExploreGroupsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ExploreGroupsModel extends FlutterFlowModel<ExploreGroupsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // State field(s) for filterTextField widget.
  FocusNode? filterTextFieldFocusNode;
  TextEditingController? filterTextFieldTextController;
  String? Function(BuildContext, String?)?
      filterTextFieldTextControllerValidator;
  List<TribeGroupsRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    filterTextFieldFocusNode?.dispose();
    filterTextFieldTextController?.dispose();
  }
}
