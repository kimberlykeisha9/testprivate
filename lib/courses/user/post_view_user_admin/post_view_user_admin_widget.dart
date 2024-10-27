import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/new_comment_component_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/progress_bar_with_text_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/course/admin_tab/content_edit_dialog/content_edit_dialog_widget.dart';
import '/courses/course/admin_tab/group_training_list_admin/group_training_list_admin_widget.dart';
import '/courses/course/admin_tab/module_edit_dialog/module_edit_dialog_widget.dart';
import '/courses/user/content_display_dialog/content_display_dialog_widget.dart';
import '/courses/user/group_training_list_user/group_training_list_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'post_view_user_admin_model.dart';
export 'post_view_user_admin_model.dart';

class PostViewUserAdminWidget extends StatefulWidget {
  const PostViewUserAdminWidget({
    super.key,
    required this.groupDoc,
    required this.courseDoc,
  });

  final TribeGroupsRecord? groupDoc;
  final DocumentReference? courseDoc;

  @override
  State<PostViewUserAdminWidget> createState() =>
      _PostViewUserAdminWidgetState();
}

class _PostViewUserAdminWidgetState extends State<PostViewUserAdminWidget> {
  late PostViewUserAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostViewUserAdminModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PostViewUserAdmin'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('POST_VIEW_USER_ADMIN_PostViewUserAdmin_O');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('PostViewUserAdmin_firestore_query');
          _model.isUserCoach = await queryMembersListRecordOnce(
            parent: widget!.courseDoc,
            queryBuilder: (membersListRecord) => membersListRecord
                .where(
                  'userRef',
                  isEqualTo: currentUserReference,
                )
                .where(
                  'role',
                  isEqualTo: 'Coach',
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          logFirebaseEvent('PostViewUserAdmin_update_page_state');
          _model.isUserAdmin = (_model.isUserCoach?.reference != null) ||
              (valueOrDefault(currentUserDocument?.userRole, '') == 'admin');
          safeSetState(() {});
        }),
        Future(() async {
          logFirebaseEvent('PostViewUserAdmin_backend_call');
          _model.isCourseEmpty =
              await TribeCourseRecord.getDocumentOnce(widget!.courseDoc!);
          if (_model.isCourseEmpty!.isEmptyCourse) {
            logFirebaseEvent('PostViewUserAdmin_update_page_state');
            _model.adminIsEditMode = true;
            safeSetState(() {});
            return;
          } else {
            return;
          }
        }),
      ]);
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
    return StreamBuilder<TribeCourseRecord>(
      stream: TribeCourseRecord.getDocument(widget!.courseDoc!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).appBG,
                  ),
                ),
              ),
            ),
          );
        }

        final postViewUserAdminTribeCourseRecord = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: responsiveVisibility(
              context: context,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).alternate,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 50.0,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'POST_VIEW_USER_ADMIN_arrow_back_ios_roun');
                            logFirebaseEvent('IconButton_navigate_back');
                            context.safePop();
                          },
                        ),
                        Text(
                          valueOrDefault<String>(
                            postViewUserAdminTribeCourseRecord.title,
                            'Course',
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          child: TopWebNavWidget(
                            groupDoc: widget!.groupDoc,
                          ),
                        ),
                      ),
                  ],
                ),
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        valueOrDefault<double>(
                          MediaQuery.sizeOf(context).width > kBreakpointMedium
                              ? 64.0
                              : 0.0,
                          0.0,
                        ),
                        valueOrDefault<double>(
                          MediaQuery.sizeOf(context).width > kBreakpointMedium
                              ? 24.0
                              : 0.0,
                          0.0,
                        ),
                        valueOrDefault<double>(
                          MediaQuery.sizeOf(context).width > kBreakpointMedium
                              ? 64.0
                              : 0.0,
                          0.0,
                        ),
                        0.0),
                    child: SafeArea(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 1440.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: StreamBuilder<
                                        List<TribeCollectionRecord>>(
                                      stream: queryTribeCollectionRecord(
                                        queryBuilder: (tribeCollectionRecord) =>
                                            tribeCollectionRecord
                                                .where(
                                                  'tribeCourseRef',
                                                  isEqualTo: widget!.courseDoc,
                                                )
                                                .orderBy('position'),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .appBG,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<TribeCollectionRecord>
                                            coursesTabContainerTribeCollectionRecordList =
                                            snapshot.data!;

                                        return Container(
                                          width: 350.0,
                                          height:
                                              MediaQuery.sizeOf(context).width >
                                                      kBreakpointMedium
                                                  ? (MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.7)
                                                  : MediaQuery.sizeOf(context)
                                                      .height,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  30.0,
                                                                  24.0,
                                                                  30.0,
                                                                  24.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              postViewUserAdminTribeCourseRecord
                                                                  .title,
                                                              'Course Title',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily),
                                                                ),
                                                          ),
                                                          AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                StreamBuilder<
                                                                    List<
                                                                        TribeContentRecord>>(
                                                              stream:
                                                                  queryTribeContentRecord(
                                                                queryBuilder:
                                                                    (tribeContentRecord) =>
                                                                        tribeContentRecord
                                                                            .where(
                                                                  'tribeCourseRef',
                                                                  isEqualTo:
                                                                      postViewUserAdminTribeCourseRecord
                                                                          .reference,
                                                                ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          20.0,
                                                                      height:
                                                                          20.0,
                                                                      child:
                                                                          SpinKitPulse(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<TribeContentRecord>
                                                                    progressBarWithTextTribeContentRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return wrapWithModel(
                                                                  model: _model
                                                                      .progressBarWithTextModel,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  updateOnChange:
                                                                      true,
                                                                  child:
                                                                      ProgressBarWithTextWidget(
                                                                    completed:
                                                                        valueOrDefault<
                                                                            int>(
                                                                      functions
                                                                          .filterContentIDs(
                                                                              (currentUserDocument?.contentCompletedIDs?.toList() ?? []).where((e) => e > 0).toList(),
                                                                              progressBarWithTextTribeContentRecordList.toList())
                                                                          .unique((e) => e)
                                                                          .length,
                                                                      0,
                                                                    ),
                                                                    total:
                                                                        valueOrDefault<
                                                                            int>(
                                                                      postViewUserAdminTribeCourseRecord
                                                                          .contentIDs
                                                                          .length,
                                                                      1,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          if (coursesTabContainerTribeCollectionRecordList
                                                              .isNotEmpty)
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                            ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model
                                                          .adminIsEditMode) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                if (valueOrDefault<
                                                                    bool>(
                                                                  coursesTabContainerTribeCollectionRecordList
                                                                          .length >
                                                                      0,
                                                                  false,
                                                                )) {
                                                                  return Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final adminCollectionChildren =
                                                                          coursesTabContainerTribeCollectionRecordList
                                                                              .toList();

                                                                      return ReorderableListView
                                                                          .builder(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        primary:
                                                                            false,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            adminCollectionChildren.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                adminCollectionChildrenIndex) {
                                                                          final adminCollectionChildrenItem =
                                                                              adminCollectionChildren[adminCollectionChildrenIndex];
                                                                          return Container(
                                                                            key: ValueKey("ListView_lnx7yiyj" +
                                                                                '_' +
                                                                                adminCollectionChildrenIndex.toString()),
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) => GroupTrainingListAdminWidget(
                                                                                key: Key('Keyy6f_${adminCollectionChildrenIndex}_of_${adminCollectionChildren.length}'),
                                                                                collectionDoc: adminCollectionChildrenItem,
                                                                                groupDoc: widget!.groupDoc!,
                                                                                courseRef: widget!.courseDoc!,
                                                                                collectionCallback: () async {
                                                                                  logFirebaseEvent('POST_VIEW_USER_ADMIN_Container_y6fogjud_');
                                                                                  logFirebaseEvent('groupTrainingListAdmin_alert_dialog');
                                                                                  await showDialog(
                                                                                    context: context,
                                                                                    builder: (dialogContext) {
                                                                                      return Dialog(
                                                                                        elevation: 0,
                                                                                        insetPadding: EdgeInsets.zero,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                        child: WebViewAware(
                                                                                          child: GestureDetector(
                                                                                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                                                                                            child: ModuleEditDialogWidget(
                                                                                              groupDoc: widget!.groupDoc!,
                                                                                              collectionDoc: adminCollectionChildrenItem,
                                                                                              saveCallback: () async {
                                                                                                logFirebaseEvent('_update_page_state');
                                                                                                _model.activeTabToDisplay = ActiveCourseTab.none;
                                                                                                safeSetState(() {});
                                                                                                logFirebaseEvent('_action_block');
                                                                                                await action_blocks.displaySnackbar(
                                                                                                  context,
                                                                                                  message: 'Module data updated!',
                                                                                                );
                                                                                              },
                                                                                              deleteCallback: () async {
                                                                                                logFirebaseEvent('_update_page_state');
                                                                                                _model.activeTabToDisplay = ActiveCourseTab.none;
                                                                                                safeSetState(() {});
                                                                                                logFirebaseEvent('_action_block');
                                                                                                await action_blocks.displaySnackbar(
                                                                                                  context,
                                                                                                  message: 'Module data updated!',
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                contentCallback: (contentDoc) async {
                                                                                  logFirebaseEvent('POST_VIEW_USER_ADMIN_Container_y6fogjud_');
                                                                                  logFirebaseEvent('groupTrainingListAdmin_update_page_state');
                                                                                  _model.activeTabToDisplay = ActiveCourseTab.none;
                                                                                  safeSetState(() {});
                                                                                  logFirebaseEvent('groupTrainingListAdmin_wait__delay');
                                                                                  await Future.delayed(const Duration(milliseconds: 50));
                                                                                  logFirebaseEvent('groupTrainingListAdmin_update_page_state');
                                                                                  _model.activeCollectionDoc = adminCollectionChildrenItem;
                                                                                  _model.activeContentDoc = contentDoc;
                                                                                  _model.activeTabToDisplay = ActiveCourseTab.content;
                                                                                  safeSetState(() {});
                                                                                  // Set btn text
                                                                                  logFirebaseEvent('groupTrainingListAdmin_Setbtntext');
                                                                                  safeSetState(() {
                                                                                    _model.contentEditDialogModel.ctaTextTextController?.text = _model.activeContentDoc!.ctaBtnText;
                                                                                    _model.contentEditDialogModel.ctaTextTextController?.selection = TextSelection.collapsed(offset: _model.contentEditDialogModel.ctaTextTextController!.text.length);
                                                                                  });
                                                                                  logFirebaseEvent('groupTrainingListAdmin_set_form_field');
                                                                                  safeSetState(() {
                                                                                    _model.contentEditDialogModel.linkTypeTextFieldTextController?.text = _model.activeContentDoc!.ctaLink;
                                                                                    _model.contentEditDialogModel.linkTypeTextFieldTextController?.selection = TextSelection.collapsed(offset: _model.contentEditDialogModel.linkTypeTextFieldTextController!.text.length);
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        onReorder:
                                                                            (int reorderableOldIndex,
                                                                                int reorderableNewIndex) async {
                                                                          logFirebaseEvent(
                                                                              'POST_VIEW_USER_ADMIN_ListView_lnx7yiyj_O');
                                                                          logFirebaseEvent(
                                                                              'ListView_custom_action');
                                                                          await actions
                                                                              .reorderTribeCollectionList(
                                                                            coursesTabContainerTribeCollectionRecordList.toList(),
                                                                            reorderableOldIndex,
                                                                            reorderableNewIndex,
                                                                          );

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/Modle_Empty_State.png',
                                                                            width:
                                                                                130.0,
                                                                            height:
                                                                                113.0,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              4.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Nothing here yet',
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Add your first module and fill it with course lessons to get started ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                              ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              24.0,
                                                                              0.0,
                                                                              16.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed: (_model.activeTabToDisplay == ActiveCourseTab.collection)
                                                                                ? null
                                                                                : () async {
                                                                                    logFirebaseEvent('POST_VIEW_USER_ADMIN_addModuleButton_ON_');
                                                                                    logFirebaseEvent('addModuleButton_backend_call');

                                                                                    await widget!.courseDoc!.update(createTribeCourseRecordData(
                                                                                      isEmptyCourse: false,
                                                                                    ));
                                                                                    logFirebaseEvent('addModuleButton_backend_call');

                                                                                    var tribeCollectionRecordReference = TribeCollectionRecord.collection.doc();
                                                                                    await tribeCollectionRecordReference.set({
                                                                                      ...createTribeCollectionRecordData(
                                                                                        authorName: currentUserDisplayName,
                                                                                        authorUserId: valueOrDefault(currentUserDocument?.tribeUserId, 0),
                                                                                        position: coursesTabContainerTribeCollectionRecordList.length,
                                                                                        id: random_data.randomInteger(10000, 20000),
                                                                                        tribeCourseRef: widget!.courseDoc,
                                                                                      ),
                                                                                      ...mapToFirestore(
                                                                                        {
                                                                                          'tribeGroupIds': [
                                                                                            widget!.groupDoc?.tribeGroupID
                                                                                          ],
                                                                                          'tribeContentIds': List.generate(random_data.randomInteger(0, 0), (index) => random_data.randomInteger(0, 10)),
                                                                                        },
                                                                                      ),
                                                                                    });
                                                                                    _model.firstCollectionDoc = TribeCollectionRecord.getDocumentFromData({
                                                                                      ...createTribeCollectionRecordData(
                                                                                        authorName: currentUserDisplayName,
                                                                                        authorUserId: valueOrDefault(currentUserDocument?.tribeUserId, 0),
                                                                                        position: coursesTabContainerTribeCollectionRecordList.length,
                                                                                        id: random_data.randomInteger(10000, 20000),
                                                                                        tribeCourseRef: widget!.courseDoc,
                                                                                      ),
                                                                                      ...mapToFirestore(
                                                                                        {
                                                                                          'tribeGroupIds': [
                                                                                            widget!.groupDoc?.tribeGroupID
                                                                                          ],
                                                                                          'tribeContentIds': List.generate(random_data.randomInteger(0, 0), (index) => random_data.randomInteger(0, 10)),
                                                                                        },
                                                                                      ),
                                                                                    }, tribeCollectionRecordReference);
                                                                                    logFirebaseEvent('addModuleButton_wait__delay');
                                                                                    await Future.delayed(const Duration(milliseconds: 2000));

                                                                                    safeSetState(() {});
                                                                                  },
                                                                            text:
                                                                                'Add First Module',
                                                                            icon:
                                                                                Icon(
                                                                              Icons.add,
                                                                              size: 16.0,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 220.0,
                                                                              height: 40.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                  ),
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              disabledColor: Color(0x6A262D34),
                                                                              disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 8.0)),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return Builder(
                                                          builder: (context) {
                                                            final userCollectionChildren =
                                                                coursesTabContainerTribeCollectionRecordList
                                                                    .toList();

                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  userCollectionChildren
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  userCollectionChildrenIndex) {
                                                                final userCollectionChildrenItem =
                                                                    userCollectionChildren[
                                                                        userCollectionChildrenIndex];
                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    wrapWithModel(
                                                                      model: _model
                                                                          .groupTrainingListUserModels
                                                                          .getModel(
                                                                        userCollectionChildrenItem
                                                                            .id
                                                                            .toString(),
                                                                        userCollectionChildrenIndex,
                                                                      ),
                                                                      updateCallback:
                                                                          () =>
                                                                              safeSetState(() {}),
                                                                      updateOnChange:
                                                                          true,
                                                                      child:
                                                                          GroupTrainingListUserWidget(
                                                                        key:
                                                                            Key(
                                                                          'Keyi93_${userCollectionChildrenItem.id.toString()}',
                                                                        ),
                                                                        collectionDoc:
                                                                            userCollectionChildrenItem,
                                                                        contentCallback:
                                                                            (contentDoc,
                                                                                contentRef) async {
                                                                          logFirebaseEvent(
                                                                              'POST_VIEW_USER_ADMIN_Container_i93r853r_');
                                                                          logFirebaseEvent(
                                                                              'groupTrainingListUser_update_page_state');
                                                                          _model.activeContentDoc =
                                                                              contentDoc;
                                                                          _model.activeCollectionDoc =
                                                                              userCollectionChildrenItem;
                                                                          _model.activeTabToDisplay =
                                                                              ActiveCourseTab.content;
                                                                          safeSetState(
                                                                              () {});
                                                                          logFirebaseEvent(
                                                                              'groupTrainingListUser_update_app_state');
                                                                          FFAppState().postViewActiveContentRef =
                                                                              contentRef;
                                                                          FFAppState()
                                                                              .update(() {});
                                                                          if (MediaQuery.sizeOf(context).width <=
                                                                              kBreakpointSmall) {
                                                                            logFirebaseEvent('groupTrainingListUser_navigate_to');

                                                                            context.pushNamed(
                                                                              'PostViewMobileContent',
                                                                              queryParameters: {
                                                                                'groupDoc': serializeParam(
                                                                                  widget!.groupDoc,
                                                                                  ParamType.Document,
                                                                                ),
                                                                                'courseDoc': serializeParam(
                                                                                  postViewUserAdminTribeCourseRecord,
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
                                                                                'courseDoc': postViewUserAdminTribeCourseRecord,
                                                                                'collectionDoc': userCollectionChildrenItem,
                                                                                'contentDoc': contentDoc,
                                                                              },
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Divider(
                                                    height: 5.0,
                                                    thickness: 1.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                  if (_model.adminIsEditMode &&
                                                      (coursesTabContainerTribeCollectionRecordList
                                                              .length >
                                                          0))
                                                    Builder(
                                                      builder: (context) =>
                                                          Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    26.0,
                                                                    16.0,
                                                                    26.0,
                                                                    24.0),
                                                        child: FFButtonWidget(
                                                          onPressed: (_model
                                                                      .activeTabToDisplay ==
                                                                  ActiveCourseTab
                                                                      .collection)
                                                              ? null
                                                              : () async {
                                                                  logFirebaseEvent(
                                                                      'POST_VIEW_USER_ADMIN_addModuleButton_ON_');
                                                                  logFirebaseEvent(
                                                                      'addModuleButton_backend_call');

                                                                  var tribeCollectionRecordReference =
                                                                      TribeCollectionRecord
                                                                          .collection
                                                                          .doc();
                                                                  await tribeCollectionRecordReference
                                                                      .set({
                                                                    ...createTribeCollectionRecordData(
                                                                      authorName:
                                                                          currentUserDisplayName,
                                                                      authorUserId:
                                                                          valueOrDefault(
                                                                              currentUserDocument?.tribeUserId,
                                                                              0),
                                                                      position:
                                                                          coursesTabContainerTribeCollectionRecordList
                                                                              .length,
                                                                      id: random_data.randomInteger(
                                                                          10000,
                                                                          20000),
                                                                      tribeCourseRef:
                                                                          widget!
                                                                              .courseDoc,
                                                                    ),
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'tribeGroupIds':
                                                                            [
                                                                          widget!
                                                                              .groupDoc
                                                                              ?.tribeGroupID
                                                                        ],
                                                                      },
                                                                    ),
                                                                  });
                                                                  _model.newCollectionDoc =
                                                                      TribeCollectionRecord
                                                                          .getDocumentFromData({
                                                                    ...createTribeCollectionRecordData(
                                                                      authorName:
                                                                          currentUserDisplayName,
                                                                      authorUserId:
                                                                          valueOrDefault(
                                                                              currentUserDocument?.tribeUserId,
                                                                              0),
                                                                      position:
                                                                          coursesTabContainerTribeCollectionRecordList
                                                                              .length,
                                                                      id: random_data.randomInteger(
                                                                          10000,
                                                                          20000),
                                                                      tribeCourseRef:
                                                                          widget!
                                                                              .courseDoc,
                                                                    ),
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'tribeGroupIds':
                                                                            [
                                                                          widget!
                                                                              .groupDoc
                                                                              ?.tribeGroupID
                                                                        ],
                                                                      },
                                                                    ),
                                                                  }, tribeCollectionRecordReference);
                                                                  logFirebaseEvent(
                                                                      'addModuleButton_alert_dialog');
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Dialog(
                                                                        elevation:
                                                                            0,
                                                                        insetPadding:
                                                                            EdgeInsets.zero,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        alignment:
                                                                            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                        child:
                                                                            WebViewAware(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () =>
                                                                                FocusScope.of(dialogContext).unfocus(),
                                                                            child:
                                                                                ModuleEditDialogWidget(
                                                                              groupDoc: widget!.groupDoc!,
                                                                              collectionDoc: _model.newCollectionDoc!,
                                                                              saveCallback: () async {
                                                                                logFirebaseEvent('_update_page_state');
                                                                                _model.activeTabToDisplay = ActiveCourseTab.none;
                                                                                safeSetState(() {});
                                                                                logFirebaseEvent('_action_block');
                                                                                await action_blocks.displaySnackbar(
                                                                                  context,
                                                                                  message: 'Module data updated!',
                                                                                );
                                                                              },
                                                                              deleteCallback: () async {
                                                                                logFirebaseEvent('_update_page_state');
                                                                                _model.activeTabToDisplay = ActiveCourseTab.none;
                                                                                safeSetState(() {});
                                                                                logFirebaseEvent('_action_block');
                                                                                await action_blocks.displaySnackbar(
                                                                                  context,
                                                                                  message: 'Module data updated!',
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                          text: 'Add Module',
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 40.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleMediumFamily),
                                                                    ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            disabledColor:
                                                                Color(
                                                                    0x6A262D34),
                                                            disabledTextColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                          ),
                                                        ),
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
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              1.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Visibility(
                                            visible: responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Builder(
                                                    builder: (context) {
                                                      if (_model
                                                          .adminIsEditMode) {
                                                        return Builder(
                                                          builder: (context) {
                                                            if (_model
                                                                    .activeTabToDisplay ==
                                                                ActiveCourseTab
                                                                    .content) {
                                                              return wrapWithModel(
                                                                model: _model
                                                                    .contentEditDialogModel,
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    ContentEditDialogWidget(
                                                                  contentDoc: _model
                                                                      .activeContentDoc!,
                                                                  groupDoc: widget!
                                                                      .groupDoc!,
                                                                  courseRef: widget!
                                                                      .courseDoc!,
                                                                  tabBarIndex:
                                                                      valueOrDefault<
                                                                          int>(
                                                                    () {
                                                                      if (_model
                                                                              .activeContentDoc
                                                                              ?.contentType ==
                                                                          'video') {
                                                                        return 0;
                                                                      } else if (_model
                                                                              .activeContentDoc
                                                                              ?.contentType ==
                                                                          'video embed') {
                                                                        return 1;
                                                                      } else if (_model
                                                                              .activeContentDoc
                                                                              ?.contentType ==
                                                                          'download') {
                                                                        return 2;
                                                                      } else if (_model
                                                                              .activeContentDoc
                                                                              ?.contentType ==
                                                                          'link') {
                                                                        return 3;
                                                                      } else if (_model
                                                                              .activeContentDoc
                                                                              ?.contentType ==
                                                                          'searchie') {
                                                                        return 4;
                                                                      } else {
                                                                        return 0;
                                                                      }
                                                                    }(),
                                                                    0,
                                                                  ),
                                                                  collectionDoc:
                                                                      _model
                                                                          .activeCollectionDoc!,
                                                                  deleteCallback:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'POST_VIEW_USER_ADMIN_Container_48rdmpjx_');
                                                                    logFirebaseEvent(
                                                                        'contentEditDialog_update_page_state');
                                                                    _model.activeTabToDisplay =
                                                                        ActiveCourseTab
                                                                            .none;
                                                                    safeSetState(
                                                                        () {});
                                                                    logFirebaseEvent(
                                                                        'contentEditDialog_action_block');
                                                                    await action_blocks
                                                                        .displaySnackbar(
                                                                      context,
                                                                      message:
                                                                          'Lesson deleted.',
                                                                    );
                                                                  },
                                                                  saveCallback:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'POST_VIEW_USER_ADMIN_Container_48rdmpjx_');
                                                                    logFirebaseEvent(
                                                                        'contentEditDialog_update_page_state');
                                                                    _model.activeTabToDisplay =
                                                                        ActiveCourseTab
                                                                            .none;
                                                                    safeSetState(
                                                                        () {});
                                                                    logFirebaseEvent(
                                                                        'contentEditDialog_action_block');
                                                                    await action_blocks
                                                                        .displaySnackbar(
                                                                      context,
                                                                      message:
                                                                          'Lesson updated!',
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            } else {
                                                              return Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            postViewUserAdminTribeCourseRecord.featuredImage,
                                                                            'https://images.unsplash.com/photo-1522747776116-64ee03be1dad?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOXx8dGVhfGVufDB8fHx8MTcxNjM3MzkxNnww&ixlib=rb-4.0.3&q=80&w=1080',
                                                                          ),
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              400.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.jpg',
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                400.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          postViewUserAdminTribeCourseRecord
                                                                              .title,
                                                                          'Course name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                            ),
                                                                      ),
                                                                      if (postViewUserAdminTribeCourseRecord.description !=
                                                                              null &&
                                                                          postViewUserAdminTribeCourseRecord.description !=
                                                                              '')
                                                                        Text(
                                                                          postViewUserAdminTribeCourseRecord
                                                                              .description,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelLarge
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                              ),
                                                                        ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      } else {
                                                        return Builder(
                                                          builder: (context) {
                                                            if (_model
                                                                    .activeTabToDisplay ==
                                                                ActiveCourseTab
                                                                    .content) {
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .contentDisplayDialogModel,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      ContentDisplayDialogWidget(
                                                                    pageSource:
                                                                        'content',
                                                                    contentDoc:
                                                                        _model
                                                                            .activeContentDoc!,
                                                                    groupDoc:
                                                                        widget!
                                                                            .groupDoc,
                                                                    courseDoc:
                                                                        postViewUserAdminTribeCourseRecord,
                                                                    collectionDoc:
                                                                        _model
                                                                            .activeCollectionDoc!,
                                                                    completedCallback:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'POST_VIEW_USER_ADMIN_Container_kbbg1w45_');
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            postViewUserAdminTribeCourseRecord.featuredImage,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/3ukc7rrxfimb/hero_app.png',
                                                                          ),
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              400.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.jpg',
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                400.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          postViewUserAdminTribeCourseRecord
                                                                              .title,
                                                                          'Course name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                            ),
                                                                      ),
                                                                      if (postViewUserAdminTribeCourseRecord.description !=
                                                                              null &&
                                                                          postViewUserAdminTribeCourseRecord.description !=
                                                                              '')
                                                                        Text(
                                                                          postViewUserAdminTribeCourseRecord
                                                                              .description,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelLarge
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                              ),
                                                                        ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                    tabletLandscape: false,
                                  ))
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 350.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.7,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.isUserAdmin &&
                                                  responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                    tabletLandscape: false,
                                                    desktop: false,
                                                  ))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 12.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'POST_VIEW_USER_ADMIN_editCourseButton_ON');
                                                      logFirebaseEvent(
                                                          'editCourseButton_update_page_state');
                                                      _model.adminIsEditMode =
                                                          !_model
                                                              .adminIsEditMode;
                                                      safeSetState(() {});
                                                    },
                                                    text: _model.adminIsEditMode
                                                        ? 'View mode'
                                                        : 'Edit mode',
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 140.0,
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily),
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              if (!_model.adminIsEditMode &&
                                                  (_model.activeContentDoc !=
                                                      null))
                                                Expanded(
                                                  child: StreamBuilder<
                                                      List<
                                                          TribeCollectionsRecord>>(
                                                    stream:
                                                        queryTribeCollectionsRecord(
                                                      queryBuilder:
                                                          (tribeCollectionsRecord) =>
                                                              tribeCollectionsRecord
                                                                  .where(
                                                        'tribeContentID',
                                                        isEqualTo: _model
                                                            .activeContentDoc
                                                            ?.tribeContentID,
                                                      ),
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      List<TribeCollectionsRecord>
                                                          commentsContainerTribeCollectionsRecordList =
                                                          snapshot.data!;
                                                      final commentsContainerTribeCollectionsRecord =
                                                          commentsContainerTribeCollectionsRecordList
                                                                  .isNotEmpty
                                                              ? commentsContainerTribeCollectionsRecordList
                                                                  .first
                                                              : null;

                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        child: Visibility(
                                                          visible: _model
                                                                  .activeContentDoc!
                                                                  .tribeContentID >
                                                              0,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          16.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Comments',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineSmallFamily),
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        '${commentsContainerTribeCollectionsRecord?.commentCount?.toString()} Comments',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: StreamBuilder<
                                                                      List<
                                                                          ChatMessagesRecord>>(
                                                                    stream:
                                                                        queryChatMessagesRecord(
                                                                      queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                                                                          .where(
                                                                            'contentID',
                                                                            isEqualTo:
                                                                                _model.activeContentDoc?.tribeContentID,
                                                                          )
                                                                          .where(
                                                                            'deleted',
                                                                            isEqualTo:
                                                                                false,
                                                                          )
                                                                          .orderBy('date', descending: true),
                                                                      limit: 30,
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).appBG,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<ChatMessagesRecord>
                                                                          commentListViewChatMessagesRecordList =
                                                                          snapshot
                                                                              .data!;

                                                                      return ListView
                                                                          .builder(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            commentListViewChatMessagesRecordList.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                commentListViewIndex) {
                                                                          final commentListViewChatMessagesRecord =
                                                                              commentListViewChatMessagesRecordList[commentListViewIndex];
                                                                          return wrapWithModel(
                                                                            model:
                                                                                _model.discussionCommentModels.getModel(
                                                                              commentListViewChatMessagesRecord.reference.id,
                                                                              commentListViewIndex,
                                                                            ),
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                DiscussionCommentWidget(
                                                                              key: Key(
                                                                                'Keyrzm_${commentListViewChatMessagesRecord.reference.id}',
                                                                              ),
                                                                              chatMessage: commentListViewChatMessagesRecord,
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .newCommentComponentModel,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        NewCommentComponentWidget(
                                                                      contentDoc:
                                                                          _model
                                                                              .activeContentDoc!,
                                                                      collectionsRef:
                                                                          commentsContainerTribeCollectionsRecord!,
                                                                    ),
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
                                      ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
