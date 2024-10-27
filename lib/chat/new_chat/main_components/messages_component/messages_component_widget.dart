import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/new_chat/audio/audio_player/audio_player_widget.dart';
import '/chat/new_chat/audio/audio_record_button/audio_record_button_widget.dart';
import '/chat/new_chat/general/acme_button/acme_button_widget.dart';
import '/chat/new_chat/general/empty_state/empty_state_widget.dart';
import '/chat/new_chat/message_types/received_message/received_message_widget.dart';
import '/chat/new_chat/message_types/reply_to_message/reply_to_message_widget.dart';
import '/chat/new_chat/message_types/sent_message/sent_message_widget.dart';
import '/chat/new_chat/overlays/message_options/message_options_widget.dart';
import '/chat/new_chat/overlays/upload_media_options/upload_media_options_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'messages_component_model.dart';
export 'messages_component_model.dart';

class MessagesComponentWidget extends StatefulWidget {
  const MessagesComponentWidget({
    super.key,
    this.conversation,
    this.otherUser,
    bool? mobileView,
    required this.viewMessages,
    this.sendingMessage,
  }) : this.mobileView = mobileView ?? false;

  final ConversationsRecord? conversation;
  final DocumentReference? otherUser;
  final bool mobileView;
  final Future Function()? viewMessages;
  final Future Function()? sendingMessage;

  @override
  State<MessagesComponentWidget> createState() =>
      _MessagesComponentWidgetState();
}

