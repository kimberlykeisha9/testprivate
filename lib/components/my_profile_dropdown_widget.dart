import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_profile_dropdown_model.dart';
export 'my_profile_dropdown_model.dart';

class MyProfileDropdownWidget extends StatefulWidget {
  const MyProfileDropdownWidget({super.key});

  @override
  State<MyProfileDropdownWidget> createState() =>
      _MyProfileDropdownWidgetState();
}

class _MyProfileDropdownWidgetState extends State<MyProfileDropdownWidget> {
  late MyProfileDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyProfileDropdownModel());

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
      width: 180.0,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (getRemoteConfigBool('EnableDMinApp'))
              Container(
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'MY_PROFILE_DROPDOWN_COMP_inboxBtn_ON_TAP');
                        logFirebaseEvent('inboxBtn_navigate_to');

                        context.pushNamed(
                          'GroupNEWCHAT',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      text: 'Inbox',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 36.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFFFAFAFA),
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
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
                        hoverColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        hoverElevation: 0.0,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: badges.Badge(
                        badgeContent: Text(
                          '1',
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                        ),
                        showBadge: true,
                        shape: badges.BadgeShape.circle,
                        badgeColor: FlutterFlowTheme.of(context).primary,
                        elevation: 4.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                        position: badges.BadgePosition.topEnd(),
                        animationType: badges.BadgeAnimationType.scale,
                        toAnimate: true,
                      ),
                    ),
                  ],
                ),
              ),
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('MY_PROFILE_DROPDOWN_profileBtn_ON_TAP');
                logFirebaseEvent('profileBtn_navigate_to');

                context.pushNamed(
                  'profile',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                    ),
                  },
                );
              },
              text: 'Profile',
              options: FFButtonOptions(
                width: double.infinity,
                height: 36.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFFAFAFA),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                hoverElevation: 0.0,
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('MY_PROFILE_DROPDOWN_notificationsButton_');
                logFirebaseEvent('notificationsButton_navigate_to');

                context.pushNamed(
                  'notifications',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                    ),
                  },
                );
              },
              text: 'Notifications',
              options: FFButtonOptions(
                width: double.infinity,
                height: 36.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFFAFAFA),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                hoverElevation: 0.0,
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('MY_PROFILE_DROPDOWN_supportButton_ON_TAP');
                logFirebaseEvent('supportButton_launch_u_r_l');
                await launchURL(getRemoteConfigString('AppSupportUrl'));
              },
              text: 'Contact Support',
              options: FFButtonOptions(
                width: double.infinity,
                height: 36.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFFAFAFA),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                hoverElevation: 0.0,
              ),
            ),
            if (valueOrDefault(currentUserDocument?.userRole, '') == 'admin')
              AuthUserStreamWidget(
                builder: (context) => FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'MY_PROFILE_DROPDOWN_supportButton_ON_TAP');
                    logFirebaseEvent('supportButton_navigate_to');

                    context.pushNamed('DashboardPlatformSettings');
                  },
                  text: 'Admin Settings',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 36.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFFFAFAFA),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                    hoverElevation: 0.0,
                  ),
                ),
              ),
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('MY_PROFILE_DROPDOWN_signoutButton_ON_TAP');
                logFirebaseEvent('signoutButton_update_app_state');
                FFAppState().deleteCurrentUserGroupList();
                FFAppState().currentUserGroupList = [];

                logFirebaseEvent('signoutButton_auth');
                GoRouter.of(context).prepareAuthEvent();
                await authManager.signOut();
                GoRouter.of(context).clearRedirectLocation();

                context.goNamedAuth('entryRedirect', context.mounted);
              },
              text: 'Log out',
              options: FFButtonOptions(
                width: double.infinity,
                height: 36.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFFAFAFA),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                hoverElevation: 0.0,
              ),
            ),
          ].divide(SizedBox(height: 2.0)),
        ),
      ),
    );
  }
}
