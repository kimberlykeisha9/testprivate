import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'start_broadcast_f_b_model.dart';
export 'start_broadcast_f_b_model.dart';

class StartBroadcastFBWidget extends StatefulWidget {
  const StartBroadcastFBWidget({
    super.key,
    this.title,
    this.description,
    this.sendNotification,
    this.notificationTitle,
    this.notificationMessage,
    this.category,
    required this.groupDoc,
    required this.broadcast,
  });

  final String? title;
  final String? description;
  final bool? sendNotification;
  final String? notificationTitle;
  final String? notificationMessage;
  final List<String>? category;
  final TribeGroupsRecord? groupDoc;
  final DocumentReference? broadcast;

  @override
  State<StartBroadcastFBWidget> createState() => _StartBroadcastFBWidgetState();
}

class _StartBroadcastFBWidgetState extends State<StartBroadcastFBWidget> {
  late StartBroadcastFBModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartBroadcastFBModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'StartBroadcast_FB'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('START_BROADCAST_F_B_StartBroadcast_FB_ON');
      if (await getPermissionStatus(cameraPermission)) {
        if (await getPermissionStatus(microphonePermission)) {
          return;
        }

        logFirebaseEvent('StartBroadcast_FB_request_permissions');
        await requestPermission(microphonePermission);
        return;
      } else {
        logFirebaseEvent('StartBroadcast_FB_request_permissions');
        await requestPermission(cameraPermission);
        if (await getPermissionStatus(microphonePermission)) {
          return;
        }

        logFirebaseEvent('StartBroadcast_FB_request_permissions');
        await requestPermission(microphonePermission);
        return;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BroadcastsRecord>(
      stream: BroadcastsRecord.getDocument(widget!.broadcast!)
        ..listen((startBroadcastFBBroadcastsRecord) async {
          if (_model.startBroadcastFBPreviousSnapshot != null &&
              !BroadcastsRecordDocumentEquality().equals(
                  startBroadcastFBBroadcastsRecord,
                  _model.startBroadcastFBPreviousSnapshot)) {
            logFirebaseEvent('START_BROADCAST_F_B_StartBroadcast_FB_ON');
            logFirebaseEvent('StartBroadcast_FB_backend_call');
            _model.checkIfLive =
                await BroadcastsRecord.getDocumentOnce(widget!.broadcast!);
            if (_model.checkIfLive!.hasIsLive() &&
                !_model.checkIfLive!.isLive) {
              logFirebaseEvent('StartBroadcast_FB_firestore_query');
              _model.queryGroupUsersGoLive = await queryUserRecordOnce(
                queryBuilder: (userRecord) => userRecord.where(
                  'TribeGroups',
                  arrayContains: getTribeGroupsFirestoreData(
                    TribeGroupsStruct(
                      tribeGroupID: widget!.groupDoc?.tribeGroupID,
                      groupRef: widget!.groupDoc?.reference,
                      role: 'member',
                    ),
                    true,
                  ),
                ),
              );
              if (widget!.sendNotification!) {
                logFirebaseEvent('StartBroadcast_FB_trigger_push_notificat');
                triggerPushNotification(
                  notificationTitle: 'Live Stream ended',
                  notificationText:
                      '${currentUserDisplayName}\'s live session has ended. Click to watch the replay',
                  notificationSound: 'default',
                  userRefs: _model.queryGroupUsersGoLive!
                      .map((e) => e.reference)
                      .toList(),
                  initialPageName: 'DiscussionPost',
                  parameterData: {
                    'broadcastDoc': _model.checkIfLive,
                    'groupDoc': widget!.groupDoc,
                  },
                );
              }
              logFirebaseEvent('StartBroadcast_FB_wait__delay');
              await Future.delayed(const Duration(milliseconds: 1500));
              logFirebaseEvent('StartBroadcast_FB_navigate_to');

              context.pushNamed(
                'DiscussionPost',
                queryParameters: {
                  'broadcastDoc': serializeParam(
                    _model.checkIfLive,
                    ParamType.Document,
                  ),
                  'groupDoc': serializeParam(
                    widget!.groupDoc,
                    ParamType.Document,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  'broadcastDoc': _model.checkIfLive,
                  'groupDoc': widget!.groupDoc,
                },
              );

              logFirebaseEvent('StartBroadcast_FB_custom_action');
              await actions.toggleWakeLock(
                false,
              );
            } else {
              safeSetState(() {});
              return;
            }

            safeSetState(() {});
          }
          _model.startBroadcastFBPreviousSnapshot =
              startBroadcastFBBroadcastsRecord;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).appBG,
                  ),
                ),
              ),
            ),
          );
        }

        final startBroadcastFBBroadcastsRecord = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (startBroadcastFBBroadcastsRecord.userId !=
                      currentUserReference)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'START_BROADCAST_F_B_Icon_bp2jakin_ON_TAP');
                            logFirebaseEvent('Icon_navigate_back');
                            context.pop();
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (startBroadcastFBBroadcastsRecord.isLive) {
                          return AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: custom_widgets.CustomWebView(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                link:
                                    '${getRemoteConfigString('hms_stream_url')}meeting/${valueOrDefault<String>(
                                  startBroadcastFBBroadcastsRecord
                                              .userId ==
                                          currentUserReference
                                      ? startBroadcastFBBroadcastsRecord
                                          .roomData.broadcasterCode
                                      : startBroadcastFBBroadcastsRecord
                                          .roomData.viewerCode,
                                  'https://tenor.com/search/rainbow-cat-gifs',
                                )}${functions.appendNameAndUserId(currentUserDisplayName, currentUserUid)}',
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Live stream has ended. Redirecting you shortly...',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
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
        );
      },
    );
  }
}
