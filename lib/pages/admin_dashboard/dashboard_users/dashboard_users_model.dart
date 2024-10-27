import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_users_widget.dart' show DashboardUsersWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class DashboardUsersModel extends FlutterFlowModel<DashboardUsersWidget> {
  ///  Local state fields for this page.

  UserRecord? currentUserDoc;

  bool userSidebarOpen = false;

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
