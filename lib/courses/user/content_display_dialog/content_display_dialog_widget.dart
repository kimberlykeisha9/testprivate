import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'content_display_dialog_model.dart';
export 'content_display_dialog_model.dart';

class ContentDisplayDialogWidget extends StatefulWidget {
  const ContentDisplayDialogWidget({
    super.key,
    required this.contentDoc,
    this.groupDoc,
    String? pageSource,
    this.contentUrl,
    required this.courseDoc,
    required this.collectionDoc,
    this.completedCallback,
  }) : this.pageSource = pageSource ?? 'content';

  final TribeContentRecord? contentDoc;
  final TribeGroupsRecord? groupDoc;
  final String pageSource;
  final String? contentUrl;
  final TribeCourseRecord? courseDoc;
  final TribeCollectionRecord? collectionDoc;
  final Future Function()? completedCallback;

  @override
  State<ContentDisplayDialogWidget> createState() =>
      _ContentDisplayDialogWidgetState();
}

class _ContentDisplayDialogWidgetState extends State<ContentDisplayDialogWidget>
    with TickerProviderStateMixin {
  late ContentDisplayDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContentDisplayDialogModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Builder(
                  builder: (context) {
                    if (valueOrDefault<bool>(
                      valueOrDefault<bool>(
                            valueOrDefault<bool>(
                                  widget!.contentDoc?.contentType == 'video',
                                  false,
                                ) ||
                                valueOrDefault<bool>(
                                  widget!.contentDoc?.contentType ==
                                      'video embed',
                                  false,
                                ) ||
                                valueOrDefault<bool>(
                                  widget!.contentDoc?.contentType == 'searchie',
                                  false,
                                ) ||
                                valueOrDefault<bool>(
                                  widget!.contentDoc?.contentType == 'Video',
                                  false,
                                ),
                            false,
                          ) &&
                          (widget!.contentDoc?.featuredVideo != null &&
                              widget!.contentDoc?.featuredVideo != ''),
                      false,
                    )) {
                      return Builder(
                        builder: (context) {
                          if ((widget!.contentDoc?.contentType == 'video') ||
                              (widget!.contentDoc?.contentType == 'Video')) {
                            return Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: FlutterFlowVideoPlayer(
                                      path:
                                          '${widget!.contentDoc?.featuredVideo}',
                                      videoType: VideoType.network,
                                      width: 600.0,
                                      aspectRatio: 1.7,
                                      autoPlay: false,
                                      looping: true,
                                      showControls: true,
                                      allowFullScreen: true,
                                      allowPlaybackSpeedMenu: false,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FlutterFlowWebView(
                                    content: widget!.contentDoc!.featuredVideo,
                                    bypass: false,
                                    width: 640.0,
                                    height: 360.0,
                                    verticalScroll: false,
                                    horizontalScroll: false,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    } else if (valueOrDefault<bool>(
                      valueOrDefault<bool>(
                            widget!.contentDoc?.contentType == 'download',
                            false,
                          ) ||
                          valueOrDefault<bool>(
                            widget!.contentDoc?.contentType == 'link',
                            false,
                          ),
                      false,
                    )) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'CONTENT_DISPLAY_DIALOG_Image_9fg1i04a_ON');
                          logFirebaseEvent('Image_launch_u_r_l');
                          await launchURL(widget!.contentDoc!.ctaLink);
                        },
                        child: Image.network(
                          valueOrDefault<String>(
                            widget!.contentDoc?.featuredImage,
                            'https://images.unsplash.com/photo-1659813254494-fbf374803c7e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTcwOTI4MzQ5OXww&ixlib=rb-4.0.3&q=80&w=1080',
                          ),
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/error_image.jpg',
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    } else if (valueOrDefault<String>(
                              widget!.contentDoc?.featuredImage,
                              'https://images.unsplash.com/photo-1659813254494-fbf374803c7e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTcwOTI4MzQ5OXww&ixlib=rb-4.0.3&q=80&w=1080',
                            ) !=
                            null &&
                        valueOrDefault<String>(
                              widget!.contentDoc?.featuredImage,
                              'https://images.unsplash.com/photo-1659813254494-fbf374803c7e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTcwOTI4MzQ5OXww&ixlib=rb-4.0.3&q=80&w=1080',
                            ) !=
                            '') {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'CONTENT_DISPLAY_DIALOG_featuredImage_ON_');
                          if (functions
                                  .isLink(widget!.contentDoc?.contentType) ||
                              functions
                                  .isZoom(widget!.contentDoc?.contentType)) {
                            // OpenExternal
                            logFirebaseEvent('featuredImage_OpenExternal');
                            await launchURL(widget!.contentUrl!);
                          } else {
                            logFirebaseEvent('featuredImage_launch_u_r_l');
                            await launchURL(
                                '${getRemoteConfigString('AppImgBaseUrl')}${functions.imgPathToString(widget!.contentDoc!.featuredImage)}');
                          }
                        },
                        child: Image.network(
                          valueOrDefault<String>(
                            widget!.contentDoc?.featuredImage,
                            'https://images.unsplash.com/photo-1659813254494-fbf374803c7e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjYWxtaW5nJTIwbmF0dXJlfGVufDB8fHx8MTcwOTI4MzQ5OXww&ixlib=rb-4.0.3&q=80&w=1080',
                          ),
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/error_image.jpg',
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'CONTENT_DISPLAY_DIALOG_groupImage_ON_TAP');
                          logFirebaseEvent('groupImage_launch_u_r_l');
                          await launchURL(widget!.contentDoc!.ctaLink);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            widget!.groupDoc!.featuredImg,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/error_image.jpg',
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 10.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectionArea(
                    child: Text(
                  valueOrDefault<String>(
                    widget!.contentDoc?.title,
                    'Content title',
                  ),
                  style: FlutterFlowTheme.of(context).displayMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).displayMediumFamily,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).displayMediumFamily),
                      ),
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (valueOrDefault<bool>(
                  (widget!.contentDoc?.ctaLink != null &&
                          widget!.contentDoc?.ctaLink != '') &&
                      (widget!.contentDoc?.contentType == 'download'),
                  false,
                ))
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CONTENT_DISPLAY_DIALOG_downloadCtaButton');
                      logFirebaseEvent('downloadCtaButton_launch_u_r_l');
                      await launchURL(widget!.contentDoc!.ctaLink);
                    },
                    text: valueOrDefault<String>(
                      widget!.contentDoc?.ctaBtnText,
                      'Download',
                    ),
                    icon: Icon(
                      Icons.file_download_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    options: FFButtonOptions(
                      height: 48.0,
                      padding: EdgeInsets.all(16.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).accent1,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                            lineHeight: 1.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).tertiary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                if (valueOrDefault<bool>(
                  (widget!.contentDoc?.ctaLink != null &&
                          widget!.contentDoc?.ctaLink != '') &&
                      (widget!.contentDoc?.contentType == 'link'),
                  false,
                ))
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CONTENT_DISPLAY_DIALOG_linkCtaButton_ON_');
                      logFirebaseEvent('linkCtaButton_launch_u_r_l');
                      await launchURL(widget!.contentDoc!.ctaLink);
                    },
                    text: 'Open Link',
                    icon: Icon(
                      Icons.link,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    options: FFButtonOptions(
                      height: 48.0,
                      padding: EdgeInsets.all(16.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).accent1,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                            lineHeight: 1.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).tertiary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                Stack(
                  children: [
                    if ((widget!.contentDoc!.tribeContentID > 0) &&
                        !(currentUserDocument?.contentCompletedIDs?.toList() ??
                                [])
                            .contains(widget!.contentDoc?.tribeContentID))
                      AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CONTENT_DISPLAY_DIALOG_Completed_ON_TAP');
                            logFirebaseEvent('Completed_backend_call');
                            _model.markCompleted =
                                await CompleteGroupContentCall.call(
                              token: valueOrDefault(
                                  currentUserDocument?.tribeToken, ''),
                              baseURL: getRemoteConfigString('AppBaseApiUrl'),
                              postId: widget!.contentDoc?.tribeContentID,
                            );

                            if ((_model.markCompleted?.succeeded ?? true)) {
                              logFirebaseEvent('Completed_action_block');
                              await action_blocks.displaySnackbar(
                                context,
                                message: 'Lesson completed!',
                              );
                            } else {
                              logFirebaseEvent('Completed_show_snack_bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Something went wrong',
                                    style: GoogleFonts.getFont(
                                      'Open Sans',
                                      color:
                                          FlutterFlowTheme.of(context).black600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                ),
                              );
                            }

                            safeSetState(() {});
                          },
                          text: 'Mark Complete',
                          icon: Icon(
                            Icons.check_box_outlined,
                            color: Color(0x99FFFFFF),
                            size: 24.0,
                          ),
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 16.0, 8.0, 16.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).accent1,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    if ((widget!.contentDoc!.tribeContentID > 0) &&
                        (currentUserDocument?.contentCompletedIDs?.toList() ??
                                [])
                            .contains(widget!.contentDoc?.tribeContentID))
                      AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CONTENT_DISPLAY_DIALOG_Incomplete_ON_TAP');
                            logFirebaseEvent('Incomplete_backend_call');
                            _model.markIncompleted =
                                await CompleteGroupContentCall.call(
                              token: valueOrDefault(
                                  currentUserDocument?.tribeToken, ''),
                              baseURL: getRemoteConfigString('AppBaseApiUrl'),
                              postId: widget!.contentDoc?.tribeContentID,
                            );

                            if ((_model.markIncompleted?.succeeded ?? true)) {
                              logFirebaseEvent('Incomplete_action_block');
                              await action_blocks.displaySnackbar(
                                context,
                                message: 'Lesson unchecked from completed.',
                              );
                            } else {
                              logFirebaseEvent('Incomplete_show_snack_bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Something went wrong',
                                    style: GoogleFonts.getFont(
                                      'Open Sans',
                                      color:
                                          FlutterFlowTheme.of(context).black600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                ),
                              );
                            }

                            safeSetState(() {});
                          },
                          text: 'Mark Incomplete',
                          icon: Icon(
                            Icons.check_box,
                            color: Color(0x99FFFFFF),
                            size: 24.0,
                          ),
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 16.0, 8.0, 16.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).accent1,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                  ],
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
          ),
          if (responsiveVisibility(
            context: context,
            phone: false,
            tablet: false,
            tabletLandscape: false,
            desktop: false,
          ))
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
              child: Container(
                height: 300.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).primaryText,
                          labelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                          unselectedLabelStyle: TextStyle(),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          indicatorWeight: 2.0,
                          padding: EdgeInsets.all(4.0),
                          tabs: [
                            Tab(
                              text: 'Description',
                            ),
                            Tab(
                              text: 'Attachments',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            custom_widgets.ContentDescriptionHTMLExpanded(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 300.0,
                              htmlContent: valueOrDefault<String>(
                                widget!.contentDoc?.descriptionHtml,
                                '<p></p>',
                              ),
                              isExpanded: true,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child:
                                        StreamBuilder<List<AttachmentsRecord>>(
                                      stream: queryAttachmentsRecord(
                                        parent: widget!.contentDoc?.reference,
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
                                        List<AttachmentsRecord>
                                            listViewAttachmentsRecordList =
                                            snapshot.data!;
                                        if (listViewAttachmentsRecordList
                                            .isEmpty) {
                                          return Center(
                                            child: EmptyListWidget(),
                                          );
                                        }

                                        return ListView.separated(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewAttachmentsRecordList
                                                  .length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 8.0),
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewAttachmentsRecord =
                                                listViewAttachmentsRecordList[
                                                    listViewIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'CONTENT_DISPLAY_DIALOG_attachmentContain');
                                                logFirebaseEvent(
                                                    'attachmentContainer_launch_u_r_l');
                                                await launchURL(
                                                    listViewAttachmentsRecord
                                                        .url);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: Color(0xFFEAECF0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Builder(
                                                        builder: (context) {
                                                          if (functions.returnFileType(
                                                                  listViewAttachmentsRecord
                                                                      .url) ==
                                                              DocumentType
                                                                  .link) {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .link,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 18.0,
                                                              ),
                                                            );
                                                          } else if (functions
                                                                  .returnFileType(
                                                                      listViewAttachmentsRecord
                                                                          .url) ==
                                                              DocumentType
                                                                  .media) {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .image,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 18.0,
                                                              ),
                                                            );
                                                          } else {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .file,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 18.0,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          listViewAttachmentsRecord
                                                              .name,
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelLargeFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                ),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          custom_widgets.ContentDescriptionHTMLExpanded(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: 300.0,
            htmlContent: valueOrDefault<String>(
              widget!.contentDoc?.descriptionHtml,
              '<p></p>',
            ),
            isExpanded: true,
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}
