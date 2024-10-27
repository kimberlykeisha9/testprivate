import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'notifications_model.dart';
export 'notifications_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'notifications'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NOTIFICATIONS_notifications_ON_INIT_STAT');
      logFirebaseEvent('notifications_wait__delay');
      await Future.delayed(const Duration(milliseconds: 500));
      logFirebaseEvent('notifications_firestore_query');
      _model.recentNotifications = await queryNotificationsRecordOnce(
        queryBuilder: (notificationsRecord) =>
            notificationsRecord.orderBy('time_created', descending: true),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('notifications_backend_call');

      await currentUserReference!.update(createUserRecordData(
        lastNotificationReadTime: _model.recentNotifications?.timeCreated,
      ));
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: responsiveVisibility(
                  context: context,
                  desktop: false,
                ) &&
                (MediaQuery.sizeOf(context).width < 768.0)
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('NOTIFICATIONS_PAGE_Icon_wj40eouv_ON_TAP');
                    logFirebaseEvent('Icon_navigate_back');
                    context.safePop();
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: FlutterFlowTheme.of(context).accent1,
                    size: 30.0,
                  ),
                ),
                title: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 300),
                  fadeOutDuration: Duration(milliseconds: 300),
                  imageUrl: valueOrDefault<String>(
                    functions
                        .stringToImgPath(getRemoteConfigString('AppLogoDark')),
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/lg0etvjtmesz/Tribe_2023_TM_Dark_trim.png',
                  ),
                  width: 100.0,
                  fit: BoxFit.fitWidth,
                ),
                actions: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                      child: wrapWithModel(
                        model: _model.profileButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ProfileButtonWidget(),
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
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
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    constraints: BoxConstraints(
                      maxWidth: 700.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Notifications',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleMediumFamily),
                                ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              child: RefreshIndicator(
                                onRefresh: () async {},
                                child: PagedListView<DocumentSnapshot<Object?>?,
                                    NotificationsRecord>.separated(
                                  pagingController:
                                      _model.setListViewController(
                                    NotificationsRecord.collection
                                        .where(
                                          'UserRefList',
                                          arrayContains: currentUserReference,
                                        )
                                        .where(
                                          'time_created',
                                          isLessThanOrEqualTo:
                                              getCurrentTimestamp,
                                        )
                                        .orderBy('time_created',
                                            descending: true),
                                  ),
                                  padding: EdgeInsets.zero,
                                  reverse: false,
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 15.0),
                                  builderDelegate: PagedChildBuilderDelegate<
                                      NotificationsRecord>(
                                    // Customize what your widget looks like when it's loading the first page.
                                    firstPageProgressIndicatorBuilder: (_) =>
                                        Center(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: SizedBox(
                                          width: 40.0,
                                          height: 40.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .appBG,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Customize what your widget looks like when it's loading another page.
                                    newPageProgressIndicatorBuilder: (_) =>
                                        Center(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: SizedBox(
                                          width: 40.0,
                                          height: 40.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .appBG,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    noItemsFoundIndicatorBuilder: (_) =>
                                        EmptyListWidget(),
                                    itemBuilder: (context, _, listViewIndex) {
                                      final listViewNotificationsRecord = _model
                                          .listViewPagingController!
                                          .itemList![listViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 8.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'NOTIFICATIONS_Column_ht59qz8c_ON_TAP');
                                            var _shouldSetState = false;
                                            // Update read status
                                            logFirebaseEvent(
                                                'Column_Updatereadstatus');

                                            await listViewNotificationsRecord
                                                .reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'viewedBy':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                },
                                              ),
                                            });
                                            if (listViewNotificationsRecord
                                                .hasDiscussionPostRef()) {
                                              // Get discussion data
                                              logFirebaseEvent(
                                                  'Column_Getdiscussiondata');
                                              _model.postDetails =
                                                  await BroadcastsRecord
                                                      .getDocumentOnce(
                                                          listViewNotificationsRecord
                                                              .discussionPostRef!);
                                              _shouldSetState = true;
                                              logFirebaseEvent(
                                                  'Column_firestore_query');
                                              _model.discussionGroup =
                                                  await queryTribeGroupsRecordOnce(
                                                queryBuilder:
                                                    (tribeGroupsRecord) =>
                                                        tribeGroupsRecord.where(
                                                  'tribeGroupID',
                                                  isEqualTo: _model
                                                      .postDetails?.groupId,
                                                ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              _shouldSetState = true;
                                              logFirebaseEvent(
                                                  'Column_navigate_to');

                                              context.pushNamed(
                                                'DiscussionPost',
                                                queryParameters: {
                                                  'broadcastDoc':
                                                      serializeParam(
                                                    _model.postDetails,
                                                    ParamType.Document,
                                                  ),
                                                  'groupDoc': serializeParam(
                                                    _model.discussionGroup,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'broadcastDoc':
                                                      _model.postDetails,
                                                  'groupDoc':
                                                      _model.discussionGroup,
                                                },
                                              );
                                            } else if (listViewNotificationsRecord
                                                .hasTribeCollectionsRef()) {
                                              logFirebaseEvent(
                                                  'Column_backend_call');
                                              _model.contentDetails =
                                                  await TribeCollectionsRecord
                                                      .getDocumentOnce(
                                                          listViewNotificationsRecord
                                                              .tribeCollectionsRef!);
                                              _shouldSetState = true;
                                              logFirebaseEvent(
                                                  'Column_navigate_to');

                                              context.pushNamed(
                                                'GroupContent',
                                                queryParameters: {
                                                  'collectionRef':
                                                      serializeParam(
                                                    _model.contentDetails
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'groupDoc': serializeParam(
                                                    widget!.groupDoc,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'groupDoc': widget!.groupDoc,
                                                },
                                              );
                                            } else {
                                              if (_shouldSetState)
                                                safeSetState(() {});
                                              return;
                                            }

                                            if (_shouldSetState)
                                              safeSetState(() {});
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (!valueOrDefault<bool>(
                                                    listViewNotificationsRecord
                                                        .viewedBy
                                                        .contains(
                                                            currentUserReference),
                                                    false,
                                                  ))
                                                    Container(
                                                      width: 12.0,
                                                      height: 12.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  Flexible(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  listViewNotificationsRecord
                                                                      .title,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        lineHeight:
                                                                            1.0,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  listViewNotificationsRecord
                                                                      .description,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                        "relative",
                                                                        listViewNotificationsRecord
                                                                            .timeCreated!),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent2,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        if (valueOrDefault<
                                                            bool>(
                                                          valueOrDefault<bool>(
                                                                listViewNotificationsRecord
                                                                        .tribeCollectionsRef !=
                                                                    null,
                                                                false,
                                                              ) ||
                                                              valueOrDefault<
                                                                  bool>(
                                                                listViewNotificationsRecord
                                                                        .discussionPostRef !=
                                                                    null,
                                                                false,
                                                              ),
                                                          false,
                                                        ))
                                                          Icon(
                                                            Icons
                                                                .chevron_right_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 24.0,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1.0,
                                                indent: 10.0,
                                                endIndent: 10.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(height: 16.0))
                          .around(SizedBox(height: 16.0)),
                    ),
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
