import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_profile_dialog_model.dart';
export 'user_profile_dialog_model.dart';

class UserProfileDialogWidget extends StatefulWidget {
  const UserProfileDialogWidget({
    super.key,
    required this.userDoc,
  });

  final UserRecord? userDoc;

  @override
  State<UserProfileDialogWidget> createState() =>
      _UserProfileDialogWidgetState();
}

class _UserProfileDialogWidgetState extends State<UserProfileDialogWidget> {
  late UserProfileDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfileDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('USER_PROFILE_DIALOG_userProfileDialog_ON');
      logFirebaseEvent('userProfileDialog_update_component_state');
      _model.addToUserPair(currentUserReference!);
      safeSetState(() {});
      if (widget!.userDoc?.reference != currentUserReference) {
        logFirebaseEvent('userProfileDialog_update_component_state');
        _model.addToUserPair(widget!.userDoc!.reference);
        safeSetState(() {});
      }
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
      width: 320.0,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    widget!.userDoc!.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.userDoc?.displayName,
                    'Username',
                  ),
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelLargeFamily,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).labelLargeFamily),
                      ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            if (widget!.userDoc?.bio != null && widget!.userDoc?.bio != '')
              Text(
                widget!.userDoc!.bio,
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).labelLargeFamily),
                    ),
              ),
            Builder(
              builder: (context) {
                final userBadges = widget!.userDoc?.userBadges?.toList() ?? [];

                return Wrap(
                  spacing: 10.0,
                  runSpacing: 15.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: List.generate(userBadges.length, (userBadgesIndex) {
                    final userBadgesItem = userBadges[userBadgesIndex];
                    return Builder(
                      builder: (context) {
                        if (userBadgesItem.badgeImg != null &&
                            userBadgesItem.badgeImg != '') {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 300),
                                  fadeOutDuration: Duration(milliseconds: 300),
                                  imageUrl: userBadgesItem.badgeImg,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/error_image.jpg',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                userBadgesItem.badgeName,
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily),
                                    ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).accent2,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    userBadgesItem.badgeName,
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }),
                );
              },
            ),
            if (_model.userPair.length > 1)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (getRemoteConfigBool('EnableDMinApp'))
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'USER_PROFILE_DIALOG_chatWithUserButton_O');
                          final firestoreBatch =
                              FirebaseFirestore.instance.batch();
                          try {
                            logFirebaseEvent('chatWithUserButton_backend_call');

                            var conversationsRecordReference =
                                ConversationsRecord.collection.doc();
                            firestoreBatch.set(conversationsRecordReference, {
                              ...createConversationsRecordData(
                                createdTime: getCurrentTimestamp,
                                conversationStarted: false,
                                lastMessage: 'New Conversation',
                                lastMessageTime: getCurrentTimestamp,
                              ),
                              ...mapToFirestore(
                                {
                                  'Users': [currentUserReference],
                                },
                              ),
                            });
                            _model.newConversation =
                                ConversationsRecord.getDocumentFromData({
                              ...createConversationsRecordData(
                                createdTime: getCurrentTimestamp,
                                conversationStarted: false,
                                lastMessage: 'New Conversation',
                                lastMessageTime: getCurrentTimestamp,
                              ),
                              ...mapToFirestore(
                                {
                                  'Users': [currentUserReference],
                                },
                              ),
                            }, conversationsRecordReference);
                            logFirebaseEvent('chatWithUserButton_backend_call');

                            firestoreBatch
                                .update(_model.newConversation!.reference, {
                              ...mapToFirestore(
                                {
                                  'Users': FieldValue.arrayUnion(
                                      [widget!.userDoc?.reference]),
                                },
                              ),
                            });
                            logFirebaseEvent('chatWithUserButton_navigate_to');

                            context.pushNamed('Page-NewChat');
                          } finally {
                            await firestoreBatch.commit();
                          }

                          safeSetState(() {});
                        },
                        text: 'Open chat',
                        icon: Icon(
                          Icons.chat_bubble_outline_sharp,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: 140.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFFAFAFA),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          hoverColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          hoverBorderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 0.0,
                          ),
                          hoverElevation: 0.0,
                        ),
                      ),
                    AuthUserStreamWidget(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'USER_PROFILE_DIALOG_blockUserBtn_ON_TAP');
                          logFirebaseEvent('blockUserBtn_alert_dialog');
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Are you sure?'),
                                      content: Text(
                                          'Do you want to ${!(currentUserDocument?.blockedUsers?.toList() ?? []).contains(widget!.userDoc?.reference) ? 'block' : 'unblock'} this user?'),
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
                            if (!(currentUserDocument?.blockedUsers?.toList() ??
                                    [])
                                .contains(widget!.userDoc?.reference)) {
                              logFirebaseEvent('blockUserBtn_backend_call');

                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'blockedUsers': FieldValue.arrayUnion(
                                        [widget!.userDoc?.reference]),
                                  },
                                ),
                              });
                            } else {
                              logFirebaseEvent('blockUserBtn_backend_call');

                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'blockedUsers': FieldValue.arrayRemove(
                                        [widget!.userDoc?.reference]),
                                  },
                                ),
                              });
                            }

                            logFirebaseEvent('blockUserBtn_action_block');
                            await action_blocks.displaySnackbar(
                              context,
                              message: !(currentUserDocument?.blockedUsers
                                              ?.toList() ??
                                          [])
                                      .contains(widget!.userDoc?.reference)
                                  ? 'User blocked.'
                                  : 'User unblocked.',
                            );
                          } else {
                            return;
                          }
                        },
                        text:
                            !(currentUserDocument?.blockedUsers?.toList() ?? [])
                                    .contains(widget!.userDoc?.reference)
                                ? 'Block user'
                                : 'Unblock user',
                        icon: Icon(
                          Icons.block,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: 140.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: valueOrDefault<Color>(
                            !(currentUserDocument?.blockedUsers?.toList() ?? [])
                                    .contains(widget!.userDoc?.reference)
                                ? FlutterFlowTheme.of(context).customColor3
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            FlutterFlowTheme.of(context).customColor3,
                          ),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: valueOrDefault<Color>(
                                  !(currentUserDocument?.blockedUsers
                                                  ?.toList() ??
                                              [])
                                          .contains(widget!.userDoc?.reference)
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .customColor3,
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ),
          ].divide(SizedBox(height: 4.0)),
        ),
      ),
    );
  }
}
