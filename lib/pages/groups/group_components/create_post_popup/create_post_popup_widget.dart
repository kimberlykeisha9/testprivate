import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_post_popup_model.dart';
export 'create_post_popup_model.dart';

class CreatePostPopupWidget extends StatefulWidget {
  const CreatePostPopupWidget({
    super.key,
    required this.groupId,
    required this.groupCategories,
    this.groupDoc,
    this.isUserGroupAdmin,
  });

  final int? groupId;
  final List<String>? groupCategories;
  final TribeGroupsRecord? groupDoc;
  final bool? isUserGroupAdmin;

  @override
  State<CreatePostPopupWidget> createState() => _CreatePostPopupWidgetState();
}

class _CreatePostPopupWidgetState extends State<CreatePostPopupWidget> {
  late CreatePostPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreatePostPopupModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.notificationTitleTextFieldTextController ??= TextEditingController();
    _model.notificationTitleTextFieldFocusNode ??= FocusNode();

    _model.notificationMessageTextFieldTextController ??=
        TextEditingController();
    _model.notificationMessageTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        constraints: BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                5.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 15.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.white,
                      borderRadius: 30.0,
                      borderWidth: 0.0,
                      buttonSize: 50.0,
                      fillColor: FlutterFlowTheme.of(context).accent1,
                      icon: Icon(
                        Icons.close,
                        color: Color(0x00222222),
                        size: 30.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    Flexible(
                      child: Text(
                        'Create post',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.white,
                      borderWidth: 0.0,
                      buttonSize: 50.0,
                      fillColor: FlutterFlowTheme.of(context).accent1,
                      icon: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'CREATE_POST_POPUP_COMP_close_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_back');
                        context.safePop();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthUserStreamWidget(
                          builder: (context) => Container(
                            width: 45.0,
                            height: 45.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              fadeOutDuration: Duration(milliseconds: 500),
                              imageUrl: currentUserPhoto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Container(
                              width: double.infinity,
                              height: 250.0,
                              child: custom_widgets.UserMentionTextInputV2(
                                width: double.infinity,
                                height: 250.0,
                                mentionSuggestionListSize: 5,
                                minLines: 4,
                                maxLines: 14,
                                hint: 'What would you like to share?',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Visibility(
                              visible: responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ),
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode,
                                textCapitalization: TextCapitalization.words,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Title (Optional)',
                                  hintText: 'Title of your content',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20.0, 25.0, 20.0, 12.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                textAlign: TextAlign.start,
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150.0,
                        height: 100.0,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).lineColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            if (_model.uploadedFileUrl1 != null &&
                                _model.uploadedFileUrl1 != '')
                              FlutterFlowMediaDisplay(
                                path: _model.uploadedFileUrl1,
                                imageBuilder: (path) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    path,
                                    width: 150.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                videoPlayerBuilder: (path) =>
                                    FlutterFlowVideoPlayer(
                                  path: path,
                                  autoPlay: false,
                                  looping: true,
                                  showControls: true,
                                  allowFullScreen: true,
                                  allowPlaybackSpeedMenu: false,
                                ),
                              ),
                            if (_model.uploadedFileUrl1 == null ||
                                _model.uploadedFileUrl1 == '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 6.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CREATE_POST_POPUP_ADD_PHOTO_BTN_ON_TAP');
                                    logFirebaseEvent(
                                        'Button_upload_media_to_firebase');
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 800.00,
                                      maxHeight: 800.00,
                                      imageQuality: 90,
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(
                                          () => _model.isDataUploading1 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        showUploadMessage(
                                          context,
                                          'Uploading file...',
                                          showLoading: true,
                                        );
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        _model.isDataUploading1 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile1 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl1 =
                                              downloadUrls.first;
                                        });
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        safeSetState(() {});
                                        showUploadMessage(
                                            context, 'Failed to upload data');
                                        return;
                                      }
                                    }
                                  },
                                  text: 'Add Photo',
                                  icon: Icon(
                                    Icons.photo_library_outlined,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 35.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0x00262D34),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            if (_model.uploadedFileUrl1 != null &&
                                _model.uploadedFileUrl1 != '')
                              Align(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 4.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    borderWidth: 0.0,
                                    buttonSize: 30.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).error,
                                    icon: Icon(
                                      Icons.delete_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 14.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CREATE_POST_POPUP_delete_sharp_ICN_ON_TA');
                                      logFirebaseEvent(
                                          'IconButton_clear_uploaded_data');
                                      safeSetState(() {
                                        _model.isDataUploading1 = false;
                                        _model.uploadedLocalFile1 =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl1 = '';
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150.0,
                        height: 100.0,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).lineColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            if (_model.uploadedFileUrl2 != null &&
                                _model.uploadedFileUrl2 != '')
                              FlutterFlowMediaDisplay(
                                path: _model.uploadedFileUrl2,
                                imageBuilder: (path) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    path,
                                    width: 150.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                videoPlayerBuilder: (path) =>
                                    FlutterFlowVideoPlayer(
                                  path: path,
                                  width: 150.0,
                                  height: 100.0,
                                  autoPlay: false,
                                  looping: false,
                                  showControls: true,
                                  allowFullScreen: false,
                                  allowPlaybackSpeedMenu: false,
                                ),
                              ),
                            if (_model.uploadedFileUrl2 == null ||
                                _model.uploadedFileUrl2 == '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 6.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CREATE_POST_POPUP_ADD_VIDEO_BTN_ON_TAP');
                                    logFirebaseEvent(
                                        'Button_upload_media_to_firebase');
                                    final selectedMedia = await selectMedia(
                                      isVideo: true,
                                      mediaSource: MediaSource.videoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(
                                          () => _model.isDataUploading2 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        showUploadMessage(
                                          context,
                                          'Uploading file...',
                                          showLoading: true,
                                        );
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        _model.isDataUploading2 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile2 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl2 =
                                              downloadUrls.first;
                                        });
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        safeSetState(() {});
                                        showUploadMessage(
                                            context, 'Failed to upload data');
                                        return;
                                      }
                                    }
                                  },
                                  text: 'Add Video',
                                  icon: Icon(
                                    Icons.videocam_sharp,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 35.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0x00262D34),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            if (_model.uploadedFileUrl2 != null &&
                                _model.uploadedFileUrl2 != '')
                              Align(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 4.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 20.0,
                                    borderWidth: 0.0,
                                    buttonSize: 30.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).error,
                                    icon: Icon(
                                      Icons.delete_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 14.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CREATE_POST_POPUP_delete_sharp_ICN_ON_TA');
                                      logFirebaseEvent(
                                          'IconButton_clear_uploaded_data');
                                      safeSetState(() {
                                        _model.isDataUploading2 = false;
                                        _model.uploadedLocalFile2 =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl2 = '';
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ],
              ),
              if (widget!.groupCategories!.length > 0)
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Add your post to a category (optional)',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodySmallFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodySmallFamily),
                            ),
                      ),
                    ],
                  ),
                ),
              if (widget!.groupCategories!.length > 0)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 5.0, 15.0, 0.0),
                          child: FlutterFlowChoiceChips(
                            options: widget!.groupCategories!
                                .map((label) => ChipData(label))
                                .toList(),
                            onChanged: (val) => safeSetState(
                                () => _model.choiceChipsValues = val),
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                  ),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              iconSize: 18.0,
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                  ),
                              iconColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              iconSize: 18.0,
                              elevation: 0.0,
                              borderColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            chipSpacing: 12.0,
                            rowSpacing: 10.0,
                            multiselect: true,
                            initialized: _model.choiceChipsValues != null,
                            alignment: WrapAlignment.start,
                            controller: _model.choiceChipsValueController ??=
                                FormFieldController<List<String>>(
                              ['All'],
                            ),
                            wrapped: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Visibility(
                  visible: widget!.isUserGroupAdmin ?? true,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value:
                                          _model.enablePushNotificationValue ??=
                                              false,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.enablePushNotificationValue =
                                                newValue!);
                                      },
                                      title: Text(
                                        'Notify Group',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLargeFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                              lineHeight: 1.0,
                                            ),
                                      ),
                                      subtitle: Text(
                                        'This will send a push notification to this Group. This is only available for Admins.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context).accent1,
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                  if (_model.enablePushNotificationValue ??
                                      true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 15.0, 0.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          controller: _model
                                              .notificationTitleTextFieldTextController,
                                          focusNode: _model
                                              .notificationTitleTextFieldFocusNode,
                                          autofocus: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          textInputAction: TextInputAction.next,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Notification Title',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily),
                                                    ),
                                            hintText:
                                                'Enter Notification Title here...',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 15.0, 15.0, 12.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLength: 32,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          validator: _model
                                              .notificationTitleTextFieldTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Visibility(
                                        visible: _model
                                                .enablePushNotificationValue ??
                                            true,
                                        child: TextFormField(
                                          controller: _model
                                              .notificationMessageTextFieldTextController,
                                          focusNode: _model
                                              .notificationMessageTextFieldFocusNode,
                                          autofocus: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          textInputAction: TextInputAction.next,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Notification Message',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily),
                                                    ),
                                            hintText:
                                                'Enter Notification Message...',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 15.0, 15.0, 12.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          maxLength: 64,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          validator: _model
                                              .notificationMessageTextFieldTextControllerValidator
                                              .asValidator(context),
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (valueOrDefault(currentUserDocument?.userRole, '') ==
                            'admin')
                          AuthUserStreamWidget(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CREATE_POST_POPUP_goLiveButton_ON_TAP');
                                logFirebaseEvent(
                                    'goLiveButton_update_app_state');
                                FFAppState().processing = false;
                                safeSetState(() {});
                                if (_model.enablePushNotificationValue!) {
                                  logFirebaseEvent(
                                      'goLiveButton_validate_form');
                                  if (_model.formKey.currentState == null ||
                                      !_model.formKey.currentState!
                                          .validate()) {
                                    return;
                                  }
                                  logFirebaseEvent('goLiveButton_action_block');
                                  _model.newBroadcast =
                                      await action_blocks.createLiveStream(
                                    context,
                                    name: _model.textController1.text,
                                    description: ' ',
                                    groupId: widget!.groupId,
                                    category: _model.choiceChipsValues,
                                  );
                                  logFirebaseEvent(
                                      'goLiveButton_firestore_query');
                                  _model.queryGroupUsersGoLive =
                                      await queryUserRecordOnce(
                                    queryBuilder: (userRecord) =>
                                        userRecord.where(
                                      'TribeGroups',
                                      arrayContains:
                                          getTribeGroupsFirestoreData(
                                        TribeGroupsStruct(
                                          tribeGroupID:
                                              widget!.groupDoc?.tribeGroupID,
                                          groupRef: widget!.groupDoc?.reference,
                                          role: 'member',
                                        ),
                                        true,
                                      ),
                                    ),
                                  );
                                  logFirebaseEvent(
                                      'goLiveButton_trigger_push_notification');
                                  triggerPushNotification(
                                    notificationTitle: _model
                                        .notificationTitleTextFieldTextController
                                        .text,
                                    notificationText: _model
                                        .notificationMessageTextFieldTextController
                                        .text,
                                    notificationSound: 'default',
                                    userRefs: _model.queryGroupUsersGoLive!
                                        .map((e) => e.reference)
                                        .toList(),
                                    initialPageName: 'StartBroadcast_FB',
                                    parameterData: {
                                      'title': _model.textController1.text,
                                      'description':
                                          FFAppState().userMentionTextInputText,
                                      'sendNotification': true,
                                      'groupDoc': widget!.groupDoc,
                                      'notificationTitle': _model
                                          .notificationTitleTextFieldTextController
                                          .text,
                                      'notificationMessage': _model
                                          .notificationMessageTextFieldTextController
                                          .text,
                                      'broadcast': _model.newBroadcast,
                                    },
                                  );
                                  logFirebaseEvent(
                                      'goLiveButton_update_app_state');
                                  FFAppState().userMentionTextInputClearState =
                                      true;
                                  safeSetState(() {});
                                  logFirebaseEvent('goLiveButton_navigate_to');

                                  context.pushNamed(
                                    'StartBroadcast_FB',
                                    queryParameters: {
                                      'description': serializeParam(
                                        FFAppState().userMentionTextInputText,
                                        ParamType.String,
                                      ),
                                      'title': serializeParam(
                                        _model.textController1.text,
                                        ParamType.String,
                                      ),
                                      'sendNotification': serializeParam(
                                        true,
                                        ParamType.bool,
                                      ),
                                      'notificationTitle': serializeParam(
                                        _model
                                            .notificationTitleTextFieldTextController
                                            .text,
                                        ParamType.String,
                                      ),
                                      'notificationMessage': serializeParam(
                                        _model
                                            .notificationMessageTextFieldTextController
                                            .text,
                                        ParamType.String,
                                      ),
                                      'groupDoc': serializeParam(
                                        widget!.groupDoc,
                                        ParamType.Document,
                                      ),
                                      'category': serializeParam(
                                        _model.choiceChipsValues,
                                        ParamType.String,
                                        isList: true,
                                      ),
                                      'broadcast': serializeParam(
                                        _model.newBroadcast,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'groupDoc': widget!.groupDoc,
                                    },
                                  );
                                } else {
                                  logFirebaseEvent('goLiveButton_action_block');
                                  _model.newBroadcastNoNotification =
                                      await action_blocks.createLiveStream(
                                    context,
                                    name: _model.textController1.text,
                                    description: ' ',
                                    groupId: widget!.groupId,
                                    category: _model.choiceChipsValues,
                                  );
                                  logFirebaseEvent('goLiveButton_navigate_to');

                                  context.pushNamed(
                                    'StartBroadcast_FB',
                                    queryParameters: {
                                      'description': serializeParam(
                                        FFAppState().userMentionTextInputText,
                                        ParamType.String,
                                      ),
                                      'title': serializeParam(
                                        _model.textController1.text,
                                        ParamType.String,
                                      ),
                                      'sendNotification': serializeParam(
                                        false,
                                        ParamType.bool,
                                      ),
                                      'groupDoc': serializeParam(
                                        widget!.groupDoc,
                                        ParamType.Document,
                                      ),
                                      'category': serializeParam(
                                        _model.choiceChipsValues,
                                        ParamType.String,
                                        isList: true,
                                      ),
                                      'broadcast': serializeParam(
                                        _model.newBroadcastNoNotification,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'groupDoc': widget!.groupDoc,
                                    },
                                  );
                                }

                                logFirebaseEvent('goLiveButton_bottom_sheet');
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.enablePushNotificationValue!
                                    ? 'Go Live & Notify'
                                    : 'Go Live',
                                'Go Live',
                              ),
                              icon: Icon(
                                Icons.circle_rounded,
                                color: FlutterFlowTheme.of(context).accent1,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 45.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 8.0, 10.0, 8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).error,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                        FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CREATE_POST_POPUP_COMP_postButton_ON_TAP');
                            logFirebaseEvent('postButton_validate_form');
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            logFirebaseEvent('postButton_update_app_state');
                            FFAppState().userMentionTextInputClearState = true;
                            safeSetState(() {});
                            if (_model.enablePushNotificationValue!) {
                              logFirebaseEvent('postButton_backend_call');

                              var broadcastsRecordReference1 =
                                  BroadcastsRecord.collection.doc();
                              await broadcastsRecordReference1.set({
                                ...createBroadcastsRecordData(
                                  isLive: false,
                                  name: FFAppState().userMentionTextInputText,
                                  time: getCurrentTimestamp,
                                  title: _model.textController1.text,
                                  userId: currentUserReference,
                                  groupId: widget!.groupId,
                                  authorName: currentUserDisplayName,
                                  authorRole: valueOrDefault(
                                      currentUserDocument?.userRole, ''),
                                  authorImg: currentUserPhoto,
                                  chatEnabled: true,
                                  pinnedToTop: false,
                                  video: _model.uploadedFileUrl2,
                                  featuredImage: _model.uploadedFileUrl1,
                                ),
                                ...mapToFirestore(
                                  {
                                    'category': _model.choiceChipsValues,
                                  },
                                ),
                              });
                              _model.createdPostWithNotification =
                                  BroadcastsRecord.getDocumentFromData({
                                ...createBroadcastsRecordData(
                                  isLive: false,
                                  name: FFAppState().userMentionTextInputText,
                                  time: getCurrentTimestamp,
                                  title: _model.textController1.text,
                                  userId: currentUserReference,
                                  groupId: widget!.groupId,
                                  authorName: currentUserDisplayName,
                                  authorRole: valueOrDefault(
                                      currentUserDocument?.userRole, ''),
                                  authorImg: currentUserPhoto,
                                  chatEnabled: true,
                                  pinnedToTop: false,
                                  video: _model.uploadedFileUrl2,
                                  featuredImage: _model.uploadedFileUrl1,
                                ),
                                ...mapToFirestore(
                                  {
                                    'category': _model.choiceChipsValues,
                                  },
                                ),
                              }, broadcastsRecordReference1);
                              // Query member users
                              logFirebaseEvent('postButton_Querymemberusers');
                              _model.queryGroupUsers =
                                  await queryUserRecordOnce(
                                queryBuilder: (userRecord) => userRecord.where(
                                  'TribeGroups',
                                  arrayContains: getTribeGroupsFirestoreData(
                                    TribeGroupsStruct(
                                      tribeGroupID:
                                          widget!.groupDoc?.tribeGroupID,
                                      groupRef: widget!.groupDoc?.reference,
                                      role: 'member',
                                    ),
                                    true,
                                  ),
                                ),
                              );
                              // Query admin users
                              logFirebaseEvent('postButton_Queryadminusers');
                              _model.queryGroupAdmins =
                                  await queryUserRecordOnce(
                                queryBuilder: (userRecord) => userRecord.where(
                                  'TribeGroups',
                                  arrayContains: getTribeGroupsFirestoreData(
                                    TribeGroupsStruct(
                                      tribeGroupID:
                                          widget!.groupDoc?.tribeGroupID,
                                      groupRef: widget!.groupDoc?.reference,
                                      role: 'admin',
                                    ),
                                    true,
                                  ),
                                ),
                              );
                              logFirebaseEvent(
                                  'postButton_update_component_state');
                              _model.usersList = functions
                                  .addTwoUserRefLists(
                                      _model.queryGroupUsers!
                                          .map((e) => e.reference)
                                          .toList(),
                                      _model.queryGroupAdmins!
                                          .map((e) => e.reference)
                                          .toList())
                                  .toList()
                                  .cast<DocumentReference>();
                              safeSetState(() {});
                              logFirebaseEvent(
                                  'postButton_trigger_push_notification');
                              triggerPushNotification(
                                notificationTitle: _model
                                    .notificationTitleTextFieldTextController
                                    .text,
                                notificationText: _model
                                    .notificationMessageTextFieldTextController
                                    .text,
                                notificationSound: 'default',
                                userRefs: _model.usersList.toList(),
                                initialPageName: 'DiscussionPost',
                                parameterData: {
                                  'broadcastDoc':
                                      _model.createdPostWithNotification,
                                  'groupDoc': widget!.groupDoc,
                                },
                              );
                              // Add Notification to Firebase
                              logFirebaseEvent(
                                  'postButton_AddNotificationtoFirebase');

                              await NotificationsRecord.collection.doc().set({
                                ...createNotificationsRecordData(
                                  title: _model
                                      .notificationTitleTextFieldTextController
                                      .text,
                                  description: _model
                                      .notificationMessageTextFieldTextController
                                      .text,
                                  timeCreated: getCurrentTimestamp,
                                  discussionPostRef: _model
                                      .createdPostWithNotification?.reference,
                                ),
                                ...mapToFirestore(
                                  {
                                    'UserRefList': _model.queryGroupUsers
                                        ?.map((e) => e.reference)
                                        .toList(),
                                  },
                                ),
                              });
                              logFirebaseEvent('postButton_wait__delay');
                              await Future.delayed(
                                  const Duration(milliseconds: 1500));
                              logFirebaseEvent('postButton_navigate_to');

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

                              if (FFAppState()
                                      .userMentionTextInputUserRefs
                                      .length >
                                  0) {
                                logFirebaseEvent(
                                    'postButton_trigger_push_notification');
                                triggerPushNotification(
                                  notificationTitle: 'New mention',
                                  notificationText:
                                      '${currentUserDisplayName} mentioned you in a post',
                                  userRefs: FFAppState()
                                      .userMentionTextInputUserRefs
                                      .toList(),
                                  initialPageName: 'DiscussionPost',
                                  parameterData: {
                                    'groupDoc': widget!.groupDoc,
                                    'broadcastDoc':
                                        _model.createdPostWithNotification,
                                  },
                                );
                                // Add Notification to Firebase
                                logFirebaseEvent(
                                    'postButton_AddNotificationtoFirebase');

                                var notificationsRecordReference2 =
                                    NotificationsRecord.collection.doc();
                                await notificationsRecordReference2.set({
                                  ...createNotificationsRecordData(
                                    title: 'New Mention',
                                    description:
                                        '${currentUserDisplayName} mentioned you in a post',
                                    timeCreated: getCurrentTimestamp,
                                    discussionPostRef: _model
                                        .createdPostWithNotification?.reference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'UserRefList': FFAppState()
                                          .userMentionTextInputUserRefs,
                                    },
                                  ),
                                });
                                _model.mentionNotificat =
                                    NotificationsRecord.getDocumentFromData({
                                  ...createNotificationsRecordData(
                                    title: 'New Mention',
                                    description:
                                        '${currentUserDisplayName} mentioned you in a post',
                                    timeCreated: getCurrentTimestamp,
                                    discussionPostRef: _model
                                        .createdPostWithNotification?.reference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'UserRefList': FFAppState()
                                          .userMentionTextInputUserRefs,
                                    },
                                  ),
                                }, notificationsRecordReference2);
                              }
                              logFirebaseEvent('postButton_show_snack_bar');
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Post + Notification sent!',
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
                            } else {
                              logFirebaseEvent('postButton_backend_call');

                              var broadcastsRecordReference2 =
                                  BroadcastsRecord.collection.doc();
                              await broadcastsRecordReference2.set({
                                ...createBroadcastsRecordData(
                                  isLive: false,
                                  name: FFAppState().userMentionTextInputText,
                                  time: getCurrentTimestamp,
                                  title: _model.textController1.text,
                                  userId: currentUserReference,
                                  groupId: widget!.groupId,
                                  authorName: currentUserDisplayName,
                                  authorRole: valueOrDefault(
                                      currentUserDocument?.userRole, ''),
                                  authorImg: currentUserPhoto,
                                  chatEnabled: true,
                                  pinnedToTop: false,
                                  featuredImage: _model.uploadedFileUrl1,
                                  video: _model.uploadedFileUrl2,
                                ),
                                ...mapToFirestore(
                                  {
                                    'category': _model.choiceChipsValues,
                                  },
                                ),
                              });
                              _model.newPost =
                                  BroadcastsRecord.getDocumentFromData({
                                ...createBroadcastsRecordData(
                                  isLive: false,
                                  name: FFAppState().userMentionTextInputText,
                                  time: getCurrentTimestamp,
                                  title: _model.textController1.text,
                                  userId: currentUserReference,
                                  groupId: widget!.groupId,
                                  authorName: currentUserDisplayName,
                                  authorRole: valueOrDefault(
                                      currentUserDocument?.userRole, ''),
                                  authorImg: currentUserPhoto,
                                  chatEnabled: true,
                                  pinnedToTop: false,
                                  featuredImage: _model.uploadedFileUrl1,
                                  video: _model.uploadedFileUrl2,
                                ),
                                ...mapToFirestore(
                                  {
                                    'category': _model.choiceChipsValues,
                                  },
                                ),
                              }, broadcastsRecordReference2);
                              logFirebaseEvent('postButton_wait__delay');
                              await Future.delayed(
                                  const Duration(milliseconds: 1500));
                              logFirebaseEvent('postButton_navigate_to');

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

                              if (FFAppState()
                                      .userMentionTextInputUserRefs
                                      .length >
                                  0) {
                                logFirebaseEvent(
                                    'postButton_trigger_push_notification');
                                triggerPushNotification(
                                  notificationTitle: 'New Mention',
                                  notificationText:
                                      '${currentUserDisplayName} mentioned you in a post',
                                  userRefs: FFAppState()
                                      .userMentionTextInputUserRefs
                                      .toList(),
                                  initialPageName: 'DiscussionPost',
                                  parameterData: {
                                    'groupDoc': widget!.groupDoc,
                                    'broadcastDoc': _model.newPost,
                                  },
                                );
                                // Add Notification to Firebase
                                logFirebaseEvent(
                                    'postButton_AddNotificationtoFirebase');

                                var notificationsRecordReference3 =
                                    NotificationsRecord.collection.doc();
                                await notificationsRecordReference3.set({
                                  ...createNotificationsRecordData(
                                    title: 'New Mention',
                                    description:
                                        '${currentUserDisplayName} mentioned you in a post',
                                    timeCreated: getCurrentTimestamp,
                                    discussionPostRef:
                                        _model.newPost?.reference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'UserRefList': FFAppState()
                                          .userMentionTextInputUserRefs,
                                    },
                                  ),
                                });
                                _model.mentionNotification =
                                    NotificationsRecord.getDocumentFromData({
                                  ...createNotificationsRecordData(
                                    title: 'New Mention',
                                    description:
                                        '${currentUserDisplayName} mentioned you in a post',
                                    timeCreated: getCurrentTimestamp,
                                    discussionPostRef:
                                        _model.newPost?.reference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'UserRefList': FFAppState()
                                          .userMentionTextInputUserRefs,
                                    },
                                  ),
                                }, notificationsRecordReference3);
                              }
                              logFirebaseEvent('postButton_show_snack_bar');
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Post Successful! :)',
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
                            }

                            safeSetState(() {});
                          },
                          text: valueOrDefault<String>(
                            _model.enablePushNotificationValue!
                                ? 'Post & Notify'
                                : 'Post',
                            'Post',
                          ),
                          icon: Icon(
                            Icons.send,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 45.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 8.0, 10.0, 8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleMediumFamily),
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
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
