import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/user_profile_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

Future groupTabRedirect(
  BuildContext context, {
  TribeGroupsRecord? groupDoc,
}) async {
  if (groupDoc!.communityTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsCommunity_FB',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'Community';
  } else if (groupDoc!.communityAdminOnlyTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsCommunity_Announcements',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'Announcements';
  } else if (groupDoc!.todayTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsToday',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'Today';
  } else if (groupDoc!.trainingTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsTraining',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'T';
  } else if (groupDoc!.replayTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsReplay',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'Replay';
  } else if (groupDoc!.eventsTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsEvents2',
      queryParameters: {
        'groupDoc': serializeParam(
          groupDoc,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'groupDoc': groupDoc,
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'Events';
  } else if (groupDoc!.nextStepsTabEnabled) {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed(
      'GroupsNextSteps',
      queryParameters: {
        'groupName': serializeParam(
          'NextSteps',
          ParamType.String,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );

    logFirebaseEvent('GroupTabRedirect_update_app_state');
    FFAppState().ActiveGroupTab = 'NextSteps';
  } else {
    logFirebaseEvent('GroupTabRedirect_navigate_to');

    context.pushNamed('GroupList');
  }

  logFirebaseEvent('GroupTabRedirect_update_app_state');
  FFAppState().currentGroup = groupDoc?.reference;
  FFAppState().update(() {});
}

Future addABView(
  BuildContext context, {
  DocumentReference? broadcaRef,
}) async {
  logFirebaseEvent('AddABView_wait__delay');
  await Future.delayed(const Duration(milliseconds: 5000));
  if (broadcaRef != null) {
    logFirebaseEvent('AddABView_backend_call');

    await broadcaRef!.update({
      ...mapToFirestore(
        {
          'totalViews': FieldValue.increment(1),
          'watchedBy': FieldValue.arrayUnion([currentUserReference]),
        },
      ),
    });
  } else {
    return;
  }
}

Future displaySnackbar(
  BuildContext context, {
  required String? message,
  Color? snackbarColor,
}) async {
  logFirebaseEvent('displaySnackbar_show_snack_bar');
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 2000),
      backgroundColor: valueOrDefault<Color>(
        snackbarColor,
        FlutterFlowTheme.of(context).primary,
      ),
    ),
  );
}

Future openUserProfileDialog(
  BuildContext context, {
  required UserRecord? userDoc,
}) async {
  logFirebaseEvent('openUserProfileDialog_alert_dialog');
  await showAlignedDialog(
    barrierColor: Color(0x89000000),
    context: context,
    isGlobal: false,
    avoidOverflow: false,
    targetAnchor:
        AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
    followerAnchor:
        AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
    builder: (dialogContext) {
      return Material(
        color: Colors.transparent,
        child: WebViewAware(
          child: Container(
            width: 320.0,
            child: UserProfileDialogWidget(
              userDoc: userDoc!,
            ),
          ),
        ),
      );
    },
  );
}

Future<DocumentReference> createLiveStream(
  BuildContext context, {
  required String? name,
  required String? description,
  required int? groupId,
  required List<String>? category,
}) async {
  RoomDataStruct? roomData;
  BroadcastsRecord? newBroadcast;

  logFirebaseEvent('createLiveStream_custom_action');
  roomData = await actions.createRoom(
    name!,
    description!,
    getRemoteConfigString('hms_template'),
    getRemoteConfigString('hms_management_token'),
  );
  logFirebaseEvent('createLiveStream_backend_call');

  var broadcastsRecordReference = BroadcastsRecord.collection.doc();
  await broadcastsRecordReference.set({
    ...createBroadcastsRecordData(
      isLive: true,
      roomData: updateRoomDataStruct(
        roomData,
        clearUnsetFields: false,
        create: true,
      ),
      name: name,
      time: getCurrentTimestamp,
      userId: currentUserReference,
      title: name,
      groupId: groupId,
      authorName: currentUserDisplayName,
      authorImg: currentUserPhoto,
      authorRole: valueOrDefault(currentUserDocument?.userRole, ''),
      pinnedToTop: false,
      chatEnabled: true,
    ),
    ...mapToFirestore(
      {
        'category': category,
      },
    ),
  });
  newBroadcast = BroadcastsRecord.getDocumentFromData({
    ...createBroadcastsRecordData(
      isLive: true,
      roomData: updateRoomDataStruct(
        roomData,
        clearUnsetFields: false,
        create: true,
      ),
      name: name,
      time: getCurrentTimestamp,
      userId: currentUserReference,
      title: name,
      groupId: groupId,
      authorName: currentUserDisplayName,
      authorImg: currentUserPhoto,
      authorRole: valueOrDefault(currentUserDocument?.userRole, ''),
      pinnedToTop: false,
      chatEnabled: true,
    ),
    ...mapToFirestore(
      {
        'category': category,
      },
    ),
  }, broadcastsRecordReference);
  return newBroadcast!.reference;
}
