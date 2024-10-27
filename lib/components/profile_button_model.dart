import '/auth/firebase_auth/auth_util.dart';
import '/components/my_profile_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'profile_button_widget.dart' show ProfileButtonWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfileButtonModel extends FlutterFlowModel<ProfileButtonWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getUnreadNotificationCount] action in ProfileButton widget.
  int? notifcationCount;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
