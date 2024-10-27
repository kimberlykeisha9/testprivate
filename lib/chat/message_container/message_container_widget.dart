import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'message_container_model.dart';
export 'message_container_model.dart';

class MessageContainerWidget extends StatefulWidget {
  const MessageContainerWidget({
    super.key,
    required this.chatMessagesRef,
  });

  final DirectMessagesRecord? chatMessagesRef;

  @override
  State<MessageContainerWidget> createState() => _MessageContainerWidgetState();
}

class _MessageContainerWidgetState extends State<MessageContainerWidget> {
  late MessageContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageContainerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget!.chatMessagesRef?.user == currentUserReference) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 0.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).accent1,
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 200),
                                  fadeOutDuration: Duration(milliseconds: 200),
                                  imageUrl: currentUserPhoto,
                                  width: 44.0,
                                  height: 44.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 520.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AuthUserStreamWidget(
                                    builder: (context) => SelectionArea(
                                        child: AutoSizeText(
                                      valueOrDefault<String>(
                                        currentUserDisplayName,
                                        'Me',
                                      ),
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.0,
                                          ),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat("relative",
                                            widget!.chatMessagesRef?.timestamp),
                                        '--',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontStyle: FontStyle.italic,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily),
                                            lineHeight: 1.0,
                                          ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                              SelectionArea(
                                  child: Text(
                                valueOrDefault<String>(
                                  widget!.chatMessagesRef?.text,
                                  '--',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily),
                                    ),
                              )),
                              if (widget!.chatMessagesRef
                                      ?.hasAttachmentLink() ??
                                  true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (functions.checkAttachmentType(widget!
                                              .chatMessagesRef!
                                              .attachmentLink) ==
                                          'image') {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            '${widget!.chatMessagesRef?.attachmentLink}',
                                            width: 400.0,
                                            height: 300.0,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else if (functions.checkAttachmentType(
                                              widget!.chatMessagesRef!
                                                  .attachmentLink) ==
                                          'video') {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: FlutterFlowVideoPlayer(
                                              path:
                                                  '${widget!.chatMessagesRef?.attachmentLink}',
                                              videoType: VideoType.network,
                                              width: 400.0,
                                              height: 300.0,
                                              autoPlay: true,
                                              looping: true,
                                              showControls: true,
                                              allowFullScreen: false,
                                              allowPlaybackSpeedMenu: false,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          width: 300.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.attach_file,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 32.0,
                                                ),
                                                MouseRegion(
                                                  opaque: true,
                                                  cursor: SystemMouseCursors
                                                          .click ??
                                                      MouseCursor.defer,
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
                                                          'MESSAGE_CONTAINER_Text_5bueu56i_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Text_launch_u_r_l');
                                                      await launchURL(widget!
                                                          .chatMessagesRef!
                                                          .attachmentLink);
                                                    },
                                                    child: Text(
                                                      'Download',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ),
                                                  onEnter: ((event) async {
                                                    safeSetState(() => _model
                                                            .mouseRegionHovered1 =
                                                        true);
                                                  }),
                                                  onExit: ((event) async {
                                                    safeSetState(() => _model
                                                            .mouseRegionHovered1 =
                                                        false);
                                                  }),
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                            ].divide(SizedBox(height: 5.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder<UserRecord>(
                future: _model.chatUser(
                  uniqueQueryKey: widget!.chatMessagesRef?.reference.id,
                  requestFn: () => UserRecord.getDocumentOnce(
                      widget!.chatMessagesRef!.user!),
                ),
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

                  final otherUserUserRecord = snapshot.data!;

                  return Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 600.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).grayIcon,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 0.0,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent1,
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 200),
                                    fadeOutDuration:
                                        Duration(milliseconds: 200),
                                    imageUrl: otherUserUserRecord.photoUrl,
                                    width: 44.0,
                                    height: 44.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 520.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SelectionArea(
                                          child: AutoSizeText(
                                        otherUserUserRecord.displayName,
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                              lineHeight: 1.0,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            dateTimeFormat(
                                                "relative",
                                                widget!.chatMessagesRef
                                                    ?.timestamp),
                                            '--',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                fontStyle: FontStyle.italic,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                                lineHeight: 1.0,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                  SelectionArea(
                                      child: AutoSizeText(
                                    valueOrDefault<String>(
                                      widget!.chatMessagesRef?.text,
                                      '--',
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily),
                                          lineHeight: 1.5,
                                        ),
                                  )),
                                  if (widget!.chatMessagesRef
                                          ?.hasAttachmentLink() ??
                                      true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          if (functions.checkAttachmentType(
                                                  widget!.chatMessagesRef!
                                                      .attachmentLink) ==
                                              'image') {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                '${widget!.chatMessagesRef?.attachmentLink}',
                                                width: 400.0,
                                                height: 300.0,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else if (functions
                                                  .checkAttachmentType(widget!
                                                      .chatMessagesRef!
                                                      .attachmentLink) ==
                                              'video') {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: FlutterFlowVideoPlayer(
                                                  path:
                                                      '${widget!.chatMessagesRef?.attachmentLink}',
                                                  videoType: VideoType.network,
                                                  width: 400.0,
                                                  height: 300.0,
                                                  autoPlay: true,
                                                  looping: true,
                                                  showControls: true,
                                                  allowFullScreen: false,
                                                  allowPlaybackSpeedMenu: false,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              width: 300.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .gray200,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.attach_file,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 32.0,
                                                    ),
                                                    MouseRegion(
                                                      opaque: true,
                                                      cursor: SystemMouseCursors
                                                              .click ??
                                                          MouseCursor.defer,
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
                                                              'MESSAGE_CONTAINER_Text_3clyem70_ON_TAP');
                                                          logFirebaseEvent(
                                                              'Text_launch_u_r_l');
                                                          await launchURL(widget!
                                                              .chatMessagesRef!
                                                              .attachmentLink);
                                                        },
                                                        child: Text(
                                                          'Download',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                        ),
                                                      ),
                                                      onEnter: ((event) async {
                                                        safeSetState(() => _model
                                                                .mouseRegionHovered2 =
                                                            true);
                                                      }),
                                                      onExit: ((event) async {
                                                        safeSetState(() => _model
                                                                .mouseRegionHovered2 =
                                                            false);
                                                      }),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                ].divide(SizedBox(height: 5.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
