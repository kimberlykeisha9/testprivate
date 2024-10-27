import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_tickets_widget.dart' show DashboardTicketsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardTicketsModel extends FlutterFlowModel<DashboardTicketsWidget> {
  ///  Local state fields for this page.

  TribeGroupsStruct? currentTribeGroup;
  void updateCurrentTribeGroupStruct(Function(TribeGroupsStruct) updateFn) {
    updateFn(currentTribeGroup ??= TribeGroupsStruct());
  }

  List<String> groupCategoriesEdit = [];
  void addToGroupCategoriesEdit(String item) => groupCategoriesEdit.add(item);
  void removeFromGroupCategoriesEdit(String item) =>
      groupCategoriesEdit.remove(item);
  void removeAtIndexFromGroupCategoriesEdit(int index) =>
      groupCategoriesEdit.removeAt(index);
  void insertAtIndexInGroupCategoriesEdit(int index, String item) =>
      groupCategoriesEdit.insert(index, item);
  void updateGroupCategoriesEditAtIndex(int index, Function(String) updateFn) =>
      groupCategoriesEdit[index] = updateFn(groupCategoriesEdit[index]);

  ///  State fields for stateful widgets in this page.

  // Model for AdminDashNav component.
  late AdminDashNavModel adminDashNavModel;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap2 = {};
  List<dynamic> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {
    adminDashNavModel = createModel(context, () => AdminDashNavModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
  }

  @override
  void dispose() {
    adminDashNavModel.dispose();
    profileButtonModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
