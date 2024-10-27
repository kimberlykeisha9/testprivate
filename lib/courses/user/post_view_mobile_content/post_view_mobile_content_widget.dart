import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/user/content_display_dialog/content_display_dialog_widget.dart';
import '/courses/user/group_training_list_user/group_training_list_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'post_view_mobile_content_model.dart';
export 'post_view_mobile_content_model.dart';

class PostViewMobileContentWidget extends StatefulWidget {
  const PostViewMobileContentWidget({
    super.key,
    required this.groupDoc,
    required this.courseDoc,
    required this.collectionDoc,
    required this.contentDoc,
  });

  final TribeGroupsRecord? groupDoc;
  final TribeCourseRecord? courseDoc;
  final TribeCollectionRecord? collectionDoc;
  final TribeContentRecord? contentDoc;

  @override
  State<PostViewMobileContentWidget> createState() =>
      _PostViewMobileContentWidgetState();
}

class _PostViewMobileContentWidgetState
    extends State<PostViewMobileContentWidget> {
  late PostViewMobileContentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostViewMobileContentModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PostViewMobileContent'});
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: StreamBuilder<List<TribeCollectionRecord>>(
          stream: queryTribeCollectionRecord(
            queryBuilder: (tribeCollectionRecord) => tribeCollectionRecord
                .where(
                  'tribeCourseRef',
                  isEqualTo: widget!.courseDoc?.reference,
                )
                .orderBy('position'),
            limit: 10,
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
            List<TribeCollectionRecord> drawerTribeCollectionRecordList =
                snapshot.data!;

            return Drawer(
              elevation: 16.0,
              child: WebViewAware(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 42.0, 4.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget!.courseDoc?.title,
                              'Course title',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleLargeFamily,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleLargeFamily),
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                widget!.courseDoc!.featuredImage,
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                                alignment: Alignment(0.0, 0.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) =>
                                  StreamBuilder<List<TribeContentRecord>>(
                                stream: queryTribeContentRecord(
                                  queryBuilder: (tribeContentRecord) =>
                                      tribeContentRecord.where(
                                    'tribeCourseRef',
                                    isEqualTo: widget!.courseDoc?.reference,
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context).appBG,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<TribeContentRecord>
                                      progressBarTribeContentRecordList =
                                      snapshot.data!;

                                  return LinearPercentIndicator(
                                    percent: valueOrDefault<double>(
                                      valueOrDefault<int>(
                                            functions
                                                .filterContentIDs(
                                                    (currentUserDocument
                                                                ?.contentCompletedIDs
                                                                ?.toList() ??
                                                            [])
                                                        .where((e) => e > 0)
                                                        .toList(),
                                                    progressBarTribeContentRecordList
                                                        .toList())
                                                .unique((e) => e)
                                                .length,
                                            0,
                                          ) /
                                          widget!.courseDoc!.contentIDs.length,
                                      0.0,
                                    ),
                                    width: 260.0,
                                    lineHeight: 24.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).primary,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    center: Text(
                                      valueOrDefault<String>(
                                        formatNumber(
                                          valueOrDefault<int>(
                                                functions
                                                    .filterContentIDs(
                                                        (currentUserDocument
                                                                    ?.contentCompletedIDs
                                                                    ?.toList() ??
                                                                [])
                                                            .where((e) => e > 0)
                                                            .toList(),
                                                        progressBarTribeContentRecordList
                                                            .toList())
                                                    .unique((e) => e)
                                                    .length,
                                                0,
                                              ) /
                                              widget!
                                                  .courseDoc!.contentIDs.length,
                                          formatType: FormatType.percent,
                                        ),
                                        '0%',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily),
                                          ),
                                    ),
                                    barRadius: Radius.circular(32.0),
                                    padding: EdgeInsets.zero,
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            'Your Progress',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                          Builder(
                            builder: (context) {
                              final userCollectionChildren =
                                  drawerTribeCollectionRecordList.toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: userCollectionChildren.length,
                                itemBuilder:
                                    (context, userCollectionChildrenIndex) {
                                  final userCollectionChildrenItem =
                                      userCollectionChildren[
                                          userCollectionChildrenIndex];
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      GroupTrainingListUserWidget(
                                        key: Key(
                                            'Keyst8_${userCollectionChildrenIndex}_of_${userCollectionChildren.length}'),
                                        collectionDoc:
                                            userCollectionChildrenItem,
                                        contentCallback:
                                            (contentDoc, contentRef) async {
                                          logFirebaseEvent(
                                              'POST_VIEW_MOBILE_CONTENT_Container_st8gm');
                                          logFirebaseEvent(
                                              'groupTrainingListUser_navigate_to');

                                          context.goNamed(
                                            'PostViewMobileContent',
                                            queryParameters: {
                                              'groupDoc': serializeParam(
                                                widget!.groupDoc,
                                                ParamType.Document,
                                              ),
                                              'courseDoc': serializeParam(
                                                widget!.courseDoc,
                                                ParamType.Document,
                                              ),
                                              'collectionDoc': serializeParam(
                                                userCollectionChildrenItem,
                                                ParamType.Document,
                                              ),
                                              'contentDoc': serializeParam(
                                                contentDoc,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'groupDoc': widget!.groupDoc,
                                              'courseDoc': widget!.courseDoc,
                                              'collectionDoc':
                                                  userCollectionChildrenItem,
                                              'contentDoc': contentDoc,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        appBar: responsiveVisibility(
                  context: context,
                  desktop: false,
                ) &&
                (MediaQuery.sizeOf(context).width < kBreakpointSmall)
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 50.0,
                      icon: Icon(
                        Icons.menu_open_rounded,
                        color: FlutterFlowTheme.of(context).accent1,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'POST_VIEW_MOBILE_CONTENT_menu_open_round');
                        logFirebaseEvent('IconButton_drawer');
                        scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget!.contentDoc?.title,
                            'Content title',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineMediumFamily),
                              ),
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
                elevation: 0.0,
              )
            : null,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              wrapWithModel(
                model: _model.groupNavigationModel,
                updateCallback: () => safeSetState(() {}),
                child: GroupNavigationWidget(
                  groupDoc: widget!.groupDoc!,
                ),
              ),
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.contentDisplayDialogModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ContentDisplayDialogWidget(
                      pageSource: 'content',
                      contentDoc: widget!.contentDoc!,
                      groupDoc: widget!.groupDoc,
                      courseDoc: widget!.courseDoc!,
                      collectionDoc: widget!.collectionDoc!,
                      completedCallback: () async {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
