import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/feed_post_item_widget.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/auth/empty_states/empty_community_post/empty_community_post_widget.dart';
import '/pages/groups/group_components/create_post_popup/create_post_popup_widget.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'groups_community_f_b_widget.dart' show GroupsCommunityFBWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GroupsCommunityFBModel extends FlutterFlowModel<GroupsCommunityFBWidget> {
  ///  Local state fields for this page.

  bool isLoadMorePosts = false;

  String? userID;

  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, BroadcastsRecord>?
      listViewPagingController;
  Query? listViewPagingQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  // Models for feedPostItem dynamic component.
  late FlutterFlowDynamicModels<FeedPostItemModel> feedPostItemModels;
  // Model for GroupSidebar component.
  late GroupSidebarModel groupSidebarModel;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    feedPostItemModels = FlutterFlowDynamicModels(() => FeedPostItemModel());
    groupSidebarModel = createModel(context, () => GroupSidebarModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    listViewStreamSubscriptions.forEach((s) => s?.cancel());
    listViewPagingController?.dispose();

    feedPostItemModels.dispose();
    groupSidebarModel.dispose();
    groupListDrawerContentModel.dispose();
  }

  /// Action blocks.
  Future refreshFeed(BuildContext context) async {}

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, BroadcastsRecord> setListViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController ??= _createListViewController(query, parent);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<DocumentSnapshot?, BroadcastsRecord>
      _createListViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, BroadcastsRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryBroadcastsRecordPage(
          queryBuilder: (_) => listViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions,
          controller: controller,
          pageSize: 10,
          isStream: true,
        ),
      );
  }
}
