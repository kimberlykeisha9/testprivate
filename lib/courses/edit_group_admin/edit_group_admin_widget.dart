import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/edit_next_steps/edit_next_steps_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'edit_group_admin_model.dart';
export 'edit_group_admin_model.dart';

class EditGroupAdminWidget extends StatefulWidget {
  const EditGroupAdminWidget({
    super.key,
    this.groupRef,
    this.isEdit,
  });

  final DocumentReference? groupRef;
  final bool? isEdit;

  @override
  State<EditGroupAdminWidget> createState() => _EditGroupAdminWidgetState();
}

class _EditGroupAdminWidgetState extends State<EditGroupAdminWidget> {
  late EditGroupAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditGroupAdminModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditGroupAdmin'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_GROUP_ADMIN_EditGroupAdmin_ON_INIT_');
      logFirebaseEvent('EditGroupAdmin_update_app_state');
      FFAppState().uploaded = '';
      safeSetState(() {});
    });

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textFieldFocusNode5 ??= FocusNode();

    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);

    _model.textFieldFocusNode6 ??= FocusNode();

    _model.expandableExpandableController4 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController5 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController6 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController7 =
        ExpandableController(initialExpanded: false);
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
                backgroundColor: FlutterFlowTheme.of(context).secondary,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 54.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).accent1,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    logFirebaseEvent(
                        'EDIT_GROUP_ADMIN_arrow_back_rounded_ICN_');
                    logFirebaseEvent('IconButton_navigate_back');
                    context.pop();
                  },
                ),
                title: Text(
                  'Edit Group Info',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: FlutterFlowTheme.of(context).accent1,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).headlineSmallFamily),
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
            alignment: AlignmentDirectional(0.0, -1.0),
            child: StreamBuilder<TribeGroupsRecord>(
              stream: TribeGroupsRecord.getDocument(widget!.groupRef!),
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

                final containerTribeGroupsRecord = snapshot.data!;

                return Container(
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  constraints: BoxConstraints(
                    maxWidth: 500.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Group Info',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'EDIT_GROUP_ADMIN_featuredImage_ON_TAP');
                                              logFirebaseEvent(
                                                  'featuredImage_upload_media_to_firebase');
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                context: context,
                                                maxWidth: 500.00,
                                                maxHeight: 500.00,
                                                allowPhoto: true,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                textColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                pickerFontFamily: 'Poppins',
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                    .isDataUploading1 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
                                                  showUploadMessage(
                                                    context,
                                                    'Uploading file...',
                                                    showLoading: true,
                                                  );
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();

                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedMedia.map(
                                                      (m) async =>
                                                          await uploadData(
                                                              m.storagePath,
                                                              m.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  _model.isDataUploading1 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile1 =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl1 =
                                                        downloadUrls.first;
                                                  });
                                                  showUploadMessage(
                                                      context, 'Success!');
                                                } else {
                                                  safeSetState(() {});
                                                  showUploadMessage(context,
                                                      'Failed to upload data');
                                                  return;
                                                }
                                              }

                                              logFirebaseEvent(
                                                  'featuredImage_update_app_state');
                                              FFAppState().postPhoto =
                                                  _model.uploadedFileUrl2;
                                              FFAppState().update(() {});
                                            },
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 500),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 500),
                                              imageUrl: valueOrDefault<String>(
                                                _model.uploadedFileUrl2,
                                                'https://www.freeiconspng.com/uploads/upload-icon-22.png',
                                              ),
                                              width: 200.0,
                                              height: 100.0,
                                              fit: BoxFit.contain,
                                            ),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 15.0, 5.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'EDIT_GROUP_ADMIN_UPLOAD_PHOTO_BTN_ON_TAP');
                                              logFirebaseEvent(
                                                  'Button_upload_media_to_firebase');
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                context: context,
                                                maxWidth: 500.00,
                                                maxHeight: 500.00,
                                                allowPhoto: true,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                textColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                pickerFontFamily: 'Poppins',
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                    .isDataUploading2 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
                                                  showUploadMessage(
                                                    context,
                                                    'Uploading file...',
                                                    showLoading: true,
                                                  );
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();

                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedMedia.map(
                                                      (m) async =>
                                                          await uploadData(
                                                              m.storagePath,
                                                              m.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  _model.isDataUploading2 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile2 =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl2 =
                                                        downloadUrls.first;
                                                  });
                                                  showUploadMessage(
                                                      context, 'Success!');
                                                } else {
                                                  safeSetState(() {});
                                                  showUploadMessage(context,
                                                      'Failed to upload data');
                                                  return;
                                                }
                                              }

                                              logFirebaseEvent(
                                                  'Button_update_app_state');
                                              FFAppState().postPhoto =
                                                  _model.uploadedFileUrl2;
                                              FFAppState().update(() {});
                                            },
                                            text: 'Upload Photo',
                                            icon: Icon(
                                              Icons.photo_library_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: 200.0,
                                              height: 35.0,
                                              padding: EdgeInsets.all(0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent1,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _model.textController1 ??=
                                                        TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerTribeGroupsRecord
                                                        .name,
                                                    'name',
                                                  ),
                                                ),
                                                focusNode:
                                                    _model.textFieldFocusNode1,
                                                onChanged: (_) =>
                                                    EasyDebounce.debounce(
                                                  '_model.textController1',
                                                  Duration(milliseconds: 2000),
                                                  () => safeSetState(() {}),
                                                ),
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Group Name',
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(20.0, 25.0,
                                                              20.0, 12.0),
                                                  suffixIcon: _model
                                                          .textController1!
                                                          .text
                                                          .isNotEmpty
                                                      ? InkWell(
                                                          onTap: () async {
                                                            _model
                                                                .textController1
                                                                ?.clear();
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 22.0,
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                  'Open Sans'),
                                                    ),
                                                textAlign: TextAlign.start,
                                                validator: _model
                                                    .textController1Validator
                                                    .asValidator(context),
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController1,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Today Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue1 ??=
                                                containerTribeGroupsRecord
                                                    .todayTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue1 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_kwcit3dp_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  todayTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_kwcit3dp_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  todayTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _model
                                                            .textController2 ??=
                                                        TextEditingController(
                                                      text:
                                                          containerTribeGroupsRecord
                                                              .headlineText,
                                                    ),
                                                    focusNode: _model
                                                        .textFieldFocusNode2,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController2',
                                                      Duration(
                                                          milliseconds: 2000),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Headline Text',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent2,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  25.0,
                                                                  20.0,
                                                                  12.0),
                                                      suffixIcon: _model
                                                              .textController2!
                                                              .text
                                                              .isNotEmpty
                                                          ? InkWell(
                                                              onTap: () async {
                                                                _model
                                                                    .textController2
                                                                    ?.clear();
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons.clear,
                                                                color: Color(
                                                                    0xFF757575),
                                                                size: 22.0,
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Open Sans'),
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 3,
                                                    validator: _model
                                                        .textController2Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (containerTribeGroupsRecord
                                                      .featuredVideo !=
                                                  null &&
                                              containerTribeGroupsRecord
                                                      .featuredVideo !=
                                                  '')
                                            FlutterFlowVideoPlayer(
                                              path: functions.retVidPath(
                                                  containerTribeGroupsRecord
                                                      .featuredVideo),
                                              videoType: VideoType.network,
                                              width: 200.0,
                                              autoPlay: false,
                                              looping: true,
                                              showControls: true,
                                              allowFullScreen: true,
                                              allowPlaybackSpeedMenu: false,
                                            ),
                                          Text(
                                            FFAppState().uploaded,
                                            style: FlutterFlowTheme.of(context)
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
                                          if (containerTribeGroupsRecord
                                                      .featuredVideo !=
                                                  null &&
                                              containerTribeGroupsRecord
                                                      .featuredVideo !=
                                                  '')
                                            FFButtonWidget(
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_DELETE_VIDEO_BTN_ON_TAP');
                                                logFirebaseEvent(
                                                    'Button_alert_dialog');
                                                var confirmDialogResponse =
                                                    await showDialog<bool>(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    'Delete Video?'),
                                                                content: Text(
                                                                    'This will delete the Featured Video for this group.'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ) ??
                                                        false;
                                                logFirebaseEvent(
                                                    'Button_update_app_state');
                                                FFAppState().uploaded = '';
                                                safeSetState(() {});
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  featuredVideo: '',
                                                ));
                                              },
                                              text: 'Delete Video',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily),
                                                        ),
                                                elevation: 2.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _model
                                                            .textController3 ??=
                                                        TextEditingController(
                                                      text: containerTribeGroupsRecord
                                                          .sessionHeadlineText,
                                                    ),
                                                    focusNode: _model
                                                        .textFieldFocusNode3,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController3',
                                                      Duration(
                                                          milliseconds: 2000),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Session Headline',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent2,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  25.0,
                                                                  20.0,
                                                                  12.0),
                                                      suffixIcon: _model
                                                              .textController3!
                                                              .text
                                                              .isNotEmpty
                                                          ? InkWell(
                                                              onTap: () async {
                                                                _model
                                                                    .textController3
                                                                    ?.clear();
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons.clear,
                                                                color: Color(
                                                                    0xFF757575),
                                                                size: 22.0,
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Open Sans'),
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    validator: _model
                                                        .textController3Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _model
                                                            .textController4 ??=
                                                        TextEditingController(
                                                      text:
                                                          containerTribeGroupsRecord
                                                              .headlineBtnText,
                                                    ),
                                                    focusNode: _model
                                                        .textFieldFocusNode4,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Headline Button Text',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent2,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  25.0,
                                                                  20.0,
                                                                  12.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Open Sans'),
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    validator: _model
                                                        .textController4Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _model
                                                            .textController5 ??=
                                                        TextEditingController(
                                                      text:
                                                          containerTribeGroupsRecord
                                                              .headlineBtnUrl,
                                                    ),
                                                    focusNode: _model
                                                        .textFieldFocusNode5,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController5',
                                                      Duration(
                                                          milliseconds: 2000),
                                                      () => safeSetState(() {}),
                                                    ),
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Headline Button URL',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent2,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  25.0,
                                                                  20.0,
                                                                  12.0),
                                                      suffixIcon: _model
                                                              .textController5!
                                                              .text
                                                              .isNotEmpty
                                                          ? InkWell(
                                                              onTap: () async {
                                                                _model
                                                                    .textController5
                                                                    ?.clear();
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons.clear,
                                                                color: Color(
                                                                    0xFF757575),
                                                                size: 22.0,
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Open Sans'),
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    validator: _model
                                                        .textController5Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: true,
                                      tapBodyToCollapse: true,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                      expandIcon: Icons.expand_more,
                                      collapseIcon: Icons.expand_less,
                                      iconColor: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController2,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Replay Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue2 ??=
                                                containerTribeGroupsRecord
                                                    .replayTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue2 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_jzmot4it_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  replayTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_jzmot4it_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  replayTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 15.0),
                                      child: Text(
                                        'All primary content from admins will appear here. Use this if you have regular member only calls or content.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController3,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Events Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue3 ??=
                                                containerTribeGroupsRecord
                                                    .eventsTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue3 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_ufi5wuss_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  eventsTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_ufi5wuss_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  eventsTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 5.0, 25.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Use this tab to display your AddEvent.com calendar. Create an account and add the share link below.',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey(
                                                              'Open Sans'),
                                                ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 15.0, 0.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                    _model.textController6 ??=
                                                        TextEditingController(
                                                  text:
                                                      containerTribeGroupsRecord
                                                          .addEventUrl,
                                                ),
                                                focusNode:
                                                    _model.textFieldFocusNode6,
                                                onChanged: (_) =>
                                                    EasyDebounce.debounce(
                                                  '_model.textController6',
                                                  Duration(milliseconds: 2000),
                                                  () => safeSetState(() {}),
                                                ),
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'AddEvent Share URL',
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(20.0, 25.0,
                                                              20.0, 12.0),
                                                  suffixIcon: _model
                                                          .textController6!
                                                          .text
                                                          .isNotEmpty
                                                      ? InkWell(
                                                          onTap: () async {
                                                            _model
                                                                .textController6
                                                                ?.clear();
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: Color(
                                                                0xFF757575),
                                                            size: 22.0,
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                  'Open Sans'),
                                                    ),
                                                textAlign: TextAlign.start,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                validator: _model
                                                    .textController6Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController4,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Current Tab (News Feed)',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue4 ??=
                                                containerTribeGroupsRecord
                                                    .communityTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue4 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_bf35o2g5_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  communityTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_bf35o2g5_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  communityTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 15.0),
                                      child: Text(
                                        'Use this tab to allow group members to post into the group, comment, and go live.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController5,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Announcements Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue5 ??=
                                                containerTribeGroupsRecord
                                                    .communityAdminOnlyTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue5 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_bpkn1sgd_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  communityAdminOnlyTabEnabled:
                                                      true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_bpkn1sgd_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  communityAdminOnlyTabEnabled:
                                                      false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 15.0),
                                      child: Text(
                                        'This tab restricts posts to Admins only.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController6,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Training Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue6 ??=
                                                containerTribeGroupsRecord
                                                    .trainingTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue6 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_535ev3aq_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  trainingTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_535ev3aq_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  trainingTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 15.0),
                                      child: Text(
                                        'To edit the content in the training module, use the 100X Dashboard.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController7,
                                  child: ExpandablePanel(
                                    header: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Next Steps Tab',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                          Switch(
                                            value: _model.switchValue7 ??=
                                                containerTribeGroupsRecord
                                                    .nextStepsTabEnabled,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue7 = newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_g1xvk051_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  nextStepsTabEnabled: true,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'EDIT_GROUP_ADMIN_Switch_g1xvk051_ON_TOGG');
                                                logFirebaseEvent(
                                                    'Switch_backend_call');

                                                await containerTribeGroupsRecord
                                                    .reference
                                                    .update(
                                                        createTribeGroupsRecordData(
                                                  nextStepsTabEnabled: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Visibility(
                                      visible: responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 15.0, 15.0),
                                            child: Builder(
                                              builder: (context) {
                                                final nextSteps =
                                                    containerTribeGroupsRecord
                                                        .nextSteps
                                                        .toList();

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      nextSteps.length,
                                                      (nextStepsIndex) {
                                                    final nextStepsItem =
                                                        nextSteps[
                                                            nextStepsIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              nextStepsItem
                                                                  .title,
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
                                                            ),
                                                          ),
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 60.0,
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .trash,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              size: 20.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'EDIT_GROUP_ADMIN_PAGE_trash_ICN_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'IconButton_backend_call');

                                                              await widget!
                                                                  .groupRef!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'nextSteps':
                                                                        FieldValue
                                                                            .arrayRemove([
                                                                      getNextStepsFirestoreData(
                                                                        updateNextStepsStruct(
                                                                          nextStepsItem,
                                                                          clearUnsetFields:
                                                                              true,
                                                                        ),
                                                                        true,
                                                                      )
                                                                    ]),
                                                                  },
                                                                ),
                                                              });
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'EDIT_GROUP_ADMIN_PAGE_EDIT_BTN_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Button_bottom_sheet');
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
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
                                                                              EditNextStepsWidget(
                                                                            title:
                                                                                nextStepsItem.title,
                                                                            description:
                                                                                nextStepsItem.description,
                                                                            isEdit:
                                                                                true,
                                                                            order:
                                                                                nextStepsItem.order,
                                                                            buttonUrl:
                                                                                nextStepsItem.ctaLink,
                                                                            buttonText:
                                                                                nextStepsItem.ctaText,
                                                                            index:
                                                                                nextStepsIndex,
                                                                            groupRef:
                                                                                containerTribeGroupsRecord.reference,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              text: 'Edit',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 25.0,
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
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15.0,
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
                                                                  width: 0.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
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
                                          FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'EDIT_GROUP_ADMIN_PAGE_BUTTON_BTN_ON_TAP');
                                              logFirebaseEvent(
                                                  'Button_bottom_sheet');
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            EditNextStepsWidget(
                                                          groupRef:
                                                              containerTribeGroupsRecord
                                                                  .reference,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            },
                                            text: 'Button',
                                            options: FFButtonOptions(
                                              width: 130.0,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
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
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 50.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'EDIT_GROUP_ADMIN_SAVE_CHANGES_BTN_ON_TAP');
                                if (FFAppState().uploaded != null &&
                                    FFAppState().uploaded != '') {
                                  logFirebaseEvent('Button_backend_call');

                                  await containerTribeGroupsRecord.reference
                                      .update(createTribeGroupsRecordData(
                                    name: _model.textController1.text,
                                    headlineText: _model.textController2.text,
                                    sessionHeadlineText:
                                        _model.textController3.text,
                                    headlineBtnText:
                                        _model.textController4.text,
                                    headlineBtnUrl: _model.textController5.text,
                                    featuredVideo:
                                        '${getRemoteConfigString('cdnBaseUrl')}${FFAppState().uploaded}',
                                    addEventUrl: _model.textController6.text,
                                  ));
                                } else {
                                  if (containerTribeGroupsRecord
                                              .featuredVideo !=
                                          null &&
                                      containerTribeGroupsRecord
                                              .featuredVideo !=
                                          '') {
                                    logFirebaseEvent('Button_backend_call');

                                    await containerTribeGroupsRecord.reference
                                        .update(createTribeGroupsRecordData(
                                      name: _model.textController1.text,
                                      headlineText: _model.textController2.text,
                                      sessionHeadlineText:
                                          _model.textController3.text,
                                      headlineBtnText:
                                          _model.textController4.text,
                                      headlineBtnUrl:
                                          _model.textController5.text,
                                      featuredVideo: containerTribeGroupsRecord
                                          .featuredVideo,
                                      addEventUrl: _model.textController6.text,
                                    ));
                                  } else {
                                    logFirebaseEvent('Button_backend_call');

                                    await containerTribeGroupsRecord.reference
                                        .update(createTribeGroupsRecordData(
                                      name: _model.textController1.text,
                                      headlineText: _model.textController2.text,
                                      sessionHeadlineText:
                                          _model.textController3.text,
                                      headlineBtnText:
                                          _model.textController4.text,
                                      headlineBtnUrl:
                                          _model.textController5.text,
                                      featuredVideo: '',
                                      addEventUrl: _model.textController6.text,
                                    ));
                                  }
                                }

                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Group updated!',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                                if (containerTribeGroupsRecord
                                    .todayTabEnabled) {
                                  logFirebaseEvent('Button_navigate_to');

                                  context.pushNamed(
                                    'GroupsToday',
                                    queryParameters: {
                                      'groupDoc': serializeParam(
                                        containerTribeGroupsRecord,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'groupDoc': containerTribeGroupsRecord,
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.rightToLeft,
                                      ),
                                    },
                                  );
                                } else {
                                  if (containerTribeGroupsRecord
                                      .replayTabEnabled) {
                                    logFirebaseEvent('Button_navigate_to');

                                    context.pushNamed(
                                      'GroupsReplay',
                                      queryParameters: {
                                        'groupDoc': serializeParam(
                                          containerTribeGroupsRecord,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'groupDoc': containerTribeGroupsRecord,
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.rightToLeft,
                                        ),
                                      },
                                    );
                                  } else {
                                    if (containerTribeGroupsRecord
                                        .communityTabEnabled) {
                                      logFirebaseEvent('Button_navigate_to');

                                      context.pushNamed(
                                        'GroupsCommunity_FB',
                                        queryParameters: {
                                          'groupDoc': serializeParam(
                                            containerTribeGroupsRecord,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'groupDoc':
                                              containerTribeGroupsRecord,
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.rightToLeft,
                                          ),
                                        },
                                      );
                                    } else {
                                      logFirebaseEvent('Button_navigate_to');

                                      context.pushNamed('GroupList');
                                    }
                                  }
                                }
                              },
                              text: 'Save Changes',
                              icon: Icon(
                                Icons.swap_vert,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Open Sans'),
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
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
        ),
      ),
    );
  }
}
