import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bottom_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/explore_groups_c_t_a/explore_groups_c_t_a_widget.dart';
import 'dart:math';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_list_model.dart';
export 'group_list_model.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({super.key});

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget>
    with TickerProviderStateMixin {
  late GroupListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupListModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'GroupList'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('GROUP_LIST_PAGE_GroupList_ON_INIT_STATE');
      if (loggedIn) {
        logFirebaseEvent('GroupList_custom_action');
        await actions.triggerAppTrackingPermissionDialog();
      } else {
        logFirebaseEvent('GroupList_navigate_to');

        context.pushNamed('EntryPage');

        return;
      }

      logFirebaseEvent('GroupList_wait__delay');
      await Future.delayed(const Duration(milliseconds: 1200));
      logFirebaseEvent('GroupList_update_app_state');
      FFAppState().userGroupsID =
          (currentUserDocument?.tribeGroups?.toList() ?? [])
              .map((e) => e.tribeGroupID)
              .toList()
              .toList()
              .cast<int>();
      safeSetState(() {});
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.0, 10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'gridViewOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.0, 10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'gridViewOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 45.0,
                      icon: Icon(
                        Icons.refresh,
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent('GROUP_LIST_PAGE_refresh_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed('ReturningRedirect');
                      },
                    ),
                    CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeOutDuration: Duration(milliseconds: 300),
                      imageUrl: valueOrDefault<String>(
                        functions.stringToImgPath(
                            getRemoteConfigString('AppLogoDark')),
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/lg0etvjtmesz/Tribe_2023_TM_Dark_trim.png',
                      ),
                      width: 90.0,
                      fit: BoxFit.contain,
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      child: wrapWithModel(
                        model: _model.topWebNavModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TopWebNavWidget(),
                      ),
                    ),
                ],
              ),
            Flexible(
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: StreamBuilder<List<TribeGroupsRecord>>(
                  stream: queryTribeGroupsRecord(
                    queryBuilder: (tribeGroupsRecord) =>
                        tribeGroupsRecord.orderBy('position'),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).appBG,
                            ),
                          ),
                        ),
                      );
                    }
                    List<TribeGroupsRecord> bodyContainerTribeGroupsRecordList =
                        snapshot.data!;

                    return Container(
                      width: 1000.0,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Builder(
                                      builder: (context) {
                                        if (getRemoteConfigBool(
                                            'isGroupTypeEnabled')) {
                                          return Builder(
                                            builder: (context) {
                                              if ((currentUserDocument
                                                              ?.tribeGroups
                                                              ?.toList() ??
                                                          [])
                                                      .length !=
                                                  0) {
                                                return Builder(
                                                  builder: (context) {
                                                    final groupTypeChild = functions
                                                        .convertJsonToListString(
                                                            getRemoteConfigString(
                                                                'GroupTypes'))
                                                        .toList();

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          groupTypeChild.length,
                                                          (groupTypeChildIndex) {
                                                        final groupTypeChildItem =
                                                            groupTypeChild[
                                                                groupTypeChildIndex];
                                                        return Visibility(
                                                          visible: bodyContainerTribeGroupsRecordList
                                                              .where((e) =>
                                                                  e.groupType
                                                                      .contains(
                                                                          groupTypeChildItem) &&
                                                                  FFAppState()
                                                                      .userGroupsID
                                                                      .contains(
                                                                          e.tribeGroupID))
                                                              .toList()
                                                              .isNotEmpty,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        0.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          25.0,
                                                                          0.0,
                                                                          15.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          groupTypeChildItem,
                                                                          'Member Education Center',
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineLarge
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).headlineLargeFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineLargeFamily),
                                                                            ),
                                                                      ).animateOnPageLoad(
                                                                          animationsMap[
                                                                              'textOnPageLoadAnimation1']!),
                                                                      if (getRemoteConfigBool(
                                                                              'Feature_AllowExploreGroups') &&
                                                                          (groupTypeChildIndex ==
                                                                              0))
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              15.0,
                                                                              0.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              logFirebaseEvent('GROUP_LIST_EXPLORE_ALL_GROUPS_BTN_ON_TAP');
                                                                              logFirebaseEvent('Button_navigate_to');

                                                                              context.pushNamed('ExploreGroups');
                                                                            },
                                                                            text:
                                                                                'Explore ${getRemoteConfigString('Copy_Groups')}',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              height: 40.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                    color: Colors.white,
                                                                                    fontSize: 15.0,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final categoryGroupsChild = bodyContainerTribeGroupsRecordList
                                                                          .where((e) =>
                                                                              e.groupType.contains(groupTypeChildItem) &&
                                                                              FFAppState().userGroupsID.contains(e.tribeGroupID))
                                                                          .toList();
                                                                      if (categoryGroupsChild
                                                                          .isEmpty) {
                                                                        return ExploreGroupsCTAWidget();
                                                                      }

                                                                      return GridView
                                                                          .builder(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        gridDelegate:
                                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 2;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 2;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 3;
                                                                            } else {
                                                                              return 3;
                                                                            }
                                                                          }(),
                                                                          crossAxisSpacing:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 14.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 18.0;
                                                                            } else {
                                                                              return 10.0;
                                                                            }
                                                                          }(),
                                                                          mainAxisSpacing:
                                                                              12.0,
                                                                          childAspectRatio:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 1.2;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 1.3;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 1.3;
                                                                            } else {
                                                                              return 1.1;
                                                                            }
                                                                          }(),
                                                                        ),
                                                                        primary:
                                                                            false,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            categoryGroupsChild.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                categoryGroupsChildIndex) {
                                                                          final categoryGroupsChildItem =
                                                                              categoryGroupsChild[categoryGroupsChildIndex];
                                                                          return InkWell(
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
                                                                              logFirebaseEvent('GROUP_LIST_PAGE_Column_872du3wt_ON_TAP');
                                                                              logFirebaseEvent('Column_action_block');
                                                                              await action_blocks.groupTabRedirect(
                                                                                context,
                                                                                groupDoc: categoryGroupsChildItem,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Material(
                                                                                  color: Colors.transparent,
                                                                                  elevation: 0.0,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                  ),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          blurRadius: 20.0,
                                                                                          color: Color(0x337090B0),
                                                                                          offset: Offset(
                                                                                            0.0,
                                                                                            8.0,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                                    ),
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        if (responsiveVisibility(
                                                                                          context: context,
                                                                                          phone: false,
                                                                                          tablet: false,
                                                                                        ))
                                                                                          ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                            child: CachedNetworkImage(
                                                                                              fadeInDuration: Duration(milliseconds: 500),
                                                                                              fadeOutDuration: Duration(milliseconds: 500),
                                                                                              imageUrl: categoryGroupsChildItem.featuredImg,
                                                                                              width: 360.0,
                                                                                              height: 168.0,
                                                                                              fit: BoxFit.cover,
                                                                                              errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                                'assets/images/error_image.jpg',
                                                                                                width: 360.0,
                                                                                                height: 168.0,
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        if (responsiveVisibility(
                                                                                          context: context,
                                                                                          tabletLandscape: false,
                                                                                          desktop: false,
                                                                                        ))
                                                                                          ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                            child: CachedNetworkImage(
                                                                                              fadeInDuration: Duration(milliseconds: 300),
                                                                                              fadeOutDuration: Duration(milliseconds: 300),
                                                                                              imageUrl: categoryGroupsChildItem.featuredImg,
                                                                                              width: 175.0,
                                                                                              height: 100.0,
                                                                                              fit: BoxFit.cover,
                                                                                              errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                                'assets/images/error_image.jpg',
                                                                                                width: 175.0,
                                                                                                height: 100.0,
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                    child: AutoSizeText(
                                                                                      categoryGroupsChildItem.name,
                                                                                      textAlign: TextAlign.start,
                                                                                      maxLines: 1,
                                                                                      minFontSize: 14.0,
                                                                                      style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                                            lineHeight: 1.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                if ((categoryGroupsChildItem.description != null && categoryGroupsChildItem.description != '') &&
                                                                                    responsiveVisibility(
                                                                                      context: context,
                                                                                      phone: false,
                                                                                      tablet: false,
                                                                                    ))
                                                                                  Text(
                                                                                    categoryGroupsChildItem.description,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).animateOnPageLoad(
                                                                          animationsMap[
                                                                              'gridViewOnPageLoadAnimation1']!);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return wrapWithModel(
                                                  model: _model
                                                      .exploreGroupsCTAModel1,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      ExploreGroupsCTAWidget(),
                                                );
                                              }
                                            },
                                          );
                                        } else {
                                          return Builder(
                                            builder: (context) {
                                              if ((currentUserDocument
                                                              ?.tribeGroups
                                                              ?.toList() ??
                                                          [])
                                                      .length !=
                                                  0) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      25.0,
                                                                      0.0,
                                                                      15.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'My ${getRemoteConfigString('Copy_Groups')}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineLargeFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineLargeFamily),
                                                                    ),
                                                              ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'textOnPageLoadAnimation2']!),
                                                              if (getRemoteConfigBool(
                                                                  'Feature_AllowExploreGroups'))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'GROUP_LIST_EXPLORE_ALL_GROUPS_BTN_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Button_navigate_to');

                                                                      context.pushNamed(
                                                                          'ExploreGroups');
                                                                    },
                                                                    text:
                                                                        'Explore ${getRemoteConfigString('Copy_Groups')}',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleSmallFamily,
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final allGroupsChild = bodyContainerTribeGroupsRecordList
                                                                  .where((e) => FFAppState()
                                                                      .userGroupsID
                                                                      .contains(
                                                                          e.tribeGroupID))
                                                                  .toList();
                                                              if (allGroupsChild
                                                                  .isEmpty) {
                                                                return ExploreGroupsCTAWidget();
                                                              }

                                                              return GridView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                gridDelegate:
                                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 2;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 2;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return 3;
                                                                    } else {
                                                                      return 3;
                                                                    }
                                                                  }(),
                                                                  crossAxisSpacing:
                                                                      () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 10.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 14.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return 18.0;
                                                                    } else {
                                                                      return 10.0;
                                                                    }
                                                                  }(),
                                                                  mainAxisSpacing:
                                                                      12.0,
                                                                  childAspectRatio:
                                                                      () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 1.2;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 1.3;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return 1.3;
                                                                    } else {
                                                                      return 1.1;
                                                                    }
                                                                  }(),
                                                                ),
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    allGroupsChild
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        allGroupsChildIndex) {
                                                                  final allGroupsChildItem =
                                                                      allGroupsChild[
                                                                          allGroupsChildIndex];
                                                                  return InkWell(
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
                                                                          'GROUP_LIST_PAGE_Column_d2yv9e78_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Column_action_block');
                                                                      await action_blocks
                                                                          .groupTabRedirect(
                                                                        context,
                                                                        groupDoc:
                                                                            allGroupsChildItem,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              0.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  blurRadius: 20.0,
                                                                                  color: Color(0x337090B0),
                                                                                  offset: Offset(
                                                                                    0.0,
                                                                                    8.0,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  phone: false,
                                                                                  tablet: false,
                                                                                ))
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                    child: CachedNetworkImage(
                                                                                      fadeInDuration: Duration(milliseconds: 500),
                                                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                                                      imageUrl: allGroupsChildItem.featuredImg,
                                                                                      width: 360.0,
                                                                                      height: 168.0,
                                                                                      fit: BoxFit.cover,
                                                                                      errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                        'assets/images/error_image.jpg',
                                                                                        width: 360.0,
                                                                                        height: 168.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  tabletLandscape: false,
                                                                                  desktop: false,
                                                                                ))
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                    child: CachedNetworkImage(
                                                                                      fadeInDuration: Duration(milliseconds: 300),
                                                                                      fadeOutDuration: Duration(milliseconds: 300),
                                                                                      imageUrl: allGroupsChildItem.featuredImg,
                                                                                      width: 175.0,
                                                                                      height: 100.0,
                                                                                      fit: BoxFit.cover,
                                                                                      errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                        'assets/images/error_image.jpg',
                                                                                        width: 175.0,
                                                                                        height: 100.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Flexible(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                AutoSizeText(
                                                                              allGroupsChildItem.name,
                                                                              textAlign: TextAlign.start,
                                                                              maxLines: 1,
                                                                              minFontSize: 14.0,
                                                                              style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                                    lineHeight: 1.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if ((allGroupsChildItem.description != null &&
                                                                                allGroupsChildItem.description != '') &&
                                                                            responsiveVisibility(
                                                                              context: context,
                                                                              phone: false,
                                                                              tablet: false,
                                                                            ))
                                                                          Text(
                                                                            allGroupsChildItem.description,
                                                                            maxLines:
                                                                                2,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'gridViewOnPageLoadAnimation2']!);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return wrapWithModel(
                                                  model: _model
                                                      .exploreGroupsCTAModel2,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      ExploreGroupsCTAWidget(),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
              wrapWithModel(
                model: _model.bottomNavModel,
                updateCallback: () => safeSetState(() {}),
                child: BottomNavWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
