import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/new_chat/general/grey_divider/grey_divider_widget.dart';
import '/chat/new_chat/general/option_list_row/option_list_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'message_options_model.dart';
export 'message_options_model.dart';

class MessageOptionsWidget extends StatefulWidget {
  const MessageOptionsWidget({
    super.key,
    required this.message,
    required this.replying,
    required this.messageType,
    this.photoReplying,
  });

  final MessagesRecord? message;
  final Future Function()? replying;
  final MessageType? messageType;
  final String? photoReplying;

  @override
  State<MessageOptionsWidget> createState() => _MessageOptionsWidgetState();
}

class _MessageOptionsWidgetState extends State<MessageOptionsWidget> {
  late MessageOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageOptionsModel());

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
      width: 220.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).offWhite,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).greyBorder,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('MESSAGE_OPTIONS_COMP_Emoji1_ON_TAP');
                    logFirebaseEvent('Emoji1_backend_call');

                    await widget!.message!.reference
                        .update(createMessagesRecordData(
                      emojiReaction: MessageReaction.Like,
                    ));
                    logFirebaseEvent('Emoji1_close_dialog_drawer_etc');
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/Like.png',
                      width: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('MESSAGE_OPTIONS_COMP_Emoji2_ON_TAP');
                    logFirebaseEvent('Emoji2_backend_call');

                    await widget!.message!.reference
                        .update(createMessagesRecordData(
                      emojiReaction: MessageReaction.Dislike,
                    ));
                    logFirebaseEvent('Emoji2_close_dialog_drawer_etc');
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/Dislike.png',
                      width: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('MESSAGE_OPTIONS_COMP_Emoji3_ON_TAP');
                    logFirebaseEvent('Emoji3_backend_call');

                    await widget!.message!.reference
                        .update(createMessagesRecordData(
                      emojiReaction: MessageReaction.Love,
                    ));
                    logFirebaseEvent('Emoji3_close_dialog_drawer_etc');
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/Love.png',
                      width: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('MESSAGE_OPTIONS_COMP_Emoji4_ON_TAP');
                    logFirebaseEvent('Emoji4_backend_call');

                    await widget!.message!.reference
                        .update(createMessagesRecordData(
                      emojiReaction: MessageReaction.Celebrate,
                    ));
                    logFirebaseEvent('Emoji4_close_dialog_drawer_etc');
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/Celebrate.png',
                      width: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: wrapWithModel(
              model: _model.greyDividerModel1,
              updateCallback: () => safeSetState(() {}),
              child: GreyDividerWidget(),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('MESSAGE_OPTIONS_Container_vmffeev0_ON_TA');
              logFirebaseEvent('OptionListRow_execute_callback');
              await widget.replying?.call();
              logFirebaseEvent('OptionListRow_close_dialog_drawer_etc');
              Navigator.pop(context);
            },
            child: wrapWithModel(
              model: _model.optionListRowModel,
              updateCallback: () => safeSetState(() {}),
              child: OptionListRowWidget(
                text: 'Reply',
                icon: Icon(
                  Icons.reply_rounded,
                ),
              ),
            ),
          ),
          if (widget!.message?.mediaType == MessageMediaType.Text)
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: wrapWithModel(
                      model: _model.greyDividerModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: GreyDividerWidget(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'MESSAGE_OPTIONS_Container_rzf7r7e7_ON_TA');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _model.mouseRegionHovered!
                                ? FlutterFlowTheme.of(context).grey1
                                : Color(0x00000000),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: valueOrDefault<Color>(
                                _model.mouseRegionHovered!
                                    ? FlutterFlowTheme.of(context).greyBorder
                                    : Colors.transparent,
                                Colors.transparent,
                              ),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 4.0, 8.0, 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Copy Text',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily),
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_model.messageCopied) {
                                      return Icon(
                                        Icons.task_alt,
                                        color: FlutterFlowTheme.of(context)
                                            .deepPurple,
                                        size: 16.0,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.content_copy,
                                        color: FlutterFlowTheme.of(context)
                                            .deepPurple,
                                        size: 16.0,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered = false);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          if (widget!.messageType == MessageType.Sent)
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: wrapWithModel(
                      model: _model.greyDividerModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: GreyDividerWidget(),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            13.0, 10.0, 13.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Read',
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelSmallFamily),
                                  ),
                            ),
                            Builder(
                              builder: (context) {
                                if (widget!.message?.read ?? false) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        dateTimeFormat("H:mm:s, E d MMM, y",
                                            widget!.message!.readTime!),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily),
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedDefaultTextStyle(
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily),
                                              lineHeight: 1.0,
                                            ),
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeInOut,
                                        child: Text(
                                          '•••',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 2.0)),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: wrapWithModel(
                      model: _model.greyDividerModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: GreyDividerWidget(),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              13.0, 10.0, 13.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivered',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelSmallFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily),
                                    ),
                              ),
                              Text(
                                dateTimeFormat("H:mm:s, E d MMM, y",
                                    widget!.message!.sentTime!),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelSmallFamily,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ]
            .divide(SizedBox(height: 0.0))
            .addToStart(SizedBox(height: 4.0))
            .addToEnd(SizedBox(height: 2.0)),
      ),
    );
  }
}
