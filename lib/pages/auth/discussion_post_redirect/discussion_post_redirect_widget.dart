import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'discussion_post_redirect_model.dart';
export 'discussion_post_redirect_model.dart';

class DiscussionPostRedirectWidget extends StatefulWidget {
  const DiscussionPostRedirectWidget({
    super.key,
    required this.broadcastRef,
  });

  final DocumentReference? broadcastRef;

  @override
  State<DiscussionPostRedirectWidget> createState() =>
      _DiscussionPostRedirectWidgetState();
}

class _DiscussionPostRedirectWidgetState
    extends State<DiscussionPostRedirectWidget> with TickerProviderStateMixin {
  late DiscussionPostRedirectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiscussionPostRedirectModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DiscussionPostRedirect'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DISCUSSION_POST_REDIRECT_DiscussionPostR');
      logFirebaseEvent('DiscussionPostRedirect_backend_call');
      _model.getBroadcastDoc =
          await BroadcastsRecord.getDocumentOnce(widget!.broadcastRef!);
      logFirebaseEvent('DiscussionPostRedirect_firestore_query');
      _model.groupDoc = await queryTribeGroupsRecordOnce(
        queryBuilder: (tribeGroupsRecord) => tribeGroupsRecord.where(
          'tribeGroupID',
          isEqualTo: _model.getBroadcastDoc?.groupId,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('DiscussionPostRedirect_navigate_to');

      context.pushNamed(
        'DiscussionPost',
        queryParameters: {
          'broadcastDoc': serializeParam(
            _model.getBroadcastDoc,
            ParamType.Document,
          ),
          'groupDoc': serializeParam(
            _model.groupDoc,
            ParamType.Document,
          ),
        }.withoutNulls,
        extra: <String, dynamic>{
          'broadcastDoc': _model.getBroadcastDoc,
          'groupDoc': _model.groupDoc,
        },
      );
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
                        CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 300),
                          imageUrl: valueOrDefault<String>(
                            functions.stringToImgPath(
                                getRemoteConfigString('AppLogoIcon')),
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/xc7g2rrbk8z7/Tribe_Icon_2023_Clear.png',
                          ),
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation']!),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Text(
                            'Connecting...',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                      ],
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
