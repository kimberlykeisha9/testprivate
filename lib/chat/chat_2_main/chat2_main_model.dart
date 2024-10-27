import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/chat_details_overlay/chat_details_overlay_widget.dart';
import '/chat/chat_thread_component/chat_thread_component_widget.dart';
import '/components/empty_chat/empty_chat_widget.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'chat2_main_widget.dart' show Chat2MainWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class Chat2MainModel extends FlutterFlowModel<Chat2MainWidget> {
  ///  Local state fields for this page.

  DirectMessagesChatRecord? activeChat;

  ///  State fields for stateful widgets in this page.

  // Model for ProfileButton component.
  late ProfileButtonModel profileButtonModel;
  // Model for chat_ThreadComponent component.
  late ChatThreadComponentModel chatThreadComponentModel;
  // Model for GroupListDrawerContent component.
  late GroupListDrawerContentModel groupListDrawerContentModel;

  @override
  void initState(BuildContext context) {
    profileButtonModel = createModel(context, () => ProfileButtonModel());
    chatThreadComponentModel =
        createModel(context, () => ChatThreadComponentModel());
    groupListDrawerContentModel =
        createModel(context, () => GroupListDrawerContentModel());
  }

  @override
  void dispose() {
    profileButtonModel.dispose();
    chatThreadComponentModel.dispose();
    groupListDrawerContentModel.dispose();
  }
}
