import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/components/user_profile_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'group_members_list_widget.dart' show GroupMembersListWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GroupMembersListModel extends FlutterFlowModel<GroupMembersListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // State field(s) for filterTextField widget.
  FocusNode? filterTextFieldFocusNode;
  TextEditingController? filterTextFieldTextController;
  String? Function(BuildContext, String?)?
      filterTextFieldTextControllerValidator;
  List<UserRecord> simpleSearchResults = [];
  // Model for GroupSidebar component.
  late GroupSidebarModel groupSidebarModel;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  @override
  void initState(BuildContext context) {
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    groupSidebarModel = createModel(context, () => GroupSidebarModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    filterTextFieldFocusNode?.dispose();
    filterTextFieldTextController?.dispose();

    groupSidebarModel.dispose();
    profileButtonModel.dispose();
    groupListDrawerContentModel.dispose();
  }
}
