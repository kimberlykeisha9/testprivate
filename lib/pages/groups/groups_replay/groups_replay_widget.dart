import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'groups_replay_model.dart';
export 'groups_replay_model.dart';

class GroupsReplayWidget extends StatefulWidget {
  const GroupsReplayWidget({
    super.key,
    int? openTab,
    this.groupDoc,
  }) : this.openTab = openTab ?? 0;

  final int openTab;
  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupsReplayWidget> createState() => _GroupsReplayWidgetState();
}

class _GroupsReplayWidgetState extends State<GroupsReplayWidget>
    with TickerProviderStateMixin {
  late GroupsReplayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupsReplayModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupsReplay'});
    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
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
                          Icons.groups_rounded,
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'GROUPS_REPLAY_groups_rounded_ICN_ON_TAP');
                          logFirebaseEvent('IconButton_drawer');
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onLongPress: () async {
                        logFirebaseEvent(
                            'GROUPS_REPLAY_Image_eo5gfdnu_ON_LONG_PRE');
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
                              'GROUPS_REPLAY_PAGE_Text_qtq06o38_ON_TAP');
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
        body: Container(
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
                tabletLandscape: false,
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
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: FutureBuilder<List<TribeCollectionsRecord>>(
                    future: queryTribeCollectionsRecordOnce(
                      queryBuilder: (tribeCollectionsRecord) =>
                          tribeCollectionsRecord.where(
                        'groupRefs',
                        arrayContains: widget!.groupDoc?.reference,
                      ),
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
                      List<TribeCollectionsRecord>
                          bodyContainerTribeCollectionsRecordList =
                          snapshot.data!;

                      return Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        constraints: BoxConstraints(
                          maxWidth: 1000.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
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
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Builder(
                                            builder: (context) {
                                              final collectionsChildren =
                                                  bodyContainerTribeCollectionsRecordList
                                                      .where((e) =>
                                                          !valueOrDefault<bool>(
                                                            e.hasTribecollectionID(),
                                                            false,
                                                          ))
                                                      .toList()
                                                      .sortedList(
                                                          keyOf: (e) =>
                                                              e.publishDate!,
                                                          desc: true)
                                                      .toList();
                                              if (collectionsChildren.isEmpty) {
                                                return EmptyListWidget();
                                              }

                                              return ListView.builder(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  16.0,
                                                  0,
                                                  0,
                                                ),
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    collectionsChildren.length,
                                                itemBuilder: (context,
                                                    collectionsChildrenIndex) {
                                                  final collectionsChildrenItem =
                                                      collectionsChildren[
                                                          collectionsChildrenIndex];
                                                  return Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  0.0,
                                                                  15.0,
                                                                  15.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 40.0,
                                                              color: Color(
                                                                  0x337090B0),
                                                              offset: Offset(
                                                                0.0,
                                                                16.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Visibility(
                                                          visible:
                                                              valueOrDefault<
                                                                  bool>(
                                                            functions.shouldDisplayContent(
                                                                collectionsChildrenItem
                                                                    .publishDate
                                                                    ?.toString(),
                                                                collectionsChildrenItem
                                                                    .endDate
                                                                    ?.toString()),
                                                            false,
                                                          ),
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
                                                                  'GROUPS_REPLAY_PAGE_Row_g52e6559_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Row_navigate_to');

                                                              context.pushNamed(
                                                                'GroupContent',
                                                                queryParameters:
                                                                    {
                                                                  'collectionRef':
                                                                      serializeParam(
                                                                    collectionsChildrenItem
                                                                        .reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
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
                                                                      widget!
                                                                          .groupDoc,
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            0),
                                                                  ),
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      if (collectionsChildrenItem.featuredImage ==
                                                                              null ||
                                                                          collectionsChildrenItem.featuredImage ==
                                                                              '')
                                                                        Hero(
                                                                          tag: widget!
                                                                              .groupDoc!
                                                                              .featuredImg,
                                                                          transitionOnUserGestures:
                                                                              true,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(10.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(10.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              widget!.groupDoc!.featuredImg,
                                                                              width: 160.0,
                                                                              height: 100.0,
                                                                              fit: BoxFit.cover,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.jpg',
                                                                                width: 160.0,
                                                                                height: 100.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      Hero(
                                                                        tag: collectionsChildrenItem
                                                                            .featuredImage,
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(10.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(10.0),
                                                                            topRight:
                                                                                Radius.circular(0.0),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 500),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 500),
                                                                            imageUrl:
                                                                                collectionsChildrenItem.featuredImage,
                                                                            width:
                                                                                160.0,
                                                                            height:
                                                                                100.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorWidget: (context, error, stackTrace) =>
                                                                                Image.asset(
                                                                              'assets/images/error_image.jpg',
                                                                              width: 160.0,
                                                                              height: 100.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (responsiveVisibility(
                                                                        context:
                                                                            context,
                                                                        phone:
                                                                            false,
                                                                        tablet:
                                                                            false,
                                                                        tabletLandscape:
                                                                            false,
                                                                        desktop:
                                                                            false,
                                                                      ))
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('GROUPS_REPLAY_PAGE_Text_hq7hctl3_ON_TAP');
                                                                              },
                                                                              child: AutoSizeText(
                                                                                'EDIT',
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Open Sans',
                                                                                      color: FlutterFlowTheme.of(context).grayIcon,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          dateTimeFormat(
                                                                              "yMMMd",
                                                                              collectionsChildrenItem.publishDate!),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                color: FlutterFlowTheme.of(context).grayIcon,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FontStyle.italic,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          collectionsChildrenItem
                                                                              .title,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                fontSize: 17.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        if (collectionsChildrenItem.commentCount >
                                                                            0)
                                                                          RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: collectionsChildrenItem.commentCount.toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                      ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: ' comments',
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                      ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              3.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 3.0, 0.0),
                                                                                child: Icon(
                                                                                  Icons.remove_red_eye,
                                                                                  color: FlutterFlowTheme.of(context).gray600,
                                                                                  size: 13.0,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  formatNumber(
                                                                                    collectionsChildrenItem.totalViews,
                                                                                    formatType: FormatType.decimal,
                                                                                    decimalType: DecimalType.automatic,
                                                                                  ),
                                                                                  '0',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      color: FlutterFlowTheme.of(context).gray600,
                                                                                      fontSize: 13.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
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
                                                },
                                              ).animateOnPageLoad(animationsMap[
                                                  'listViewOnPageLoadAnimation']!);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 15.0, 0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.groupSidebarModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GroupSidebarWidget(
                                          groupDoc: widget!.groupDoc!,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
