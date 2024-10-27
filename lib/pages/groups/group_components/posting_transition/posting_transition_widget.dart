import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'posting_transition_model.dart';
export 'posting_transition_model.dart';

class PostingTransitionWidget extends StatefulWidget {
  const PostingTransitionWidget({
    super.key,
    required this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<PostingTransitionWidget> createState() =>
      _PostingTransitionWidgetState();
}

class _PostingTransitionWidgetState extends State<PostingTransitionWidget>
    with TickerProviderStateMixin {
  late PostingTransitionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostingTransitionModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PostingTransition'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('POSTING_TRANSITION_PostingTransition_ON_');
      logFirebaseEvent('PostingTransition_wait__delay');
      await Future.delayed(const Duration(milliseconds: 600));
      logFirebaseEvent('PostingTransition_navigate_to');
      if (Navigator.of(context).canPop()) {
        context.pop();
      }
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
        },
      );
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 1200.0.ms,
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rotate_right,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  size: 40.0,
                ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
                Text(
                  'Posting...',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
