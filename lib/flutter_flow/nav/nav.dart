import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => RootPageContext.wrap(
        appStateNotifier.loggedIn
            ? ReturningRedirectWidget()
            : EntryRedirectWidget(),
        errorRoute: state.uri.toString(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => RootPageContext.wrap(
            appStateNotifier.loggedIn
                ? ReturningRedirectWidget()
                : EntryRedirectWidget(),
          ),
          routes: [
            FFRoute(
              name: 'profile',
              path: 'myProfile',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => ProfileWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'lockScreen',
              path: 'lockScreen',
              builder: (context, params) => LockScreenWidget(),
            ),
            FFRoute(
              name: 'SearchContent',
              path: 'searchContent',
              requireAuth: true,
              builder: (context, params) => SearchContentWidget(
                collectionID: params.getParam(
                  'collectionID',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: 'EntryPage',
              path: 'entryPage',
              builder: (context, params) => EntryPageWidget(),
            ),
            FFRoute(
              name: 'NewUser',
              path: 'newUser',
              builder: (context, params) => NewUserWidget(
                email: params.getParam(
                  'email',
                  ParamType.String,
                ),
                firstTimeUser: params.getParam(
                  'firstTimeUser',
                  ParamType.bool,
                ),
                tribeUID: params.getParam(
                  'tribeUID',
                  ParamType.int,
                ),
                fullName: params.getParam(
                  'fullName',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: 'ExistingUser',
              path: 'existingUser',
              builder: (context, params) => ExistingUserWidget(
                email: params.getParam(
                  'email',
                  ParamType.String,
                ),
                name: params.getParam(
                  'name',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: 'PostView',
              path: 'postView',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => PostViewWidget(
                postID: params.getParam(
                  'postID',
                  ParamType.int,
                ),
                hasLiked: params.getParam(
                  'hasLiked',
                  ParamType.bool,
                ),
                pageSource: params.getParam(
                  'pageSource',
                  ParamType.String,
                ),
                completed: params.getParam(
                  'completed',
                  ParamType.bool,
                ),
                video: params.getParam(
                  'video',
                  ParamType.String,
                ),
                type: params.getParam(
                  'type',
                  ParamType.String,
                ),
                contentURI: params.getParam(
                  'contentURI',
                  ParamType.String,
                ),
                descriptionPlain: params.getParam(
                  'descriptionPlain',
                  ParamType.String,
                ),
                featuredImage: params.getParam(
                  'featuredImage',
                  ParamType.String,
                ),
                title: params.getParam(
                  'title',
                  ParamType.String,
                ),
                userPic: params.getParam(
                  'userPic',
                  ParamType.String,
                ),
                userName: params.getParam(
                  'userName',
                  ParamType.String,
                ),
                chatEnabled: params.getParam(
                  'chatEnabled',
                  ParamType.bool,
                ),
                likeCount: params.getParam(
                  'likeCount',
                  ParamType.int,
                ),
                commentCount: params.getParam(
                  'commentCount',
                  ParamType.int,
                ),
                commentFocus: params.getParam(
                  'commentFocus',
                  ParamType.bool,
                ),
                userId: params.getParam(
                  'userId',
                  ParamType.int,
                ),
                descriptionHtml: params.getParam(
                  'descriptionHtml',
                  ParamType.String,
                ),
                groupSlug: params.getParam(
                  'groupSlug',
                  ParamType.String,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupList',
              path: 'groupList',
              requireAuth: true,
              builder: (context, params) => GroupListWidget(),
            ),
            FFRoute(
              name: 'entryRedirect',
              path: 'entryRedirect',
              builder: (context, params) => EntryRedirectWidget(),
            ),
            FFRoute(
              name: 'GroupsToday',
              path: 'groupsToday',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsTodayWidget(
                openTab: params.getParam(
                  'openTab',
                  ParamType.int,
                ),
                activeGroupTab: params.getParam(
                  'activeGroupTab',
                  ParamType.String,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsReplay',
              path: 'groupsReplay',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsReplayWidget(
                openTab: params.getParam(
                  'openTab',
                  ParamType.int,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsNextSteps',
              path: 'groupsNextSteps',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsNextStepsWidget(
                groupName: params.getParam(
                  'groupName',
                  ParamType.String,
                ),
                groupCoverImg: params.getParam(
                  'groupCoverImg',
                  ParamType.String,
                ),
                currentUserRole: params.getParam(
                  'currentUserRole',
                  ParamType.String,
                ),
                groupSlug: params.getParam(
                  'groupSlug',
                  ParamType.String,
                ),
                groupId: params.getParam(
                  'groupId',
                  ParamType.int,
                ),
                openTab: params.getParam(
                  'openTab',
                  ParamType.int,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
                groupRef: params.getParam(
                  'groupRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['TribeGroups'],
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsCommunity_FB',
              path: 'groupsCommunityFB',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsCommunityFBWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'EditGroupAdmin',
              path: 'editGroupAdmin',
              builder: (context, params) => EditGroupAdminWidget(
                groupRef: params.getParam(
                  'groupRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['TribeGroups'],
                ),
                isEdit: params.getParam(
                  'isEdit',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupContent',
              path: 'groupContent',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupContentWidget(
                collectionRef: params.getParam(
                  'collectionRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['TribeCollections'],
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'DiscussionPost',
              path: 'discussionPost',
              requireAuth: true,
              asyncParams: {
                'broadcastDoc':
                    getDoc(['broadcasts'], BroadcastsRecord.fromSnapshot),
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DiscussionPostWidget(
                broadcastDoc: params.getParam(
                  'broadcastDoc',
                  ParamType.Document,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
                isEditMode: params.getParam(
                  'isEditMode',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: 'StartBroadcast_FB',
              path: 'startBroadcastFB',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => StartBroadcastFBWidget(
                title: params.getParam(
                  'title',
                  ParamType.String,
                ),
                description: params.getParam(
                  'description',
                  ParamType.String,
                ),
                sendNotification: params.getParam(
                  'sendNotification',
                  ParamType.bool,
                ),
                notificationTitle: params.getParam(
                  'notificationTitle',
                  ParamType.String,
                ),
                notificationMessage: params.getParam(
                  'notificationMessage',
                  ParamType.String,
                ),
                category: params.getParam<String>(
                  'category',
                  ParamType.String,
                  isList: true,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
                broadcast: params.getParam(
                  'broadcast',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['broadcasts'],
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsTraining',
              path: 'groupsTraining',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsTrainingWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'updateApp',
              path: 'updateApp',
              builder: (context, params) => UpdateAppWidget(),
            ),
            FFRoute(
              name: 'ReturningRedirect',
              path: 'ReturningRedirect',
              builder: (context, params) => ReturningRedirectWidget(),
            ),
            FFRoute(
              name: 'DiscussionPostRedirect',
              path: 'discussionPostRedirect',
              requireAuth: true,
              builder: (context, params) => DiscussionPostRedirectWidget(
                broadcastRef: params.getParam(
                  'broadcastRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['broadcasts'],
                ),
              ),
            ),
            FFRoute(
              name: 'UploadTest',
              path: 'uploadTest',
              builder: (context, params) => UploadTestWidget(),
            ),
            FFRoute(
              name: 'ExploreGroups',
              path: 'exploreGroups',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => ExploreGroupsWidget(
                openTab: params.getParam(
                  'openTab',
                  ParamType.int,
                ),
                activeGroupTab: params.getParam(
                  'activeGroupTab',
                  ParamType.String,
                ),
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'DashboardContent',
              path: 'Content',
              builder: (context, params) => DashboardContentWidget(),
            ),
            FFRoute(
              name: 'DashboardMembers',
              path: 'Dashboard/Members',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardMembersWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsEvents2',
              path: 'groupsEvents2',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsEvents2Widget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'DashboardFeed',
              path: 'Dashboard/Feed',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardFeedWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'SearchieTest',
              path: 'searchieTest',
              builder: (context, params) => SearchieTestWidget(),
            ),
            FFRoute(
              name: 'PostingTransition',
              path: 'postingTransition',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => PostingTransitionWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'PostViewUserAdmin',
              path: 'postViewUserAdmin',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => PostViewUserAdminWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
                courseDoc: params.getParam(
                  'courseDoc',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['TribeCourse'],
                ),
              ),
            ),
            FFRoute(
              name: 'coursesList',
              path: 'coursesList',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => CoursesListWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'PostViewMobileContent',
              path: 'postViewMobileContent',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
                'courseDoc':
                    getDoc(['TribeCourse'], TribeCourseRecord.fromSnapshot),
                'collectionDoc': getDoc(
                    ['TribeCollection'], TribeCollectionRecord.fromSnapshot),
                'contentDoc':
                    getDoc(['TribeContent'], TribeContentRecord.fromSnapshot),
              },
              builder: (context, params) => PostViewMobileContentWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
                courseDoc: params.getParam(
                  'courseDoc',
                  ParamType.Document,
                ),
                collectionDoc: params.getParam(
                  'collectionDoc',
                  ParamType.Document,
                ),
                contentDoc: params.getParam(
                  'contentDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsChatbot',
              path: 'groupsChatbot',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsChatbotWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'notifications',
              path: 'Notifications',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => NotificationsWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'groupMembersList',
              path: 'groupMembersList',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupMembersListWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'chat_2_Details',
              path: 'chat2Details',
              asyncParams: {
                'chatRef': getDoc(['direct_messages_chat'],
                    DirectMessagesChatRecord.fromSnapshot),
              },
              builder: (context, params) => Chat2DetailsWidget(
                chatRef: params.getParam(
                  'chatRef',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'chat_2_main',
              path: 'chat2Main',
              asyncParams: {
                'chat': getDoc(['direct_messages_chat'],
                    DirectMessagesChatRecord.fromSnapshot),
              },
              builder: (context, params) => Chat2MainWidget(
                chat: params.getParam(
                  'chat',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'chat_2_InviteUsers',
              path: 'chat2InviteUsers',
              asyncParams: {
                'chatRef': getDoc(['direct_messages_chat'],
                    DirectMessagesChatRecord.fromSnapshot),
              },
              builder: (context, params) => Chat2InviteUsersWidget(
                chatRef: params.getParam(
                  'chatRef',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'image_Details',
              path: 'imageDetails',
              asyncParams: {
                'chatMessage': getDoc(
                    ['direct_messages'], DirectMessagesRecord.fromSnapshot),
              },
              builder: (context, params) => ImageDetailsWidget(
                chatMessage: params.getParam(
                  'chatMessage',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'DashboardPlatformSettings',
              path: 'Dashboard/Platform',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardPlatformSettingsWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'DashboardUsers',
              path: 'Dashboard/Users',
              builder: (context, params) => DashboardUsersWidget(),
            ),
            FFRoute(
              name: 'DashboardTickets',
              path: 'Dashboard/Tickets',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardTicketsWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'Courses',
              path: 'courses',
              builder: (context, params) => CoursesWidget(),
            ),
            FFRoute(
              name: 'DashboardGroupSettings',
              path: 'Dashboard/GroupSettings',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardGroupSettingsWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupsCommunity_Announcements',
              path: 'groupsCommunityAnnouncements',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupsCommunityAnnouncementsWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'Download',
              path: 'download',
              builder: (context, params) => DownloadWidget(),
            ),
            FFRoute(
              name: 'DashboardAdminReply',
              path: 'Dashboard/AdminReply',
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => DashboardAdminReplyWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'GroupNEWCHAT',
              path: 'chat',
              requireAuth: true,
              asyncParams: {
                'groupDoc':
                    getDoc(['TribeGroups'], TribeGroupsRecord.fromSnapshot),
              },
              builder: (context, params) => GroupNEWCHATWidget(
                groupDoc: params.getParam(
                  'groupDoc',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'Page-NewChat',
              path: 'pageNewChat',
              builder: (context, params) => PageNewChatWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/entryRedirect';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
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
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
