import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import '/pages/groups/group_components/post_options_f_b/post_options_f_b_widget.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'discussion_post_model.dart';
export 'discussion_post_model.dart';

class DiscussionPostWidget extends StatefulWidget {
  const DiscussionPostWidget({
    super.key,
    required this.broadcastDoc,
    required this.groupDoc,
    bool? isEditMode,
  }) : this.isEditMode = isEditMode ?? false;

  final BroadcastsRecord? broadcastDoc;
  final TribeGroupsRecord? groupDoc;
  final bool isEditMode;

  @override
  State<DiscussionPostWidget> createState() => _DiscussionPostWidgetState();
}

class _DiscussionPostWidgetState extends State<DiscussionPostWidget> {
  late DiscussionPostModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiscussionPostModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DiscussionPost'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DISCUSSION_POST_DiscussionPost_ON_INIT_S');
      logFirebaseEvent('DiscussionPost_update_page_state');
      _model.editMode = widget!.isEditMode;
      safeSetState(() {});
      logFirebaseEvent('DiscussionPost_action_block');
      await action_blocks.addABView(context);
    });

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.commentBoxTextController ??= TextEditingController();
    _model.commentBoxFocusNode ??= FocusNode();

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
      child: WillPopScope(
        onWillPop: () async => false,
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
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 54.0,
                          icon: Icon(
                            Icons.chevron_left_sharp,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'DISCUSSION_POST_chevron_left_sharp_ICN_O');
                            logFirebaseEvent('IconButton_navigate_to');

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
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            widget!.broadcastDoc!.title,
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineSmallFamily),
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
                  centerTitle: false,
                  elevation: 2.0,
                )
              : null,
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 1.0,
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
                        constraints: BoxConstraints(
                          maxWidth: 1000.0,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'DISCUSSION_POST_PAGE_Row_22w2rvwl_ON_TAP');
                                        logFirebaseEvent('Row_navigate_to');

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
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 10.0, 0.0, 10.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'DISCUSSION_POST_PAGE_Row_ce47bett_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Row_navigate_back');
                                                    context.safePop();
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_back_ios,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                      Text(
                                                        'Back to Community',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
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
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
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
                                    Expanded(
                                      child: StreamBuilder<BroadcastsRecord>(
                                        stream: BroadcastsRecord.getDocument(
                                            widget!.broadcastDoc!.reference),
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
                                                    FlutterFlowTheme.of(context)
                                                        .appBG,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          final containerGetBroadcastLatestBroadcastsRecord =
                                              snapshot.data!;

                                          return Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 35.0,
                                                                  height: 35.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .gray200,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 40.0,
                                                                    height:
                                                                        40.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      fadeInDuration:
                                                                          Duration(
                                                                              milliseconds: 500),
                                                                      fadeOutDuration:
                                                                          Duration(
                                                                              milliseconds: 500),
                                                                      imageUrl:
                                                                          valueOrDefault<
                                                                              String>(
                                                                        widget!
                                                                            .broadcastDoc
                                                                            ?.authorImg,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorWidget: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.jpg',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            widget!.broadcastDoc?.authorName,
                                                                            'Unknown User',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        dateTimeFormat(
                                                                            "relative",
                                                                            widget!.broadcastDoc!.time!),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 11.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w200,
                                                                              fontStyle: FontStyle.italic,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        if ((valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.userRole,
                                                                    '') ==
                                                                'admin') ||
                                                            (widget!.broadcastDoc
                                                                    ?.userId ==
                                                                currentUserReference) ||
                                                            (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.userRole,
                                                                    '') ==
                                                                'creator'))
                                                          Builder(
                                                            builder: (context) =>
                                                                AuthUserStreamWidget(
                                                              builder: (context) =>
                                                                  FlutterFlowIconButton(
                                                                borderColor: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    30.0,
                                                                borderWidth:
                                                                    0.0,
                                                                buttonSize:
                                                                    45.0,
                                                                icon: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .ellipsisV,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grayIcon,
                                                                  size: 22.0,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'DISCUSSION_POST_ellipsisV_ICN_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'IconButton_alert_dialog');
                                                                  await showAlignedDialog(
                                                                    barrierColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            WebViewAware(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () =>
                                                                                FocusScope.of(dialogContext).unfocus(),
                                                                            child:
                                                                                Container(
                                                                              height: 240.0,
                                                                              width: 200.0,
                                                                              child: PostOptionsFBWidget(
                                                                                postId: widget!.broadcastDoc?.contentID,
                                                                                groupDoc: widget!.groupDoc!,
                                                                                postAuthorRef: widget!.broadcastDoc?.userId,
                                                                                pinned: widget!.broadcastDoc?.pinnedToTop,
                                                                                discussionPost: widget!.broadcastDoc?.reference,
                                                                                callback: () async {
                                                                                  logFirebaseEvent('_update_page_state');
                                                                                  _model.editMode = !_model.editMode;
                                                                                  safeSetState(() {});
                                                                                  logFirebaseEvent('_close_dialog_drawer_etc');
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Builder(
                                                          builder: (context) {
                                                            if (!((valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.userRole,
                                                                        '') ==
                                                                    'admin') ||
                                                                (widget!.broadcastDoc
                                                                        ?.userId ==
                                                                    currentUserReference) ||
                                                                (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.userRole,
                                                                        '') ==
                                                                    'creator'))) {
                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (valueOrDefault<
                                                                              String>(
                                                                            widget!.broadcastDoc?.title,
                                                                            'Title',
                                                                          ) !=
                                                                          null &&
                                                                      valueOrDefault<
                                                                              String>(
                                                                            widget!.broadcastDoc?.title,
                                                                            'Title',
                                                                          ) !=
                                                                          '')
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          12.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          widget!
                                                                              .broadcastDoc
                                                                              ?.title,
                                                                          'Title',
                                                                        ).maybeHandleOverflow(
                                                                          maxChars:
                                                                              275,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        maxLines:
                                                                            7,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 20.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  if (widget!.broadcastDoc
                                                                              ?.name !=
                                                                          null &&
                                                                      widget!.broadcastDoc
                                                                              ?.name !=
                                                                          '')
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                        child: custom_widgets
                                                                            .LinkableText(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              100.0,
                                                                          text: widget!
                                                                              .broadcastDoc!
                                                                              .name,
                                                                          textSize:
                                                                              16.0,
                                                                          limitTextLength:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              );
                                                            } else {
                                                              return Builder(
                                                                builder:
                                                                    (context) {
                                                                  if (!_model
                                                                      .editMode) {
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        if (containerGetBroadcastLatestBroadcastsRecord.title !=
                                                                                null &&
                                                                            containerGetBroadcastLatestBroadcastsRecord.title !=
                                                                                '')
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                12.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              containerGetBroadcastLatestBroadcastsRecord.title.maybeHandleOverflow(
                                                                                maxChars: 275,
                                                                                replacement: '…',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              maxLines: 7,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Open Sans',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        if (containerGetBroadcastLatestBroadcastsRecord.name !=
                                                                                null &&
                                                                            containerGetBroadcastLatestBroadcastsRecord.name !=
                                                                                '')
                                                                          custom_widgets
                                                                              .LinkableTextV2(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                80.0,
                                                                            text:
                                                                                containerGetBroadcastLatestBroadcastsRecord.name,
                                                                            textSize:
                                                                                16.0,
                                                                            limitTextLength:
                                                                                false,
                                                                          ),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          25.0,
                                                                          0.0,
                                                                          25.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _model.textController1 ??= TextEditingController(
                                                                                text: containerGetBroadcastLatestBroadcastsRecord.title,
                                                                              ),
                                                                              focusNode: _model.textFieldFocusNode1,
                                                                              autofocus: false,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                labelText: 'Post Title (Optional)',
                                                                                alignLabelWithHint: false,
                                                                                hintText: 'Optional',
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                    ),
                                                                                enabledBorder: InputBorder.none,
                                                                                focusedBorder: InputBorder.none,
                                                                                errorBorder: InputBorder.none,
                                                                                focusedErrorBorder: InputBorder.none,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                  ),
                                                                              validator: _model.textController1Validator.asValidator(context),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _model.textController2 ??= TextEditingController(
                                                                                text: containerGetBroadcastLatestBroadcastsRecord.name,
                                                                              ),
                                                                              focusNode: _model.textFieldFocusNode2,
                                                                              onChanged: (_) => EasyDebounce.debounce(
                                                                                '_model.textController2',
                                                                                Duration(milliseconds: 2000),
                                                                                () => safeSetState(() {}),
                                                                              ),
                                                                              autofocus: false,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                labelText: 'Post',
                                                                                labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                    ),
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                    ),
                                                                                enabledBorder: InputBorder.none,
                                                                                focusedBorder: InputBorder.none,
                                                                                errorBorder: InputBorder.none,
                                                                                focusedErrorBorder: InputBorder.none,
                                                                                suffixIcon: _model.textController2!.text.isNotEmpty
                                                                                    ? InkWell(
                                                                                        onTap: () async {
                                                                                          _model.textController2?.clear();
                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.clear,
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          size: 20.0,
                                                                                        ),
                                                                                      )
                                                                                    : null,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                  ),
                                                                              textAlign: TextAlign.start,
                                                                              maxLines: 6,
                                                                              keyboardType: TextInputType.multiline,
                                                                              validator: _model.textController2Validator.asValidator(context),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                15.0,
                                                                                8.0,
                                                                                15.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    logFirebaseEvent('DISCUSSION_POST_DONT_SAVE_BTN_ON_TAP');
                                                                                    logFirebaseEvent('Button_update_page_state');
                                                                                    _model.editMode = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  text: 'Don\'t save',
                                                                                  options: FFButtonOptions(
                                                                                    height: 40.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                          color: Colors.white,
                                                                                          fontSize: 18.0,
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
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    logFirebaseEvent('DISCUSSION_POST_SAVE_CHANGES_BTN_ON_TAP');
                                                                                    logFirebaseEvent('Button_backend_call');

                                                                                    await widget!.broadcastDoc!.reference.update(createBroadcastsRecordData(
                                                                                      title: _model.textController1.text,
                                                                                      name: _model.textController2.text,
                                                                                    ));
                                                                                    logFirebaseEvent('Button_action_block');
                                                                                    await action_blocks.displaySnackbar(
                                                                                      context,
                                                                                      message: 'Post updated!',
                                                                                    );
                                                                                    logFirebaseEvent('Button_update_page_state');
                                                                                    _model.editMode = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  text: 'Save Changes',
                                                                                  options: FFButtonOptions(
                                                                                    height: 40.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                          color: Colors.white,
                                                                                          fontSize: 18.0,
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
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        if ((widget!.broadcastDoc
                                                                        ?.video !=
                                                                    null &&
                                                                widget!.broadcastDoc
                                                                        ?.video !=
                                                                    '') ||
                                                            (widget!.broadcastDoc
                                                                        ?.featuredImage !=
                                                                    null &&
                                                                widget!.broadcastDoc
                                                                        ?.featuredImage !=
                                                                    ''))
                                                          Stack(
                                                            children: [
                                                              if ((widget!.broadcastDoc
                                                                              ?.video ==
                                                                          null ||
                                                                      widget!.broadcastDoc
                                                                              ?.video ==
                                                                          '') &&
                                                                  (widget!.broadcastDoc
                                                                              ?.featuredImage !=
                                                                          null &&
                                                                      widget!.broadcastDoc
                                                                              ?.featuredImage !=
                                                                          ''))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
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
                                                                          'DISCUSSION_POST_featuredImage_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'featuredImage_expand_image');
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                CachedNetworkImage(
                                                                              fadeInDuration: Duration(milliseconds: 500),
                                                                              fadeOutDuration: Duration(milliseconds: 500),
                                                                              imageUrl: widget!.broadcastDoc!.featuredImage,
                                                                              fit: BoxFit.contain,
                                                                              errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.jpg',
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                widget!.broadcastDoc!.featuredImage,
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: widget!
                                                                          .broadcastDoc!
                                                                          .featuredImage,
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        fadeInDuration:
                                                                            Duration(milliseconds: 500),
                                                                        fadeOutDuration:
                                                                            Duration(milliseconds: 500),
                                                                        imageUrl: widget!
                                                                            .broadcastDoc!
                                                                            .featuredImage,
                                                                        width: double
                                                                            .infinity,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorWidget: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Image.asset(
                                                                          'assets/images/error_image.jpg',
                                                                          width:
                                                                              double.infinity,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (widget!.broadcastDoc
                                                                          ?.video !=
                                                                      null &&
                                                                  widget!.broadcastDoc
                                                                          ?.video !=
                                                                      '')
                                                                FlutterFlowVideoPlayer(
                                                                  path: functions
                                                                      .retVidPath(widget!
                                                                          .broadcastDoc
                                                                          ?.video),
                                                                  videoType:
                                                                      VideoType
                                                                          .network,
                                                                  autoPlay:
                                                                      false,
                                                                  looping:
                                                                      false,
                                                                  showControls:
                                                                      true,
                                                                  allowFullScreen:
                                                                      false,
                                                                  allowPlaybackSpeedMenu:
                                                                      false,
                                                                ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                12.0,
                                                                12.0),
                                                    child: StreamBuilder<
                                                        List<
                                                            ChatMessagesRecord>>(
                                                      stream:
                                                          queryChatMessagesRecord(
                                                        queryBuilder:
                                                            (chatMessagesRecord) =>
                                                                chatMessagesRecord
                                                                    .where(
                                                                      'deleted',
                                                                      isEqualTo:
                                                                          false,
                                                                    )
                                                                    .where(
                                                                      'broadcastRef',
                                                                      isEqualTo: widget!
                                                                          .broadcastDoc
                                                                          ?.reference,
                                                                    )
                                                                    .orderBy(
                                                                        'date',
                                                                        descending:
                                                                            true),
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
                                                        List<ChatMessagesRecord>
                                                            commentListViewChatMessagesRecordList =
                                                            snapshot.data!;

                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              commentListViewChatMessagesRecordList
                                                                  .length,
                                                          itemBuilder: (context,
                                                              commentListViewIndex) {
                                                            final commentListViewChatMessagesRecord =
                                                                commentListViewChatMessagesRecordList[
                                                                    commentListViewIndex];
                                                            return wrapWithModel(
                                                              model: _model
                                                                  .discussionCommentModels
                                                                  .getModel(
                                                                widget!
                                                                    .broadcastDoc!
                                                                    .reference
                                                                    .id,
                                                                commentListViewIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  DiscussionCommentWidget(
                                                                key: Key(
                                                                  'Keydav_${widget!.broadcastDoc!.reference.id}',
                                                                ),
                                                                chatMessage:
                                                                    commentListViewChatMessagesRecord,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5.0,
                                              color: Color(0x20000000),
                                              offset: Offset(
                                                0.0,
                                                -1.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 1.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 80.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 800.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      15.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  currentUserPhoto,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                                ),
                                                                width: 35.0,
                                                                height: 35.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  'assets/images/error_image.jpg',
                                                                  width: 35.0,
                                                                  height: 35.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        18.0,
                                                                        0.0,
                                                                        4.0,
                                                                        0.0),
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .commentBoxTextController,
                                                              focusNode: _model
                                                                  .commentBoxFocusNode,
                                                              autofocus: false,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .sentences,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Leave a Comment',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Open Sans',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .grayIcon,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              'Open Sans'),
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 0.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 0.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 0.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 0.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Open Sans',
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Open Sans'),
                                                                    lineHeight:
                                                                        1.1,
                                                                  ),
                                                              maxLines: 2,
                                                              minLines: 1,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              validator: _model
                                                                  .commentBoxTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      15.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'DISCUSSION_POST_PAGE__BTN_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Button_backend_call');

                                                              await ChatMessagesRecord
                                                                  .collection
                                                                  .doc()
                                                                  .set(
                                                                      createChatMessagesRecordData(
                                                                    contentID: widget!
                                                                        .broadcastDoc
                                                                        ?.contentID,
                                                                    deleted:
                                                                        false,
                                                                    date:
                                                                        getCurrentTimestamp,
                                                                    message: _model
                                                                        .commentBoxTextController
                                                                        .text,
                                                                    user:
                                                                        currentUserReference,
                                                                    broadcastRef: widget!
                                                                        .broadcastDoc
                                                                        ?.reference,
                                                                    authorName:
                                                                        currentUserDisplayName,
                                                                    authorImg:
                                                                        currentUserPhoto,
                                                                  ));
                                                              if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.userRole,
                                                                      '') ==
                                                                  'admin') {
                                                                logFirebaseEvent(
                                                                    'Button_backend_call');

                                                                await widget!
                                                                    .broadcastDoc!
                                                                    .reference
                                                                    .update({
                                                                  ...createBroadcastsRecordData(
                                                                    adminHasReplied:
                                                                        true,
                                                                  ),
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'commentCount':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    },
                                                                  ),
                                                                });
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'Button_backend_call');

                                                                await widget!
                                                                    .broadcastDoc!
                                                                    .reference
                                                                    .update({
                                                                  ...createBroadcastsRecordData(
                                                                    adminHasReplied:
                                                                        false,
                                                                  ),
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'commentCount':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    },
                                                                  ),
                                                                });
                                                              }

                                                              // NewInboxNotification
                                                              logFirebaseEvent(
                                                                  'Button_NewInboxNotification');

                                                              await NotificationsRecord
                                                                  .collection
                                                                  .doc()
                                                                  .set({
                                                                ...createNotificationsRecordData(
                                                                  title:
                                                                      'New comment from ${currentUserDisplayName}',
                                                                  description:
                                                                      _model
                                                                          .commentBoxTextController
                                                                          .text,
                                                                  timeCreated:
                                                                      getCurrentTimestamp,
                                                                  discussionPostRef: widget!
                                                                      .broadcastDoc
                                                                      ?.reference,
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'UserRefList':
                                                                        [
                                                                      widget!
                                                                          .broadcastDoc
                                                                          ?.userId
                                                                    ],
                                                                  },
                                                                ),
                                                              });
                                                              logFirebaseEvent(
                                                                  'Button_clear_text_fields_pin_codes');
                                                              safeSetState(() {
                                                                _model
                                                                    .commentBoxTextController
                                                                    ?.clear();
                                                              });
                                                              logFirebaseEvent(
                                                                  'Button_trigger_push_notification');
                                                              triggerPushNotification(
                                                                notificationTitle:
                                                                    'New comment from ${currentUserDisplayName}',
                                                                notificationText:
                                                                    '${currentUserDisplayName} commented on your post!',
                                                                notificationSound:
                                                                    'default',
                                                                userRefs: [
                                                                  widget!
                                                                      .broadcastDoc!
                                                                      .userId!
                                                                ],
                                                                initialPageName:
                                                                    'DiscussionPost',
                                                                parameterData: {
                                                                  'broadcastDoc':
                                                                      widget!
                                                                          .broadcastDoc,
                                                                  'groupDoc':
                                                                      widget!
                                                                          .groupDoc,
                                                                },
                                                              );
                                                              logFirebaseEvent(
                                                                  'Button_show_snack_bar');
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Comment Posted',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBtnText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                ),
                                                              );
                                                            },
                                                            text: '',
                                                            icon: Icon(
                                                              Icons.send,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              size: 20.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 48.0,
                                                              height: 48.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Open Sans',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .accent1,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey('Open Sans'),
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                            ),
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
                                  ],
                                ),
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: wrapWithModel(
                                      model: _model.groupSidebarModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: GroupSidebarWidget(
                                        groupDoc: widget!.groupDoc!,
                                      ),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
