import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).appBG,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'profile': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'lockScreen': ParameterData.none(),
  'SearchContent': (data) async => ParameterData(
        allParams: {
          'collectionID': getParameter<int>(data, 'collectionID'),
        },
      ),
  'EntryPage': ParameterData.none(),
  'NewUser': (data) async => ParameterData(
        allParams: {
          'email': getParameter<String>(data, 'email'),
          'firstTimeUser': getParameter<bool>(data, 'firstTimeUser'),
          'tribeUID': getParameter<int>(data, 'tribeUID'),
          'fullName': getParameter<String>(data, 'fullName'),
        },
      ),
  'ExistingUser': (data) async => ParameterData(
        allParams: {
          'email': getParameter<String>(data, 'email'),
          'name': getParameter<String>(data, 'name'),
        },
      ),
  'PostView': (data) async => ParameterData(
        allParams: {
          'postID': getParameter<int>(data, 'postID'),
          'hasLiked': getParameter<bool>(data, 'hasLiked'),
          'pageSource': getParameter<String>(data, 'pageSource'),
          'completed': getParameter<bool>(data, 'completed'),
          'video': getParameter<String>(data, 'video'),
          'type': getParameter<String>(data, 'type'),
          'contentURI': getParameter<String>(data, 'contentURI'),
          'descriptionPlain': getParameter<String>(data, 'descriptionPlain'),
          'featuredImage': getParameter<String>(data, 'featuredImage'),
          'title': getParameter<String>(data, 'title'),
          'userPic': getParameter<String>(data, 'userPic'),
          'userName': getParameter<String>(data, 'userName'),
          'chatEnabled': getParameter<bool>(data, 'chatEnabled'),
          'likeCount': getParameter<int>(data, 'likeCount'),
          'commentCount': getParameter<int>(data, 'commentCount'),
          'commentFocus': getParameter<bool>(data, 'commentFocus'),
          'userId': getParameter<int>(data, 'userId'),
          'descriptionHtml': getParameter<String>(data, 'descriptionHtml'),
          'groupSlug': getParameter<String>(data, 'groupSlug'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupList': ParameterData.none(),
  'entryRedirect': ParameterData.none(),
  'GroupsToday': (data) async => ParameterData(
        allParams: {
          'openTab': getParameter<int>(data, 'openTab'),
          'activeGroupTab': getParameter<String>(data, 'activeGroupTab'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupsReplay': (data) async => ParameterData(
        allParams: {
          'openTab': getParameter<int>(data, 'openTab'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupsNextSteps': (data) async => ParameterData(
        allParams: {
          'groupName': getParameter<String>(data, 'groupName'),
          'groupCoverImg': getParameter<String>(data, 'groupCoverImg'),
          'currentUserRole': getParameter<String>(data, 'currentUserRole'),
          'groupSlug': getParameter<String>(data, 'groupSlug'),
          'groupId': getParameter<int>(data, 'groupId'),
          'openTab': getParameter<int>(data, 'openTab'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
          'groupRef': getParameter<DocumentReference>(data, 'groupRef'),
        },
      ),
  'GroupsCommunity_FB': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupContent': (data) async => ParameterData(
        allParams: {
          'collectionRef':
              getParameter<DocumentReference>(data, 'collectionRef'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'DiscussionPost': (data) async => ParameterData(
        allParams: {
          'broadcastDoc': await getDocumentParameter<BroadcastsRecord>(
              data, 'broadcastDoc', BroadcastsRecord.fromSnapshot),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
          'isEditMode': getParameter<bool>(data, 'isEditMode'),
        },
      ),
  'StartBroadcast_FB': (data) async => ParameterData(
        allParams: {
          'title': getParameter<String>(data, 'title'),
          'description': getParameter<String>(data, 'description'),
          'sendNotification': getParameter<bool>(data, 'sendNotification'),
          'notificationTitle': getParameter<String>(data, 'notificationTitle'),
          'notificationMessage':
              getParameter<String>(data, 'notificationMessage'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
          'broadcast': getParameter<DocumentReference>(data, 'broadcast'),
        },
      ),
  'GroupsTraining': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'updateApp': ParameterData.none(),
  'ReturningRedirect': ParameterData.none(),
  'DiscussionPostRedirect': (data) async => ParameterData(
        allParams: {
          'broadcastRef': getParameter<DocumentReference>(data, 'broadcastRef'),
        },
      ),
  'UploadTest': ParameterData.none(),
  'ExploreGroups': (data) async => ParameterData(
        allParams: {
          'openTab': getParameter<int>(data, 'openTab'),
          'activeGroupTab': getParameter<String>(data, 'activeGroupTab'),
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'DashboardMembers': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupsEvents2': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'DashboardFeed': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'SearchieTest': ParameterData.none(),
  'PostingTransition': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'PostViewUserAdmin': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
          'courseDoc': getParameter<DocumentReference>(data, 'courseDoc'),
        },
      ),
  'coursesList': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'PostViewMobileContent': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
          'courseDoc': await getDocumentParameter<TribeCourseRecord>(
              data, 'courseDoc', TribeCourseRecord.fromSnapshot),
          'collectionDoc': await getDocumentParameter<TribeCollectionRecord>(
              data, 'collectionDoc', TribeCollectionRecord.fromSnapshot),
          'contentDoc': await getDocumentParameter<TribeContentRecord>(
              data, 'contentDoc', TribeContentRecord.fromSnapshot),
        },
      ),
  'GroupsChatbot': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'notifications': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'groupMembersList': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'DashboardPlatformSettings': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'DashboardUsers': ParameterData.none(),
  'DashboardTickets': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'Courses': ParameterData.none(),
  'DashboardGroupSettings': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupsCommunity_Announcements': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'Download': ParameterData.none(),
  'DashboardAdminReply': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'GroupNEWCHAT': (data) async => ParameterData(
        allParams: {
          'groupDoc': await getDocumentParameter<TribeGroupsRecord>(
              data, 'groupDoc', TribeGroupsRecord.fromSnapshot),
        },
      ),
  'Page-NewChat': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
