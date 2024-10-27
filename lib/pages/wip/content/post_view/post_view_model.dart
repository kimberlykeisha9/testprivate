import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/delete_post/delete_post_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/reply_to_comment/reply_to_comment_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/group_training_list/group_training_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'post_view_widget.dart' show PostViewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PostViewModel extends FlutterFlowModel<PostViewWidget> {
  ///  Local state fields for this page.

  bool completed = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (viewPost)] action in PostView widget.
  ApiCallResponse? apiResult8rv;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Models for GroupTrainingList dynamic component.
  late FlutterFlowDynamicModels<GroupTrainingListModel> groupTrainingListModels;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // Stores action output result for [Backend Call - API (completeGroupContent)] action in Completed widget.
  ApiCallResponse? apiResultc02;
  // Stores action output result for [Backend Call - API (completeGroupContent)] action in Incomplete widget.
  ApiCallResponse? apiResultc05;
  // Stores action output result for [Backend Call - API (getGroupContent)] action in Icon widget.
  ApiCallResponse? apiResulthu7;
  // Stores action output result for [Backend Call - API (likePost)] action in Stack widget.
  ApiCallResponse? likePostResult;
  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;
  // Stores action output result for [Backend Call - API (createChat)] action in Button widget.
  ApiCallResponse? chatResponse2;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupTrainingListModels =
        FlutterFlowDynamicModels(() => GroupTrainingListModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupTrainingListModels.dispose();
    groupNavigationModel.dispose();
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();
  }
}
