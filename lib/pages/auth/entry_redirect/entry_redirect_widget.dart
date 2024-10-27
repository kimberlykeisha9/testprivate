import '/auth/base_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'entry_redirect_model.dart';
export 'entry_redirect_model.dart';

class EntryRedirectWidget extends StatefulWidget {
  const EntryRedirectWidget({super.key});

  @override
  State<EntryRedirectWidget> createState() => _EntryRedirectWidgetState();
}

class _EntryRedirectWidgetState extends State<EntryRedirectWidget>
    with TickerProviderStateMixin {
  late EntryRedirectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EntryRedirectModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'entryRedirect'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      logFirebaseEvent('ENTRY_REDIRECT_entryRedirect_ON_INIT_STA');
      if (!loggedIn) {
        logFirebaseEvent('entryRedirect_navigate_to');
        if (Navigator.of(context).canPop()) {
          context.pop();
        }
        context.pushNamed('EntryPage');
      }
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).alternate,
        body: SafeArea(
          top: true,
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
                FaIcon(
                  FontAwesomeIcons.redo,
                  color: FlutterFlowTheme.of(context).grayIcon,
                  size: 45.0,
                ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
