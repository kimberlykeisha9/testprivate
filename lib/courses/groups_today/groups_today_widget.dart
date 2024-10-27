import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/create_content_admin/create_content_admin_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'dart:math';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'groups_today_model.dart';
export 'groups_today_model.dart';

class GroupsTodayWidget extends StatefulWidget {
  const GroupsTodayWidget({
    super.key,
    int? openTab,
    String? activeGroupTab,
    this.groupDoc,
  })  : this.openTab = openTab ?? 0,
        this.activeGroupTab = activeGroupTab ?? 'Today';

  final int openTab;
  final String activeGroupTab;
  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupsTodayWidget> createState() => _GroupsTodayWidgetState();
}

class _GroupsTodayWidgetState extends State<GroupsTodayWidget>
    with TickerProviderStateMixin {
  late GroupsTodayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupsTodayModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'GroupsToday'});
    animationsMap.addAll({
      'columnOnPageLoadAnimation1': AnimationInfo(
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
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 500.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 500.0.ms,
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
        backgroundColor: FlutterFlowTheme.of(context).appBG,
        drawer: Drawer(
          elevation: 16.0,
          child: WebViewAware(
            child: wrapWithModel(
              model: _model.groupListDrawerContentModel,
              updateCallback: () => safeSetState(() {}),
              child: GroupListDrawerContentWidget(),
            ),
          ),
        ),
        appBar: responsiveVisibility(
                  context: context,
                  desktop: false,
                ) &&
                (MediaQuery.sizeOf(context).width < 768.0)
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 0.0,
                        buttonSize: 45.0,
                        icon: Icon(
                          Icons.groups,
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'GROUPS_TODAY_PAGE_groups_ICN_ON_TAP');
                          logFirebaseEvent('IconButton_drawer');
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onLongPress: () async {
                          logFirebaseEvent(
                              'GROUPS_TODAY_Image_p1yxpd69_ON_LONG_PRES');
                          logFirebaseEvent('Image_update_app_state');
                          FFAppState().deleteUserID();
                          FFAppState().userID = 0;

                          FFAppState().deleteCurrentUserGroupList();
                          FFAppState().currentUserGroupList = [];

                          FFAppState().update(() {});
                          logFirebaseEvent('Image_auth');
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          logFirebaseEvent('Image_navigate_to');

                          context.pushNamedAuth('EntryPage', context.mounted);
                        },
                        child: Image.network(
                          widget!.groupDoc!.featuredImg,
                          width: 100.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'GROUPS_TODAY_PAGE_Text_xvn8f645_ON_TAP');
                          logFirebaseEvent('Text_navigate_to');

                          context.pushNamed(
                            'EditGroupAdmin',
                            queryParameters: {
                              'groupRef': serializeParam(
                                widget!.groupDoc?.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Text(
                          'EDIT GROUP',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ),
                    wrapWithModel(
                      model: _model.profileButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileButtonWidget(),
                    ),
                  ],
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: wrapWithModel(
                      model: _model.topWebNavModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TopWebNavWidget(
                        groupDoc: widget!.groupDoc,
                      ),
                    ),
                  ),
                Flexible(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    constraints: BoxConstraints(
                      maxWidth: 1000.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      tablet: false,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      wrapWithModel(
                                        model: _model.groupNavigationModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GroupNavigationWidget(
                                          groupDoc: widget!.groupDoc!,
                                        ),
                                      ),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) => Text(
                                                      'Welcome back, ${currentUserDisplayName}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelLargeFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                if (widget!.groupDoc
                                                            ?.headlineText !=
                                                        null &&
                                                    widget!.groupDoc
                                                            ?.headlineText !=
                                                        '')
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 15.0),
                                                    child: Text(
                                                      widget!.groupDoc!
                                                          .headlineText,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily),
                                                                lineHeight: 1.1,
                                                              ),
                                                    ),
                                                  ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (widget!.groupDoc
                                                                ?.featuredVideo !=
                                                            null &&
                                                        widget!.groupDoc
                                                                ?.featuredVideo !=
                                                            '')
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    0.0,
                                                                    0.0),
                                                        child:
                                                            FlutterFlowVideoPlayer(
                                                          path: functions
                                                              .retVidPath(widget!
                                                                  .groupDoc
                                                                  ?.featuredVideo),
                                                          videoType:
                                                              VideoType.network,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.9,
                                                          autoPlay: false,
                                                          looping: false,
                                                          showControls: true,
                                                          allowFullScreen:
                                                              false,
                                                          allowPlaybackSpeedMenu:
                                                              false,
                                                          lazyLoad: false,
                                                        ),
                                                      ),
                                                    if (widget!.groupDoc
                                                                ?.headlineBtnUrl !=
                                                            null &&
                                                        widget!.groupDoc
                                                                ?.headlineBtnUrl !=
                                                            '')
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'GROUPS_TODAY_LEARN_MORE_ABOUT_THE_WISDOM');
                                                            logFirebaseEvent(
                                                                'Button_launch_u_r_l');
                                                            await launchURL(widget!
                                                                .groupDoc!
                                                                .headlineBtnUrl);
                                                          },
                                                          text: widget!
                                                              .groupDoc!
                                                              .headlineBtnText,
                                                          options:
                                                              FFButtonOptions(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelLargeFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).labelLargeFamily),
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 0.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          showLoadingIndicator:
                                                              false,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation1']!),
                                            Padding(
                                              padding: EdgeInsets.all(25.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final nextSteps = widget!
                                                              .groupDoc
                                                              ?.nextSteps
                                                              ?.toList() ??
                                                          [];

                                                      return MasonryGridView
                                                          .builder(
                                                        gridDelegate:
                                                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                        ),
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0,
                                                        itemCount:
                                                            nextSteps.length,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context,
                                                            nextStepsIndex) {
                                                          final nextStepsItem =
                                                              nextSteps[
                                                                  nextStepsIndex];
                                                          return Visibility(
                                                            visible: nextStepsItem
                                                                .featureOnToday,
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'GROUPS_TODAY_PAGE_Image_knblk9la_ON_TAP');
                                                                if (functions
                                                                    .isExternalUrl(
                                                                        nextStepsItem
                                                                            .ctaLink)) {
                                                                  logFirebaseEvent(
                                                                      'Image_launch_u_r_l');
                                                                  await launchURL(
                                                                      nextStepsItem
                                                                          .ctaLink);
                                                                } else {
                                                                  if (nextStepsItem
                                                                          .ctaLink ==
                                                                      'Events') {
                                                                    logFirebaseEvent(
                                                                        'Image_navigate_to');

                                                                    context
                                                                        .pushNamed(
                                                                      'GroupsEvents2',
                                                                      queryParameters:
                                                                          {
                                                                        'groupDoc':
                                                                            serializeParam(
                                                                          widget!
                                                                              .groupDoc,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'groupDoc':
                                                                            widget!.groupDoc,
                                                                      },
                                                                    );
                                                                  } else {
                                                                    if (nextStepsItem
                                                                            .ctaLink ==
                                                                        'Replays') {
                                                                      logFirebaseEvent(
                                                                          'Image_navigate_to');

                                                                      context
                                                                          .pushNamed(
                                                                        'GroupsReplay',
                                                                        queryParameters:
                                                                            {
                                                                          'groupDoc':
                                                                              serializeParam(
                                                                            widget!.groupDoc,
                                                                            ParamType.Document,
                                                                          ),
                                                                        }.withoutNulls,
                                                                        extra: <String,
                                                                            dynamic>{
                                                                          'groupDoc':
                                                                              widget!.groupDoc,
                                                                        },
                                                                      );
                                                                    } else {
                                                                      if (nextStepsItem
                                                                              .ctaLink ==
                                                                          'Training') {
                                                                        logFirebaseEvent(
                                                                            'Image_navigate_to');

                                                                        context
                                                                            .pushNamed(
                                                                          'GroupsTraining',
                                                                          queryParameters:
                                                                              {
                                                                            'groupDoc':
                                                                                serializeParam(
                                                                              widget!.groupDoc,
                                                                              ParamType.Document,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            'groupDoc':
                                                                                widget!.groupDoc,
                                                                          },
                                                                        );
                                                                      } else {
                                                                        if (nextStepsItem.ctaLink ==
                                                                            'NextSteps') {
                                                                          logFirebaseEvent(
                                                                              'Image_navigate_to');

                                                                          context
                                                                              .pushNamed(
                                                                            'GroupsNextSteps',
                                                                            queryParameters:
                                                                                {
                                                                              'groupRef': serializeParam(
                                                                                widget!.groupDoc?.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                              'groupDoc': serializeParam(
                                                                                widget!.groupDoc,
                                                                                ParamType.Document,
                                                                              ),
                                                                            }.withoutNulls,
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              'groupDoc': widget!.groupDoc,
                                                                            },
                                                                          );
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                              child:
                                                                  CachedNetworkImage(
                                                                fadeInDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            500),
                                                                fadeOutDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            500),
                                                                imageUrl:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  nextStepsItem
                                                                      .featuredImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/ud9hnylna4th/100x-Hero-app.png',
                                                                ),
                                                                width: 170.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'containerOnPageLoadAnimation']!),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 25.0, 15.0, 10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    if (widget!.groupDoc
                                                                ?.sessionHeadlineText !=
                                                            null &&
                                                        widget!.groupDoc
                                                                ?.sessionHeadlineText !=
                                                            '')
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Text(
                                                            widget!.groupDoc!
                                                                .sessionHeadlineText,
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleLargeFamily),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                          valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.userRole,
                                                                  '') ==
                                                              'admin',
                                                          false,
                                                        ) &&
                                                        responsiveVisibility(
                                                          context: context,
                                                          phone: false,
                                                          tablet: false,
                                                          tabletLandscape:
                                                              false,
                                                          desktop: false,
                                                        ))
                                                      AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            FlutterFlowIconButton(
                                                          borderColor: Colors
                                                              .transparent,
                                                          borderRadius: 30.0,
                                                          borderWidth: 1.0,
                                                          buttonSize: 45.0,
                                                          fillColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .black600,
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBtnText,
                                                            size: 25.0,
                                                          ),
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'GROUPS_TODAY_PAGE_add_ICN_ON_TAP');
                                                            logFirebaseEvent(
                                                                'IconButton_update_app_state');
                                                            FFAppState()
                                                                .uploaded = '';
                                                            safeSetState(() {});
                                                            logFirebaseEvent(
                                                                'IconButton_bottom_sheet');
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              barrierColor: Color(
                                                                  0x00000000),
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return WebViewAware(
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () =>
                                                                        FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.8,
                                                                        child:
                                                                            CreateContentAdminWidget(
                                                                          authorRef:
                                                                              currentUserReference,
                                                                          groupRef: widget!
                                                                              .groupDoc
                                                                              ?.reference,
                                                                          isEdit:
                                                                              false,
                                                                          title:
                                                                              '',
                                                                          groupId: widget!
                                                                              .groupDoc
                                                                              ?.tribeGroupID,
                                                                          publishDateTime:
                                                                              getCurrentTimestamp,
                                                                          enableTodo:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                        ),
                                                      ),
                                                  ],
                                                ).animateOnPageLoad(animationsMap[
                                                    'rowOnPageLoadAnimation']!),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        if (responsiveVisibility(
                                                          context: context,
                                                          phone: false,
                                                          tablet: false,
                                                          tabletLandscape:
                                                              false,
                                                          desktop: false,
                                                        ))
                                                          FutureBuilder<
                                                              List<
                                                                  TribeCollectionsRecord>>(
                                                            future:
                                                                queryTribeCollectionsRecordOnce(
                                                              queryBuilder: (tribeCollectionsRecord) =>
                                                                  tribeCollectionsRecord
                                                                      .where(
                                                                        'groupRef',
                                                                        isEqualTo: widget!
                                                                            .groupDoc
                                                                            ?.reference,
                                                                      )
                                                                      .orderBy(
                                                                          'publishDate'),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .appBG,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<TribeCollectionsRecord>
                                                                  listViewTribeCollectionsRecordList =
                                                                  snapshot
                                                                      .data!;
                                                              if (listViewTribeCollectionsRecordList
                                                                  .isEmpty) {
                                                                return EmptyListWidget();
                                                              }

                                                              return ListView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    listViewTribeCollectionsRecordList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        listViewIndex) {
                                                                  final listViewTribeCollectionsRecord =
                                                                      listViewTribeCollectionsRecordList[
                                                                          listViewIndex];
                                                                  return Visibility(
                                                                    visible:
                                                                        valueOrDefault<
                                                                            bool>(
                                                                      functions.isPublishDateToday(
                                                                          listViewTribeCollectionsRecord
                                                                              .publishDate),
                                                                      false,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'GROUPS_TODAY_Container_z9t0wm4p_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Container_navigate_to');

                                                                          context
                                                                              .pushNamed(
                                                                            'GroupContent',
                                                                            queryParameters:
                                                                                {
                                                                              'collectionRef': serializeParam(
                                                                                listViewTribeCollectionsRecord.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                              'groupDoc': serializeParam(
                                                                                widget!.groupDoc,
                                                                                ParamType.Document,
                                                                              ),
                                                                            }.withoutNulls,
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              'groupDoc': widget!.groupDoc,
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.9,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).white,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Stack(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    children: [
                                                                                      ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                        child: CachedNetworkImage(
                                                                                          fadeInDuration: Duration(milliseconds: 500),
                                                                                          fadeOutDuration: Duration(milliseconds: 500),
                                                                                          imageUrl: listViewTribeCollectionsRecord.featuredImage,
                                                                                          width: double.infinity,
                                                                                          height: 225.0,
                                                                                          fit: BoxFit.cover,
                                                                                          errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                            'assets/images/error_image.jpg',
                                                                                            width: double.infinity,
                                                                                            height: 225.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      if (responsiveVisibility(
                                                                                        context: context,
                                                                                        phone: false,
                                                                                        tablet: false,
                                                                                        tabletLandscape: false,
                                                                                        desktop: false,
                                                                                      ))
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).customColor3,
                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 7.0, 0.0),
                                                                                            child: Text(
                                                                                              'LIVE NOW!',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: 24.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      FaIcon(
                                                                                        FontAwesomeIcons.solidPlayCircle,
                                                                                        color: Color(0x80E0E3E7),
                                                                                        size: 90.0,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                dateTimeFormat("relative", listViewTribeCollectionsRecord.publishDate!),
                                                                                                maxLines: 1,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Open Sans',
                                                                                                      color: FlutterFlowTheme.of(context).grayIcon,
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FontStyle.italic,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                listViewTribeCollectionsRecord.title,
                                                                                                textAlign: TextAlign.start,
                                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyLargeFamily),
                                                                                                      lineHeight: 1.1,
                                                                                                    ),
                                                                                              ),
                                                                                              AutoSizeText(
                                                                                                listViewTribeCollectionsRecord.description,
                                                                                                maxLines: 2,
                                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                                    ),
                                                                                              ),
                                                                                              RichText(
                                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                                text: TextSpan(
                                                                                                  children: [
                                                                                                    TextSpan(
                                                                                                      text: listViewTribeCollectionsRecord.commentCount.toString(),
                                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                                          ),
                                                                                                    ),
                                                                                                    TextSpan(
                                                                                                      text: ' comments',
                                                                                                      style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelSmallFamily),
                                                                                                          ),
                                                                                                    )
                                                                                                  ],
                                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                        fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                                        letterSpacing: 0.0,
                                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        if (responsiveVisibility(
                                                                                          context: context,
                                                                                          phone: false,
                                                                                          tablet: false,
                                                                                          tabletLandscape: false,
                                                                                          desktop: false,
                                                                                        ))
                                                                                          FFButtonWidget(
                                                                                            onPressed: () {
                                                                                              print('Button pressed ...');
                                                                                            },
                                                                                            text: 'EDIT',
                                                                                            options: FFButtonOptions(
                                                                                              height: 40.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).black600,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                                    color: Colors.white,
                                                                                                    fontSize: 14.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                                                  ),
                                                                                              elevation: 2.0,
                                                                                              borderSide: BorderSide(
                                                                                                color: Colors.transparent,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                            showLoadingIndicator: false,
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      50.0),
                                                          child: StreamBuilder<
                                                              List<
                                                                  TribeCollectionsRecord>>(
                                                            stream:
                                                                queryTribeCollectionsRecord(
                                                              queryBuilder: (tribeCollectionsRecord) =>
                                                                  tribeCollectionsRecord
                                                                      .where(
                                                                        'groupRef',
                                                                        isEqualTo: widget!
                                                                            .groupDoc
                                                                            ?.reference,
                                                                      )
                                                                      .where(
                                                                        'publishDate',
                                                                        isGreaterThan:
                                                                            getCurrentTimestamp,
                                                                      )
                                                                      .orderBy(
                                                                          'publishDate'),
                                                              singleRecord:
                                                                  true,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/clear.png',
                                                                  ),
                                                                );
                                                              }
                                                              List<TribeCollectionsRecord>
                                                                  getNextItemTribeCollectionsRecordList =
                                                                  snapshot
                                                                      .data!;
                                                              // Return an empty Container when the item does not exist.
                                                              if (snapshot.data!
                                                                  .isEmpty) {
                                                                return Container();
                                                              }
                                                              final getNextItemTribeCollectionsRecord =
                                                                  getNextItemTribeCollectionsRecordList
                                                                          .isNotEmpty
                                                                      ? getNextItemTribeCollectionsRecordList
                                                                          .first
                                                                      : null;

                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 300.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'GROUPS_TODAY_PAGE_Column_f40ccssw_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Column_navigate_to');

                                                                      context
                                                                          .pushNamed(
                                                                        'GroupContent',
                                                                        queryParameters:
                                                                            {
                                                                          'collectionRef':
                                                                              serializeParam(
                                                                            getNextItemTribeCollectionsRecord?.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                          'groupDoc':
                                                                              serializeParam(
                                                                            widget!.groupDoc,
                                                                            ParamType.Document,
                                                                          ),
                                                                        }.withoutNulls,
                                                                        extra: <String,
                                                                            dynamic>{
                                                                          'groupDoc':
                                                                              widget!.groupDoc,
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          'NEXT UP:',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          getNextItemTribeCollectionsRecord!
                                                                              .title,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyLargeFamily),
                                                                              ),
                                                                        ),
                                                                        custom_widgets
                                                                            .CountdownTimer(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              150.0,
                                                                          endTime:
                                                                              getNextItemTribeCollectionsRecord!.publishDate!,
                                                                        ),
                                                                        Text(
                                                                          dateTimeFormat(
                                                                              "M/d h:mm a",
                                                                              getNextItemTribeCollectionsRecord!.publishDate!),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation2']!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            wrapWithModel(
                              model: _model.groupSidebarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: GroupSidebarWidget(
                                groupDoc: widget!.groupDoc!,
                              ),
                            ),
                        ],
                      ),
                    ),
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
