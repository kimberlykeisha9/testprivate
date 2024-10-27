import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/new_chat/general/acme_button/acme_button_widget.dart';
import '/chat/new_chat/general/conversation_container/conversation_container_widget.dart';
import '/chat/new_chat/general/empty_state/empty_state_widget.dart';
import '/chat/new_chat/general/search_listing/search_listing_widget.dart';
import '/chat/new_chat/main_components/messages_component/messages_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'new_chat_component_model.dart';
export 'new_chat_component_model.dart';

class NewChatComponentWidget extends StatefulWidget {
  const NewChatComponentWidget({
    super.key,
    this.conversations,
  });

  final List<ConversationsRecord>? conversations;

  @override
  State<NewChatComponentWidget> createState() => _NewChatComponentWidgetState();
}

class _NewChatComponentWidgetState extends State<NewChatComponentWidget>
    with TickerProviderStateMixin {
  late NewChatComponentModel _model;

  var hasListViewTriggered1 = false;
  var hasMessagesComponentTriggered = false;
  var hasListViewTriggered2 = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewChatComponentModel());

    _model.searchInputTextController1 ??= TextEditingController();
    _model.searchInputFocusNode1 ??= FocusNode();

    _model.searchInputTextController2 ??= TextEditingController();
    _model.searchInputFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(4.0, 4.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'listViewOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'messagesComponentOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(4.0, 4.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'listViewOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: Offset(4.0, 4.0),
            end: Offset(0.0, 0.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: Offset(0.0, 5.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      animationsMap['listViewOnPageLoadAnimation']!
          .controller
          .forward(from: 0.0);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(),
      child: Builder(
        builder: (context) {
          if (MediaQuery.sizeOf(context).width >= 840.0) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    height: double.infinity,
                    constraints: BoxConstraints(
                      minWidth: 240.0,
                      maxWidth: 360.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          color: Color(0x0D667AE1),
                          offset: Offset(
                            0.0,
                            4.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).greyBorder,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 108.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child:
                                  // Sorted list showing either un-archived or archived Conversations
                                  Visibility(
                                visible: !_model.sendingMessage,
                                child: AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final conversations = widget!
                                              .conversations
                                              ?.where((e) => _model.viewArchive
                                                  ? (currentUserDocument
                                                              ?.archivedConversations
                                                              ?.toList() ??
                                                          [])
                                                      .contains(e.reference)
                                                  : !(currentUserDocument
                                                              ?.archivedConversations
                                                              ?.toList() ??
                                                          [])
                                                      .contains(e.reference))
                                              .toList()
                                              ?.sortedList(
                                                  keyOf: (e) =>
                                                      e.lastMessageTime!,
                                                  desc: true)
                                              ?.toList() ??
                                          [];
                                      if (conversations.isEmpty) {
                                        return Center(
                                          child: EmptyStateWidget(),
                                        );
                                      }

                                      return ListView.builder(
                                        padding: EdgeInsets.fromLTRB(
                                          0,
                                          8.0,
                                          0,
                                          0,
                                        ),
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        itemCount: conversations.length,
                                        itemBuilder:
                                            (context, conversationsIndex) {
                                          final conversationsItem =
                                              conversations[conversationsIndex];
                                          return Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'NEW_CHAT_COMPONENT_Container_o984omz9_ON');
                                                    await Future.wait([
                                                      Future(() async {
                                                        logFirebaseEvent(
                                                            'ConversationContainer_update_component_s');
                                                        _model.activeChat =
                                                            conversationsItem;
                                                        safeSetState(() {});
                                                      }),
                                                      Future(() async {
                                                        logFirebaseEvent(
                                                            'ConversationContainer_widget_animation');
                                                        if (animationsMap[
                                                                'messagesComponentOnActionTriggerAnimation'] !=
                                                            null) {
                                                          safeSetState(() =>
                                                              hasMessagesComponentTriggered =
                                                                  true);
                                                          SchedulerBinding
                                                              .instance
                                                              .addPostFrameCallback((_) async =>
                                                                  await animationsMap[
                                                                          'messagesComponentOnActionTriggerAnimation']!
                                                                      .controller
                                                                      .forward(
                                                                          from:
                                                                              0.0));
                                                        }
                                                      }),
                                                    ]);
                                                  },
                                                  child:
                                                      ConversationContainerWidget(
                                                    key: Key(
                                                        'Keyo98_${conversationsIndex}_of_${conversations.length}'),
                                                    listIndex:
                                                        conversationsIndex,
                                                    archiveView:
                                                        _model.viewArchive,
                                                    sendingMessage:
                                                        _model.sendingMessage,
                                                    conversation:
                                                        conversationsItem,
                                                    currentConversation: _model
                                                        .activeChat?.reference,
                                                    clearActive: () async {
                                                      logFirebaseEvent(
                                                          'NEW_CHAT_COMPONENT_Container_o984omz9_CA');
                                                      logFirebaseEvent(
                                                          'ConversationContainer_update_component_s');
                                                      _model.activeChat = null;
                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                          .animateOnPageLoad(animationsMap[
                                              'listViewOnPageLoadAnimation']!)
                                          .animateOnActionTrigger(
                                              animationsMap[
                                                  'listViewOnActionTriggerAnimation1']!,
                                              hasBeenTriggered:
                                                  hasListViewTriggered1);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeIn,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 40.0,
                                    color: Color(0x1A667AE1),
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).greyBorder,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (_model.viewArchive) {
                                                  return AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      valueOrDefault<String>(
                                                        widget!.conversations
                                                            ?.where((e) => (currentUserDocument
                                                                        ?.archivedConversations
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(e
                                                                    .reference))
                                                            .toList()
                                                            ?.length
                                                            ?.toString(),
                                                        '0',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily),
                                                                lineHeight: 1.0,
                                                              ),
                                                    ),
                                                  );
                                                } else {
                                                  return AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      valueOrDefault<String>(
                                                        widget!.conversations
                                                            ?.where((e) => !(currentUserDocument
                                                                        ?.archivedConversations
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(e
                                                                    .reference))
                                                            .toList()
                                                            ?.length
                                                            ?.toString(),
                                                        '0',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily),
                                                                lineHeight: 1.0,
                                                              ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                _model.viewArchive
                                                    ? 'Archived'
                                                    : 'Conversations',
                                                'Conversations',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                        lineHeight: 1.0,
                                                      ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 6.0))
                                              .addToStart(SizedBox(width: 4.0)),
                                        ),
                                        MouseRegion(
                                          opaque: false,
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'NEW_CHAT_COMPONENT_Container_9pzzwf4w_ON');
                                              await Future.wait([
                                                Future(() async {
                                                  logFirebaseEvent(
                                                      'AcmeButton_update_component_state');
                                                  _model.activeChat = null;
                                                  safeSetState(() {});
                                                  if (_model.viewArchive) {
                                                    logFirebaseEvent(
                                                        'AcmeButton_update_component_state');
                                                    _model.viewArchive = false;
                                                    safeSetState(() {});
                                                  } else {
                                                    logFirebaseEvent(
                                                        'AcmeButton_update_component_state');
                                                    _model.viewArchive = true;
                                                    safeSetState(() {});
                                                  }
                                                }),
                                                Future(() async {
                                                  logFirebaseEvent(
                                                      'AcmeButton_widget_animation');
                                                  if (animationsMap[
                                                          'listViewOnActionTriggerAnimation2'] !=
                                                      null) {
                                                    safeSetState(() =>
                                                        hasListViewTriggered2 =
                                                            true);
                                                    SchedulerBinding.instance
                                                        .addPostFrameCallback((_) async =>
                                                            await animationsMap[
                                                                    'listViewOnActionTriggerAnimation2']!
                                                                .controller
                                                                .forward(
                                                                    from: 0.0));
                                                  }
                                                }),
                                              ]);
                                            },
                                            child: wrapWithModel(
                                              model: _model.acmeButtonModel1,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: AcmeButtonWidget(
                                                emojiOn: false,
                                                iconOn: true,
                                                textOn: true,
                                                icon: Icon(
                                                  Icons.all_inbox_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey3,
                                                  size: 14.0,
                                                ),
                                                text: 'Archive',
                                                colorLock: _model.viewArchive ||
                                                    _model
                                                        .archiveHoverHovered1!,
                                              ),
                                            ),
                                          ),
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .archiveHoverHovered1 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .archiveHoverHovered1 = false);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 2000),
                                      curve: Curves.easeInOutQuint,
                                      height: 36.0,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        children: [
                                          // Search input to activate fuzzy search.
                                          TextFormField(
                                            controller: _model
                                                .searchInputTextController1,
                                            focusNode:
                                                _model.searchInputFocusNode1,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.searchInputTextController1',
                                              Duration(milliseconds: 1000),
                                              () async {
                                                logFirebaseEvent(
                                                    'NEW_CHAT_COMPONENT_SearchInput_ON_TEXTFI');
                                                logFirebaseEvent(
                                                    'SearchInput_simple_search');
                                                await queryUserRecordOnce()
                                                    .then(
                                                      (records) => _model
                                                              .simpleSearchResults1 =
                                                          TextSearch(
                                                        records
                                                            .map(
                                                              (record) =>
                                                                  TextSearchItem
                                                                      .fromTerms(
                                                                          record,
                                                                          [
                                                                    record
                                                                        .displayName!
                                                                  ]),
                                                            )
                                                            .toList(),
                                                      )
                                                              .search(_model
                                                                  .searchInputTextController1
                                                                  .text)
                                                              .map((r) =>
                                                                  r.object)
                                                              .toList(),
                                                    )
                                                    .onError((_, __) => _model
                                                            .simpleSearchResults1 =
                                                        [])
                                                    .whenComplete(() =>
                                                        safeSetState(() {}));

                                                if (_model.simpleSearchResults1
                                                    .isNotEmpty) {
                                                  logFirebaseEvent(
                                                      'SearchInput_update_component_state');
                                                  _model.searchVisible = true;
                                                  safeSetState(() {});
                                                }
                                              },
                                            ),
                                            autofocus: false,
                                            textInputAction:
                                                TextInputAction.search,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Search...',
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey2,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily),
                                                      ),
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey2,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily),
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .greyBorder,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey2,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.search_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .grey1,
                                                size: 16.0,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey3,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily),
                                                ),
                                            validator: _model
                                                .searchInputTextController1Validator
                                                .asValidator(context),
                                          ),
                                          Container(
                                            width: 28.0,
                                            height: 28.0,
                                            decoration: BoxDecoration(),
                                            child:
                                                // Button to clear search input field
                                                Visibility(
                                              visible: _model
                                                          .searchInputTextController1
                                                          .text !=
                                                      null &&
                                                  _model.searchInputTextController1
                                                          .text !=
                                                      '',
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'NEW_CHAT_COMPONENT_Icon_55n2gdt1_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Icon_clear_text_fields_pin_codes');
                                                  safeSetState(() {
                                                    _model
                                                        .searchInputTextController1
                                                        ?.clear();
                                                  });
                                                  logFirebaseEvent(
                                                      'Icon_update_component_state');
                                                  _model.searchVisible = false;
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey2,
                                                  size: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Displaying search results, minus the current User.
                                  //
                                  // This can be set as whatever you like, not just Users.
                                  if (_model.searchVisible)
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: Builder(
                                          builder: (context) {
                                            final searchResults = _model
                                                .simpleSearchResults1
                                                .where((e) =>
                                                    e.reference !=
                                                    currentUserReference)
                                                .toList();

                                            return ListView.builder(
                                              padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0,
                                                80.0,
                                              ),
                                              primary: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount: searchResults.length,
                                              itemBuilder: (context,
                                                  searchResultsIndex) {
                                                final searchResultsItem =
                                                    searchResults[
                                                        searchResultsIndex];
                                                return SearchListingWidget(
                                                  key: Key(
                                                      'Keyhou_${searchResultsIndex}_of_${searchResults.length}'),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    constraints: BoxConstraints(
                      minWidth: 360.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          color: Color(0x0D667AE1),
                          offset: Offset(
                            0.0,
                            4.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).greyBorder,
                        width: 2.0,
                      ),
                    ),
                    child: wrapWithModel(
                      model: _model.messagesComponentPanelModel,
                      updateCallback: () => safeSetState(() {}),
                      child: MessagesComponentWidget(
                        mobileView: false,
                        conversation: _model.activeChat,
                        otherUser: _model.activeChat?.users
                            ?.where((e) => e.id != currentUserReference?.id)
                            .toList()
                            ?.first,
                        viewMessages: () async {
                          logFirebaseEvent(
                              'NEW_CHAT_COMPONENT_MessagesComponentPane');
                          logFirebaseEvent(
                              'MessagesComponentPanel_update_component_');
                          _model.messagesVisible = false;
                          safeSetState(() {});
                        },
                        sendingMessage: () async {
                          logFirebaseEvent(
                              'NEW_CHAT_COMPONENT_MessagesComponentPane');
                          await Future.wait([
                            Future(() async {
                              logFirebaseEvent(
                                  'MessagesComponentPanel_update_component_');
                              _model.sendingMessage = !_model.sendingMessage;
                              safeSetState(() {});
                            }),
                            Future(() async {
                              logFirebaseEvent(
                                  'MessagesComponentPanel_widget_animation');
                              if (animationsMap[
                                      'listViewOnActionTriggerAnimation2'] !=
                                  null) {
                                safeSetState(
                                    () => hasListViewTriggered2 = true);
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) async => await animationsMap[
                                            'listViewOnActionTriggerAnimation2']!
                                        .controller
                                        .forward(from: 0.0));
                              }
                            }),
                          ]);
                        },
                      ),
                    ).animateOnActionTrigger(
                        animationsMap[
                            'messagesComponentOnActionTriggerAnimation']!,
                        hasBeenTriggered: hasMessagesComponentTriggered),
                  ),
                ),
              ].divide(SizedBox(width: 20.0)),
            );
          } else {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                    width: double.infinity,
                    height: double.infinity,
                    constraints: BoxConstraints(
                      minWidth: 280.0,
                      maxWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          color: Color(0x0D667AE1),
                          offset: Offset(
                            0.0,
                            4.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).greyBorder,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 108.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child:
                                  // Sorted list showing either un-archived or archived Conversations
                                  AuthUserStreamWidget(
                                builder: (context) => Builder(
                                  builder: (context) {
                                    final conversations = widget!.conversations
                                            ?.where((e) => _model.viewArchive
                                                ? (currentUserDocument
                                                            ?.archivedConversations
                                                            ?.toList() ??
                                                        [])
                                                    .contains(e.reference)
                                                : !(currentUserDocument
                                                            ?.archivedConversations
                                                            ?.toList() ??
                                                        [])
                                                    .contains(e.reference))
                                            .toList()
                                            ?.sortedList(
                                                keyOf: (e) =>
                                                    e.lastMessageTime!,
                                                desc: true)
                                            ?.toList() ??
                                        [];
                                    if (conversations.isEmpty) {
                                      return Center(
                                        child: EmptyStateWidget(),
                                      );
                                    }

                                    return ListView.builder(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        8.0,
                                        0,
                                        0,
                                      ),
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      itemCount: conversations.length,
                                      itemBuilder:
                                          (context, conversationsIndex) {
                                        final conversationsItem =
                                            conversations[conversationsIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'NEW_CHAT_COMPONENT_Container_17fapd6u_ON');
                                            logFirebaseEvent(
                                                'ConversationContainer_update_component_s');
                                            _model.activeChat =
                                                conversationsItem;
                                            _model.messagesVisible = true;
                                            safeSetState(() {});
                                          },
                                          child: ConversationContainerWidget(
                                            key: Key(
                                                'Key17f_${conversationsIndex}_of_${conversations.length}'),
                                            listIndex: conversationsIndex,
                                            archiveView: _model.viewArchive,
                                            sendingMessage:
                                                _model.sendingMessage,
                                            conversation: conversationsItem,
                                            currentConversation:
                                                _model.activeChat?.reference,
                                            clearActive: () async {
                                              logFirebaseEvent(
                                                  'NEW_CHAT_COMPONENT_Container_17fapd6u_CA');
                                              logFirebaseEvent(
                                                  'ConversationContainer_update_component_s');
                                              _model.activeChat = null;
                                              safeSetState(() {});
                                            },
                                          ),
                                        );
                                      },
                                    ).animateOnActionTrigger(
                                        animationsMap[
                                            'listViewOnActionTriggerAnimation2']!,
                                        hasBeenTriggered:
                                            hasListViewTriggered2);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 0.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeIn,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 40.0,
                                    color: Color(0x1A667AE1),
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).greyBorder,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (_model.viewArchive) {
                                                  return AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      valueOrDefault<String>(
                                                        widget!.conversations
                                                            ?.where((e) => (currentUserDocument
                                                                        ?.archivedConversations
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(e
                                                                    .reference))
                                                            .toList()
                                                            ?.length
                                                            ?.toString(),
                                                        '0',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily),
                                                                lineHeight: 1.0,
                                                              ),
                                                    ),
                                                  );
                                                } else {
                                                  return AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      valueOrDefault<String>(
                                                        widget!.conversations
                                                            ?.where((e) => !(currentUserDocument
                                                                        ?.archivedConversations
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(e
                                                                    .reference))
                                                            .toList()
                                                            ?.length
                                                            ?.toString(),
                                                        '0',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily),
                                                                lineHeight: 1.0,
                                                              ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                _model.viewArchive
                                                    ? 'Archived'
                                                    : 'Conversations',
                                                'Conversations',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                        lineHeight: 1.0,
                                                      ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 6.0))
                                              .addToStart(SizedBox(width: 4.0)),
                                        ),
                                        MouseRegion(
                                          opaque: false,
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'NEW_CHAT_COMPONENT_Container_ydaeg396_ON');
                                              await Future.wait([
                                                Future(() async {
                                                  logFirebaseEvent(
                                                      'AcmeButton_update_component_state');
                                                  _model.activeChat = null;
                                                  safeSetState(() {});
                                                  if (_model.viewArchive) {
                                                    logFirebaseEvent(
                                                        'AcmeButton_update_component_state');
                                                    _model.viewArchive = false;
                                                    safeSetState(() {});
                                                  } else {
                                                    logFirebaseEvent(
                                                        'AcmeButton_update_component_state');
                                                    _model.viewArchive = true;
                                                    safeSetState(() {});
                                                  }
                                                }),
                                                Future(() async {
                                                  logFirebaseEvent(
                                                      'AcmeButton_widget_animation');
                                                  if (animationsMap[
                                                          'listViewOnActionTriggerAnimation2'] !=
                                                      null) {
                                                    safeSetState(() =>
                                                        hasListViewTriggered2 =
                                                            true);
                                                    SchedulerBinding.instance
                                                        .addPostFrameCallback((_) async =>
                                                            await animationsMap[
                                                                    'listViewOnActionTriggerAnimation2']!
                                                                .controller
                                                                .forward(
                                                                    from: 0.0));
                                                  }
                                                }),
                                              ]);
                                            },
                                            child: wrapWithModel(
                                              model: _model.acmeButtonModel2,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: AcmeButtonWidget(
                                                emojiOn: false,
                                                iconOn: true,
                                                textOn: true,
                                                icon: Icon(
                                                  Icons.all_inbox_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey3,
                                                  size: 14.0,
                                                ),
                                                text: 'Archive',
                                                colorLock: _model.viewArchive &&
                                                    _model
                                                        .archiveHoverHovered1!,
                                              ),
                                            ),
                                          ),
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .archiveHoverHovered2 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .archiveHoverHovered2 = false);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 2000),
                                      curve: Curves.easeInOutQuint,
                                      height: 36.0,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        children: [
                                          // Search input to activate fuzzy search.
                                          TextFormField(
                                            controller: _model
                                                .searchInputTextController2,
                                            focusNode:
                                                _model.searchInputFocusNode2,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.searchInputTextController2',
                                              Duration(milliseconds: 1000),
                                              () async {
                                                logFirebaseEvent(
                                                    'NEW_CHAT_COMPONENT_SearchInput_ON_TEXTFI');
                                                logFirebaseEvent(
                                                    'SearchInput_simple_search');
                                                await queryUserRecordOnce()
                                                    .then(
                                                      (records) => _model
                                                              .simpleSearchResults2 =
                                                          TextSearch(
                                                        records
                                                            .map(
                                                              (record) =>
                                                                  TextSearchItem
                                                                      .fromTerms(
                                                                          record,
                                                                          [
                                                                    record
                                                                        .displayName!
                                                                  ]),
                                                            )
                                                            .toList(),
                                                      )
                                                              .search(_model
                                                                  .searchInputTextController1
                                                                  .text)
                                                              .map((r) =>
                                                                  r.object)
                                                              .toList(),
                                                    )
                                                    .onError((_, __) => _model
                                                            .simpleSearchResults2 =
                                                        [])
                                                    .whenComplete(() =>
                                                        safeSetState(() {}));

                                                if (_model.simpleSearchResults1
                                                    .isNotEmpty) {
                                                  logFirebaseEvent(
                                                      'SearchInput_update_component_state');
                                                  _model.searchVisible = true;
                                                  safeSetState(() {});
                                                }
                                              },
                                            ),
                                            autofocus: false,
                                            textInputAction:
                                                TextInputAction.search,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Search...',
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey2,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily),
                                                      ),
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey2,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily),
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .greyBorder,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey2,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.search_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .grey1,
                                                size: 16.0,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey3,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily),
                                                ),
                                            validator: _model
                                                .searchInputTextController2Validator
                                                .asValidator(context),
                                          ),
                                          Container(
                                            width: 28.0,
                                            height: 28.0,
                                            decoration: BoxDecoration(),
                                            child:
                                                // Button to clear search input field
                                                Visibility(
                                              visible: _model
                                                          .searchInputTextController2
                                                          .text !=
                                                      null &&
                                                  _model.searchInputTextController2
                                                          .text !=
                                                      '',
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'NEW_CHAT_COMPONENT_Icon_1s6boid9_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Icon_clear_text_fields_pin_codes');
                                                  safeSetState(() {
                                                    _model
                                                        .searchInputTextController2
                                                        ?.clear();
                                                  });
                                                  logFirebaseEvent(
                                                      'Icon_update_component_state');
                                                  _model.searchVisible = false;
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey2,
                                                  size: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Displaying search results, minus the current User.
                                  //
                                  // This can be set as whatever you like, not just Users.
                                  if (_model.searchVisible)
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 40.0),
                                        child: Builder(
                                          builder: (context) {
                                            final searchResults = _model
                                                .simpleSearchResults2
                                                .where((e) =>
                                                    e.reference !=
                                                    currentUserReference)
                                                .toList();

                                            return ListView.builder(
                                              padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0,
                                                80.0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: searchResults.length,
                                              itemBuilder: (context,
                                                  searchResultsIndex) {
                                                final searchResultsItem =
                                                    searchResults[
                                                        searchResultsIndex];
                                                return SearchListingWidget(
                                                  key: Key(
                                                      'Keymth_${searchResultsIndex}_of_${searchResults.length}'),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_model.messagesVisible ?? true)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        minWidth: 360.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40.0,
                            color: Color(0x0D667AE1),
                            offset: Offset(
                              0.0,
                              4.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).greyBorder,
                          width: 2.0,
                        ),
                      ),
                      child: wrapWithModel(
                        model: _model.messagesComponentModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MessagesComponentWidget(
                          mobileView: true,
                          conversation: _model.activeChat,
                          otherUser: _model.activeChat?.users
                              ?.where((e) => e.id != currentUserReference?.id)
                              .toList()
                              ?.first,
                          viewMessages: () async {
                            logFirebaseEvent(
                                'NEW_CHAT_COMPONENT_Container_kqeeex3b_CA');
                            logFirebaseEvent(
                                'MessagesComponent_update_component_state');
                            _model.messagesVisible = false;
                            safeSetState(() {});
                          },
                          sendingMessage: () async {
                            logFirebaseEvent(
                                'NEW_CHAT_COMPONENT_Container_kqeeex3b_CA');
                            await Future.wait([
                              Future(() async {
                                logFirebaseEvent(
                                    'MessagesComponent_update_component_state');
                                _model.sendingMessage = !_model.sendingMessage;
                                safeSetState(() {});
                              }),
                              Future(() async {
                                logFirebaseEvent(
                                    'MessagesComponent_widget_animation');
                                if (animationsMap[
                                        'listViewOnActionTriggerAnimation2'] !=
                                    null) {
                                  safeSetState(
                                      () => hasListViewTriggered2 = true);
                                  SchedulerBinding.instance.addPostFrameCallback(
                                      (_) async => await animationsMap[
                                              'listViewOnActionTriggerAnimation2']!
                                          .controller
                                          .forward(from: 0.0));
                                }
                              }),
                            ]);
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
