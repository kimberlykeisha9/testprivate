import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/components/admin_dash_nav_widget.dart';
import '/components/dashboard_stat_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_group_settings_model.dart';
export 'dashboard_group_settings_model.dart';

class DashboardGroupSettingsWidget extends StatefulWidget {
  const DashboardGroupSettingsWidget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<DashboardGroupSettingsWidget> createState() =>
      _DashboardGroupSettingsWidgetState();
}

class _DashboardGroupSettingsWidgetState
    extends State<DashboardGroupSettingsWidget> with TickerProviderStateMixin {
  late DashboardGroupSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasListViewTriggered = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardGroupSettingsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DashboardGroupSettings'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'listViewOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
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
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      animationsMap['listViewOnPageLoadAnimation']!
          .controller
          .forward(from: 0.0);
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
        backgroundColor: Colors.white,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Container(
                width: 270.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(0.0),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'DASHBOARD_GROUP_SETTINGS_Image_xo2i3gat_');
                                  logFirebaseEvent('Image_navigate_to');

                                  context.pushNamed('GroupList');
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 300),
                                    fadeOutDuration:
                                        Duration(milliseconds: 300),
                                    imageUrl: valueOrDefault<String>(
                                      functions.stringToImgPath(
                                          getRemoteConfigString('AppLogo')),
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/ckno2i5pqlpe/Tribe_2023_TM_Light_trim.png',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 12.0,
                        thickness: 2.0,
                        color: Color(0xFFE5E7EB),
                      ),
                      Expanded(
                        child: wrapWithModel(
                          model: _model.adminDashNavModel,
                          updateCallback: () => safeSetState(() {}),
                          child: AdminDashNavWidget(
                            tribeGroup: widget!.groupDoc,
                          ),
                        ),
                      ),
                      Divider(
                        height: 12.0,
                        thickness: 2.0,
                        color: Color(0xFFE5E7EB),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.menu_open_rounded,
                                color: Color(0xFF606A85),
                                size: 24.0,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 1370.0,
                    maxHeight: 1370.0,
                  ),
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Group Settings',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            color: Color(0xFF15161E),
                                            fontSize: 24.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Inter Tight'),
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                      child: Text(
                                        'Stats and admin settings for your entire platform',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              color: Color(0xFF606A85),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Inter Tight'),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    wrapWithModel(
                                      model: _model.profileButtonModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ProfileButtonWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FutureBuilder<List<AnalyticsRecord>>(
                                  future: queryAnalyticsRecordOnce(
                                    queryBuilder: (analyticsRecord) =>
                                        analyticsRecord
                                            .where(
                                              'groupRef',
                                              isEqualTo:
                                                  widget!.groupDoc?.reference,
                                            )
                                            .orderBy('endDate',
                                                descending: true),
                                    limit: 5,
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
                                              FlutterFlowTheme.of(context)
                                                  .appBG,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<AnalyticsRecord>
                                        chartAnalyticsRecordList =
                                        snapshot.data!;

                                    return Container(
                                      width: 370.0,
                                      height: 176.0,
                                      child: FlutterFlowBarChart(
                                        barData: [
                                          FFBarChartData(
                                            yData: chartAnalyticsRecordList
                                                .map((d) => d.totalPosts)
                                                .toList(),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                          FFBarChartData(
                                            yData: chartAnalyticsRecordList
                                                .map((d) => d.totalComments)
                                                .toList(),
                                            color: Color(0xFF6F28CB),
                                          ),
                                          FFBarChartData(
                                            yData: chartAnalyticsRecordList
                                                .map((d) => d.totalLivePosts)
                                                .toList(),
                                            color: Color(0xFF2536A4),
                                          )
                                        ],
                                        xLabels: chartAnalyticsRecordList
                                            .map((d) => d.groupName)
                                            .toList(),
                                        barWidth: 16.0,
                                        barBorderRadius:
                                            BorderRadius.circular(8.0),
                                        barSpace: 0.0,
                                        groupSpace: 8.0,
                                        alignment:
                                            BarChartAlignment.spaceAround,
                                        chartStylingInfo: ChartStylingInfo(
                                          enableTooltip: true,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          showBorder: false,
                                        ),
                                        axisBounds: AxisBounds(),
                                        xAxisLabelInfo: AxisLabelInfo(
                                          showLabels: true,
                                          labelInterval: 10.0,
                                          reservedSize: 28.0,
                                        ),
                                        yAxisLabelInfo: AxisLabelInfo(
                                          showLabels: true,
                                          labelInterval: 10.0,
                                          reservedSize: 42.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 4.0),
                              child: FutureBuilder<List<AnalyticsRecord>>(
                                future: queryAnalyticsRecordOnce(
                                  queryBuilder: (analyticsRecord) =>
                                      analyticsRecord
                                          .where(
                                            'groupRef',
                                            isEqualTo:
                                                widget!.groupDoc?.reference,
                                          )
                                          .orderBy('endDate', descending: true),
                                  singleRecord: true,
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
                                  List<AnalyticsRecord>
                                      topStatsAnalyticsRecordList =
                                      snapshot.data!;
                                  // Return an empty Container when the item does not exist.
                                  if (snapshot.data!.isEmpty) {
                                    return Container();
                                  }
                                  final topStatsAnalyticsRecord =
                                      topStatsAnalyticsRecordList.isNotEmpty
                                          ? topStatsAnalyticsRecordList.first
                                          : null;

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        wrapWithModel(
                                          model: _model.dashboardStatModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: DashboardStatWidget(
                                            number: valueOrDefault<double>(
                                              topStatsAnalyticsRecord
                                                  ?.totalComments,
                                              0.0,
                                            ),
                                            label: 'Total Comments',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.dashboardStatModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: DashboardStatWidget(
                                            number: valueOrDefault<double>(
                                              topStatsAnalyticsRecord
                                                  ?.totalPosts,
                                              0.0,
                                            ),
                                            label: 'Total Posts',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.dashboardStatModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: DashboardStatWidget(
                                            number: valueOrDefault<double>(
                                              topStatsAnalyticsRecord
                                                  ?.totalLivePosts,
                                              0.0,
                                            ),
                                            label: 'Total Live Posts',
                                          ),
                                        ),
                                      ]
                                          .divide(SizedBox(width: 16.0))
                                          .addToStart(SizedBox(width: 16.0))
                                          .addToEnd(SizedBox(width: 16.0)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  width: 550.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Badges',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily),
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .lineColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                              ),
                                                            ),
                                                            if (_model.uploadedFileUrl !=
                                                                    null &&
                                                                _model.uploadedFileUrl !=
                                                                    '')
                                                              FlutterFlowMediaDisplay(
                                                                path: _model
                                                                    .uploadedFileUrl,
                                                                imageBuilder:
                                                                    (path) =>
                                                                        ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                  child: Image
                                                                      .network(
                                                                    path,
                                                                    width: 80.0,
                                                                    height:
                                                                        80.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                videoPlayerBuilder:
                                                                    (path) =>
                                                                        FlutterFlowVideoPlayer(
                                                                  path: path,
                                                                  autoPlay:
                                                                      false,
                                                                  looping: true,
                                                                  showControls:
                                                                      true,
                                                                  allowFullScreen:
                                                                      true,
                                                                  allowPlaybackSpeedMenu:
                                                                      false,
                                                                ),
                                                              ),
                                                            if (_model.uploadedFileUrl ==
                                                                    null ||
                                                                _model.uploadedFileUrl ==
                                                                    '')
                                                              FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'DASHBOARD_GROUP_SETTINGS_UPLOAD_BTN_ON_T');
                                                                  logFirebaseEvent(
                                                                      'Button_upload_media_to_firebase');
                                                                  final selectedMedia =
                                                                      await selectMedia(
                                                                    maxWidth:
                                                                        500.00,
                                                                    maxHeight:
                                                                        500.00,
                                                                    imageQuality:
                                                                        90,
                                                                    mediaSource:
                                                                        MediaSource
                                                                            .photoGallery,
                                                                    multiImage:
                                                                        false,
                                                                  );
                                                                  if (selectedMedia !=
                                                                          null &&
                                                                      selectedMedia.every((m) => validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                    safeSetState(() =>
                                                                        _model.isDataUploading =
                                                                            true);
                                                                    var selectedUploadedFiles =
                                                                        <FFUploadedFile>[];

                                                                    var downloadUrls =
                                                                        <String>[];
                                                                    try {
                                                                      showUploadMessage(
                                                                        context,
                                                                        'Uploading file...',
                                                                        showLoading:
                                                                            true,
                                                                      );
                                                                      selectedUploadedFiles = selectedMedia
                                                                          .map((m) => FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                              ))
                                                                          .toList();

                                                                      downloadUrls = (await Future
                                                                              .wait(
                                                                        selectedMedia
                                                                            .map(
                                                                          (m) async => await uploadData(
                                                                              m.storagePath,
                                                                              m.bytes),
                                                                        ),
                                                                      ))
                                                                          .where((u) =>
                                                                              u !=
                                                                              null)
                                                                          .map((u) =>
                                                                              u!)
                                                                          .toList();
                                                                    } finally {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .hideCurrentSnackBar();
                                                                      _model.isDataUploading =
                                                                          false;
                                                                    }
                                                                    if (selectedUploadedFiles.length ==
                                                                            selectedMedia
                                                                                .length &&
                                                                        downloadUrls.length ==
                                                                            selectedMedia.length) {
                                                                      safeSetState(
                                                                          () {
                                                                        _model.uploadedLocalFile =
                                                                            selectedUploadedFiles.first;
                                                                        _model.uploadedFileUrl =
                                                                            downloadUrls.first;
                                                                      });
                                                                      showUploadMessage(
                                                                          context,
                                                                          'Success!');
                                                                    } else {
                                                                      safeSetState(
                                                                          () {});
                                                                      showUploadMessage(
                                                                          context,
                                                                          'Failed to upload data');
                                                                      return;
                                                                    }
                                                                  }
                                                                },
                                                                text: 'Upload',
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 35.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: Color(
                                                                      0x00262D34),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Open Sans',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey('Open Sans'),
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                showLoadingIndicator:
                                                                    false,
                                                              ),
                                                            if (_model.uploadedFileUrl !=
                                                                    null &&
                                                                _model.uploadedFileUrl !=
                                                                    '')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0),
                                                                child:
                                                                    FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      20.0,
                                                                  borderWidth:
                                                                      0.0,
                                                                  buttonSize:
                                                                      30.0,
                                                                  fillColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete_sharp,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    size: 14.0,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'DASHBOARD_GROUP_SETTINGS_delete_sharp_IC');
                                                                    logFirebaseEvent(
                                                                        'IconButton_clear_uploaded_data');
                                                                    safeSetState(
                                                                        () {
                                                                      _model.isDataUploading =
                                                                          false;
                                                                      _model.uploadedLocalFile =
                                                                          FFUploadedFile(
                                                                              bytes: Uint8List.fromList([]));
                                                                      _model.uploadedFileUrl =
                                                                          '';
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .textController,
                                                                focusNode: _model
                                                                    .textFieldFocusNode,
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  '_model.textController',
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                ),
                                                                autofocus: true,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Badge Name here....',
                                                                  hintStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelMediumFamily,
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                        lineHeight:
                                                                            1.0,
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  suffixIcon: _model
                                                                          .textController!
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            _model.textController?.clear();
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.clear,
                                                                            size:
                                                                                22,
                                                                          ),
                                                                        )
                                                                      : null,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                      lineHeight:
                                                                          1.0,
                                                                    ),
                                                                validator: _model
                                                                    .textControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                              ),
                                                            ),
                                                            Text(
                                                              '500 px  X 500 px recommended',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 2.0)),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 14.0)),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'DASHBOARD_GROUP_SETTINGS_uploadImageButt');
                                                        if (_model.textController
                                                                    .text !=
                                                                null &&
                                                            _model.textController
                                                                    .text !=
                                                                '') {
                                                          logFirebaseEvent(
                                                              'uploadImageButton_backend_call');

                                                          await widget!
                                                              .groupDoc!
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'GroupBadges':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  getUserBadgesFirestoreData(
                                                                    updateUserBadgesStruct(
                                                                      UserBadgesStruct(
                                                                        badgeName: _model
                                                                            .textController
                                                                            .text,
                                                                        badgeGroupRef: widget!
                                                                            .groupDoc
                                                                            ?.reference,
                                                                        badgeImg:
                                                                            _model.uploadedFileUrl,
                                                                      ),
                                                                      clearUnsetFields:
                                                                          false,
                                                                    ),
                                                                    true,
                                                                  )
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          logFirebaseEvent(
                                                              'uploadImageButton_clear_uploaded_data');
                                                          safeSetState(() {
                                                            _model.isDataUploading =
                                                                false;
                                                            _model.uploadedLocalFile =
                                                                FFUploadedFile(
                                                                    bytes: Uint8List
                                                                        .fromList(
                                                                            []));
                                                            _model.uploadedFileUrl =
                                                                '';
                                                          });

                                                          logFirebaseEvent(
                                                              'uploadImageButton_clear_text_fields_pin_');
                                                          safeSetState(() {
                                                            _model
                                                                .textController
                                                                ?.clear();
                                                          });
                                                        }
                                                      },
                                                      text: 'Add Badge',
                                                      icon: Icon(
                                                        Icons.add,
                                                        size: 18.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 34.0,
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
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily),
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 9.0)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        StreamBuilder<TribeGroupsRecord>(
                                          stream: TribeGroupsRecord.getDocument(
                                              widget!.groupDoc!.reference),
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

                                            final listGroupBadgesTribeGroupsRecord =
                                                snapshot.data!;

                                            return Builder(
                                              builder: (context) {
                                                final groupBadges =
                                                    listGroupBadgesTribeGroupsRecord
                                                        .groupBadges
                                                        .toList();

                                                return ReorderableListView
                                                        .builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: groupBadges.length,
                                                  itemBuilder: (context,
                                                      groupBadgesIndex) {
                                                    final groupBadgesItem =
                                                        groupBadges[
                                                            groupBadgesIndex];
                                                    return Container(
                                                      key: ValueKey(
                                                          "ListView_wdg2jpd2" +
                                                              '_' +
                                                              groupBadgesIndex
                                                                  .toString()),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    4.0),
                                                        child: Container(
                                                          height: 70.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  1.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        36.0,
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
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      groupBadgesItem
                                                                          .badgeImg,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
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
                                                                Expanded(
                                                                  flex: 5,
                                                                  child: Text(
                                                                    groupBadgesItem
                                                                        .badgeName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        50.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      children: [
                                                                        if (!_model
                                                                            .confirmDelete)
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('DASHBOARD_GROUP_SETTINGS_Delete_ON_TAP');
                                                                                logFirebaseEvent('Delete_update_page_state');
                                                                                _model.confirmDelete = true;
                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Card(
                                                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                    color: Color(0x19E21C3D),
                                                                                    elevation: 0.0,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(40.0),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Icon(
                                                                                        Icons.delete_outline,
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        size: 20.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        if (_model
                                                                            .confirmDelete)
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('DASHBOARD_GROUP_SETTINGS_confirmDelete_O');
                                                                                logFirebaseEvent('confirmDelete_backend_call');

                                                                                await widget!.groupDoc!.reference.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'GroupBadges': FieldValue.arrayRemove([
                                                                                        getUserBadgesFirestoreData(
                                                                                          updateUserBadgesStruct(
                                                                                            groupBadgesItem,
                                                                                            clearUnsetFields: false,
                                                                                          ),
                                                                                          true,
                                                                                        )
                                                                                      ]),
                                                                                    },
                                                                                  ),
                                                                                });
                                                                                logFirebaseEvent('confirmDelete_update_page_state');
                                                                                _model.confirmDelete = false;
                                                                                safeSetState(() {});
                                                                                logFirebaseEvent('confirmDelete_show_snack_bar');
                                                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      'Badge removed',
                                                                                      style: GoogleFonts.getFont(
                                                                                        'Inter Tight',
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.0,
                                                                                      ),
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 2000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).error,
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Click to remove',
                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                              color: FlutterFlowTheme.of(context).error,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      logFirebaseEvent('DASHBOARD_GROUP_SETTINGS_Card_fyqtbrfe_O');
                                                                                      logFirebaseEvent('Card_update_page_state');
                                                                                      _model.confirmDelete = false;
                                                                                      safeSetState(() {});
                                                                                    },
                                                                                    child: Card(
                                                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                      color: FlutterFlowTheme.of(context).accent3,
                                                                                      elevation: 0.0,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(40.0),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(8.0),
                                                                                        child: Icon(
                                                                                          Icons.close,
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          size: 20.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 8.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onReorder: (int
                                                          reorderableOldIndex,
                                                      int reorderableNewIndex) async {
                                                    logFirebaseEvent(
                                                        'DASHBOARD_GROUP_SETTINGS_ListGroupBadges');
                                                    logFirebaseEvent(
                                                        'ListGroupBadges_custom_action');
                                                    _model.newListOrder =
                                                        await actions
                                                            .reorderUserBadges(
                                                      reorderableOldIndex,
                                                      reorderableNewIndex,
                                                      groupBadges.toList(),
                                                    );
                                                    logFirebaseEvent(
                                                        'ListGroupBadges_backend_call');

                                                    await widget!
                                                        .groupDoc!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'GroupBadges':
                                                              getUserBadgesListFirestoreData(
                                                            _model.newListOrder,
                                                          ),
                                                        },
                                                      ),
                                                    });

                                                    safeSetState(() {});
                                                  },
                                                )
                                                    .animateOnPageLoad(
                                                        animationsMap[
                                                            'listViewOnPageLoadAnimation']!)
                                                    .animateOnActionTrigger(
                                                        animationsMap[
                                                            'listViewOnActionTriggerAnimation']!,
                                                        hasBeenTriggered:
                                                            hasListViewTriggered);
                                              },
                                            );
                                          },
                                        ),
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                          Builder(
                                            builder: (context) {
                                              final groupCategories = functions
                                                  .convertJsonToListString(
                                                      getRemoteConfigString(
                                                          'GroupTypes'))
                                                  .toList();

                                              return ReorderableListView
                                                  .builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    groupCategories.length,
                                                itemBuilder: (context,
                                                    groupCategoriesIndex) {
                                                  final groupCategoriesItem =
                                                      groupCategories[
                                                          groupCategoriesIndex];
                                                  return Container(
                                                    key: ValueKey(
                                                        "ListView_3yb2w1rg" +
                                                            '_' +
                                                            groupCategoriesIndex
                                                                .toString()),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          groupCategoriesItem,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
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
                                                      ],
                                                    ),
                                                  );
                                                },
                                                onReorder: (int
                                                        reorderableOldIndex,
                                                    int reorderableNewIndex) async {
                                                  logFirebaseEvent(
                                                      'DASHBOARD_GROUP_SETTINGS_ListGroupCatego');
                                                  logFirebaseEvent(
                                                      'ListGroupCategories_update_page_state');
                                                  _model.groupCategoriesEdit =
                                                      groupCategories
                                                          .toList()
                                                          .cast<String>();
                                                  safeSetState(() {});

                                                  safeSetState(() {});
                                                },
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (getRemoteConfigBool('isGroupTypeEnabled'))
                                StreamBuilder<TribeGroupsRecord>(
                                  stream: TribeGroupsRecord.getDocument(
                                      widget!.groupDoc!.reference),
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
                                              FlutterFlowTheme.of(context)
                                                  .appBG,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    final groupCategoryTribeGroupsRecord =
                                        snapshot.data!;

                                    return Container(
                                      width: 400.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 15.0, 15.0, 15.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'DASHBOARD_GROUP_SETTINGS_Column_u9gzf2hb');
                                            logFirebaseEvent(
                                                'Column_backend_call');

                                            await groupCategoryTribeGroupsRecord
                                                .reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'GroupType': _model
                                                      .checkboxGroupValues,
                                                },
                                              ),
                                            });
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Group Categories',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily),
                                                        ),
                                              ),
                                              Text(
                                                'Select which categories you would like this group to appear. ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily),
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 20.0, 0.0, 20.0),
                                                child: FlutterFlowCheckboxGroup(
                                                  options: functions
                                                      .convertArrayToList(
                                                          getRemoteConfigString(
                                                              'GroupTypes'))!
                                                      .toList(),
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                              .checkboxGroupValues =
                                                          val),
                                                  controller: _model
                                                          .checkboxGroupValueController ??=
                                                      FormFieldController<
                                                          List<String>>(
                                                    List.from(
                                                        groupCategoryTribeGroupsRecord
                                                                .groupType ??
                                                            []),
                                                  ),
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  checkboxBorderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                  unselectedTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 18.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumFamily),
                                                          ),
                                                  checkboxBorderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  initialized: _model
                                                          .checkboxGroupValues !=
                                                      null,
                                                ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'DASHBOARD_GROUP_SETTINGS_UPDATE_CATEGORI');
                                                  logFirebaseEvent(
                                                      'Button_backend_call');

                                                  await groupCategoryTribeGroupsRecord
                                                      .reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'GroupType': _model
                                                            .checkboxGroupValues,
                                                      },
                                                    ),
                                                  });
                                                },
                                                text: 'Update Categories',
                                                options: FFButtonOptions(
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmallFamily),
                                                          ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ]
                                .divide(SizedBox(width: 16.0))
                                .addToStart(SizedBox(width: 16.0))
                                .addToEnd(SizedBox(width: 16.0)),
                          ),
                        ),
                      ].addToEnd(SizedBox(height: 24.0)),
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
