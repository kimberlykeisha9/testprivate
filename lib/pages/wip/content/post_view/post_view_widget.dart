import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/delete_post/delete_post_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/reply_to_comment/reply_to_comment_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/group_training_list/group_training_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'post_view_model.dart';
export 'post_view_model.dart';

class PostViewWidget extends StatefulWidget {
  const PostViewWidget({
    super.key,
    this.postID,
    this.hasLiked,
    this.pageSource,
    this.completed,
    this.video,
    this.type,
    this.contentURI,
    this.descriptionPlain,
    this.featuredImage,
    this.title,
    this.userPic,
    this.userName,
    this.chatEnabled,
    this.likeCount,
    this.commentCount,
    this.commentFocus,
    this.userId,
    this.descriptionHtml,
    this.groupSlug,
    this.groupDoc,
  });

  final int? postID;
  final bool? hasLiked;
  final String? pageSource;
  final bool? completed;
  final String? video;
  final String? type;
  final String? contentURI;
  final String? descriptionPlain;
  final String? featuredImage;
  final String? title;
  final String? userPic;
  final String? userName;
  final bool? chatEnabled;
  final int? likeCount;
  final int? commentCount;
  final bool? commentFocus;
  final int? userId;
  final String? descriptionHtml;
  final String? groupSlug;
  final TribeGroupsRecord? groupDoc;

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget> {
  late PostViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostViewModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PostView'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('POST_VIEW_PAGE_PostView_ON_INIT_STATE');
      if (valueOrDefault(currentUserDocument?.tribeToken, '') != null &&
          valueOrDefault(currentUserDocument?.tribeToken, '') != '') {
        if (widget!.postID != null) {
          logFirebaseEvent('PostView_update_app_state');
          FFAppState().hasLiked = widget!.hasLiked!;
          FFAppState().likeCount = widget!.likeCount!;
          FFAppState().update(() {});
          if (widget!.pageSource == 'content') {
            if (widget!.completed!) {
              logFirebaseEvent('PostView_update_app_state');
              FFAppState().complete = true;
              FFAppState().update(() {});
            } else {
              logFirebaseEvent('PostView_update_app_state');
              FFAppState().complete = false;
              FFAppState().update(() {});
            }
          }
          logFirebaseEvent('PostView_wait__delay');
          await Future.delayed(const Duration(milliseconds: 10000));
          logFirebaseEvent('PostView_backend_call');
          _model.apiResult8rv = await ViewPostCall.call(
            baseURL: getRemoteConfigString('AppBaseApiUrl'),
            contentID: widget!.postID,
            token: valueOrDefault(currentUserDocument?.tribeToken, ''),
          );

          logFirebaseEvent('PostView_custom_action');
          await actions.toggleWakeLock(
            true,
          );
          return;
        } else {
          logFirebaseEvent('PostView_show_snack_bar');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Something went wrong',
                style: GoogleFonts.getFont(
                  'Open Sans',
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                  fontSize: 18.0,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).customColor3,
            ),
          );
          return;
        }
      } else {
        logFirebaseEvent('PostView_navigate_to');

        context.pushNamed('EntryPage');

        return;
      }
    });

    _model.commentBoxTextController ??= TextEditingController();
    _model.commentBoxFocusNode ??= FocusNode();

    _model.commentBoxFocusTextController ??= TextEditingController();
    _model.commentBoxFocusFocusNode ??= FocusNode();

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
                              'POST_VIEW_arrow_back_ios_rounded_ICN_ON_');
                          logFirebaseEvent('IconButton_navigate_to');

                          context.pushNamed(
                            'GroupsTraining',
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

                          logFirebaseEvent('IconButton_custom_action');
                          await actions.toggleWakeLock(
                            false,
                          );
                        },
                      ),
                      if (widget!.title != null && widget!.title != '')
                        Text(
                          widget!.title!,
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
                      child: Padding(
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
                    ),
                ],
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 1000.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Container(
                                            width: 350.0,
                                            height: 700.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  12.0),
                                                      child: Text(
                                                        'Your Progress',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                    ),
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          FutureBuilder<
                                                              ApiCallResponse>(
                                                        future:
                                                            GetGroupCollectionsCall
                                                                .call(
                                                          token: valueOrDefault(
                                                              currentUserDocument
                                                                  ?.tribeToken,
                                                              ''),
                                                          slug: widget!.groupDoc
                                                              ?.groupSlug,
                                                          baseURL:
                                                              getRemoteConfigString(
                                                                  'AppBaseApiUrl'),
                                                          itemsPerPage: 250,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
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

                                                              return ListView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    groupCollection
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        groupCollectionIndex) {
                                                                  final groupCollectionItem =
                                                                      groupCollection[
                                                                          groupCollectionIndex];
                                                                  return SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
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
                                                                            logFirebaseEvent('POST_VIEW_PAGE_Container_0mq08xpd_ON_TAP');
                                                                            logFirebaseEvent('GroupTrainingList_custom_action');
                                                                            await actions.printToConsole(
                                                                              listViewGetGroupCollectionsResponse.jsonBody.toString(),
                                                                            );
                                                                          },
                                                                          child:
                                                                              wrapWithModel(
                                                                            model:
                                                                                _model.groupTrainingListModels.getModel(
                                                                              getJsonField(
                                                                                groupCollectionItem,
                                                                                r'''$.id''',
                                                                              ).toString(),
                                                                              groupCollectionIndex,
                                                                            ),
                                                                            updateCallback: () =>
                                                                                safeSetState(() {}),
                                                                            child:
                                                                                GroupTrainingListWidget(
                                                                              key: Key(
                                                                                'Key0mq_${getJsonField(
                                                                                  groupCollectionItem,
                                                                                  r'''$.id''',
                                                                                ).toString()}',
                                                                              ),
                                                                              groupId: widget!.groupDoc?.tribeGroupID,
                                                                              groupSlug: widget!.groupDoc?.groupSlug,
                                                                              collectionName: getJsonField(
                                                                                groupCollectionItem,
                                                                                r'''$.name''',
                                                                              ).toString(),
                                                                              collectionDescription: null,
                                                                              totalItems: getJsonField(
                                                                                groupCollectionItem,
                                                                                r'''$.totalCount''',
                                                                              ),
                                                                              completedItems: getJsonField(
                                                                                groupCollectionItem,
                                                                                r'''$.userCompletedCount''',
                                                                              ),
                                                                              contents: getJsonField(
                                                                                groupCollectionItem,
                                                                                r'''$.Contents''',
                                                                                true,
                                                                              )!,
                                                                              groupDoc: widget!.groupDoc!,
                                                                              showThumbnails: false,
                                                                              showContentTitleOnly: true,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
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
                                      ],
                                    ),
                                  ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        child: Container(
                                          width: 800.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (functions.isStatic(
                                                            widget!.type) &&
                                                        (widget!.featuredImage !=
                                                                null &&
                                                            widget!.featuredImage !=
                                                                ''))
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
                                                              'POST_VIEW_PAGE_Image_zw1x68h3_ON_TAP');
                                                          if (functions.isLink(
                                                                  widget!
                                                                      .type) ||
                                                              functions.isZoom(
                                                                  widget!
                                                                      .type)) {
                                                            // OpenExternal
                                                            logFirebaseEvent(
                                                                'Image_OpenExternal');
                                                            await launchURL(
                                                                widget!
                                                                    .contentURI!);
                                                          } else {
                                                            // OpenImage
                                                            logFirebaseEvent(
                                                                'Image_OpenImage');
                                                            await launchURL(
                                                                '${getRemoteConfigString('AppImgBaseUrl')}${widget!.featuredImage}');
                                                          }
                                                        },
                                                        child: Image.network(
                                                          functions.featuredImageReturn(
                                                              widget!
                                                                  .featuredImage,
                                                              getRemoteConfigString(
                                                                  'AppImgBaseUrl')),
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.4,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        constraints:
                                                            BoxConstraints(
                                                          maxHeight:
                                                              MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      768.0
                                                                  ? 500.0
                                                                  : 300.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Visibility(
                                                          visible: (widget!
                                                                      .type ==
                                                                  'video') ||
                                                              (widget!.type ==
                                                                  'video embed') ||
                                                              (widget!.type ==
                                                                  'mux') ||
                                                              (widget!.type ==
                                                                  'restream') ||
                                                              (widget!.type ==
                                                                  'live streaming') ||
                                                              (widget!.type ==
                                                                  'searchie'),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.4,
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              children: [
                                                                if (!isWeb)
                                                                  Stack(
                                                                    children: [
                                                                      if ((widget!.type ==
                                                                              'video') ||
                                                                          (widget!.type ==
                                                                              'live streaming'))
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              FlutterFlowVideoPlayer(
                                                                            path:
                                                                                '${getRemoteConfigString('cdnBaseUrl')}${widget!.video}',
                                                                            videoType:
                                                                                VideoType.network,
                                                                            width:
                                                                                double.infinity,
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
                                                                      if ((widget!.type ==
                                                                              'video') ||
                                                                          (widget!.type ==
                                                                              'live streaming'))
                                                                        FlutterFlowWebView(
                                                                          content:
                                                                              '${getRemoteConfigString('AppBaseApiUrl')}/embed/${widget!.postID?.toString()}',
                                                                          bypass:
                                                                              false,
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              440.0,
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
                                                                      if ((widget!.type ==
                                                                              'live streaming') &&
                                                                          isWeb)
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              325.0,
                                                                          child:
                                                                              custom_widgets.CustomVideoWebViewWidget(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                325.0,
                                                                            videoUrl:
                                                                                functions.getLivepeerPlayerUrl(widget!.contentURI!)!,
                                                                          ),
                                                                        ),
                                                                      if (widget!
                                                                              .type ==
                                                                          'video')
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              440.0,
                                                                          child:
                                                                              custom_widgets.CustomVideoWebViewWidget(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                440.0,
                                                                            videoUrl:
                                                                                '${getRemoteConfigString('AppBaseApiUrl')}/embed/${widget!.postID?.toString()}',
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                if (functions
                                                                    .showVideoIfYoutube(
                                                                        widget!
                                                                            .video,
                                                                        widget!
                                                                            .contentURI))
                                                                  FlutterFlowYoutubePlayer(
                                                                    url: functions
                                                                        .retVidPath(
                                                                            widget!.contentURI),
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    autoPlay:
                                                                        false,
                                                                    looping:
                                                                        false,
                                                                    mute: false,
                                                                    showControls:
                                                                        true,
                                                                    showFullScreen:
                                                                        true,
                                                                    strictRelatedVideos:
                                                                        true,
                                                                  ),
                                                                if (functions
                                                                    .showVimeo(
                                                                        widget!
                                                                            .contentURI))
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        440.0,
                                                                    child: custom_widgets
                                                                        .CustomVideoWebViewWidget(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          440.0,
                                                                      videoUrl:
                                                                          'https://player.vimeo.com/video/${functions.extractVimeoId(widget!.contentURI)}?h=33160d1512&autoplay=1&color=de0101',
                                                                    ),
                                                                  ),
                                                                if (functions.isSearchie(
                                                                        widget!
                                                                            .type) ??
                                                                    true)
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -3.67),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          440.0,
                                                                      child: custom_widgets
                                                                          .CustomVideoWebViewWidget(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height:
                                                                            440.0,
                                                                        videoUrl:
                                                                            'https://app.searchie.io/file/${widget!.contentURI}/embed',
                                                                      ),
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
                                                if (valueOrDefault<bool>(
                                                  functions
                                                      .isZoom(widget!.type),
                                                  false,
                                                ))
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'POST_VIEW_PAGE_Launch_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Launch_launch_u_r_l');
                                                            await launchURL(
                                                                widget!
                                                                    .contentURI!);
                                                          },
                                                          text:
                                                              'Join Zoom Call',
                                                          icon: Icon(
                                                            Icons
                                                                .video_call_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                            size: 24.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        20.0,
                                                                        10.0,
                                                                        20.0),
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
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (valueOrDefault<bool>(
                                                  functions
                                                      .isDownload(widget!.type),
                                                  false,
                                                ))
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'POST_VIEW_PAGE_Download_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Download_launch_u_r_l');
                                                            await launchURL(
                                                                '${getRemoteConfigString('cdnBaseUrl')}${widget!.video}');
                                                          },
                                                          text: 'Get Content',
                                                          icon: Icon(
                                                            Icons.file_download,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                            size: 22.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        20.0,
                                                                        10.0,
                                                                        20.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .gray600,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (valueOrDefault<bool>(
                                                  functions
                                                      .isLink(widget!.type),
                                                  false,
                                                ))
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'POST_VIEW_PAGE_Download_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Download_launch_u_r_l');
                                                            await launchURL(
                                                                widget!
                                                                    .contentURI!);
                                                          },
                                                          text: 'Open Link',
                                                          icon: FaIcon(
                                                            FontAwesomeIcons
                                                                .externalLinkAlt,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                            size: 22.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        20.0,
                                                                        10.0,
                                                                        20.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .gray600,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                      desktop: false,
                                                    ))
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            print(
                                                                'ContentCTA pressed ...');
                                                          },
                                                          text:
                                                              'Mark as Completed',
                                                          icon: Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                            size: 24.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        20.0),
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
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          if ((widget!.pageSource ==
                                                                  'content') &&
                                                              !FFAppState()
                                                                  .complete)
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'POST_VIEW_PAGE_Completed_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Completed_backend_call');
                                                                _model.apiResultc02 =
                                                                    await CompleteGroupContentCall
                                                                        .call(
                                                                  token: valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.tribeToken,
                                                                      ''),
                                                                  baseURL:
                                                                      getRemoteConfigString(
                                                                          'AppBaseApiUrl'),
                                                                  postId: widget!
                                                                      .postID,
                                                                );

                                                                if ((_model
                                                                        .apiResultc02
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  logFirebaseEvent(
                                                                      'Completed_update_app_state');
                                                                  FFAppState()
                                                                          .complete =
                                                                      true;
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  logFirebaseEvent(
                                                                      'Completed_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Completed!',
                                                                        style: GoogleFonts
                                                                            .getFont(
                                                                          'Open Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBtnText,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .tertiary400,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'Completed_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Something went wrong',
                                                                        style: GoogleFonts
                                                                            .getFont(
                                                                          'Open Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).black600,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .alternate,
                                                                    ),
                                                                  );
                                                                }

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text:
                                                                  'Mark as Completed',
                                                              icon: Icon(
                                                                Icons
                                                                    .check_circle_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                size: 24.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        20.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
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
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                            0.0),
                                                              ),
                                                            ),
                                                          if ((widget!.pageSource ==
                                                                  'content') &&
                                                              FFAppState()
                                                                  .complete)
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'POST_VIEW_PAGE_Incomplete_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Incomplete_backend_call');
                                                                _model.apiResultc05 =
                                                                    await CompleteGroupContentCall
                                                                        .call(
                                                                  token: valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.tribeToken,
                                                                      ''),
                                                                  baseURL:
                                                                      getRemoteConfigString(
                                                                          'AppBaseApiUrl'),
                                                                  postId: widget!
                                                                      .postID,
                                                                );

                                                                if ((_model
                                                                        .apiResultc05
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  logFirebaseEvent(
                                                                      'Incomplete_update_app_state');
                                                                  FFAppState()
                                                                          .complete =
                                                                      false;
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  logFirebaseEvent(
                                                                      'Incomplete_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Set as incomplete',
                                                                        style: GoogleFonts
                                                                            .getFont(
                                                                          'Open Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBtnText,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .tertiary400,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'Incomplete_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Something went wrong',
                                                                        style: GoogleFonts
                                                                            .getFont(
                                                                          'Open Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).black600,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .alternate,
                                                                    ),
                                                                  );
                                                                }

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text:
                                                                  'Mark as Incomplete',
                                                              icon: FaIcon(
                                                                FontAwesomeIcons
                                                                    .checkCircle,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent1,
                                                                size: 24.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        20.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
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
                                                                            0.0),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0.0, 15.0, 10.0,
                                                          12.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    15.0,
                                                                    0.0),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          widget!.title!,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
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
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 5.0, 15.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                        child: Image.network(
                                                          functions.pfpNullImage(
                                                              widget!.userPic,
                                                              getRemoteConfigString(
                                                                  'AppImgBaseUrl')),
                                                          width: 35.0,
                                                          height: 35.0,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            'assets/images/error_image.jpg',
                                                            width: 35.0,
                                                            height: 35.0,
                                                            fit: BoxFit.cover,
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
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                widget!
                                                                    .userName!,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Open Sans',
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              'Open Sans'),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      if (((widget!.userId ==
                                                                  FFAppState()
                                                                      .userID) ||
                                                              (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.userRole,
                                                                      '') ==
                                                                  'admin') ||
                                                              (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.userRole,
                                                                      '') ==
                                                                  'sa')) &&
                                                          responsiveVisibility(
                                                            context: context,
                                                            phone: false,
                                                            tablet: false,
                                                            tabletLandscape:
                                                                false,
                                                            desktop: false,
                                                          ))
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    InkWell(
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
                                                                    'POST_VIEW_PAGE_Icon_e2h9he32_ON_TAP');
                                                                var _shouldSetState =
                                                                    false;
                                                                logFirebaseEvent(
                                                                    'Icon_bottom_sheet');
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return WebViewAware(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap: () =>
                                                                            FocusScope.of(context).unfocus(),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              DeletePostWidget(
                                                                            postId:
                                                                                widget!.postID,
                                                                            groupSlug:
                                                                                widget!.groupSlug,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));

                                                                logFirebaseEvent(
                                                                    'Icon_backend_call');
                                                                _model.apiResulthu7 =
                                                                    await GetGroupContentCall
                                                                        .call(
                                                                  token: valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.tribeToken,
                                                                      ''),
                                                                  slug: widget!
                                                                      .groupSlug,
                                                                  baseURL:
                                                                      getRemoteConfigString(
                                                                          'AppBaseApiUrl'),
                                                                  currentPage:
                                                                      1,
                                                                  itemsPerPage:
                                                                      25,
                                                                );

                                                                _shouldSetState =
                                                                    true;
                                                                if ((_model
                                                                        .apiResulthu7
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  logFirebaseEvent(
                                                                      'Icon_update_app_state');
                                                                  FFAppState()
                                                                          .discussionList =
                                                                      getJsonField(
                                                                    (_model.apiResulthu7
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.items''',
                                                                    true,
                                                                  )!
                                                                          .toList()
                                                                          .cast<
                                                                              dynamic>();
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  if (GetGroupContentCall
                                                                      .moreItems(
                                                                    (_model.apiResulthu7
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  )!) {
                                                                    logFirebaseEvent(
                                                                        'Icon_update_app_state');
                                                                    FFAppState()
                                                                            .showLoadMore =
                                                                        true;
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});
                                                                    logFirebaseEvent(
                                                                        'Icon_navigate_back');
                                                                    context
                                                                        .pop();
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                    return;
                                                                  } else {
                                                                    logFirebaseEvent(
                                                                        'Icon_update_app_state');
                                                                    FFAppState()
                                                                            .showLoadMore =
                                                                        false;
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});
                                                                    logFirebaseEvent(
                                                                        'Icon_navigate_back');
                                                                    context
                                                                        .pop();
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                    return;
                                                                  }
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'Icon_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Something went wrong',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          Color(
                                                                              0x00000000),
                                                                    ),
                                                                  );
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                }

                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                              },
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .ellipsisV,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .grayIcon,
                                                                size: 22.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                custom_widgets
                                                    .ContentDescriptionHTML(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 100.0,
                                                  htmlContent:
                                                      widget!.descriptionHtml!,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 10.0,
                                                          16.0, 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          InkWell(
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
                                                                  'POST_VIEW_PAGE_Stack_iq0uvsr1_ON_TAP');
                                                              var _shouldSetState =
                                                                  false;
                                                              logFirebaseEvent(
                                                                  'Stack_backend_call');
                                                              _model.likePostResult =
                                                                  await LikePostCall
                                                                      .call(
                                                                token: valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.tribeToken,
                                                                    ''),
                                                                baseURL:
                                                                    getRemoteConfigString(
                                                                        'AppBaseApiUrl'),
                                                                id: widget!
                                                                    .postID,
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .likePostResult
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                if (FFAppState()
                                                                    .hasLiked) {
                                                                  logFirebaseEvent(
                                                                      'Stack_update_app_state');
                                                                  FFAppState()
                                                                          .hasLiked =
                                                                      false;
                                                                  FFAppState()
                                                                          .likeCount =
                                                                      FFAppState()
                                                                              .likeCount +
                                                                          -1;
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'Stack_update_app_state');
                                                                  FFAppState()
                                                                          .hasLiked =
                                                                      true;
                                                                  FFAppState()
                                                                          .likeCount =
                                                                      FFAppState()
                                                                              .likeCount +
                                                                          1;
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                }
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'Stack_show_snack_bar');
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Something went wrong',
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Open Sans',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBtnText,
                                                                        fontSize:
                                                                            18.0,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .customColor3,
                                                                  ),
                                                                );
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }

                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .thumb_up_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 24.0,
                                                                ),
                                                                if (FFAppState()
                                                                    .hasLiked)
                                                                  Icon(
                                                                    Icons
                                                                        .thumb_up,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 24.0,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  '${FFAppState().likeCount.toString()} Likes',
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
                                                              ),
                                                              if (FFAppState()
                                                                  .hasLiked)
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    '${FFAppState().likeCount.toString()} Likes',
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
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      if (widget!.chatEnabled ??
                                                          true)
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                '${widget!.commentCount?.toString()} Comments',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodySmallFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodySmallFamily),
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                if (widget!.chatEnabled ?? true)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                12.0,
                                                                15.0,
                                                                12.0),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          FutureBuilder<
                                                              ApiCallResponse>(
                                                        future: GetChatByIDCall
                                                            .call(
                                                          token: valueOrDefault(
                                                              currentUserDocument
                                                                  ?.tribeToken,
                                                              ''),
                                                          id: widget!.postID,
                                                          baseURL:
                                                              getRemoteConfigString(
                                                                  'AppBaseApiUrl'),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
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
                                                          final commentListViewGetChatByIDResponse =
                                                              snapshot.data!;

                                                          return Builder(
                                                            builder: (context) {
                                                              final postComments =
                                                                  getJsonField(
                                                                commentListViewGetChatByIDResponse
                                                                    .jsonBody,
                                                                r'''$''',
                                                              ).toList();

                                                              return ListView
                                                                  .separated(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    postComments
                                                                        .length,
                                                                separatorBuilder: (_,
                                                                        __) =>
                                                                    SizedBox(
                                                                        height:
                                                                            5.0),
                                                                itemBuilder:
                                                                    (context,
                                                                        postCommentsIndex) {
                                                                  final postCommentsItem =
                                                                      postComments[
                                                                          postCommentsIndex];
                                                                  return Visibility(
                                                                    visible:
                                                                        !getJsonField(
                                                                      postCommentsItem,
                                                                      r'''$.deleted''',
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                                child: Image.network(
                                                                                  functions.pfpNullImage(
                                                                                      getJsonField(
                                                                                        postCommentsItem,
                                                                                        r'''$.User.photoUrl''',
                                                                                      ).toString(),
                                                                                      getRemoteConfigString('AppImgBaseUrl')),
                                                                                  width: 35.0,
                                                                                  height: 35.0,
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    'assets/images/error_image.jpg',
                                                                                    width: 35.0,
                                                                                    height: 35.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: double.infinity,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0x7FE1E5EA),
                                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        getJsonField(
                                                                                                          postCommentsItem,
                                                                                                          r'''$.displayName''',
                                                                                                        ).toString(),
                                                                                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                              fontFamily: 'Open Sans',
                                                                                                              fontSize: 16.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                            ),
                                                                                                      ),
                                                                                                      Text(
                                                                                                        getJsonField(
                                                                                                          postCommentsItem,
                                                                                                          r'''$.messagePlain''',
                                                                                                        ).toString(),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Open Sans',
                                                                                                              fontSize: 14.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                            ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                        child: Text(
                                                                                                          dateTimeFormat(
                                                                                                              "relative",
                                                                                                              functions.formatDate(getJsonField(
                                                                                                                postCommentsItem,
                                                                                                                r'''$.createdAt''',
                                                                                                              ).toString())),
                                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                fontFamily: 'Open Sans',
                                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FontStyle.italic,
                                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 10.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    logFirebaseEvent('POST_VIEW_PAGE_ReplyButton_ON_TAP');
                                                                                                    logFirebaseEvent('ReplyButton_bottom_sheet');
                                                                                                    await showModalBottomSheet(
                                                                                                      isScrollControlled: true,
                                                                                                      backgroundColor: FlutterFlowTheme.of(context).black600,
                                                                                                      barrierColor: Color(0x00000000),
                                                                                                      context: context,
                                                                                                      builder: (context) {
                                                                                                        return WebViewAware(
                                                                                                          child: GestureDetector(
                                                                                                            onTap: () => FocusScope.of(context).unfocus(),
                                                                                                            child: Padding(
                                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                                              child: ReplyToCommentWidget(
                                                                                                                postID: widget!.postID,
                                                                                                                parentID: getJsonField(
                                                                                                                  postCommentsItem,
                                                                                                                  r'''$.id''',
                                                                                                                ),
                                                                                                                currentComment: postCommentsItem,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ).then((value) => safeSetState(() {}));
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    'Reply',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Open Sans',
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          fontSize: 10.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
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
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Flexible(
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            final replies = getJsonField(
                                                                                              postCommentsItem,
                                                                                              r'''$.replies''',
                                                                                            ).toList();

                                                                                            return Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: List.generate(replies.length, (repliesIndex) {
                                                                                                final repliesItem = replies[repliesIndex];
                                                                                                return Visibility(
                                                                                                  visible: !getJsonField(
                                                                                                    repliesItem,
                                                                                                    r'''$.deleted''',
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          ClipRRect(
                                                                                                            borderRadius: BorderRadius.circular(40.0),
                                                                                                            child: Image.network(
                                                                                                              functions.pfpNullImage(
                                                                                                                  getJsonField(
                                                                                                                    repliesItem,
                                                                                                                    r'''$.User.photoUrl''',
                                                                                                                  ).toString(),
                                                                                                                  getRemoteConfigString('AppImgBaseUrl')),
                                                                                                              width: 35.0,
                                                                                                              height: 35.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                                'assets/images/error_image.jpg',
                                                                                                                width: 35.0,
                                                                                                                height: 35.0,
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                                                    child: Column(
                                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                      children: [
                                                                                                                        Container(
                                                                                                                          width: MediaQuery.sizeOf(context).width * 0.55,
                                                                                                                          constraints: BoxConstraints(
                                                                                                                            maxWidth: 560.0,
                                                                                                                          ),
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: Color(0x7FE1E5EA),
                                                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                                                          ),
                                                                                                                          child: Padding(
                                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                                                                                                                            child: Column(
                                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                              children: [
                                                                                                                                Text(
                                                                                                                                  getJsonField(
                                                                                                                                    repliesItem,
                                                                                                                                    r'''$.displayName''',
                                                                                                                                  ).toString(),
                                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                        fontFamily: 'Open Sans',
                                                                                                                                        fontSize: 16.0,
                                                                                                                                        letterSpacing: 0.0,
                                                                                                                                        fontWeight: FontWeight.bold,
                                                                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                                                      ),
                                                                                                                                ),
                                                                                                                                Text(
                                                                                                                                  getJsonField(
                                                                                                                                    repliesItem,
                                                                                                                                    r'''$.messagePlain''',
                                                                                                                                  ).toString(),
                                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                        fontFamily: 'Open Sans',
                                                                                                                                        fontSize: 14.0,
                                                                                                                                        letterSpacing: 0.0,
                                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                                                                                      ),
                                                                                                                                ),
                                                                                                                                Padding(
                                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                                                  child: Text(
                                                                                                                                    dateTimeFormat(
                                                                                                                                        "relative",
                                                                                                                                        functions.formatDate(getJsonField(
                                                                                                                                          repliesItem,
                                                                                                                                          r'''$.createdAt''',
                                                                                                                                        ).toString())),
                                                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                                          fontFamily: 'Open Sans',
                                                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                          fontSize: 12.0,
                                                                                                                                          letterSpacing: 0.0,
                                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                                          fontStyle: FontStyle.italic,
                                                                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
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
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
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
                                        ),
                                      ),
                                      if (widget!.chatEnabled ?? true)
                                        Container(
                                          width: 800.0,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x26000000),
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
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        8.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
                                                                          width:
                                                                              35.0,
                                                                          height:
                                                                              35.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0),
                                                                        child: Image
                                                                            .network(
                                                                          functions.imageReturn(
                                                                              FFAppState().currentUserImg,
                                                                              getRemoteConfigString('AppImgBaseUrl')),
                                                                          width:
                                                                              35.0,
                                                                          height:
                                                                              35.0,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          _model
                                                                              .commentBoxTextController,
                                                                      focusNode:
                                                                          _model
                                                                              .commentBoxFocusNode,
                                                                      autofocus:
                                                                          false,
                                                                      textCapitalization:
                                                                          TextCapitalization
                                                                              .sentences,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Leave a Comment',
                                                                        hintStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              color: FlutterFlowTheme.of(context).grayIcon,
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                            ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0x00000000),
                                                                            width:
                                                                                0.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0x00000000),
                                                                            width:
                                                                                0.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        errorBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0x00000000),
                                                                            width:
                                                                                0.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        focusedErrorBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0x00000000),
                                                                            width:
                                                                                0.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            0.0,
                                                                            0.0),
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey('Open Sans'),
                                                                            lineHeight:
                                                                                1.1,
                                                                          ),
                                                                      maxLines:
                                                                          4,
                                                                      minLines:
                                                                          1,
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
                                                                          'POST_VIEW_PAGE__BTN_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'Button_backend_call');
                                                                      _model.chatResponse2 =
                                                                          await CreateChatCall
                                                                              .call(
                                                                        token: valueOrDefault(
                                                                            currentUserDocument?.tribeToken,
                                                                            ''),
                                                                        userId: FFAppState()
                                                                            .userID
                                                                            .toString(),
                                                                        contentId:
                                                                            widget!.postID,
                                                                        message: _model
                                                                            .commentBoxTextController
                                                                            .text,
                                                                        baseURL:
                                                                            getRemoteConfigString('AppBaseApiUrl'),
                                                                      );

                                                                      if ((_model
                                                                              .chatResponse2
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        logFirebaseEvent(
                                                                            'Button_clear_text_fields_pin_codes');
                                                                        safeSetState(
                                                                            () {
                                                                          _model
                                                                              .commentBoxTextController
                                                                              ?.clear();
                                                                          _model
                                                                              .commentBoxFocusTextController
                                                                              ?.clear();
                                                                        });
                                                                        logFirebaseEvent(
                                                                            'Button_show_snack_bar');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Message Posted!',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 2000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).tertiary400,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        logFirebaseEvent(
                                                                            'Button_show_snack_bar');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Failed to post comment.',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                          ),
                                                                        );
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    text: '',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .send,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
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
                                                                                'Outfit',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey('Outfit'),
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
                                              if ((widget!.commentFocus ??
                                                      true) &&
                                                  responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                    tabletLandscape: false,
                                                    desktop: false,
                                                  ))
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x1A000000),
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
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 80.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
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
                                                                            BorderRadius.circular(40.0),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            currentUserPhoto,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                                          ),
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          18.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _model.commentBoxFocusTextController,
                                                                        focusNode:
                                                                            _model.commentBoxFocusFocusNode,
                                                                        autofocus:
                                                                            true,
                                                                        textCapitalization:
                                                                            TextCapitalization.sentences,
                                                                        obscureText:
                                                                            false,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Leave a Comment',
                                                                          hintStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                color: FlutterFlowTheme.of(context).grayIcon,
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                              ),
                                                                          enabledBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x00000000),
                                                                              width: 0.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x00000000),
                                                                              width: 0.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                          errorBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x00000000),
                                                                              width: 0.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                          focusedErrorBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x00000000),
                                                                              width: 0.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans'),
                                                                              lineHeight: 1.1,
                                                                            ),
                                                                        maxLines:
                                                                            4,
                                                                        minLines:
                                                                            1,
                                                                        keyboardType:
                                                                            TextInputType.multiline,
                                                                        validator: _model
                                                                            .commentBoxFocusTextControllerValidator
                                                                            .asValidator(context),
                                                                      ),
                                                                    ),
                                                                  ),
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
                                                                            'POST_VIEW_PAGE__BTN_ON_TAP');
                                                                        logFirebaseEvent(
                                                                            'Button_backend_call');
                                                                        _model.chatResponse =
                                                                            await CreateChatCall.call(
                                                                          token: valueOrDefault(
                                                                              currentUserDocument?.tribeToken,
                                                                              ''),
                                                                          userId: FFAppState()
                                                                              .userID
                                                                              .toString(),
                                                                          contentId:
                                                                              widget!.postID,
                                                                          message: _model
                                                                              .commentBoxFocusTextController
                                                                              .text,
                                                                          baseURL:
                                                                              getRemoteConfigString('AppBaseApiUrl'),
                                                                        );

                                                                        if ((_model.chatResponse?.succeeded ??
                                                                            true)) {
                                                                          logFirebaseEvent(
                                                                              'Button_clear_text_fields_pin_codes');
                                                                          safeSetState(
                                                                              () {
                                                                            _model.commentBoxFocusTextController?.clear();
                                                                            _model.commentBoxTextController?.clear();
                                                                          });
                                                                          logFirebaseEvent(
                                                                              'Button_show_snack_bar');
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Message Posted!',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 2000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).tertiary400,
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          logFirebaseEvent(
                                                                              'Button_show_snack_bar');
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Failed to post comment.',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                          );
                                                                        }

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text: '',
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .send,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .accent1,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            40.0,
                                                                        height:
                                                                            40.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Outfit',
                                                                              color: Colors.white,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Outfit'),
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50.0),
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
                                            ],
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
            ],
          ),
        ),
      ),
    );
  }
}
