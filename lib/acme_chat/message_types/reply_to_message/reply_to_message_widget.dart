import '/acme_chat/message_types/message_types/message_types_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reply_to_message_model.dart';
export 'reply_to_message_model.dart';

class ReplyToMessageWidget extends StatefulWidget {
  const ReplyToMessageWidget({
    super.key,
    required this.message,
    required this.type,
    bool? drafting,
    bool? mobileView,
  })  : this.drafting = drafting ?? false,
        this.mobileView = mobileView ?? false;

  final MessagesRecord? message;
  final MessageType? type;
  final bool drafting;
  final bool mobileView;

  @override
  State<ReplyToMessageWidget> createState() => _ReplyToMessageWidgetState();
}

class _ReplyToMessageWidgetState extends State<ReplyToMessageWidget> {
  late ReplyToMessageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReplyToMessageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget!.drafting)
          Align(
            alignment: AlignmentDirectional(
                valueOrDefault<double>(
                  widget!.type == MessageType.Sent ? 1.0 : -1.0,
                  0.0,
                ),
                0.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                    child: Text(
                      'Replied to ${widget!.message?.sentBy != currentUserReference ? 'their' : 'your'} ',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                color: FlutterFlowTheme.of(context).grey2,
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineSmallFamily),
                                lineHeight: 1.0,
                              ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                    child: Text(
                      valueOrDefault<String>(
                        () {
                          if (widget!.message?.mediaType ==
                              MessageMediaType.Text) {
                            return 'message';
                          } else if (widget!.message?.mediaType ==
                              MessageMediaType.Image) {
                            return 'photo';
                          } else if (widget!.message?.mediaType ==
                              MessageMediaType.Video) {
                            return 'video';
                          } else if (widget!.message?.mediaType ==
                              MessageMediaType.Audio) {
                            return 'voicenote';
                          } else {
                            return 'message';
                          }
                        }(),
                        'message',
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                color: FlutterFlowTheme.of(context).grey2,
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineSmallFamily),
                                lineHeight: 1.0,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Align(
          alignment: AlignmentDirectional(
              valueOrDefault<double>(
                widget!.type == MessageType.Sent ? 1.0 : -1.0,
                0.0,
              ),
              0.0),
          child: Container(
            decoration: BoxDecoration(),
            child: wrapWithModel(
              model: _model.messageTypesModel,
              updateCallback: () => safeSetState(() {}),
              child: MessageTypesWidget(
                mobileView: widget!.mobileView,
                replyTo: true,
                message: widget!.message!,
                messageType: MessageType.ReplyTo,
                textColor: FlutterFlowTheme.of(context).deepPurple,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
