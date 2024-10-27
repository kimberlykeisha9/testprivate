import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'delete_reply_ban_options_model.dart';
export 'delete_reply_ban_options_model.dart';

class DeleteReplyBanOptionsWidget extends StatefulWidget {
  const DeleteReplyBanOptionsWidget({
    super.key,
    this.postId,
    this.groupSlug,
    this.postUserId,
    this.currentReply,
    this.currentComment,
    this.collectionRef,
  });

  final int? postId;
  final String? groupSlug;
  final int? postUserId;
  final PostCommentStruct? currentReply;
  final DocumentReference? currentComment;
  final DocumentReference? collectionRef;

  @override
  State<DeleteReplyBanOptionsWidget> createState() =>
      _DeleteReplyBanOptionsWidgetState();
}

class _DeleteReplyBanOptionsWidgetState
    extends State<DeleteReplyBanOptionsWidget> {
  late DeleteReplyBanOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteReplyBanOptionsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatMessagesRecord>(
      stream: ChatMessagesRecord.getDocument(widget!.currentComment!),
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

        final containerChatMessagesRecord = snapshot.data!;

        return Container(
          width: double.infinity,
          height: 270.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x3B1D2429),
                offset: Offset(
                  0.0,
                  -3.0,
                ),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (valueOrDefault(currentUserDocument?.userRole, '') ==
                    'admin')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'DELETE_REPLY_BAN_OPTIONS_BAN_USER_BTN_ON');
                          logFirebaseEvent('Button_alert_dialog');
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Ban User'),
                                      content: Text(
                                          'Are you sure you want to ban this user?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            logFirebaseEvent('Button_backend_call');

                            await widget!.currentReply!.userref!
                                .update(createUserRecordData(
                              banned: true,
                            ));
                            logFirebaseEvent('Button_bottom_sheet');
                            Navigator.pop(context);
                          } else {
                            logFirebaseEvent('Button_bottom_sheet');
                            Navigator.pop(context);
                            return;
                          }
                        },
                        text: 'Ban User',
                        icon: Icon(
                          Icons.flag,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).grayIcon,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Open Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey('Open Sans'),
                              ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                if ((containerChatMessagesRecord.user ==
                        currentUserReference) ||
                    (valueOrDefault(currentUserDocument?.userRole, '') ==
                        'admin') ||
                    (valueOrDefault(currentUserDocument?.userRole, '') == 'sa'))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'DELETE_REPLY_BAN_OPTIONS_DELETE_REPLY_BT');
                          logFirebaseEvent('Button_alert_dialog');
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Delete Comment'),
                                      content: Text(
                                          'Are you sure you want to Delete?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            logFirebaseEvent('Button_backend_call');

                            await widget!.currentComment!.update({
                              ...mapToFirestore(
                                {
                                  'replies': FieldValue.arrayRemove([
                                    getPostCommentFirestoreData(
                                      createPostCommentStruct(
                                        deleted: true,
                                        clearUnsetFields: false,
                                      ),
                                      true,
                                    )
                                  ]),
                                },
                              ),
                            });
                            logFirebaseEvent('Button_backend_call');

                            await widget!.collectionRef!.update({
                              ...mapToFirestore(
                                {
                                  'commentCount': FieldValue.increment(-(1)),
                                },
                              ),
                            });
                          } else {
                            logFirebaseEvent('Button_bottom_sheet');
                            Navigator.pop(context);
                            return;
                          }

                          logFirebaseEvent('Button_bottom_sheet');
                          Navigator.pop(context);
                        },
                        text: 'Delete Reply',
                        icon: Icon(
                          Icons.delete,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).customColor3,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Open Sans',
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey('Open Sans'),
                              ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'DELETE_REPLY_BAN_OPTIONS_CANCEL_BTN_ON_T');
                      logFirebaseEvent('Button_bottom_sheet');
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).accent3,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Open Sans',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Open Sans'),
                          ),
                      elevation: 2.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
