import '/auth/base_auth_user_provider.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'entry_page_widget.dart' show EntryPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EntryPageModel extends FlutterFlowModel<EntryPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for login_emailAddress widget.
  FocusNode? loginEmailAddressFocusNode;
  TextEditingController? loginEmailAddressTextController;
  String? Function(BuildContext, String?)?
      loginEmailAddressTextControllerValidator;
  String? _loginEmailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please provide email';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (ValidateUser)] action in login_emailAddress widget.
  ApiCallResponse? validateUserCallTextField;
  // Stores action output result for [Backend Call - API (ValidateUser)] action in Button-Login widget.
  ApiCallResponse? validateUserCall;

  @override
  void initState(BuildContext context) {
    loginEmailAddressTextControllerValidator =
        _loginEmailAddressTextControllerValidator;
  }

  @override
  void dispose() {
    loginEmailAddressFocusNode?.dispose();
    loginEmailAddressTextController?.dispose();
  }
}
