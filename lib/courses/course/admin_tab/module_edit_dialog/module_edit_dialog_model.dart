import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/alert_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'module_edit_dialog_widget.dart' show ModuleEditDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ModuleEditDialogModel extends FlutterFlowModel<ModuleEditDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for collectionNameTextField widget.
  FocusNode? collectionNameTextFieldFocusNode;
  TextEditingController? collectionNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      collectionNameTextFieldTextControllerValidator;
  String? _collectionNameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name cannot be empty';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 50) {
      return 'Maximum 50 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // Stores action output result for [Alert Dialog - Custom Dialog] action in deleteButton widget.
  bool? alertDialogResponse;

  @override
  void initState(BuildContext context) {
    collectionNameTextFieldTextControllerValidator =
        _collectionNameTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    collectionNameTextFieldFocusNode?.dispose();
    collectionNameTextFieldTextController?.dispose();
  }
}
