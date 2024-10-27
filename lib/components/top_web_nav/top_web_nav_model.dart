import '/backend/backend.dart';
import '/components/group_list_content_web/group_list_content_web_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'top_web_nav_widget.dart' show TopWebNavWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TopWebNavModel extends FlutterFlowModel<TopWebNavWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    groupNavigationModel.dispose();
  }
}
