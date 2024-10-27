import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import '/pages/groups/group_components/post_options_f_b/post_options_f_b_widget.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'discussion_post_widget.dart' show DiscussionPostWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DiscussionPostModel extends FlutterFlowModel<DiscussionPostWidget> {
  ///  Local state fields for this page.

  bool editMode = false;

  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Models for DiscussionComment dynamic component.
  late FlutterFlowDynamicModels<DiscussionCommentModel> discussionCommentModels;
  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;
  // Model for GroupSidebar component.
  late GroupSidebarModel groupSidebarModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    discussionCommentModels =
        FlutterFlowDynamicModels(() => DiscussionCommentModel());
    groupSidebarModel = createModel(context, () => GroupSidebarModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    discussionCommentModels.dispose();
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();

    groupSidebarModel.dispose();
  }
}
