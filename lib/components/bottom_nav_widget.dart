import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_model.dart';
export 'bottom_nav_model.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget>
    with TickerProviderStateMixin {
  late BottomNavModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 100.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.0, 22.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 18.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });

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
      width: double.infinity,
      height: 110.0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x00FFFFFF), Color(0x80FFFFFF)],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 90.0,
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Container(
                          width: double.infinity,
                          height: 88.0,
                          decoration: BoxDecoration(
                            color: Color(0xD8FFFFFF),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final menuItem = FFAppState().menuItems.toList();

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(menuItem.length,
                                  (menuItemIndex) {
                                final menuItemItem = menuItem[menuItemIndex];
                                return Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 4.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'BOTTOM_NAV_COMP_menu_item_ON_TAP');
                                              if (menuItemItem == 'Feed') {
                                              } else if (menuItemItem ==
                                                  'Groups') {
                                                logFirebaseEvent(
                                                    'menu_item_navigate_to');

                                                context.pushNamed('GroupList');
                                              } else if (menuItemItem ==
                                                  'Support') {
                                                logFirebaseEvent(
                                                    'menu_item_launch_u_r_l');
                                                await launchURL(
                                                    'https://www.828support.com/');
                                              } else if (menuItemItem ==
                                                  'My Profile') {
                                                logFirebaseEvent(
                                                    'menu_item_navigate_to');

                                                context.pushNamed('profile');
                                              }

                                              logFirebaseEvent(
                                                  'menu_item_update_app_state');
                                              FFAppState().menuActiveItem =
                                                  menuItemItem;
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: double.infinity,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (responsiveVisibility(
                                                          context: context,
                                                          phone: false,
                                                          tablet: false,
                                                          tabletLandscape:
                                                              false,
                                                        ))
                                                          Container(
                                                            width: 1.0,
                                                            height: 7.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                          ),
                                                        Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            Container(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        12.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                  )
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                children: [
                                                                  if (menuItemItem ==
                                                                      'Feed')
                                                                    Icon(
                                                                      Icons
                                                                          .chat,
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        menuItemItem ==
                                                                                FFAppState().menuActiveItem
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (menuItemItem ==
                                                                      'Groups')
                                                                    Icon(
                                                                      Icons
                                                                          .groups,
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        menuItemItem ==
                                                                                FFAppState().menuActiveItem
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (menuItemItem ==
                                                                      'Support')
                                                                    Icon(
                                                                      Icons
                                                                          .help,
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        menuItemItem ==
                                                                                FFAppState().menuActiveItem
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (menuItemItem ==
                                                                      'My Profile')
                                                                    Icon(
                                                                      Icons
                                                                          .person_sharp,
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        menuItemItem ==
                                                                                FFAppState().menuActiveItem
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          menuItemItem,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmallFamily,
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  menuItemItem ==
                                                                          FFAppState()
                                                                              .menuActiveItem
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .displaySmallFamily),
                                                              ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'textOnPageLoadAnimation']!),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 65.0,
                                        height: 6.0,
                                        decoration: BoxDecoration(
                                          color: valueOrDefault<Color>(
                                            menuItemItem ==
                                                    FFAppState().menuActiveItem
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation2']!),
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
