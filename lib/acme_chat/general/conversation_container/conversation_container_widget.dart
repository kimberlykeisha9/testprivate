import '/acme_chat/general/grey_divider/grey_divider_widget.dart';
import '/acme_chat/overlays/archive_overlay/archive_overlay_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'conversation_container_model.dart';
export 'conversation_container_model.dart';

class ConversationContainerWidget extends StatefulWidget {
  const ConversationContainerWidget({
    super.key,
    required this.conversation,
    this.currentConversation,
    required this.listIndex,
    required this.clearActive,
    bool? archiveView,
    bool? sendingMessage,
  })  : this.archiveView = archiveView ?? false,
        this.sendingMessage = sendingMessage ?? false;

  final ConversationsRecord? conversation;
  final DocumentReference? currentConversation;
  final int? listIndex;
  final Future Function()? clearActive;
  final bool archiveView;
  final bool sendingMessage;

  @override
  State<ConversationContainerWidget> createState() =>
      _ConversationContainerWidgetState();
}

class _ConversationContainerWidgetState
    extends State<ConversationContainerWidget> with TickerProviderStateMixin {
  late ConversationContainerModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConversationContainerModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
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
      'conditionalBuilderOnPageLoadAnimation': AnimationInfo(
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
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional(1.0, 0.0),
              children: [
                // QUERY
                //
                // This query is to fetch the data for the other User in the Conversation.
                //
                // i.e. to show their avatar, name, etc.
                StreamBuilder<UserRecord>(
                  stream: UserRecord.getDocument(widget!.conversation!.users
                      .where((e) => e.id != currentUserReference?.id)
                      .toList()
                      .first),
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

                    final conversationDetailsUserRecord = snapshot.data!;

                    return Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 68.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 44.0,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            conversationDetailsUserRecord
                                                .photoUrl,
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .white40,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                conversationDetailsUserRecord
                                                    .displayName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmallFamily,
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.componentHoverHovered! ||
                                                                    (widget!.currentConversation ==
                                                                        widget!
                                                                            .conversation
                                                                            ?.reference)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .deepPurple
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .grey3,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grey3,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmallFamily),
                                                          lineHeight: 1.0,
                                                        ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    height: 12.0,
                                                    decoration: BoxDecoration(),
                                                    child: Visibility(
                                                      visible: !(widget!
                                                              .sendingMessage &&
                                                          (widget!.conversation
                                                                  ?.reference ==
                                                              widget!
                                                                  .currentConversation)),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          widget!.conversation!
                                                                      .conversationStarted ||
                                                                  (widget!.conversation
                                                                          ?.lastMessageTime !=
                                                                      null)
                                                              ? valueOrDefault<
                                                                  String>(
                                                                  functions.relativeTime(widget!
                                                                      .conversation!
                                                                      .lastMessageTime!),
                                                                  'Time Sent',
                                                                )
                                                              : '-',
                                                          'Time',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmallFamily,
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    widget!.currentConversation ==
                                                                            widget!
                                                                                .conversation?.reference
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .grey3
                                                                        : FlutterFlowTheme.of(context)
                                                                            .grey2,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .grey2,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelSmallFamily),
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'textOnPageLoadAnimation']!),
                                                    ),
                                                  ),
                                                  if (!widget!.conversation!
                                                          .allMessagesRead &&
                                                      (widget!.conversation
                                                              ?.lastMessageSentBy !=
                                                          currentUserReference))
                                                    Container(
                                                      width: 12.0,
                                                      height: 12.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFF598DCE),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 20.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 12.0,
                                                    decoration: BoxDecoration(),
                                                    child:
                                                        // Conditional Builder
                                                        //
                                                        // Switches between showing the most recent message in the conversation or "is typing"
                                                        Visibility(
                                                      visible: !(widget!
                                                              .sendingMessage &&
                                                          (widget!.conversation
                                                                  ?.reference ==
                                                              widget!
                                                                  .currentConversation)),
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (widget!
                                                                  .conversation!
                                                                  .userTyping
                                                                  .contains(
                                                                      conversationDetailsUserRecord
                                                                          .reference) &&
                                                              widget!
                                                                  .conversation!
                                                                  .typing) {
                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  '${conversationDetailsUserRecord.displayName} is typing...'
                                                                      .maybeHandleOverflow(
                                                                    maxChars:
                                                                        80,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                                  maxLines: 1,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelMediumFamily,
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model.componentHoverHovered! || (widget!.currentConversation == widget!.conversation?.reference)
                                                                              ? FlutterFlowTheme.of(context).grey4
                                                                              : FlutterFlowTheme.of(context).grey3,
                                                                          FlutterFlowTheme.of(context)
                                                                              .grey3,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                        lineHeight:
                                                                            1.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                widget!.conversation?.lastMessage ==
                                                                            null ||
                                                                        widget!.conversation?.lastMessage ==
                                                                            ''
                                                                    ? '...'
                                                                    : valueOrDefault<
                                                                        String>(
                                                                        widget!
                                                                            .conversation
                                                                            ?.lastMessage,
                                                                        'Last Message',
                                                                      ),
                                                                'Last Message',
                                                              ).maybeHandleOverflow(
                                                                maxChars: 80,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              maxLines: 1,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelMediumFamily,
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      _model.componentHoverHovered! || (widget!.currentConversation == widget!.conversation?.reference)
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .grey4
                                                                          : FlutterFlowTheme.of(context)
                                                                              .grey3,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .grey3,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).labelMediumFamily),
                                                                    lineHeight:
                                                                        1.0,
                                                                  ),
                                                            );
                                                          }
                                                        },
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'conditionalBuilderOnPageLoadAnimation']!),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 1.0),
                                child: Builder(
                                  builder: (context) => InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'CONVERSATION_CONTAINER_Container_cw4kp5p');
                                      logFirebaseEvent(
                                          'Container_alert_dialog');
                                      await showAlignedDialog(
                                        barrierColor: Color(0x191F2756),
                                        context: context,
                                        isGlobal: false,
                                        avoidOverflow: true,
                                        targetAnchor:
                                            AlignmentDirectional(1.0, -1.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        followerAnchor:
                                            AlignmentDirectional(1.0, -1.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        builder: (dialogContext) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: WebViewAware(
                                              child: Container(
                                                width: 140.0,
                                                child: ArchiveOverlayWidget(
                                                  conversation:
                                                      widget!.conversation!,
                                                  archiveView:
                                                      widget!.archiveView,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: MouseRegion(
                                        opaque: false,
                                        cursor: MouseCursor.defer ??
                                            MouseCursor.defer,
                                        child:
                                            // Tap Action
                                            //
                                            // To launch the options dialog, with archive & other options buttons.
                                            Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 12.0, 0.0),
                                            child: AnimatedDefaultTextStyle(
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily,
                                                    color:
                                                        valueOrDefault<Color>(
                                                      _model.optionsHoverHovered!
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .deepPurple
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .grey2,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .grey2,
                                                    ),
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmallFamily),
                                                    lineHeight: 1.0,
                                                  ),
                                              duration:
                                                  Duration(milliseconds: 100),
                                              curve: Curves.easeInOut,
                                              child: Text(
                                                '•••',
                                              ),
                                            ),
                                          ),
                                        ),
                                        onEnter: ((event) async {
                                          safeSetState(() => _model
                                              .optionsHoverHovered = true);
                                        }),
                                        onExit: ((event) async {
                                          safeSetState(() => _model
                                              .optionsHoverHovered = false);
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            wrapWithModel(
              model: _model.greyDividerModel,
              updateCallback: () => safeSetState(() {}),
              child: GreyDividerWidget(),
            ),
          ],
        ),
      ),
      onEnter: ((event) async {
        safeSetState(() => _model.componentHoverHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.componentHoverHovered = false);
      }),
    );
  }
}
