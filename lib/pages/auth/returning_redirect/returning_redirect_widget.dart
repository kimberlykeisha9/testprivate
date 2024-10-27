import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'returning_redirect_model.dart';
export 'returning_redirect_model.dart';

class ReturningRedirectWidget extends StatefulWidget {
  const ReturningRedirectWidget({super.key});

  @override
  State<ReturningRedirectWidget> createState() =>
      _ReturningRedirectWidgetState();
}

class _ReturningRedirectWidgetState extends State<ReturningRedirectWidget>
    with TickerProviderStateMixin {
  late ReturningRedirectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReturningRedirectModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ReturningRedirect'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      logFirebaseEvent('RETURNING_REDIRECT_ReturningRedirect_ON_');
      if (FFAppState().currentGroup != null) {
        logFirebaseEvent('ReturningRedirect_backend_call');

        await currentUserReference!.update(createUserRecordData(
          lastLoginTime: getCurrentTimestamp,
        ));
        logFirebaseEvent('ReturningRedirect_backend_call');
        _model.currentGroupRead =
            await TribeGroupsRecord.getDocumentOnce(FFAppState().currentGroup!);
        logFirebaseEvent('ReturningRedirect_action_block');
        await action_blocks.groupTabRedirect(
          context,
          groupDoc: _model.currentGroupRead,
        );
      } else {
        logFirebaseEvent('ReturningRedirect_navigate_to');

        context.pushNamed('GroupList');

        return;
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 8000.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
    context.watch<FFAppState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).alternate,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    Lottie.asset(
                      'assets/jsons/spinningglobe.json',
                      width: 800.0,
                      height: 500.0,
                      fit: BoxFit.contain,
                      animate: true,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: BoxDecoration(
                          color: Color(0xCA262D34),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          valueOrDefault<String>(
                            functions.stringToImgPath(
                                getRemoteConfigString('AppLogoIcon')),
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/xc7g2rrbk8z7/Tribe_Icon_2023_Clear.png',
                          ),
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation']!),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 300.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'RETURNING_REDIRECT_Text_q4u6os8t_ON_TAP');
                          logFirebaseEvent('Text_auth');
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth('entryRedirect', context.mounted);
                        },
                        child: Text(
                          'Sign out and try again',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['textOnPageLoadAnimation']!),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
