import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/alert_dialog_widget.dart';
import '/components/feed_post_item_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/auth/empty_states/empty_other_user_posts/empty_other_user_posts_widget.dart';
import '/pages/groups/group_components/dashboard_member_options/dashboard_member_options_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_members_widget.dart' show DashboardMembersWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DashboardMembersModel extends FlutterFlowModel<DashboardMembersWidget> {
  ///  Local state fields for this page.

  bool userSidebarOpen = false;

  UserRecord? currentUserDoc;

  String emails = 'empty';

  TribeGroupsStruct? currentTribeGroup;
  void updateCurrentTribeGroupStruct(Function(TribeGroupsStruct) updateFn) {
    updateFn(currentTribeGroup ??= TribeGroupsStruct());
  }

  List<UserBadgesStruct> selectedCheckboxes = [];
  void addToSelectedCheckboxes(UserBadgesStruct item) =>
      selectedCheckboxes.add(item);
  void removeFromSelectedCheckboxes(UserBadgesStruct item) =>
      selectedCheckboxes.remove(item);
  void removeAtIndexFromSelectedCheckboxes(int index) =>
      selectedCheckboxes.removeAt(index);
  void insertAtIndexInSelectedCheckboxes(int index, UserBadgesStruct item) =>
      selectedCheckboxes.insert(index, item);
  void updateSelectedCheckboxesAtIndex(
          int index, Function(UserBadgesStruct) updateFn) =>
      selectedCheckboxes[index] = updateFn(selectedCheckboxes[index]);

  ///  State fields for stateful widgets in this page.

  // Model for AdminDashNav component.
  late AdminDashNavModel adminDashNavModel;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // State field(s) for filterTextField widget.
  FocusNode? filterTextFieldFocusNode;
  TextEditingController? filterTextFieldTextController;
  String? Function(BuildContext, String?)?
      filterTextFieldTextControllerValidator;
  List<UserRecord> simpleSearchResults = [];
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  bool? deleteUserDialogResponse;
  // Stores action output result for [Backend Call - API (Remove User from Group)] action in IconButton widget.
  ApiCallResponse? removeUserAPIResponse;
  // State field(s) for Checkbox widget.
  Map<UserBadgesStruct, bool> checkboxValueMap = {};
  List<UserBadgesStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {
    adminDashNavModel = createModel(context, () => AdminDashNavModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
  }

  @override
  void dispose() {
    adminDashNavModel.dispose();
    profileButtonModel.dispose();
    filterTextFieldFocusNode?.dispose();
    filterTextFieldTextController?.dispose();
  }
}
