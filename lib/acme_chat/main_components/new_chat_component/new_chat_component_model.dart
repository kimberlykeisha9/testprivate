import '/acme_chat/general/acme_button/acme_button_widget.dart';
import '/acme_chat/general/conversation_container/conversation_container_widget.dart';
import '/acme_chat/general/empty_state/empty_state_widget.dart';
import '/acme_chat/general/search_listing/search_listing_widget.dart';
import '/acme_chat/main_components/messages_component/messages_component_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'new_chat_component_widget.dart' show NewChatComponentWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class NewChatComponentModel extends FlutterFlowModel<NewChatComponentWidget> {
  ///  Local state fields for this component.

  ConversationsRecord? activeChat;

  List<MessagesRecord> activeMessages = [];
  void addToActiveMessages(MessagesRecord item) => activeMessages.add(item);
  void removeFromActiveMessages(MessagesRecord item) =>
      activeMessages.remove(item);
  void removeAtIndexFromActiveMessages(int index) =>
      activeMessages.removeAt(index);
  void insertAtIndexInActiveMessages(int index, MessagesRecord item) =>
      activeMessages.insert(index, item);
  void updateActiveMessagesAtIndex(
          int index, Function(MessagesRecord) updateFn) =>
      activeMessages[index] = updateFn(activeMessages[index]);

  MessagesRecord? detailsMessage;

  bool detailsVisible = false;

  bool viewArchive = false;

  bool searchVisible = false;

  bool? messagesVisible = false;

  bool sendingMessage = false;

  ///  State fields for stateful widgets in this component.

  // Models for ConversationContainer dynamic component.
  late FlutterFlowDynamicModels<ConversationContainerModel>
      conversationContainerModels1;
  // State field(s) for ArchiveHover widget.
  bool archiveHoverHovered1 = false;
  // Model for AcmeButton component.
  late AcmeButtonModel acmeButtonModel1;
  // State field(s) for SearchInput widget.
  FocusNode? searchInputFocusNode1;
  TextEditingController? searchInputTextController1;
  String? Function(BuildContext, String?)? searchInputTextController1Validator;
  List<UserRecord> simpleSearchResults1 = [];
  // Model for MessagesComponentPanel.
  late MessagesComponentModel messagesComponentPanelModel;
  // State field(s) for ArchiveHover widget.
  bool archiveHoverHovered2 = false;
  // Model for AcmeButton component.
  late AcmeButtonModel acmeButtonModel2;
  // State field(s) for SearchInput widget.
  FocusNode? searchInputFocusNode2;
  TextEditingController? searchInputTextController2;
  String? Function(BuildContext, String?)? searchInputTextController2Validator;
  List<UserRecord> simpleSearchResults2 = [];
  // Model for MessagesComponent component.
  late MessagesComponentModel messagesComponentModel;

  @override
  void initState(BuildContext context) {
    conversationContainerModels1 =
        FlutterFlowDynamicModels(() => ConversationContainerModel());
    acmeButtonModel1 = createModel(context, () => AcmeButtonModel());
    messagesComponentPanelModel =
        createModel(context, () => MessagesComponentModel());
    acmeButtonModel2 = createModel(context, () => AcmeButtonModel());
    messagesComponentModel =
        createModel(context, () => MessagesComponentModel());
  }

  @override
  void dispose() {
    conversationContainerModels1.dispose();
    acmeButtonModel1.dispose();
    searchInputFocusNode1?.dispose();
    searchInputTextController1?.dispose();

    messagesComponentPanelModel.dispose();
    acmeButtonModel2.dispose();
    searchInputFocusNode2?.dispose();
    searchInputTextController2?.dispose();

    messagesComponentModel.dispose();
  }
}
