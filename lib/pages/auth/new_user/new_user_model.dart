import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'new_user_widget.dart' show NewUserWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewUserModel extends FlutterFlowModel<NewUserWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NewUser_Name widget.
  FocusNode? newUserNameFocusNode;
  TextEditingController? newUserNameTextController;
  String? Function(BuildContext, String?)? newUserNameTextControllerValidator;
  String? _newUserNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for NewUser_emailAddress widget.
  FocusNode? newUserEmailAddressFocusNode;
  TextEditingController? newUserEmailAddressTextController;
  String? Function(BuildContext, String?)?
      newUserEmailAddressTextControllerValidator;
  String? _newUserEmailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for signUp_password widget.
  FocusNode? signUpPasswordFocusNode;
  TextEditingController? signUpPasswordTextController;
  late bool signUpPasswordVisibility;
  String? Function(BuildContext, String?)?
      signUpPasswordTextControllerValidator;
  String? _signUpPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for signuppassConfirm widget.
  FocusNode? signuppassConfirmFocusNode;
  TextEditingController? signuppassConfirmTextController;
  late bool signuppassConfirmVisibility;
  String? Function(BuildContext, String?)?
      signuppassConfirmTextControllerValidator;
  String? _signuppassConfirmTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for AcceptTerms widget.
  bool? acceptTermsValue;
  // Stores action output result for [Backend Call - API (setPassword)] action in Button-SignUp widget.
  ApiCallResponse? setPasswordResponse;
  // Stores action output result for [Backend Call - API (Signup)] action in NewAccount widget.
  ApiCallResponse? signUpResponse;

  @override
  void initState(BuildContext context) {
    newUserNameTextControllerValidator = _newUserNameTextControllerValidator;
    newUserEmailAddressTextControllerValidator =
        _newUserEmailAddressTextControllerValidator;
    signUpPasswordVisibility = false;
    signUpPasswordTextControllerValidator =
        _signUpPasswordTextControllerValidator;
    signuppassConfirmVisibility = false;
    signuppassConfirmTextControllerValidator =
        _signuppassConfirmTextControllerValidator;
  }

  @override
  void dispose() {
    newUserNameFocusNode?.dispose();
    newUserNameTextController?.dispose();

    newUserEmailAddressFocusNode?.dispose();
    newUserEmailAddressTextController?.dispose();

    signUpPasswordFocusNode?.dispose();
    signUpPasswordTextController?.dispose();

    signuppassConfirmFocusNode?.dispose();
    signuppassConfirmTextController?.dispose();
  }
}
