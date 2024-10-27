import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/course/course_edit_dialog/course_edit_dialog_widget.dart';
import '/courses/course/courses_dialog/courses_dialog_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'courses_list_widget.dart' show CoursesListWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CoursesListModel extends FlutterFlowModel<CoursesListWidget> {
  ///  State fields for stateful widgets in this page.

  List<TribeCourseRecord>? coursesListPreviousSnapshot;
  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for TopWebNav component.
  late TopWebNavModel topWebNavModel;
  // Model for GroupNavigation component.
  late GroupNavigationModel groupNavigationModel;
  // State field(s) for mobileFilterChoiceChips widget.
  FormFieldController<List<String>>? mobileFilterChoiceChipsValueController;
  String? get mobileFilterChoiceChipsValue =>
      mobileFilterChoiceChipsValueController?.value?.firstOrNull;
  set mobileFilterChoiceChipsValue(String? val) =>
      mobileFilterChoiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for desktopFilterChoiceChips widget.
  FormFieldController<List<String>>? desktopFilterChoiceChipsValueController;
  String? get desktopFilterChoiceChipsValue =>
      desktopFilterChoiceChipsValueController?.value?.firstOrNull;
  set desktopFilterChoiceChipsValue(String? val) =>
      desktopFilterChoiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for desktopFilterTextField widget.
  FocusNode? desktopFilterTextFieldFocusNode;
  TextEditingController? desktopFilterTextFieldTextController;
  String? Function(BuildContext, String?)?
      desktopFilterTextFieldTextControllerValidator;
  List<TribeCourseRecord> simpleSearchResults = [];
  // Stores action output result for [Backend Call - Create Document] action in addCourseButton widget.
  TribeCourseRecord? newCourseDoc;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  /// Query cache managers for this widget.

  final _courseListManager = StreamRequestManager<List<TribeCourseRecord>>();
  Stream<List<TribeCourseRecord>> courseList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TribeCourseRecord>> Function() requestFn,
  }) =>
      _courseListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCourseListCache() => _courseListManager.clear();
  void clearCourseListCacheKey(String? uniqueKey) =>
      _courseListManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    topWebNavModel = createModel(context, () => TopWebNavModel());
    groupNavigationModel = createModel(context, () => GroupNavigationModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    topWebNavModel.dispose();
    groupNavigationModel.dispose();
    desktopFilterTextFieldFocusNode?.dispose();
    desktopFilterTextFieldTextController?.dispose();

    groupListDrawerContentModel.dispose();

    /// Dispose query cache managers for this widget.

    clearCourseListCache();
  }
}
