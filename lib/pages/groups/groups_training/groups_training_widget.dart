import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/group_training_list/group_training_list_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'groups_training_model.dart';
export 'groups_training_model.dart';

class GroupsTrainingWidget extends StatefulWidget {
  const GroupsTrainingWidget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupsTrainingWidget> createState() => _GroupsTrainingWidgetState();
}

class _GroupsTrainingWidgetState extends State<GroupsTrainingWidget>
    with TickerProviderStateMixin {
  late GroupsTrainingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupsTrainingModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupsTraining'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('GROUPS_TRAINING_GroupsTraining_ON_INIT_S');
      logFirebaseEvent('GroupsTraining_refresh_database_request');
      safeSetState(() => _model.apiRequestCompleter = null);
    });

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
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
                title: Visibility(
                  visible: responsiveVisibility(
                    context: context,
                    tabletLandscape: false,
                    desktop: false,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'GROUPS_TRAINING_PAGE_groups_ICN_ON_TAP');
                            logFirebaseEvent('IconButton_drawer');
                            scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                      ),
                      Flexible(
                        child: Image.network(
                          widget!.groupDoc!.featuredImg,
                          width: 100.0,
                          height: 50.0,
                          fit: BoxFit.contain,
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
                                'GROUPS_TRAINING_Text_nhixrcal_ON_TAP');
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
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (responsiveVisibility(
                                        context: context,
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
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 15.0, 15.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Your Progress',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmallFamily,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmallFamily),
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) =>
                                            FutureBuilder<ApiCallResponse>(
                                          future: (_model
                                                      .apiRequestCompleter ??=
                                                  Completer<ApiCallResponse>()
                                                    ..complete(
                                                        GetGroupCollectionsCall
                                                            .call(
                                                      token: valueOrDefault(
                                                          currentUserDocument
                                                              ?.tribeToken,
                                                          ''),
                                                      slug: widget!
                                                          .groupDoc?.groupSlug,
                                                      baseURL:
                                                          getRemoteConfigString(
                                                              'AppBaseApiUrl'),
                                                      itemsPerPage: 375,
                                                    )))
                                              .future,
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .appBG,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final listViewGetGroupCollectionsResponse =
                                                snapshot.data!;

                                            return Builder(
                                              builder: (context) {
                                                final groupCollection =
                                                    getJsonField(
                                                  listViewGetGroupCollectionsResponse
                                                      .jsonBody,
                                                  r'''$.items''',
                                                ).toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      groupCollection.length,
                                                  itemBuilder: (context,
                                                      groupCollectionIndex) {
                                                    final groupCollectionItem =
                                                        groupCollection[
                                                            groupCollectionIndex];
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (groupCollectionIndex ==
                                                            0)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        0.0,
                                                                        15.0,
                                                                        12.0),
                                                            child:
                                                                LinearPercentIndicator(
                                                              percent: functions
                                                                  .returnProgressMath(
                                                                      getJsonField(
                                                                        listViewGetGroupCollectionsResponse
                                                                            .jsonBody,
                                                                        r'''$.totalCompletedCount''',
                                                                      ).toString(),
                                                                      getJsonField(
                                                                        listViewGetGroupCollectionsResponse
                                                                            .jsonBody,
                                                                        r'''$.totalContentCount''',
                                                                      ).toString())!,
                                                              lineHeight: 20.0,
                                                              animation: true,
                                                              animateFromLastPercent:
                                                                  true,
                                                              progressColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .accent4,
                                                              center: Text(
                                                                functions.returnProgressPercent(
                                                                    getJsonField(
                                                                      listViewGetGroupCollectionsResponse
                                                                          .jsonBody,
                                                                      r'''$.totalCompletedCount''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      listViewGetGroupCollectionsResponse
                                                                          .jsonBody,
                                                                      r'''$.totalContentCount''',
                                                                    ).toString())!,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineSmallFamily,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineSmallFamily),
                                                                    ),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                          ),
                                                        wrapWithModel(
                                                          model: _model
                                                              .groupTrainingListModels
                                                              .getModel(
                                                            getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.id''',
                                                            ).toString(),
                                                            groupCollectionIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          updateOnChange: true,
                                                          child:
                                                              GroupTrainingListWidget(
                                                            key: Key(
                                                              'Key32c_${getJsonField(
                                                                groupCollectionItem,
                                                                r'''$.id''',
                                                              ).toString()}',
                                                            ),
                                                            groupId: widget!
                                                                .groupDoc
                                                                ?.tribeGroupID,
                                                            groupSlug: widget!
                                                                .groupDoc
                                                                ?.groupSlug,
                                                            contents:
                                                                getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.Contents''',
                                                              true,
                                                            )!,
                                                            collectionName:
                                                                getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            collectionDescription:
                                                                getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.descriptionPlain''',
                                                            ).toString(),
                                                            totalItems:
                                                                getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.totalCount''',
                                                            ),
                                                            completedItems:
                                                                getJsonField(
                                                              groupCollectionItem,
                                                              r'''$.userCompletedCount''',
                                                            ),
                                                            groupDoc: widget!
                                                                .groupDoc!,
                                                            showThumbnails:
                                                                true,
                                                            showContentTitleOnly:
                                                                false,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ).animateOnPageLoad(animationsMap[
                                                    'listViewOnPageLoadAnimation']!);
                                              },
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
                          SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
