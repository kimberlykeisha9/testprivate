import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/feed_post_item_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_admin_reply_widget.dart' show DashboardAdminReplyWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class DashboardAdminReplyModel
    extends FlutterFlowModel<DashboardAdminReplyWidget> {
  ///  Local state fields for this page.

  bool userSidebarOpen = false;

  String emails = 'empty';

  BroadcastsRecord? currentBroadcastDoc;

  ///  State fields for stateful widgets in this page.

  // Model for AdminDashNav component.
  late AdminDashNavModel adminDashNavModel;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, BroadcastsRecord>?
      listViewPagingController1;
  Query? listViewPagingQuery1;
  List<StreamSubscription?> listViewStreamSubscriptions1 = [];

  // Model for feedPostItem component.
  late FeedPostItemModel feedPostItemModel;
  // Models for DiscussionComment dynamic component.
  late FlutterFlowDynamicModels<DiscussionCommentModel> discussionCommentModels;
  // State field(s) for commentBox widget.
  FocusNode? commentBoxFocusNode;
  TextEditingController? commentBoxTextController;
  String? Function(BuildContext, String?)? commentBoxTextControllerValidator;

  @override
  void initState(BuildContext context) {
    adminDashNavModel = createModel(context, () => AdminDashNavModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    feedPostItemModel = createModel(context, () => FeedPostItemModel());
    discussionCommentModels =
        FlutterFlowDynamicModels(() => DiscussionCommentModel());
  }

  @override
  void dispose() {
    adminDashNavModel.dispose();
    profileButtonModel.dispose();
    listViewStreamSubscriptions1.forEach((s) => s?.cancel());
    listViewPagingController1?.dispose();

    feedPostItemModel.dispose();
    discussionCommentModels.dispose();
    commentBoxFocusNode?.dispose();
    commentBoxTextController?.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, BroadcastsRecord> setListViewController1(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController1 ??= _createListViewController1(query, parent);
    if (listViewPagingQuery1 != query) {
      listViewPagingQuery1 = query;
      listViewPagingController1?.refresh();
    }
    return listViewPagingController1!;
  }

  PagingController<DocumentSnapshot?, BroadcastsRecord>
      _createListViewController1(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, BroadcastsRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryBroadcastsRecordPage(
          queryBuilder: (_) => listViewPagingQuery1 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions1,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
