import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_navigation_model.dart';
export 'group_navigation_model.dart';

class GroupNavigationWidget extends StatefulWidget {
  const GroupNavigationWidget({
    super.key,
    required this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupNavigationWidget> createState() => _GroupNavigationWidgetState();
}

class _GroupNavigationWidgetState extends State<GroupNavigationWidget> {
  late GroupNavigationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupNavigationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget!.groupDoc?.communityTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_community_ON_TAP');
                    logFirebaseEvent('community_navigate_to');

                    context.pushNamed(
                      'GroupsCommunity_FB',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('community_update_app_state');
                    FFAppState().ActiveGroupTab = 'Community';
                    safeSetState(() {});
                  },
                  text: valueOrDefault<String>(
                    getRemoteConfigString('Copy_Community'),
                    'Community',
                  ),
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Community'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.communityAdminOnlyTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_adminTab_ON_TAP');
                    logFirebaseEvent('adminTab_navigate_to');

                    context.pushNamed(
                      'GroupsCommunity_Announcements',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                      },
                    );

                    logFirebaseEvent('adminTab_update_app_state');
                    FFAppState().ActiveGroupTab = 'Announcements';
                    safeSetState(() {});
                  },
                  text: 'Announcements',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Announcements'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.todayTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_today_ON_TAP');
                    logFirebaseEvent('today_navigate_to');

                    context.pushNamed(
                      'GroupsToday',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('today_update_app_state');
                    FFAppState().ActiveGroupTab = 'Today';
                  },
                  text: 'Today',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Today'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.trainingTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_training_ON_TAP');
                    logFirebaseEvent('training_navigate_to');

                    context.pushNamed(
                      'GroupsTraining',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('training_update_app_state');
                    FFAppState().ActiveGroupTab = 'Training';
                    safeSetState(() {});
                  },
                  text: valueOrDefault<String>(
                    getRemoteConfigString('Copy_Training'),
                    'Training',
                  ),
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Training'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.coursesTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_courses_ON_TAP');
                    logFirebaseEvent('courses_navigate_to');

                    context.pushNamed(
                      'coursesList',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                      },
                    );

                    logFirebaseEvent('courses_update_app_state');
                    FFAppState().ActiveGroupTab = 'Courses';
                    safeSetState(() {});
                  },
                  text: 'Courses',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Courses'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.replayTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_replay_ON_TAP');
                    logFirebaseEvent('replay_navigate_to');

                    context.pushNamed(
                      'GroupsReplay',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('replay_update_app_state');
                    FFAppState().ActiveGroupTab = 'Replay';
                  },
                  text: 'Replays',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Replay'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.eventsTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_events_ON_TAP');
                    logFirebaseEvent('events_navigate_to');

                    context.pushNamed(
                      'GroupsEvents2',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('events_update_app_state');
                    FFAppState().ActiveGroupTab = 'Events';
                    safeSetState(() {});
                  },
                  text: 'Events',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Events'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.membersTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_members_ON_TAP');
                    logFirebaseEvent('members_navigate_to');

                    context.pushNamed(
                      'groupMembersList',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('members_update_app_state');
                    FFAppState().ActiveGroupTab = 'Members';
                    safeSetState(() {});
                  },
                  text: 'Members',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Members'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.chatbotTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_chatbot_ON_TAP');
                    logFirebaseEvent('chatbot_navigate_to');

                    context.pushNamed(
                      'GroupsChatbot',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('chatbot_update_app_state');
                    FFAppState().ActiveGroupTab = 'Chatbot';
                    safeSetState(() {});
                  },
                  text: widget!.groupDoc!.hasChatbotTabLabel()
                      ? widget!.groupDoc!.chatbotTabLabel
                      : 'Chatbot',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Chatbot'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (widget!.groupDoc?.nextStepsTabEnabled ?? true)
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('GROUP_NAVIGATION_COMP_nextSteps_ON_TAP');
                    logFirebaseEvent('nextSteps_navigate_to');

                    context.pushNamed(
                      'GroupsNextSteps',
                      queryParameters: {
                        'groupDoc': serializeParam(
                          widget!.groupDoc,
                          ParamType.Document,
                        ),
                        'groupId': serializeParam(
                          widget!.groupDoc?.tribeGroupID,
                          ParamType.int,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'groupDoc': widget!.groupDoc,
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );

                    logFirebaseEvent('nextSteps_update_app_state');
                    FFAppState().ActiveGroupTab = 'Next Steps';
                    safeSetState(() {});
                  },
                  text: 'Resources',
                  options: FFButtonOptions(
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FFAppState().ActiveGroupTab == 'Next Steps'
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                          lineHeight: 1.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  showLoadingIndicator: false,
                ),
              if (((valueOrDefault(currentUserDocument?.userRole, '') ==
                          'admin') ||
                      (valueOrDefault(currentUserDocument?.userRole, '') ==
                          'creator')) &&
                  (widget!.groupDoc != null))
                AuthUserStreamWidget(
                  builder: (context) => FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('GROUP_NAVIGATION_groupSettings_ON_TAP');
                      logFirebaseEvent('groupSettings_navigate_to');

                      context.pushNamed(
                        'DashboardGroupSettings',
                        queryParameters: {
                          'groupDoc': serializeParam(
                            widget!.groupDoc,
                            ParamType.Document,
                          ),
                        }.withoutNulls,
                        extra: <String, dynamic>{
                          'groupDoc': widget!.groupDoc,
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      logFirebaseEvent('groupSettings_update_app_state');
                      FFAppState().ActiveGroupTab = 'Settings';
                      safeSetState(() {});
                    },
                    text: 'Settings',
                    options: FFButtonOptions(
                      height: 36.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FFAppState().ActiveGroupTab == 'Next Steps'
                          ? FlutterFlowTheme.of(context).primaryBackground
                          : Colors.transparent,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelLargeFamily),
                            lineHeight: 1.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    showLoadingIndicator: false,
                  ),
                ),
            ]
                .divide(SizedBox(width: 4.0))
                .addToStart(SizedBox(width: 0.0))
                .addToEnd(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
