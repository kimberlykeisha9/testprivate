import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/user/content_display_dialog/content_display_dialog_widget.dart';
import '/courses/user/group_training_list_user/group_training_list_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'post_view_mobile_content_widget.dart' show PostViewMobileContentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PostViewMobileContentModel
    extends FlutterFlowModel<PostViewMobileContentWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for contentDisplayDialog component.
  late ContentDisplayDialogModel contentDisplayDialogModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    contentDisplayDialogModel =
        createModel(context, () => ContentDisplayDialogModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    groupNavigationModel.dispose();
    topWebNavModel.dispose();
    contentDisplayDialogModel.dispose();
  }
}