class _MessagesComponentWidgetState extends State<MessagesComponentWidget>
    with TickerProviderStateMixin {
  late MessagesComponentModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessagesComponentModel());

    _model.messageInputTextController ??= TextEditingController();
    _model.messageInputFocusNode ??= FocusNode();
    _model.messageInputFocusNode!.addListener(
      () async {
        logFirebaseEvent('MESSAGES_COMPONENT_MessageInput_ON_FOCUS');
        logFirebaseEvent('MessageInput_update_component_state');
        _model.typing = !_model.typing;
        safeSetState(() {});
        if (_model.typing) {
          logFirebaseEvent('MessageInput_backend_call');

          await widget!.conversation!.reference.update({
            ...createConversationsRecordData(
              typing: true,
            ),
            ...mapToFirestore(
              {
                'UserTyping': FieldValue.arrayUnion([currentUserReference]),
              },
            ),
          });
        } else {
          logFirebaseEvent('MessageInput_backend_call');

          await widget!.conversation!.reference.update({
            ...createConversationsRecordData(
              typing: false,
            ),
            ...mapToFirestore(
              {
                'UserTyping': FieldValue.arrayRemove([currentUserReference]),
              },
            ),
          });
        }
      },
    );
    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
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
    return
        // Queries the Messages subcollection in the 'activeConversation' Conversation document
        StreamBuilder<List<MessagesRecord>>(
      stream: queryMessagesRecord(
        parent: widget!.conversation?.reference,
      )..listen((snapshot) {
          List<MessagesRecord> messagesMessagesRecordList = snapshot;
          if (_model.messagesPreviousSnapshot != null &&
              !const ListEquality(MessagesRecordDocumentEquality()).equals(
                  messagesMessagesRecordList,
                  _model.messagesPreviousSnapshot)) {
            () async {}();
          }
          _model.messagesPreviousSnapshot = snapshot;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).appBG,
                ),
              ),
            ),
          );
        }
        List<MessagesRecord> messagesMessagesRecordList = snapshot.data!;

        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Color(0x00F1F3F7),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget!.conversation != null)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            valueOrDefault<double>(
                              widget!.mobileView ? 4.0 : 8.0,
                              8.0,
                            ),
                            0.0,
                            0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 54.0,
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
                                child: Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (widget!.mobileView &&
                                          responsiveVisibility(
                                            context: context,
                                            tabletLandscape: false,
                                            desktop: false,
                                          ))
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 4.0, 0.0),
                                                child: InkWell(
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
                                                        'MESSAGES_COMPONENT_Icon_nmsbbrwi_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Icon_execute_callback');
                                                    await widget.viewMessages
                                                        ?.call();
                                                  },
                                                  child: Icon(
                                                    Icons.chevron_left_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .deepPurple,
                                                    size: 28.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 2.0),
                                              child: Container(
                                                width: 2.0,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .offWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          99.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            StreamBuilder<UserRecord>(
                                              stream: UserRecord.getDocument(
                                                  widget!.otherUser!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .appBG,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                final detailsUserRecord =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 36.0,
                                                        height: 36.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image:
                                                                Image.network(
                                                              detailsUserRecord
                                                                  .photoUrl,
                                                            ).image,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .greyBorder,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        detailsUserRecord
                                                            .displayName,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmallFamily,
                                                                  fontSize:
                                                                      14.0,
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
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 8.0))
                                                        .addToEnd(SizedBox(
                                                            width: 20.0)),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(width: 8.0))
                              .addToStart(SizedBox(
                                  width: valueOrDefault<double>(
                                widget!.mobileView ? 4.0 : 8.0,
                                8.0,
                              )))
                              .addToEnd(SizedBox(
                                  width: valueOrDefault<double>(
                                widget!.mobileView ? 4.0 : 8.0,
                                8.0,
                              ))),
                        ),
                      ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            if (widget!.conversation == null) {
                              return wrapWithModel(
                                model: _model.emptyStateModel,
                                updateCallback: () => safeSetState(() {}),
                                child: EmptyStateWidget(),
                              );
                            } else {
                              return Visibility(
                                visible: !_model.sendingMessage,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      valueOrDefault<double>(
                                        widget!.mobileView ? 8.0 : 20.0,
                                        20.0,
                                      ),
                                      0.0,
                                      valueOrDefault<double>(
                                        widget!.mobileView ? 8.0 : 20.0,
                                        20.0,
                                      ),
                                      0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final messages =
                                          messagesMessagesRecordList
                                              .sortedList(
                                                  keyOf: (e) => e.sentTime!,
                                                  desc: true)
                                              .toList();
                                      if (messages.isEmpty) {
                                        return Center(
                                          child: EmptyStateWidget(),
                                        );
                                      }

                                      return ListView.builder(
                                        padding: EdgeInsets.fromLTRB(
                                          0,
                                          80.0,
                                          0,
                                          20.0,
                                        ),
                                        reverse: true,
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        itemCount: messages.length,
                                        itemBuilder: (context, messagesIndex) {
                                          final messagesItem =
                                              messages[messagesIndex];
                                          return Stack(
                                            children: [
                                              if (messagesItem.sentBy ==
                                                  currentUserReference)
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onLongPress:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'MESSAGES_COMPONENT_Container_1e27a4f7_ON');
                                                              logFirebaseEvent(
                                                                  'SentMessage_alert_dialog');
                                                              await showAlignedDialog(
                                                                barrierColor: Colors
                                                                    .transparent,
                                                                context:
                                                                    context,
                                                                isGlobal: false,
                                                                avoidOverflow:
                                                                    true,
                                                                targetAnchor:
                                                                    AlignmentDirectional(
                                                                            1.0,
                                                                            1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                followerAnchor:
                                                                    AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        WebViewAware(
                                                                      child:
                                                                          MessageOptionsWidget(
                                                                        message:
                                                                            messagesItem,
                                                                        messageType:
                                                                            MessageType.Sent,
                                                                        replying:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              '_update_component_state');
                                                                          _model.replyingMessage =
                                                                              messagesItem;
                                                                          _model.replyingVisible =
                                                                              true;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                SentMessageWidget(
                                                              key: Key(
                                                                  'Key1e2_${messagesIndex}_of_${messages.length}'),
                                                              mobileView: widget!
                                                                  .mobileView,
                                                              message:
                                                                  messagesItem,
                                                              messagesList: messagesMessagesRecordList
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .sentTime!,
                                                                      desc:
                                                                          false),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (messagesItem.sentBy !=
                                                  currentUserReference)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Builder(
                                                        builder: (context) =>
                                                            InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'MESSAGES_COMPONENT_Container_hpnpcu7a_ON');
                                                            logFirebaseEvent(
                                                                'ReceivedMessage_alert_dialog');
                                                            await showAlignedDialog(
                                                              barrierColor: Colors
                                                                  .transparent,
                                                              context: context,
                                                              isGlobal: false,
                                                              avoidOverflow:
                                                                  true,
                                                              targetAnchor:
                                                                  AlignmentDirectional(
                                                                          1.0,
                                                                          1.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                              followerAnchor:
                                                                  AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                              builder:
                                                                  (dialogContext) {
                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      WebViewAware(
                                                                    child:
                                                                        MessageOptionsWidget(
                                                                      message:
                                                                          messagesItem,
                                                                      messageType:
                                                                          MessageType
                                                                              .Received,
                                                                      replying:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            '_update_component_state');
                                                                        _model.replyingMessage =
                                                                            messagesItem;
                                                                        _model.replyingVisible =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child:
                                                              ReceivedMessageWidget(
                                                            key: Key(
                                                                'Keyhpn_${messagesIndex}_of_${messages.length}'),
                                                            mobileView: widget!
                                                                .mobileView,
                                                            message:
                                                                messagesItem,
                                                            messagesList: messagesMessagesRecordList
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        e.sentTime!,
                                                                    desc: false),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          );
                                        },
                                      ).animateOnPageLoad(animationsMap[
                                          'listViewOnPageLoadAnimation']!);
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    if (widget!.conversation != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_model.replyingMessage != null)
                            Padding(
                              padding: EdgeInsets.all(valueOrDefault<double>(
                                widget!.mobileView ? 4.0 : 8.0,
                                8.0,
                              )),
                              child: Container(
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
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6.0, 10.0, 0.0, 0.0),
                                            child: Transform.rotate(
                                              angle: 180.0 * (math.pi / 180),
                                              child: Icon(
                                                Icons.reply_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .grey3,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Reply',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey3,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                        lineHeight: 1.0,
                                                      ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Container(
                                                    child: wrapWithModel(
                                                      model: _model
                                                          .replyToMessageModel,
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          ReplyToMessageWidget(
                                                        drafting: true,
                                                        mobileView: false,
                                                        message: _model
                                                            .replyingMessage!,
                                                        type: MessageType
                                                            .Received,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),

                                      // Tap action to cancel the reply & delete any associated data
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'MESSAGES_COMPONENT_CancelReplyButton_ON_');
                                          logFirebaseEvent(
                                              'CancelReplyButton_update_component_state');
                                          _model.replyingMessage = null;
                                          _model.replyingVisible = true;
                                          safeSetState(() {});
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.easeIn,
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .offWhite,
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .greyBorder,
                                              width: 1.0,
                                            ),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.close_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .black,
                                                size: 16.0,
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                valueOrDefault<double>(
                                  widget!.mobileView ? 4.0 : 8.0,
                                  8.0,
                                ),
                                0.0,
                                valueOrDefault<double>(
                                  widget!.mobileView ? 4.0 : 8.0,
                                  8.0,
                                ),
                                valueOrDefault<double>(
                                  widget!.mobileView ? 4.0 : 8.0,
                                  8.0,
                                )),
                            child: Container(
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
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 4.0, 4.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0),
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Builder(
                                            builder: (context) {
                                              if (_model.uploadingAudio !=
                                                      null &&
                                                  _model.uploadingAudio != '') {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, -1.0),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 220.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .greyBorder,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        8.0,
                                                                        8.0,
                                                                        4.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Voicenote',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .grey3,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineSmallFamily),
                                                                        lineHeight:
                                                                            1.0,
                                                                      ),
                                                                ),
                                                                wrapWithModel(
                                                                  model: _model
                                                                      .audioPlayerModel,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      AudioPlayerWidget(
                                                                    audio: _model
                                                                        .uploadingAudio!,
                                                                    reply:
                                                                        false,
                                                                    type: MessageType
                                                                        .Received,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                                              'MESSAGES_COMPONENT_CancelButton_ON_TAP');
                                                          await Future.wait([
                                                            Future(() async {
                                                              logFirebaseEvent(
                                                                  'CancelButton_delete_data');
                                                              await FirebaseStorage
                                                                  .instance
                                                                  .refFromURL(_model
                                                                      .uploadingAudio!)
                                                                  .delete();
                                                            }),
                                                            Future(() async {
                                                              logFirebaseEvent(
                                                                  'CancelButton_update_component_state');
                                                              _model.uploadingAudio =
                                                                  null;
                                                              _model.draftMessageSet =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            }),
                                                          ]);
                                                        },
                                                        child: Container(
                                                          width: 24.0,
                                                          height: 24.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .offWhite,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .greyBorder,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Icon(
                                                            Icons.close_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .black,
                                                            size: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else if (_model
                                                  .uploadingImages.isNotEmpty) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    height: 160.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .greyBorder,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  6.0,
                                                                  0.0,
                                                                  6.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final uploadingImagesList =
                                                              _model
                                                                  .uploadingImages
                                                                  .toList();

                                                          return ListView
                                                              .separated(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                              8.0,
                                                              0,
                                                              8.0,
                                                              0,
                                                            ),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                uploadingImagesList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    width: 8.0),
                                                            itemBuilder: (context,
                                                                uploadingImagesListIndex) {
                                                              final uploadingImagesListItem =
                                                                  uploadingImagesList[
                                                                      uploadingImagesListIndex];
                                                              return Container(
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          12.0,
                                                                      color: Color(
                                                                          0x1A1F2756),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .white40,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        logFirebaseEvent(
                                                                            'MESSAGES_COMPONENT_Image_sp5bdy4j_ON_TAP');
                                                                        logFirebaseEvent(
                                                                            'Image_expand_image');
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                FlutterFlowExpandedImageView(
                                                                              image: Image.network(
                                                                                uploadingImagesListItem,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                              allowRotation: false,
                                                                              tag: uploadingImagesListItem,
                                                                              useHeroAnimation: true,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Hero(
                                                                        tag:
                                                                            uploadingImagesListItem,
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          child:
                                                                              Image.network(
                                                                            uploadingImagesListItem,
                                                                            height:
                                                                                double.infinity,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'MESSAGES_COMPONENT_Container_apd3hpky_ON');
                                                                          await Future
                                                                              .wait([
                                                                            Future(() async {
                                                                              logFirebaseEvent('Container_delete_data');
                                                                              await FirebaseStorage.instance.refFromURL(uploadingImagesListIndex.toString()).delete();
                                                                            }),
                                                                            Future(() async {
                                                                              if (_model.uploadingImages.length == 1) {
                                                                                logFirebaseEvent('Container_update_component_state');
                                                                                _model.draftMessageSet = false;
                                                                                safeSetState(() {});
                                                                                logFirebaseEvent('Container_update_component_state');
                                                                                _model.removeFromUploadingImages(uploadingImagesListItem);
                                                                                safeSetState(() {});
                                                                                logFirebaseEvent('Container_update_component_state');
                                                                                _model.uploadingImages = [];
                                                                                safeSetState(() {});
                                                                              } else {
                                                                                logFirebaseEvent('Container_update_component_state');
                                                                                _model.removeFromUploadingImages(uploadingImagesListItem);
                                                                                safeSetState(() {});
                                                                              }
                                                                            }),
                                                                          ]);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              24.0,
                                                                          height:
                                                                              24.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).offBlack,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).grey3,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Icon(
                                                                            Icons.close_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).white,
                                                                            size:
                                                                                14.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (_model
                                                          .uploadingVideo !=
                                                      null &&
                                                  _model.uploadingVideo != '') {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white40,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .grey1,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            child: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxHeight:
                                                                    240.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child:
                                                                  FlutterFlowVideoPlayer(
                                                                path: _model
                                                                    .uploadingVideo!,
                                                                videoType:
                                                                    VideoType
                                                                        .network,
                                                                width: 400.0,
                                                                autoPlay: false,
                                                                looping: false,
                                                                showControls:
                                                                    true,
                                                                allowFullScreen:
                                                                    true,
                                                                allowPlaybackSpeedMenu:
                                                                    false,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              logFirebaseEvent(
                                                                  'MESSAGES_COMPONENT_Container_ev0ab5ev_ON');
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'Container_delete_data');
                                                                  await FirebaseStorage
                                                                      .instance
                                                                      .refFromURL(
                                                                          _model
                                                                              .uploadingVideo!)
                                                                      .delete();
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'Container_update_component_state');
                                                                  _model.uploadingVideo =
                                                                      null;
                                                                  _model.draftMessageSet =
                                                                      false;
                                                                  safeSetState(
                                                                      () {});
                                                                }),
                                                              ]);
                                                            },
                                                            child: Container(
                                                              width: 24.0,
                                                              height: 24.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .offBlack,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grey3,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .close_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .white,
                                                                size: 14.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else if (_model.uploadingFile !=
                                                      null &&
                                                  _model.uploadingFile != '') {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 260.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .offWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .greyBorder,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .file_present_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .grey4,
                                                            size: 24.0,
                                                          ),
                                                          Text(
                                                            functions
                                                                .returnFileName(
                                                                    _model
                                                                        .uploadingFile!),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grey4,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelLargeFamily),
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          minHeight: 36.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .offWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .greyBorder,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .messageInputTextController,
                                                              focusNode: _model
                                                                  .messageInputFocusNode,
                                                              onChanged: (_) =>
                                                                  EasyDebounce
                                                                      .debounce(
                                                                '_model.messageInputTextController',
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'MESSAGES_COMPONENT_MessageInput_ON_TEXTF');
                                                                  if (_model.messageInputTextController
                                                                              .text !=
                                                                          null &&
                                                                      _model.messageInputTextController
                                                                              .text !=
                                                                          '') {
                                                                    logFirebaseEvent(
                                                                        'MessageInput_update_component_state');
                                                                    _model.draftMessageSet =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    logFirebaseEvent(
                                                                        'MessageInput_update_component_state');
                                                                    _model.draftMessageSet =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                              ),
                                                              autofocus: false,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .none,
                                                              readOnly:
                                                                  widget!.conversation ==
                                                                          null
                                                                      ? true
                                                                      : false,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .grey2,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).labelMediumFamily),
                                                                    ),
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                                errorBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedErrorBorder:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            6.0),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                              maxLines: 8,
                                                              minLines: 1,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              validator: _model
                                                                  .messageInputTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (!_model.draftMessageSet &&
                                                !widget!.mobileView)
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.easeInOut,
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            'MESSAGES_COMPONENT_PhotoUpload_ON_TAP');
                                                        logFirebaseEvent(
                                                            'PhotoUpload_upload_media_to_firebase');
                                                        final selectedMedia =
                                                            await selectMedia(
                                                          mediaSource:
                                                              MediaSource
                                                                  .photoGallery,
                                                          multiImage: true,
                                                        );
                                                        if (selectedMedia !=
                                                                null &&
                                                            selectedMedia.every((m) =>
                                                                validateFileFormat(
                                                                    m.storagePath,
                                                                    context))) {
                                                          safeSetState(() =>
                                                              _model.isDataUploading1 =
                                                                  true);
                                                          var selectedUploadedFiles =
                                                              <FFUploadedFile>[];

                                                          var downloadUrls =
                                                              <String>[];
                                                          try {
                                                            showUploadMessage(
                                                              context,
                                                              'Uploading file...',
                                                              showLoading: true,
                                                            );
                                                            selectedUploadedFiles =
                                                                selectedMedia
                                                                    .map((m) =>
                                                                        FFUploadedFile(
                                                                          name: m
                                                                              .storagePath
                                                                              .split('/')
                                                                              .last,
                                                                          bytes:
                                                                              m.bytes,
                                                                          height: m
                                                                              .dimensions
                                                                              ?.height,
                                                                          width: m
                                                                              .dimensions
                                                                              ?.width,
                                                                          blurHash:
                                                                              m.blurHash,
                                                                        ))
                                                                    .toList();

                                                            downloadUrls =
                                                                (await Future
                                                                        .wait(
                                                              selectedMedia.map(
                                                                (m) async =>
                                                                    await uploadData(
                                                                        m.storagePath,
                                                                        m.bytes),
                                                              ),
                                                            ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                          } finally {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                            _model.isDataUploading1 =
                                                                false;
                                                          }
                                                          if (selectedUploadedFiles
                                                                      .length ==
                                                                  selectedMedia
                                                                      .length &&
                                                              downloadUrls
                                                                      .length ==
                                                                  selectedMedia
                                                                      .length) {
                                                            safeSetState(() {
                                                              _model.uploadedLocalFiles1 =
                                                                  selectedUploadedFiles;
                                                              _model.uploadedFileUrls1 =
                                                                  downloadUrls;
                                                            });
                                                            showUploadMessage(
                                                                context,
                                                                'Success!');
                                                          } else {
                                                            safeSetState(() {});
                                                            showUploadMessage(
                                                                context,
                                                                'Failed to upload data');
                                                            return;
                                                          }
                                                        }

                                                        logFirebaseEvent(
                                                            'PhotoUpload_update_component_state');
                                                        _model.uploadingImages =
                                                            _model
                                                                .uploadedFileUrls1
                                                                .toList()
                                                                .cast<String>();
                                                        safeSetState(() {});
                                                        if (_model
                                                                .uploadingImages
                                                                .length >=
                                                            1) {
                                                          logFirebaseEvent(
                                                              'PhotoUpload_update_component_state');
                                                          _model.draftMessageSet =
                                                              true;
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .photoUploadModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: AcmeButtonWidget(
                                                          emojiOn: false,
                                                          iconOn: true,
                                                          textOn: false,
                                                          icon: Icon(
                                                            Icons
                                                                .add_photo_alternate_outlined,
                                                            size: 20.0,
                                                          ),
                                                          colorLock: false,
                                                        ),
                                                      ),
                                                    ),
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
                                                            'MESSAGES_COMPONENT_VideoUpload_ON_TAP');
                                                        logFirebaseEvent(
                                                            'VideoUpload_upload_media_to_firebase');
                                                        final selectedMedia =
                                                            await selectMedia(
                                                          isVideo: true,
                                                          mediaSource:
                                                              MediaSource
                                                                  .videoGallery,
                                                          multiImage: false,
                                                        );
                                                        if (selectedMedia !=
                                                                null &&
                                                            selectedMedia.every((m) =>
                                                                validateFileFormat(
                                                                    m.storagePath,
                                                                    context))) {
                                                          safeSetState(() =>
                                                              _model.isDataUploading2 =
                                                                  true);
                                                          var selectedUploadedFiles =
                                                              <FFUploadedFile>[];

                                                          var downloadUrls =
                                                              <String>[];
                                                          try {
                                                            showUploadMessage(
                                                              context,
                                                              'Uploading file...',
                                                              showLoading: true,
                                                            );
                                                            selectedUploadedFiles =
                                                                selectedMedia
                                                                    .map((m) =>
                                                                        FFUploadedFile(
                                                                          name: m
                                                                              .storagePath
                                                                              .split('/')
                                                                              .last,
                                                                          bytes:
                                                                              m.bytes,
                                                                          height: m
                                                                              .dimensions
                                                                              ?.height,
                                                                          width: m
                                                                              .dimensions
                                                                              ?.width,
                                                                          blurHash:
                                                                              m.blurHash,
                                                                        ))
                                                                    .toList();

                                                            downloadUrls =
                                                                (await Future
                                                                        .wait(
                                                              selectedMedia.map(
                                                                (m) async =>
                                                                    await uploadData(
                                                                        m.storagePath,
                                                                        m.bytes),
                                                              ),
                                                            ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                          } finally {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                            _model.isDataUploading2 =
                                                                false;
                                                          }
                                                          if (selectedUploadedFiles
                                                                      .length ==
                                                                  selectedMedia
                                                                      .length &&
                                                              downloadUrls
                                                                      .length ==
                                                                  selectedMedia
                                                                      .length) {
                                                            safeSetState(() {
                                                              _model.uploadedLocalFile2 =
                                                                  selectedUploadedFiles
                                                                      .first;
                                                              _model.uploadedFileUrl2 =
                                                                  downloadUrls
                                                                      .first;
                                                            });
                                                            showUploadMessage(
                                                                context,
                                                                'Success!');
                                                          } else {
                                                            safeSetState(() {});
                                                            showUploadMessage(
                                                                context,
                                                                'Failed to upload data');
                                                            return;
                                                          }
                                                        }

                                                        logFirebaseEvent(
                                                            'VideoUpload_update_component_state');
                                                        _model.uploadingVideo =
                                                            _model
                                                                .uploadedFileUrl2;
                                                        _model.draftMessageSet =
                                                            true;
                                                        safeSetState(() {});
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .videoUploadModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: AcmeButtonWidget(
                                                          emojiOn: false,
                                                          iconOn: true,
                                                          textOn: false,
                                                          icon: Icon(
                                                            Icons
                                                                .video_camera_back_outlined,
                                                            size: 20.0,
                                                          ),
                                                          colorLock: false,
                                                        ),
                                                      ),
                                                    ),
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
                                                            'MESSAGES_COMPONENT_FileUpload_ON_TAP');
                                                        logFirebaseEvent(
                                                            'FileUpload_upload_file_to_firebase');
                                                        final selectedFiles =
                                                            await selectFiles(
                                                          multiFile: false,
                                                        );
                                                        if (selectedFiles !=
                                                            null) {
                                                          safeSetState(() =>
                                                              _model.isDataUploading3 =
                                                                  true);
                                                          var selectedUploadedFiles =
                                                              <FFUploadedFile>[];

                                                          var downloadUrls =
                                                              <String>[];
                                                          try {
                                                            showUploadMessage(
                                                              context,
                                                              'Uploading file...',
                                                              showLoading: true,
                                                            );
                                                            selectedUploadedFiles =
                                                                selectedFiles
                                                                    .map((m) =>
                                                                        FFUploadedFile(
                                                                          name: m
                                                                              .storagePath
                                                                              .split('/')
                                                                              .last,
                                                                          bytes:
                                                                              m.bytes,
                                                                        ))
                                                                    .toList();

                                                            downloadUrls =
                                                                (await Future
                                                                        .wait(
                                                              selectedFiles.map(
                                                                (f) async =>
                                                                    await uploadData(
                                                                        f.storagePath,
                                                                        f.bytes),
                                                              ),
                                                            ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                          } finally {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                            _model.isDataUploading3 =
                                                                false;
                                                          }
                                                          if (selectedUploadedFiles
                                                                      .length ==
                                                                  selectedFiles
                                                                      .length &&
                                                              downloadUrls
                                                                      .length ==
                                                                  selectedFiles
                                                                      .length) {
                                                            safeSetState(() {
                                                              _model.uploadedLocalFile3 =
                                                                  selectedUploadedFiles
                                                                      .first;
                                                              _model.uploadedFileUrl3 =
                                                                  downloadUrls
                                                                      .first;
                                                            });
                                                            showUploadMessage(
                                                              context,
                                                              'Success!',
                                                            );
                                                          } else {
                                                            safeSetState(() {});
                                                            showUploadMessage(
                                                              context,
                                                              'Failed to upload file',
                                                            );
                                                            return;
                                                          }
                                                        }

                                                        logFirebaseEvent(
                                                            'FileUpload_update_component_state');
                                                        _model.uploadingFile =
                                                            _model
                                                                .uploadedFileUrl3;
                                                        _model.draftMessageSet =
                                                            true;
                                                        safeSetState(() {});
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .fileUploadModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: AcmeButtonWidget(
                                                          emojiOn: false,
                                                          iconOn: true,
                                                          textOn: false,
                                                          icon: Icon(
                                                            Icons.attach_file,
                                                            size: 20.0,
                                                          ),
                                                          colorLock: false,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 4.0)),
                                                ),
                                              ),
                                            if (!_model.draftMessageSet)
                                              wrapWithModel(
                                                model: _model
                                                    .audioRecordButtonModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: AudioRecordButtonWidget(
                                                  audioRecording:
                                                      (audio) async {
                                                    logFirebaseEvent(
                                                        'MESSAGES_COMPONENT_Container_37360pgj_CA');
                                                    logFirebaseEvent(
                                                        'AudioRecordButton_update_component_state');
                                                    _model.uploadingAudio =
                                                        audio;
                                                    _model.draftMessageSet =
                                                        true;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            if (!_model.draftMessageSet &&
                                                widget!.mobileView)
                                              Builder(
                                                builder: (context) => InkWell(
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
                                                        'MESSAGES_COMPONENT_MobileOptions_ON_TAP');
                                                    logFirebaseEvent(
                                                        'MobileOptions_alert_dialog');
                                                    await showAlignedDialog(
                                                      barrierColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      isGlobal: false,
                                                      avoidOverflow: true,
                                                      targetAnchor:
                                                          AlignmentDirectional(
                                                                  0.0, -1.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      followerAnchor:
                                                          AlignmentDirectional(
                                                                  1.0, -1.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      builder: (dialogContext) {
                                                        return Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: WebViewAware(
                                                            child:
                                                                UploadMediaOptionsWidget(
                                                              uploadPhoto:
                                                                  (photos) async {
                                                                logFirebaseEvent(
                                                                    '_update_component_state');
                                                                _model.uploadingImages =
                                                                    photos
                                                                        .toList()
                                                                        .cast<
                                                                            String>();
                                                                safeSetState(
                                                                    () {});
                                                                if (photos
                                                                        .length >=
                                                                    1) {
                                                                  logFirebaseEvent(
                                                                      '_update_component_state');
                                                                  _model.draftMessageSet =
                                                                      true;
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              },
                                                              uploadVideo:
                                                                  (video) async {
                                                                logFirebaseEvent(
                                                                    '_update_component_state');
                                                                _model.uploadingVideo =
                                                                    video;
                                                                _model.draftMessageSet =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              uploadFile:
                                                                  (file) async {
                                                                logFirebaseEvent(
                                                                    '_update_component_state');
                                                                _model.uploadingFile =
                                                                    file;
                                                                _model.draftMessageSet =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .mobileOptionsModel,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: AcmeButtonWidget(
                                                      emojiOn: false,
                                                      iconOn: true,
                                                      textOn: false,
                                                      icon: Icon(
                                                        Icons.perm_media,
                                                        size: 16.0,
                                                      ),
                                                      colorLock: false,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (_model.draftMessageSet)
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'MESSAGES_COMPONENT_SendButton_ON_TAP');
                                                  var _shouldSetState = false;
                                                  // These animations (hopefully) get around the flickering that is caused when queries update.
                                                  await Future.wait([
                                                    Future(() async {
                                                      logFirebaseEvent(
                                                          'SendButton_update_component_state');
                                                      _model.sendingMessage =
                                                          true;
                                                      safeSetState(() {});
                                                    }),
                                                    Future(() async {
                                                      logFirebaseEvent(
                                                          'SendButton_execute_callback');
                                                      await widget
                                                          .sendingMessage
                                                          ?.call();
                                                    }),
                                                    Future(() async {
                                                      if (!widget!.conversation!
                                                          .conversationStarted) {
                                                        logFirebaseEvent(
                                                            'SendButton_backend_call');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update(
                                                                createConversationsRecordData(
                                                          conversationStarted:
                                                              true,
                                                        ));
                                                      }
                                                    }),
                                                  ]);
                                                  if (_model.messageInputTextController
                                                              .text !=
                                                          null &&
                                                      _model.messageInputTextController
                                                              .text !=
                                                          '') {
                                                    // Create - Text Message
                                                    logFirebaseEvent(
                                                        'SendButton_Create-TextMessage');

                                                    var messagesRecordReference1 =
                                                        MessagesRecord
                                                            .createDoc(widget!
                                                                .conversation!
                                                                .reference);
                                                    await messagesRecordReference1
                                                        .set({
                                                      ...createMessagesRecordData(
                                                        message: _model
                                                            .messageInputTextController
                                                            .text,
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Text,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.newMessageText =
                                                        MessagesRecord
                                                            .getDocumentFromData({
                                                      ...createMessagesRecordData(
                                                        message: _model
                                                            .messageInputTextController
                                                            .text,
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Text,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, messagesRecordReference1);
                                                    _shouldSetState = true;
                                                    await Future.wait([
                                                      Future(() async {
                                                        // Add Msg to Conversation
                                                        logFirebaseEvent(
                                                            'SendButton_AddMsgtoConversation');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update({
                                                          ...createConversationsRecordData(
                                                            lastMessage: _model
                                                                .newMessageText
                                                                ?.message,
                                                            lastMessageSentBy:
                                                                currentUserReference,
                                                            allMessagesRead:
                                                                false,
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'LastMessageTime':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                            },
                                                          ),
                                                        });
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_update_component_state');
                                                            _model.draftMessageSet =
                                                                false;
                                                            _model.sendingMessage =
                                                                false;
                                                            safeSetState(() {});
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_clear_text_fields_pin_codes');
                                                            safeSetState(() {
                                                              _model
                                                                  .messageInputTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_execute_callback');
                                                            await widget
                                                                .sendingMessage
                                                                ?.call();
                                                          }),
                                                        ]);
                                                      }),
                                                      Future(() async {
                                                        if (_model
                                                            .replyingVisible) {
                                                          logFirebaseEvent(
                                                              'SendButton_backend_call');

                                                          await _model
                                                              .newMessageText!
                                                              .reference
                                                              .update(
                                                                  createMessagesRecordData(
                                                            replyTo: _model
                                                                .replyingMessage
                                                                ?.reference,
                                                          ));
                                                          logFirebaseEvent(
                                                              'SendButton_update_component_state');
                                                          _model.replyingVisible =
                                                              false;
                                                          _model.replyingMessage =
                                                              null;
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                    ]);
                                                  } else if (_model
                                                          .uploadingImages
                                                          .length >=
                                                      1) {
                                                    // Create - Image Message
                                                    logFirebaseEvent(
                                                        'SendButton_Create-ImageMessage');

                                                    var messagesRecordReference2 =
                                                        MessagesRecord
                                                            .createDoc(widget!
                                                                .conversation!
                                                                .reference);
                                                    await messagesRecordReference2
                                                        .set({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Image,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime': FieldValue
                                                              .serverTimestamp(),
                                                          'Images': _model
                                                              .uploadingImages,
                                                        },
                                                      ),
                                                    });
                                                    _model.newMessageImages =
                                                        MessagesRecord
                                                            .getDocumentFromData({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Image,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime':
                                                              DateTime.now(),
                                                          'Images': _model
                                                              .uploadingImages,
                                                        },
                                                      ),
                                                    }, messagesRecordReference2);
                                                    _shouldSetState = true;
                                                    await Future.wait([
                                                      Future(() async {
                                                        // Add Msg to Conversation
                                                        logFirebaseEvent(
                                                            'SendButton_AddMsgtoConversation');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update({
                                                          ...createConversationsRecordData(
                                                            lastMessage: _model
                                                                        .uploadingImages
                                                                        .length >=
                                                                    2
                                                                ? '${_model.uploadingImages.length.toString()} New Photos'
                                                                : '1 New Photo',
                                                            lastMessageSentBy:
                                                                currentUserReference,
                                                            allMessagesRead:
                                                                false,
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'LastMessageTime':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                            },
                                                          ),
                                                        });
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_update_component_state');
                                                            _model.draftMessageSet =
                                                                false;
                                                            _model.sendingMessage =
                                                                false;
                                                            safeSetState(() {});
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_clear_text_fields_pin_codes');
                                                            safeSetState(() {
                                                              _model
                                                                  .messageInputTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_execute_callback');
                                                            await widget
                                                                .sendingMessage
                                                                ?.call();
                                                          }),
                                                        ]);
                                                      }),
                                                      Future(() async {
                                                        if (_model
                                                            .replyingVisible) {
                                                          logFirebaseEvent(
                                                              'SendButton_backend_call');

                                                          await _model
                                                              .newMessageImages!
                                                              .reference
                                                              .update(
                                                                  createMessagesRecordData(
                                                            replyTo: _model
                                                                .replyingMessage
                                                                ?.reference,
                                                          ));
                                                          logFirebaseEvent(
                                                              'SendButton_update_component_state');
                                                          _model.replyingVisible =
                                                              false;
                                                          _model.replyingMessage =
                                                              null;
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        // Clear UploadingPhoto State
                                                        logFirebaseEvent(
                                                            'SendButton_ClearUploadingPhotoState');
                                                        _model.uploadingImages =
                                                            [];
                                                        safeSetState(() {});
                                                      }),
                                                    ]);
                                                  } else if (_model
                                                              .uploadingVideo !=
                                                          null &&
                                                      _model.uploadingVideo !=
                                                          '') {
                                                    // Create - Video Message
                                                    logFirebaseEvent(
                                                        'SendButton_Create-VideoMessage');

                                                    var messagesRecordReference3 =
                                                        MessagesRecord
                                                            .createDoc(widget!
                                                                .conversation!
                                                                .reference);
                                                    await messagesRecordReference3
                                                        .set({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        video: _model
                                                            .uploadingVideo,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Video,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.newMessageVideo =
                                                        MessagesRecord
                                                            .getDocumentFromData({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        video: _model
                                                            .uploadingVideo,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Video,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, messagesRecordReference3);
                                                    _shouldSetState = true;
                                                    await Future.wait([
                                                      Future(() async {
                                                        // Add Msg to Conversation
                                                        logFirebaseEvent(
                                                            'SendButton_AddMsgtoConversation');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update({
                                                          ...createConversationsRecordData(
                                                            lastMessage:
                                                                'New Video',
                                                            lastMessageSentBy:
                                                                currentUserReference,
                                                            allMessagesRead:
                                                                false,
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'LastMessageTime':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                            },
                                                          ),
                                                        });
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_update_component_state');
                                                            _model.draftMessageSet =
                                                                false;
                                                            _model.sendingMessage =
                                                                false;
                                                            safeSetState(() {});
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_clear_text_fields_pin_codes');
                                                            safeSetState(() {
                                                              _model
                                                                  .messageInputTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_execute_callback');
                                                            await widget
                                                                .sendingMessage
                                                                ?.call();
                                                          }),
                                                        ]);
                                                      }),
                                                      Future(() async {
                                                        if (_model
                                                            .replyingVisible) {
                                                          logFirebaseEvent(
                                                              'SendButton_backend_call');

                                                          await _model
                                                              .newMessageVideo!
                                                              .reference
                                                              .update(
                                                                  createMessagesRecordData(
                                                            replyTo: _model
                                                                .replyingMessage
                                                                ?.reference,
                                                          ));
                                                          logFirebaseEvent(
                                                              'SendButton_update_component_state');
                                                          _model.replyingVisible =
                                                              false;
                                                          _model.replyingMessage =
                                                              null;
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        // Clear UploadingVideo State
                                                        logFirebaseEvent(
                                                            'SendButton_ClearUploadingVideoState');
                                                        _model.uploadingVideo =
                                                            null;
                                                        safeSetState(() {});
                                                      }),
                                                    ]);
                                                  } else if (_model
                                                              .uploadingAudio !=
                                                          null &&
                                                      _model.uploadingAudio !=
                                                          '') {
                                                    // Save Recorded Audio
                                                    logFirebaseEvent(
                                                        'SendButton_SaveRecordedAudio');
                                                    {
                                                      safeSetState(() => _model
                                                              .isDataUploading4 =
                                                          true);
                                                      var selectedUploadedFiles =
                                                          <FFUploadedFile>[];
                                                      var selectedFiles =
                                                          <SelectedFile>[];
                                                      var downloadUrls =
                                                          <String>[];
                                                      try {
                                                        selectedUploadedFiles = _model
                                                                .audioRecordButtonModel
                                                                .recordedFileBytes
                                                                .bytes!
                                                                .isNotEmpty
                                                            ? [
                                                                _model
                                                                    .audioRecordButtonModel
                                                                    .recordedFileBytes
                                                              ]
                                                            : <FFUploadedFile>[];
                                                        selectedFiles =
                                                            selectedFilesFromUploadedFiles(
                                                          selectedUploadedFiles,
                                                        );
                                                        downloadUrls =
                                                            (await Future.wait(
                                                          selectedFiles.map(
                                                            (f) async =>
                                                                await uploadData(
                                                                    f.storagePath,
                                                                    f.bytes),
                                                          ),
                                                        ))
                                                                .where((u) =>
                                                                    u != null)
                                                                .map((u) => u!)
                                                                .toList();
                                                      } finally {
                                                        _model.isDataUploading4 =
                                                            false;
                                                      }
                                                      if (selectedUploadedFiles
                                                                  .length ==
                                                              selectedFiles
                                                                  .length &&
                                                          downloadUrls.length ==
                                                              selectedFiles
                                                                  .length) {
                                                        safeSetState(() {
                                                          _model.uploadedLocalFile4 =
                                                              selectedUploadedFiles
                                                                  .first;
                                                          _model.uploadedFileUrl4 =
                                                              downloadUrls
                                                                  .first;
                                                        });
                                                      } else {
                                                        safeSetState(() {});
                                                        return;
                                                      }
                                                    }

                                                    // Create - Audio Message
                                                    logFirebaseEvent(
                                                        'SendButton_Create-AudioMessage');

                                                    var messagesRecordReference4 =
                                                        MessagesRecord
                                                            .createDoc(widget!
                                                                .conversation!
                                                                .reference);
                                                    await messagesRecordReference4
                                                        .set({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        audio: _model
                                                            .uploadingAudio,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Audio,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.newMessageAudio =
                                                        MessagesRecord
                                                            .getDocumentFromData({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        audio: _model
                                                            .uploadingAudio,
                                                        mediaType:
                                                            MessageMediaType
                                                                .Audio,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, messagesRecordReference4);
                                                    _shouldSetState = true;
                                                    await Future.wait([
                                                      Future(() async {
                                                        // Add Msg to Conversation
                                                        logFirebaseEvent(
                                                            'SendButton_AddMsgtoConversation');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update({
                                                          ...createConversationsRecordData(
                                                            lastMessage:
                                                                'New Voicenote',
                                                            lastMessageSentBy:
                                                                currentUserReference,
                                                            allMessagesRead:
                                                                false,
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'LastMessageTime':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                            },
                                                          ),
                                                        });
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_update_component_state');
                                                            _model.draftMessageSet =
                                                                false;
                                                            _model.sendingMessage =
                                                                false;
                                                            safeSetState(() {});
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_clear_text_fields_pin_codes');
                                                            safeSetState(() {
                                                              _model
                                                                  .messageInputTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_execute_callback');
                                                            await widget
                                                                .sendingMessage
                                                                ?.call();
                                                          }),
                                                        ]);
                                                      }),
                                                      Future(() async {
                                                        if (_model
                                                            .replyingVisible) {
                                                          logFirebaseEvent(
                                                              'SendButton_backend_call');

                                                          await _model
                                                              .newMessageAudio!
                                                              .reference
                                                              .update(
                                                                  createMessagesRecordData(
                                                            replyTo: _model
                                                                .replyingMessage
                                                                ?.reference,
                                                          ));
                                                          logFirebaseEvent(
                                                              'SendButton_update_component_state');
                                                          _model.replyingVisible =
                                                              false;
                                                          _model.replyingMessage =
                                                              null;
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        // Clear UploadingAudio State
                                                        logFirebaseEvent(
                                                            'SendButton_ClearUploadingAudioState');
                                                        _model.uploadingAudio =
                                                            null;
                                                        safeSetState(() {});
                                                      }),
                                                    ]);
                                                  } else if (_model
                                                              .uploadingFile !=
                                                          null &&
                                                      _model.uploadingFile !=
                                                          '') {
                                                    // Create - File Message
                                                    logFirebaseEvent(
                                                        'SendButton_Create-FileMessage');

                                                    var messagesRecordReference5 =
                                                        MessagesRecord
                                                            .createDoc(widget!
                                                                .conversation!
                                                                .reference);
                                                    await messagesRecordReference5
                                                        .set({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .File,
                                                        file: _model
                                                            .uploadingFile,
                                                        fileName: functions
                                                            .returnFileName(_model
                                                                .uploadingFile!),
                                                        fileType: functions
                                                            .returnFileType(_model
                                                                .uploadingFile!),
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.newMessageFile =
                                                        MessagesRecord
                                                            .getDocumentFromData({
                                                      ...createMessagesRecordData(
                                                        read: false,
                                                        sentBy:
                                                            currentUserReference,
                                                        mediaType:
                                                            MessageMediaType
                                                                .File,
                                                        file: _model
                                                            .uploadingFile,
                                                        fileName: functions
                                                            .returnFileName(_model
                                                                .uploadingFile!),
                                                        fileType: functions
                                                            .returnFileType(_model
                                                                .uploadingFile!),
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'SentTime':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, messagesRecordReference5);
                                                    _shouldSetState = true;
                                                    await Future.wait([
                                                      Future(() async {
                                                        // Add Msg to Conversation
                                                        logFirebaseEvent(
                                                            'SendButton_AddMsgtoConversation');

                                                        await widget!
                                                            .conversation!
                                                            .reference
                                                            .update({
                                                          ...createConversationsRecordData(
                                                            lastMessage:
                                                                'New File',
                                                            lastMessageSentBy:
                                                                currentUserReference,
                                                            allMessagesRead:
                                                                false,
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'LastMessageTime':
                                                                  FieldValue
                                                                      .serverTimestamp(),
                                                            },
                                                          ),
                                                        });
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_update_component_state');
                                                            _model.draftMessageSet =
                                                                false;
                                                            _model.sendingMessage =
                                                                false;
                                                            safeSetState(() {});
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_clear_text_fields_pin_codes');
                                                            safeSetState(() {
                                                              _model
                                                                  .messageInputTextController
                                                                  ?.clear();
                                                            });
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'SendButton_execute_callback');
                                                            await widget
                                                                .sendingMessage
                                                                ?.call();
                                                          }),
                                                        ]);
                                                      }),
                                                      Future(() async {
                                                        if (_model
                                                            .replyingVisible) {
                                                          logFirebaseEvent(
                                                              'SendButton_backend_call');

                                                          await _model
                                                              .newMessageFile!
                                                              .reference
                                                              .update(
                                                                  createMessagesRecordData(
                                                            replyTo: _model
                                                                .replyingMessage
                                                                ?.reference,
                                                          ));
                                                          logFirebaseEvent(
                                                              'SendButton_update_component_state');
                                                          _model.replyingVisible =
                                                              false;
                                                          _model.replyingMessage =
                                                              null;
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        // Clear UploadingFile State
                                                        logFirebaseEvent(
                                                            'SendButton_ClearUploadingFileState');
                                                        _model.uploadingFile =
                                                            null;
                                                        safeSetState(() {});
                                                      }),
                                                    ]);
                                                  } else {
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                    return;
                                                  }

                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                },
                                                child: wrapWithModel(
                                                  model: _model.sendButtonModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: AcmeButtonWidget(
                                                    emojiOn: false,
                                                    iconOn: true,
                                                    textOn: false,
                                                    icon: Icon(
                                                      Icons.send_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grey3,
                                                      size: 16.0,
                                                    ),
                                                    text: 'Send',
                                                    colorLock: false,
                                                  ),
                                                ),
                                              ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
