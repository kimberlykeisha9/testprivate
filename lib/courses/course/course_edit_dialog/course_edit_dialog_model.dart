import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/course_member_role_dropdown_widget.dart';
import '/courses/course/course_invite_member_dialog/course_invite_member_dialog_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import 'course_edit_dialog_widget.dart' show CourseEditDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CourseEditDialogModel extends FlutterFlowModel<CourseEditDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for accessChoiceChips widget.
  FormFieldController<List<String>>? accessChoiceChipsValueController;
  String? get accessChoiceChipsValue =>
      accessChoiceChipsValueController?.value?.firstOrNull;
  set accessChoiceChipsValue(String? val) =>
      accessChoiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for courseNameTextField widget.
  FocusNode? courseNameTextFieldFocusNode;
  TextEditingController? courseNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      courseNameTextFieldTextControllerValidator;
  String? _courseNameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Course name cannot be empty';
    }

    return null;
  }

  // State field(s) for courseDescriptionTextField widget.
  FocusNode? courseDescriptionTextFieldFocusNode;
  TextEditingController? courseDescriptionTextFieldTextController;
  String? Function(BuildContext, String?)?
      courseDescriptionTextFieldTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {
    courseNameTextFieldTextControllerValidator =
        _courseNameTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    courseNameTextFieldFocusNode?.dispose();
    courseNameTextFieldTextController?.dispose();

    courseDescriptionTextFieldFocusNode?.dispose();
    courseDescriptionTextFieldTextController?.dispose();
  }
}
