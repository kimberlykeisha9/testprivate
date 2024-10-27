import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/dashboard_stat_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dashboard_group_settings_widget.dart' show DashboardGroupSettingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardGroupSettingsModel
    extends FlutterFlowModel<DashboardGroupSettingsWidget> {
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

  bool confirmDelete = false;

  ///  State fields for stateful widgets in this page.

  // Model for AdminDashNav component.
  late AdminDashNavModel adminDashNavModel;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for DashboardStat component.
  late DashboardStatModel dashboardStatModel1;
  // Model for DashboardStat component.
  late DashboardStatModel dashboardStatModel2;
  // Model for DashboardStat component.
  late DashboardStatModel dashboardStatModel3;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - reorderUserBadges] action in ListGroupBadges widget.
  List<UserBadgesStruct>? newListOrder;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  @override
  void initState(BuildContext context) {
    adminDashNavModel = createModel(context, () => AdminDashNavModel());
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    dashboardStatModel1 = createModel(context, () => DashboardStatModel());
    dashboardStatModel2 = createModel(context, () => DashboardStatModel());
    dashboardStatModel3 = createModel(context, () => DashboardStatModel());
  }

  @override
  void dispose() {
    adminDashNavModel.dispose();
    profileButtonModel.dispose();
    dashboardStatModel1.dispose();
    dashboardStatModel2.dispose();
    dashboardStatModel3.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
