import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/new_comment_component_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/progress_bar_with_text_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/course/admin_tab/content_edit_dialog/content_edit_dialog_widget.dart';
import '/courses/course/admin_tab/group_training_list_admin/group_training_list_admin_widget.dart';
import '/courses/course/admin_tab/module_edit_dialog/module_edit_dialog_widget.dart';
import '/courses/user/content_display_dialog/content_display_dialog_widget.dart';
import '/courses/user/group_training_list_user/group_training_list_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'post_view_user_admin_widget.dart' show PostViewUserAdminWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PostViewUserAdminModel extends FlutterFlowModel<PostViewUserAdminWidget> {
  ///  Local state fields for this page.

  ActiveCourseTab? activeTabToDisplay = ActiveCourseTab.none;

  TribeCollectionRecord? activeCollectionDoc;

  TribeContentRecord? activeContentDoc;

  bool adminIsEditMode = false;

  List<double> collectionProgress = [];
  void addToCollectionProgress(double item) => collectionProgress.add(item);
  void removeFromCollectionProgress(double item) =>
      collectionProgress.remove(item);
  void removeAtIndexFromCollectionProgress(int index) =>
      collectionProgress.removeAt(index);
  void insertAtIndexInCollectionProgress(int index, double item) =>
      collectionProgress.insert(index, item);
  void updateCollectionProgressAtIndex(int index, Function(double) updateFn) =>
      collectionProgress[index] = updateFn(collectionProgress[index]);

  bool isUserAdmin = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in PostViewUserAdmin widget.
  MembersListRecord? isUserCoach;
  // Stores action output result for [Backend Call - Read Document] action in PostViewUserAdmin widget.
  TribeCourseRecord? isCourseEmpty;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // Model for ProgressBarWithText component.
  late ProgressBarWithTextModel progressBarWithTextModel;
  // Stores action output result for [Backend Call - Create Document] action in addModuleButton widget.
  TribeCollectionRecord? firstCollectionDoc;
  // Models for groupTrainingListUser dynamic component.
  late FlutterFlowDynamicModels<GroupTrainingListUserModel>
      groupTrainingListUserModels;
  // Stores action output result for [Backend Call - Create Document] action in addModuleButton widget.
  TribeCollectionRecord? newCollectionDoc;
  // Model for contentEditDialog component.
  late ContentEditDialogModel contentEditDialogModel;
  // Model for contentDisplayDialog component.
  late ContentDisplayDialogModel contentDisplayDialogModel;
  // Models for DiscussionComment dynamic component.
  late FlutterFlowDynamicModels<DiscussionCommentModel> discussionCommentModels;
  // Model for newCommentComponent component.
  late NewCommentComponentModel newCommentComponentModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    progressBarWithTextModel =
        createModel(context, () => ProgressBarWithTextModel());
    groupTrainingListUserModels =
        FlutterFlowDynamicModels(() => GroupTrainingListUserModel());
    contentEditDialogModel =
        createModel(context, () => ContentEditDialogModel());
    contentDisplayDialogModel =
        createModel(context, () => ContentDisplayDialogModel());
    discussionCommentModels =
        FlutterFlowDynamicModels(() => DiscussionCommentModel());
    newCommentComponentModel =
        createModel(context, () => NewCommentComponentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    progressBarWithTextModel.dispose();
    groupTrainingListUserModels.dispose();
    contentEditDialogModel.dispose();
    contentDisplayDialogModel.dispose();
    discussionCommentModels.dispose();
    newCommentComponentModel.dispose();
  }
}
