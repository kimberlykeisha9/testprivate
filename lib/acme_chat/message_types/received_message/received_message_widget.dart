import '/acme_chat/message_types/message_types/message_types_widget.dart';
import '/acme_chat/message_types/reply_to_message/reply_to_message_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'received_message_model.dart';
export 'received_message_model.dart';

class ReceivedMessageWidget extends StatefulWidget {
  const ReceivedMessageWidget({
    super.key,
    required this.message,
    bool? mobileView,
    required this.messagesList,
  }) : this.mobileView = mobileView ?? false;

  final MessagesRecord? message;
  final bool mobileView;
  final List<MessagesRecord>? messagesList;

  @override
  State<ReceivedMessageWidget> createState() => _ReceivedMessageWidgetState();
}

class _ReceivedMessageWidgetState extends State<ReceivedMessageWidget>
    with TickerProviderStateMixin {
  late ReceivedMessageModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceivedMessageModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('RECEIVED_MESSAGE_ReceivedMessage_ON_INIT');
      if (!widget!.message!.read) {
        logFirebaseEvent('ReceivedMessage_backend_call');

        await widget!.message!.reference.update({
          ...createMessagesRecordData(
            read: true,
          ),
          ...mapToFirestore(
            {
              'ReadTime': FieldValue.serverTimestamp(),
            },
          ),
        });
        logFirebaseEvent('ReceivedMessage_backend_call');

        await widget!.message!.parentReference
            .update(createConversationsRecordData(
          allMessagesRead: true,
        ));
      }
    });

    animationsMap.addAll({
      'tooltipOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShakeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            hz: 2,
            offset: Offset(1.0, 0.0),
            rotation: 0.14,
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
    return Align(
      alignment: AlignmentDirectional(-1.0, -1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            12.0,
            0.0,
            0.0,
            valueOrDefault<double>(
              functions.within1MinuteOfNext(
                      widget!.message!, widget!.messagesList!.toList())
                  ? 40.0
                  : 0.0,
              0.0,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (valueOrDefault<bool>(
                      widget!.message?.replyTo != null,
                      false,
                    ))
                      FutureBuilder<MessagesRecord>(
                        future: MessagesRecord.getDocumentOnce(
                            widget!.message!.replyTo!),
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

                          final containerMessagesRecord = snapshot.data!;

                          return Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width * 1.0,
                            ),
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.replyToMessageModel,
                              updateCallback: () => safeSetState(() {}),
                              child: ReplyToMessageWidget(
                                drafting: false,
                                mobileView: widget!.mobileView,
                                message: containerMessagesRecord,
                                type: MessageType.Received,
                              ),
                            ),
                          );
                        },
                      ),
                    Stack(
                      alignment: AlignmentDirectional(-1.0, 1.0),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              valueOrDefault<double>(
                                functions.within1MinuteOfNext(widget!.message!,
                                        widget!.messagesList!.toList())
                                    ? 8.0
                                    : 0.0,
                                8.0,
                              )),
                          child: Stack(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: valueOrDefault<Color>(
                                      (widget!.message?.mediaType ==
                                                  MessageMediaType.Image) ||
                                              (widget!.message?.mediaType ==
                                                  MessageMediaType.File)
                                          ? Color(0x00F1F3F7)
                                          : FlutterFlowTheme.of(context)
                                              .offWhite,
                                      FlutterFlowTheme.of(context).offWhite,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: valueOrDefault<Color>(
                                          (widget!.message?.mediaType ==
                                                      MessageMediaType.Image) ||
                                                  (widget!.message?.mediaType ==
                                                      MessageMediaType.Video) ||
                                                  (widget!.message?.mediaType ==
                                                      MessageMediaType.File)
                                              ? Color(0x001F2756)
                                              : Color(0x0D1F2756),
                                          Color(0x0D1F2756),
                                        ),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        (widget!.message?.mediaType ==
                                                    MessageMediaType.Image) ||
                                                (widget!.message?.mediaType ==
                                                    MessageMediaType.File)
                                            ? Color(0x00F1F3F7)
                                            : FlutterFlowTheme.of(context)
                                                .greyBorder,
                                        FlutterFlowTheme.of(context).greyBorder,
                                      ),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: wrapWithModel(
                                    model: _model.messageTypesModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: MessageTypesWidget(
                                      mobileView: widget!.mobileView,
                                      replyTo: false,
                                      message: widget!.message!,
                                      messageType: MessageType.Received,
                                      textColor: FlutterFlowTheme.of(context)
                                          .deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                              if (valueOrDefault<bool>(
                                widget!.message?.emojiReaction != null,
                                false,
                              ))
                                AlignedTooltip(
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'double click to remove!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: Color(0xFFFDFDFD),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily),
                                          ),
                                    ),
                                  ),
                                  offset: 2.0,
                                  preferredDirection: AxisDirection.down,
                                  borderRadius: BorderRadius.circular(8.0),
                                  backgroundColor: Color(0x8001031C),
                                  elevation: 1.0,
                                  tailBaseWidth: 0.0,
                                  tailLength: 4.0,
                                  waitDuration: Duration(milliseconds: 500),
                                  showDuration: Duration(milliseconds: 100),
                                  triggerMode: TooltipTriggerMode.longPress,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'RECEIVED_MESSAGE_Container_aesnlv15_ON_T');
                                      logFirebaseEvent(
                                          'Container_backend_call');

                                      await widget!.message!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'EmojiReaction':
                                                FieldValue.delete(),
                                          },
                                        ),
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .greyBorder,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Builder(
                                              builder: (context) {
                                                if (widget!.message
                                                        ?.emojiReaction ==
                                                    MessageReaction.Like) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/Like.png',
                                                        height: 14.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                } else if (widget!.message
                                                        ?.emojiReaction ==
                                                    MessageReaction.Dislike) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/Dislike.png',
                                                        height: 14.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                } else if (widget!.message
                                                        ?.emojiReaction ==
                                                    MessageReaction.Love) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/Love.png',
                                                        height: 14.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                } else if (widget!.message
                                                        ?.emojiReaction ==
                                                    MessageReaction.Celebrate) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/Celebrate.png',
                                                        height: 14.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container(
                                                    width: 16.0,
                                                    height: 16.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'tooltipOnPageLoadAnimation']!),
                            ],
                          ),
                        ),
                        if (functions.within1MinuteOfNext(
                            widget!.message!, widget!.messagesList!.toList()))
                          Text(
                            valueOrDefault<String>(
                              functions
                                  .relativeTime(widget!.message!.sentTime!),
                              'Time Sent',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  color: FlutterFlowTheme.of(context).grey2,
                                  fontSize: valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall
                                        ? 8.0
                                        : 10.0,
                                    10.0,
                                  ),
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .labelSmallFamily),
                                ),
                          ),
                      ],
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ],
            ),
          ].divide(SizedBox(height: 0.0)),
        ),
      ),
    );
  }
}
