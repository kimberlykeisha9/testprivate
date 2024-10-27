import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/create_account_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/challenge_post_stats/challenge_post_stats_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/wip/discussion_comment/discussion_comment_widget.dart';
import 'dart:async';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'group_content_model.dart';
export 'group_content_model.dart';

class GroupContentWidget extends StatefulWidget {
  const GroupContentWidget({
    super.key,
    this.collectionRef,
    this.groupDoc,
  });

  final DocumentReference? collectionRef;
  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupContentWidget> createState() => _GroupContentWidgetState();
}

class _GroupContentWidgetState extends State<GroupContentWidget>
    with TickerProviderStateMixin {
  late GroupContentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupContentModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupContent'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('GROUP_CONTENT_GroupContent_ON_INIT_STATE');
      logFirebaseEvent('GroupContent_custom_action');
      await actions.toggleWakeLock(
        true,
      );
      logFirebaseEvent('GroupContent_wait__delay');
      await Future.delayed(const Duration(milliseconds: 10000));
      if (loggedIn) {
        logFirebaseEvent('GroupContent_backend_call');

        await widget!.collectionRef!.update({
          ...mapToFirestore(
            {
              'totalViews': FieldValue.increment(1),
              'watchedBy': FieldValue.arrayUnion([currentUserReference]),
            },
          ),
        });
      }
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TribeCollectionsRecord>(
      stream: TribeCollectionsRecord.getDocument(widget!.collectionRef!),
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

        final groupContentTribeCollectionsRecord = snapshot.data!;

        return YoutubeFullScreenWrapper(
          child: GestureDetector(
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
                            buttonSize: 50.0,
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: FlutterFlowTheme.of(context).accent1,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'GROUP_CONTENT_arrow_back_ios_rounded_ICN');
                              logFirebaseEvent('IconButton_navigate_back');
                              context.pop();
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  groupContentTribeCollectionsRecord.title,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .headlineMediumFamily),
                                        lineHeight: 1.2,
                                      ),
                                ),
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                  Text(
                                    dateTimeFormat(
                                        "MMMEd",
                                        groupContentTribeCollectionsRecord
                                            .publishDate!),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                          lineHeight: 1.1,
                                        ),
                                  ),
                              ],
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
              body: SafeArea(
                top: true,
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Container(
                                    width: 700.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
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
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, -1.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              constraints: BoxConstraints(
                                                maxWidth: 730.0,
                                              ),
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            if (functions.isStatic(
                                                                    groupContentTribeCollectionsRecord
                                                                        .contentType) &&
                                                                (groupContentTribeCollectionsRecord
                                                                            .featuredImage !=
                                                                        null &&
                                                                    groupContentTribeCollectionsRecord
                                                                            .featuredImage !=
                                                                        ''))
                                                              Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  groupContentTribeCollectionsRecord
                                                                      .featuredImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                                ),
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            if (!isWeb)
                                                              Stack(
                                                                children: [
                                                                  if (((groupContentTribeCollectionsRecord.contentType ==
                                                                              'video') ||
                                                                          (groupContentTribeCollectionsRecord.contentType ==
                                                                              'live streaming')) &&
                                                                      responsiveVisibility(
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
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          FlutterFlowVideoPlayer(
                                                                        path:
                                                                            '${getRemoteConfigString('cdnBaseUrl')}${groupContentTribeCollectionsRecord.featuredVideo}',
                                                                        videoType:
                                                                            VideoType.network,
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        autoPlay:
                                                                            false,
                                                                        looping:
                                                                            false,
                                                                        showControls:
                                                                            true,
                                                                        allowFullScreen:
                                                                            true,
                                                                        allowPlaybackSpeedMenu:
                                                                            true,
                                                                        lazyLoad:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  if ((groupContentTribeCollectionsRecord
                                                                              .contentType ==
                                                                          'video') ||
                                                                      (groupContentTribeCollectionsRecord
                                                                              .contentType ==
                                                                          'live streaming'))
                                                                    FlutterFlowWebView(
                                                                      content:
                                                                          '${getRemoteConfigString('AppBaseApiUrl')}/embed/${groupContentTribeCollectionsRecord.tribeContentID.toString()}',
                                                                      bypass:
                                                                          false,
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          250.0,
                                                                      verticalScroll:
                                                                          false,
                                                                      horizontalScroll:
                                                                          false,
                                                                    ),
                                                                ],
                                                              ),
                                                            if (isWeb)
                                                              Stack(
                                                                children: [
                                                                  if (groupContentTribeCollectionsRecord
                                                                          .contentType ==
                                                                      'live streaming')
                                                                    custom_widgets
                                                                        .CustomVideoWebViewWidget(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          370.0,
                                                                      videoUrl:
                                                                          functions
                                                                              .getLivepeerPlayerUrl(groupContentTribeCollectionsRecord.featuredVideo)!,
                                                                    ),
                                                                  if (groupContentTribeCollectionsRecord
                                                                          .contentType ==
                                                                      'video')
                                                                    custom_widgets
                                                                        .CustomVideoWebViewWidget(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          370.0,
                                                                      videoUrl:
                                                                          '${getRemoteConfigString('AppBaseApiUrl')}/embed/${groupContentTribeCollectionsRecord.tribeContentID.toString()}',
                                                                    ),
                                                                ],
                                                              ),
                                                            if (functions.isSearchie(
                                                                    groupContentTribeCollectionsRecord
                                                                        .contentType) ??
                                                                true)
                                                              custom_widgets
                                                                  .CustomVideoWebViewWidget(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: 370.0,
                                                                videoUrl:
                                                                    'https://app.searchie.io/file/${groupContentTribeCollectionsRecord.featuredVideo}/embed',
                                                              ),
                                                            if (groupContentTribeCollectionsRecord
                                                                    .contentType ==
                                                                'video embed')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    FlutterFlowYoutubePlayer(
                                                                  url: valueOrDefault<
                                                                      String>(
                                                                    functions.retVidPath(
                                                                        groupContentTribeCollectionsRecord
                                                                            .featuredVideo),
                                                                    'https://www.youtube.com/watch?v=NpEaa2P7qZI',
                                                                  ),
                                                                  autoPlay:
                                                                      false,
                                                                  looping:
                                                                      false,
                                                                  mute: false,
                                                                  showControls:
                                                                      true,
                                                                  showFullScreen:
                                                                      true,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    15.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if ((groupContentTribeCollectionsRecord
                                                                            .title !=
                                                                        null &&
                                                                    groupContentTribeCollectionsRecord
                                                                            .title !=
                                                                        '') &&
                                                                responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                ))
                                                              Text(
                                                                groupContentTribeCollectionsRecord
                                                                    .title,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (groupContentTribeCollectionsRecord
                                                                        .description !=
                                                                    null &&
                                                                groupContentTribeCollectionsRecord
                                                                        .description !=
                                                                    '')
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      SelectionArea(
                                                                          child:
                                                                              Text(
                                                                    groupContentTribeCollectionsRecord
                                                                        .description,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          fontSize:
                                                                              15.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                          lineHeight:
                                                                              1.2,
                                                                        ),
                                                                  )),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (!(isWeb
                                                          ? MediaQuery.viewInsetsOf(
                                                                      context)
                                                                  .bottom >
                                                              0
                                                          : _isKeyboardVisible))
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            if (((valueOrDefault(
                                                                            currentUserDocument
                                                                                ?.userRole,
                                                                            '') ==
                                                                        'admin') &&
                                                                    (groupContentTribeCollectionsRecord.ctaBtnText !=
                                                                            null &&
                                                                        groupContentTribeCollectionsRecord.ctaBtnText !=
                                                                            '')) &&
                                                                responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                  tabletLandscape:
                                                                      false,
                                                                  desktop:
                                                                      false,
                                                                ))
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            10.0,
                                                                            0.0),
                                                                child:
                                                                    AuthUserStreamWidget(
                                                                  builder:
                                                                      (context) =>
                                                                          FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'GROUP_CONTENT_PAGE_STATS_BTN_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Button_bottom_sheet');
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        barrierColor:
                                                                            Color(0x00000000),
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return WebViewAware(
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () => FocusScope.of(context).unfocus(),
                                                                              child: Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: Container(
                                                                                  height: MediaQuery.sizeOf(context).height * 0.9,
                                                                                  child: ChallengePostStatsWidget(
                                                                                    contentId: groupContentTribeCollectionsRecord.tribeContentID,
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
                                                                    text:
                                                                        'Stats',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleSmallFamily,
                                                                            color:
                                                                                Colors.white,
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
                                                                    showLoadingIndicator:
                                                                        false,
                                                                  ),
                                                                ),
                                                              ),
                                                            if (valueOrDefault<
                                                                bool>(
                                                              groupContentTribeCollectionsRecord
                                                                          .ctaBtnText !=
                                                                      null &&
                                                                  groupContentTribeCollectionsRecord
                                                                          .ctaBtnText !=
                                                                      '',
                                                              false,
                                                            ))
                                                              Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          15.0,
                                                                          5.0,
                                                                          15.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'GROUP_CONTENT_SHARE_TO_QUALIFY_TO_WIN_DA');
                                                                      if (groupContentTribeCollectionsRecord
                                                                          .ctaSharable) {
                                                                        if (loggedIn) {
                                                                          logFirebaseEvent(
                                                                              'Button_share');
                                                                          await Share
                                                                              .share(
                                                                            groupContentTribeCollectionsRecord.ctaLink,
                                                                            sharePositionOrigin:
                                                                                getWidgetBoundingBox(context),
                                                                          );
                                                                          logFirebaseEvent(
                                                                              'Button_backend_call');

                                                                          await ContentSharesRecord
                                                                              .collection
                                                                              .doc()
                                                                              .set(createContentSharesRecordData(
                                                                                contentid: groupContentTribeCollectionsRecord.tribeContentID,
                                                                                userEmail: currentUserEmail,
                                                                                userRef: currentUserReference,
                                                                                userDisplayName: currentUserDisplayName,
                                                                                createdTime: getCurrentTimestamp,
                                                                              ));
                                                                        } else {
                                                                          logFirebaseEvent(
                                                                              'Button_bottom_sheet');
                                                                          await showModalBottomSheet(
                                                                            isScrollControlled:
                                                                                true,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            barrierColor:
                                                                                Color(0x00000000),
                                                                            enableDrag:
                                                                                false,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return WebViewAware(
                                                                                child: GestureDetector(
                                                                                  onTap: () => FocusScope.of(context).unfocus(),
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: CreateAccountWidget(),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ).then((value) =>
                                                                              safeSetState(() {}));
                                                                        }
                                                                      } else {
                                                                        logFirebaseEvent(
                                                                            'Button_launch_u_r_l');
                                                                        await launchURL(
                                                                            groupContentTribeCollectionsRecord.ctaLink);
                                                                      }
                                                                    },
                                                                    text: groupContentTribeCollectionsRecord
                                                                        .ctaBtnText,
                                                                    icon:
                                                                        FaIcon(
                                                                      FontAwesomeIcons
                                                                          .chevronCircleRight,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
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
                                                                    showLoadingIndicator:
                                                                        false,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      if (groupContentTribeCollectionsRecord
                                                          .chatEnabled)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      15.0,
                                                                      12.0,
                                                                      15.0,
                                                                      12.0),
                                                          child: StreamBuilder<
                                                              List<
                                                                  ChatMessagesRecord>>(
                                                            stream:
                                                                queryChatMessagesRecord(
                                                              queryBuilder: (chatMessagesRecord) =>
                                                                  chatMessagesRecord
                                                                      .where(
                                                                        'contentID',
                                                                        isEqualTo:
                                                                            groupContentTribeCollectionsRecord.tribeContentID,
                                                                      )
                                                                      .where(
                                                                        'deleted',
                                                                        isEqualTo:
                                                                            false,
                                                                      )
                                                                      .orderBy(
                                                                          'date',
                                                                          descending:
                                                                              true),
                                                              limit: 100,
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
                                                              List<ChatMessagesRecord>
                                                                  commentListViewChatMessagesRecordList =
                                                                  snapshot
                                                                      .data!;

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
                                                                    commentListViewChatMessagesRecordList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        commentListViewIndex) {
                                                                  final commentListViewChatMessagesRecord =
                                                                      commentListViewChatMessagesRecordList[
                                                                          commentListViewIndex];
                                                                  return wrapWithModel(
                                                                    model: _model
                                                                        .discussionCommentModels
                                                                        .getModel(
                                                                      commentListViewChatMessagesRecord
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
                                                                        'Keydqn_${commentListViewChatMessagesRecord.reference.id}',
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
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (groupContentTribeCollectionsRecord
                                            .chatEnabled)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Stack(
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 2.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBtnText,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x26000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .textController,
                                                              focusNode: _model
                                                                  .textFieldFocusNode,
                                                              autofocus: false,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: false,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Open Sans',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              'Open Sans'),
                                                                    ),
                                                                hintText:
                                                                    'Join the conversation...',
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
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
                                                                  ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              validator: _model
                                                                  .textControllerValidator
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
                                                                  'GROUP_CONTENT_PAGE__BTN_ON_TAP');
                                                              if (_model.textController
                                                                          .text !=
                                                                      null &&
                                                                  _model.textController
                                                                          .text !=
                                                                      '') {
                                                                logFirebaseEvent(
                                                                    'Button_backend_call');

                                                                await ChatMessagesRecord
                                                                    .collection
                                                                    .doc()
                                                                    .set(
                                                                        createChatMessagesRecordData(
                                                                      message: _model
                                                                          .textController
                                                                          .text,
                                                                      user:
                                                                          currentUserReference,
                                                                      date:
                                                                          getCurrentTimestamp,
                                                                      deleted:
                                                                          false,
                                                                      contentID:
                                                                          groupContentTribeCollectionsRecord
                                                                              .tribeContentID,
                                                                      authorName:
                                                                          currentUserDisplayName,
                                                                      authorImg:
                                                                          currentUserPhoto,
                                                                      tribeCollectionRef:
                                                                          widget!
                                                                              .collectionRef,
                                                                    ));
                                                                logFirebaseEvent(
                                                                    'Button_backend_call');

                                                                await widget!
                                                                    .collectionRef!
                                                                    .update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'commentCount':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    },
                                                                  ),
                                                                });
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
                                                                            .textController
                                                                            .text,
                                                                    timeCreated:
                                                                        getCurrentTimestamp,
                                                                    tribeCollectionsRef:
                                                                        widget!
                                                                            .collectionRef,
                                                                  ),
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'UserRefList':
                                                                          [
                                                                        groupContentTribeCollectionsRecord
                                                                            .authorRef
                                                                      ],
                                                                    },
                                                                  ),
                                                                });
                                                                logFirebaseEvent(
                                                                    'Button_clear_text_fields_pin_codes');
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .textController
                                                                      ?.clear();
                                                                });
                                                              }
                                                            },
                                                            text: '',
                                                            icon: Icon(
                                                              Icons.send,
                                                              size: 20.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 40.0,
                                                              height: 40.0,
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
                                                                            'Outfit',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey('Outfit'),
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
                                                if (!loggedIn)
                                                  InkWell(
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
                                                          'GROUP_CONTENT_PAGE_BlockGuests_ON_TAP');
                                                      logFirebaseEvent(
                                                          'BlockGuests_navigate_to');

                                                      context.pushNamed(
                                                        'EntryPage',
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .bottomToTop,
                                                          ),
                                                        },
                                                      );
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 3.0,
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xC51E3653),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'Create a free account to comment',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Poppins'),
                                                              ),
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
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                              ))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 350.0,
                                        height: 500.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                child: Text(
                                                  'Additional Replays',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                              ),
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                              ))
                                                FutureBuilder<
                                                    List<
                                                        TribeCollectionsRecord>>(
                                                  future:
                                                      queryTribeCollectionsRecordOnce(
                                                    queryBuilder:
                                                        (tribeCollectionsRecord) =>
                                                            tribeCollectionsRecord
                                                                .where(
                                                                  'groupRefs',
                                                                  arrayContains:
                                                                      widget!
                                                                          .groupDoc
                                                                          ?.reference,
                                                                )
                                                                .where(
                                                                  'publishDate',
                                                                  isLessThanOrEqualTo:
                                                                      getCurrentTimestamp,
                                                                )
                                                                .orderBy(
                                                                    'publishDate',
                                                                    descending:
                                                                        true),
                                                    limit: 5,
                                                  ),
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
                                                    List<TribeCollectionsRecord>
                                                        listViewTribeCollectionsRecordList =
                                                        snapshot.data!;
                                                    if (listViewTribeCollectionsRecordList
                                                        .isEmpty) {
                                                      return EmptyListWidget();
                                                    }

                                                    return ListView.builder(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        0,
                                                        20.0,
                                                        0,
                                                        0,
                                                      ),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          listViewTribeCollectionsRecordList
                                                              .length,
                                                      itemBuilder: (context,
                                                          listViewIndex) {
                                                        final listViewTribeCollectionsRecord =
                                                            listViewTribeCollectionsRecordList[
                                                                listViewIndex];
                                                        return Visibility(
                                                          visible:
                                                              valueOrDefault<
                                                                  bool>(
                                                            functions.shouldDisplayContent(
                                                                listViewTribeCollectionsRecord
                                                                    .publishDate
                                                                    ?.toString(),
                                                                listViewTribeCollectionsRecord
                                                                    .endDate
                                                                    ?.toString()),
                                                            false,
                                                          ),
                                                          child: Align(
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
                                                                          12.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          40.0,
                                                                      color: Color(
                                                                          0x337090B0),
                                                                      offset:
                                                                          Offset(
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
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'GROUP_CONTENT_PAGE_Row_7oj4bu3o_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Row_navigate_to');

                                                                    context
                                                                        .pushNamed(
                                                                      'GroupContent',
                                                                      queryParameters:
                                                                          {
                                                                        'collectionRef':
                                                                            serializeParam(
                                                                          listViewTribeCollectionsRecord
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
                                                                            widget!.groupDoc,
                                                                        kTransitionInfoKey:
                                                                            TransitionInfo(
                                                                          hasTransition:
                                                                              true,
                                                                          transitionType:
                                                                              PageTransitionType.fade,
                                                                          duration:
                                                                              Duration(milliseconds: 0),
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
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              60.0,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Hero(
                                                                                tag: listViewTribeCollectionsRecord.featuredImage,
                                                                                transitionOnUserGestures: true,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(10.0),
                                                                                    bottomRight: Radius.circular(0.0),
                                                                                    topLeft: Radius.circular(10.0),
                                                                                    topRight: Radius.circular(0.0),
                                                                                  ),
                                                                                  child: CachedNetworkImage(
                                                                                    fadeInDuration: Duration(milliseconds: 500),
                                                                                    fadeOutDuration: Duration(milliseconds: 500),
                                                                                    imageUrl: listViewTribeCollectionsRecord.featuredImage,
                                                                                    width: 100.0,
                                                                                    height: 80.0,
                                                                                    fit: BoxFit.cover,
                                                                                    errorWidget: (context, error, stackTrace) => Image.asset(
                                                                                      'assets/images/error_image.jpg',
                                                                                      width: 100.0,
                                                                                      height: 80.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                dateTimeFormat("yMMMd", listViewTribeCollectionsRecord.publishDate!),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Open Sans',
                                                                                      color: FlutterFlowTheme.of(context).grayIcon,
                                                                                      fontSize: 11.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FontStyle.italic,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                listViewTribeCollectionsRecord.title,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      fontSize: 18.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                      lineHeight: 1.2,
                                                                                    ),
                                                                              ),
                                                                              if (listViewTribeCollectionsRecord.commentCount > 0)
                                                                                RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: listViewTribeCollectionsRecord.commentCount.toString(),
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                            ),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: ' comments',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                            ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
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
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'listViewOnPageLoadAnimation']!);
                                                  },
                                                ),
                                            ],
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
