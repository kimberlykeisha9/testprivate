import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/new_chat/main_components/new_chat_component/new_chat_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'page_new_chat_widget.dart' show PageNewChatWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageNewChatModel extends FlutterFlowModel<PageNewChatWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NewChatComponent component.
  late NewChatComponentModel newChatComponentModel;

  @override
  void initState(BuildContext context) {
    newChatComponentModel = createModel(context, () => NewChatComponentModel());
  }

  @override
  void dispose() {
    newChatComponentModel.dispose();
  }
}
