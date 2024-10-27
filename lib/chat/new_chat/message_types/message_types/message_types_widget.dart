import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/new_chat/audio/audio_player/audio_player_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'message_types_model.dart';
export 'message_types_model.dart';

class MessageTypesWidget extends StatefulWidget {
  const MessageTypesWidget({
    super.key,
    required this.message,
    bool? mobileView,
    required this.messageType,
    bool? replyTo,
    Color? textColor,
  })  : this.mobileView = mobileView ?? false,
        this.replyTo = replyTo ?? false,
        this.textColor = textColor ?? Colors.black;

  final MessagesRecord? message;
  final bool mobileView;
  final MessageType? messageType;
  final bool replyTo;
  final Color textColor;

  @override
  State<MessageTypesWidget> createState() => _MessageTypesWidgetState();
}

class _MessageTypesWidgetState extends State<MessageTypesWidget> {
  late MessageTypesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageTypesModel());

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
        if (widget!.message?.mediaType == MessageMediaType.Text) {
          return Builder(
            builder: (context) {
              if (widget!.replyTo) {
                return Text(
                  valueOrDefault<String>(
                    widget!.message?.message,
                    'Message',
                  ).maybeHandleOverflow(
                    maxChars: 25,
                    replacement: '…',
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: Color(0xFF868E9C),
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                      ),
                );
              } else {
                return Container(
                  constraints: BoxConstraints(
                    minHeight: 36.0,
                    maxWidth: () {
                      if (widget!.mobileView) {
                        return 280.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointSmall) {
                        return 200.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointMedium) {
                        return 300.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointLarge) {
                        return 400.0;
                      } else {
                        return 540.0;
                      }
                    }(),
                  ),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(valueOrDefault<double>(
                      !widget!.replyTo ? 8.0 : 2.0,
                      2.0,
                    )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: custom_widgets.LinkableText(
                            width: 200.0,
                            height: 40.0,
                            text: valueOrDefault<String>(
                              widget!.message?.message,
                              'Message',
                            ),
                            textSize: 14.0,
                            limitTextLength: false,
                            textColor: valueOrDefault<Color>(
                              widget!.textColor,
                              FlutterFlowTheme.of(context).deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        } else if (widget!.message?.mediaType == MessageMediaType.Image) {
          return Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Builder(
              builder: (context) {
                if (widget!.message!.images.length >= 2) {
                  return Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                      child: Container(
                        width: 320.0,
                        height: 320.0,
                        constraints: BoxConstraints(
                          maxWidth: valueOrDefault<double>(
                            () {
                              if (widget!.replyTo) {
                                return 120.0;
                              } else if (widget!.mobileView) {
                                return 250.0;
                              } else {
                                return 400.0;
                              }
                            }(),
                            400.0,
                          ),
                          maxHeight: valueOrDefault<double>(
                            () {
                              if (widget!.replyTo) {
                                return 140.0;
                              } else if (widget!.mobileView) {
                                return 280.0;
                              } else {
                                return 400.0;
                              }
                            }(),
                            400.0,
                          ),
                        ),
                        decoration: BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            final imagesList =
                                widget!.message?.images?.toList() ?? [];

                            return FlutterFlowSwipeableStack(
                              onSwipeFn: (index) {},
                              onLeftSwipe: (index) {},
                              onRightSwipe: (index) {},
                              onUpSwipe: (index) {},
                              onDownSwipe: (index) {},
                              itemBuilder: (context, imagesListIndex) {
                                final imagesListItem =
                                    imagesList[imagesListIndex];
                                return Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 0.0,
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 12.0,
                                            color: Color(0x151F2756),
                                            offset: Offset(
                                              2.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: Color(0x65FFFFFF),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'MESSAGE_TYPES_COMP_Image_gbw23rw0_ON_TAP');
                                          logFirebaseEvent(
                                              'Image_expand_image');
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  imagesListItem,
                                                  fit: BoxFit.contain,
                                                  alignment:
                                                      Alignment(0.0, 0.0),
                                                ),
                                                allowRotation: false,
                                                tag: imagesListItem,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: imagesListItem,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.network(
                                              imagesListItem,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                              alignment: Alignment(0.0, 0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: imagesList.length,
                              controller: _model.swipeableStackController,
                              loop: true,
                              cardDisplayCount: 3,
                              scale: 0.95,
                              threshold: 0.4,
                              maxAngle: 40.0,
                              cardPadding: EdgeInsets.all(0.0),
                              backCardOffset: const Offset(20.0, 4.0),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    constraints: BoxConstraints(
                      maxWidth: valueOrDefault<double>(
                        () {
                          if (widget!.replyTo) {
                            return 120.0;
                          } else if (widget!.mobileView) {
                            return 280.0;
                          } else {
                            return 400.0;
                          }
                        }(),
                        400.0,
                      ),
                      maxHeight: valueOrDefault<double>(
                        widget!.mobileView ? 280.0 : 400.0,
                        400.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Color(0x151F2756),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'MESSAGE_TYPES_COMP_Image_mgxjlhis_ON_TAP');
                        logFirebaseEvent('Image_expand_image');
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: FlutterFlowExpandedImageView(
                              image: Image.network(
                                widget!.message!.images.first,
                                fit: BoxFit.contain,
                                alignment: Alignment(0.0, 0.0),
                              ),
                              allowRotation: false,
                              tag: widget!.message!.images.first,
                              useHeroAnimation: true,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: widget!.message!.images.first,
                        transitionOnUserGestures: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget!.message!.images.first,
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.0),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else if (widget!.message?.mediaType == MessageMediaType.Video) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12.0,
                    color: Color(0x1B1F2756),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Builder(
                builder: (context) {
                  if (widget!.replyTo) {
                    return FlutterFlowVideoPlayer(
                      path: widget!.message!.video,
                      videoType: VideoType.network,
                      width: 200.0,
                      autoPlay: false,
                      looping: false,
                      showControls: false,
                      allowFullScreen: true,
                      allowPlaybackSpeedMenu: false,
                      lazyLoad: false,
                    );
                  } else {
                    return FlutterFlowVideoPlayer(
                      path: widget!.message!.video,
                      videoType: VideoType.network,
                      width: valueOrDefault<double>(
                        widget!.mobileView ? 280.0 : 400.0,
                        400.0,
                      ),
                      autoPlay: false,
                      looping: false,
                      showControls: true,
                      allowFullScreen: true,
                      allowPlaybackSpeedMenu: false,
                      lazyLoad: false,
                    );
                  }
                },
              ),
            ),
          );
        } else if (widget!.message?.mediaType == MessageMediaType.Audio) {
          return wrapWithModel(
            model: _model.audioPlayerModel,
            updateCallback: () => safeSetState(() {}),
            child: AudioPlayerWidget(
              audio: widget!.message!.audio,
              reply: false,
              type: widget!.messageType!,
            ),
          );
        } else if (widget!.message?.mediaType == MessageMediaType.File) {
          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('MESSAGE_TYPES_COMP_FileContainer_ON_TAP');
              logFirebaseEvent('FileContainer_launch_u_r_l');
              await launchURL(widget!.message!.file);
            },
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).offWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).greyBorder,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_present_outlined,
                      color: FlutterFlowTheme.of(context).grey4,
                      size: 24.0,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.message?.fileName,
                        'FileName',
                      ).maybeHandleOverflow(
                        maxChars: 36,
                        replacement: '…',
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            color: FlutterFlowTheme.of(context).grey4,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelLargeFamily),
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
            ),
          );
        } else {
          return Text(
            '[Empty Message]',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                  color: FlutterFlowTheme.of(context).white,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).labelLargeFamily),
                ),
          );
        }
      },
    );
  }
}
