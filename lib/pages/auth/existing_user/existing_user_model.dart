import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'existing_user_widget.dart' show ExistingUserWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExistingUserModel extends FlutterFlowModel<ExistingUserWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for login_emailAddress widget.
  FocusNode? loginEmailAddressFocusNode;
  TextEditingController? loginEmailAddressTextController;
  String? Function(BuildContext, String?)?
      loginEmailAddressTextControllerValidator;
  // State field(s) for login_password widget.
  FocusNode? loginPasswordFocusNode;
  TextEditingController? loginPasswordTextController;
  late bool loginPasswordVisibility;
  String? Function(BuildContext, String?)? loginPasswordTextControllerValidator;
  String? _loginPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (SignIn)] action in login_password widget.
  ApiCallResponse? signInResponseTextField;
  // Stores action output result for [Backend Call - API (SignIn)] action in Button-Login widget.
  ApiCallResponse? signInResponseBtn;
  // Stores action output result for [Backend Call - API (forgotPassword)] action in Button-ForgotPassword widget.
  ApiCallResponse? forgotPasswordResponse;

  @override
  void initState(BuildContext context) {
    loginPasswordVisibility = false;
    loginPasswordTextControllerValidator =
        _loginPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    loginEmailAddressFocusNode?.dispose();
    loginEmailAddressTextController?.dispose();

    loginPasswordFocusNode?.dispose();
    loginPasswordTextController?.dispose();
  }
}
