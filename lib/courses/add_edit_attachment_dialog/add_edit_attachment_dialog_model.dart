import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import 'add_edit_attachment_dialog_widget.dart'
    show AddEditAttachmentDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEditAttachmentDialogModel
    extends FlutterFlowModel<AddEditAttachmentDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for urlTextField widget.
  FocusNode? urlTextFieldFocusNode;
  TextEditingController? urlTextFieldTextController;
  String? Function(BuildContext, String?)? urlTextFieldTextControllerValidator;
  String? _urlTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Provide public URL to your attachment';
    }

    return null;
  }

  // State field(s) for nameTextField widget.
  FocusNode? nameTextFieldFocusNode;
  TextEditingController? nameTextFieldTextController;
  String? Function(BuildContext, String?)? nameTextFieldTextControllerValidator;
  String? _nameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please provide name for your attachment';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    urlTextFieldTextControllerValidator = _urlTextFieldTextControllerValidator;
    nameTextFieldTextControllerValidator =
        _nameTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    urlTextFieldFocusNode?.dispose();
    urlTextFieldTextController?.dispose();

    nameTextFieldFocusNode?.dispose();
    nameTextFieldTextController?.dispose();
  }
}
