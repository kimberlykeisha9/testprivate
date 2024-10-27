import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_platform_settings_widget.dart'
    show DashboardPlatformSettingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DashboardPlatformSettingsModel
    extends FlutterFlowModel<DashboardPlatformSettingsWidget> {
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
  // State field(s) for ExporeGroups widget.
  bool? exporeGroupsValue;
  // Stores action output result for [Cloud Function - updateFeatureAllowExploreGroups] action in ExporeGroups widget.
  UpdateFeatureAllowExploreGroupsCloudFunctionCallResponse? updateExploreGroups;
  // Stores action output result for [Cloud Function - updateFeatureAllowExploreGroups] action in ExporeGroups widget.
  UpdateFeatureAllowExploreGroupsCloudFunctionCallResponse?
      updateExploreGroupsCopy;
  // State field(s) for EnabledDM widget.
  bool? enabledDMValue;
  // Stores action output result for [Cloud Function - updateEnableDMinApp] action in EnabledDM widget.
  UpdateEnableDMinAppCloudFunctionCallResponse? dMEnable;
  // Stores action output result for [Cloud Function - updateEnableDMinApp] action in EnabledDM widget.
  UpdateEnableDMinAppCloudFunctionCallResponse? dMDisable;
  // State field(s) for EnableGroupCategories widget.
  bool? enableGroupCategoriesValue;
  // Stores action output result for [Cloud Function - updateIsGroupTypeEnabled] action in EnableGroupCategories widget.
  UpdateIsGroupTypeEnabledCloudFunctionCallResponse? groupTypeEnable;
  // Stores action output result for [Cloud Function - updateIsGroupTypeEnabled] action in EnableGroupCategories widget.
  UpdateIsGroupTypeEnabledCloudFunctionCallResponse? groupTypeDisable;

  @override
  void initState(BuildContext context) {
    adminDashNavModel = createModel(context, () => AdminDashNavModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
  }

  @override
  void dispose() {
    adminDashNavModel.dispose();
    profileButtonModel.dispose();
  }
}
