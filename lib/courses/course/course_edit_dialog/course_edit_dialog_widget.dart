import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/course_member_role_dropdown_widget.dart';
import '/courses/course/course_invite_member_dialog/course_invite_member_dialog_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'course_edit_dialog_model.dart';
export 'course_edit_dialog_model.dart';

class CourseEditDialogWidget extends StatefulWidget {
  const CourseEditDialogWidget({
    super.key,
    required this.courseDoc,
    this.groupDoc,
  });

  final TribeCourseRecord? courseDoc;
  final TribeGroupsRecord? groupDoc;

  @override
  State<CourseEditDialogWidget> createState() => _CourseEditDialogWidgetState();
}

class _CourseEditDialogWidgetState extends State<CourseEditDialogWidget> {
  late CourseEditDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseEditDialogModel());

    _model.courseNameTextFieldTextController ??=
        TextEditingController(text: widget!.courseDoc?.title);
    _model.courseNameTextFieldFocusNode ??= FocusNode();

    _model.courseDescriptionTextFieldTextController ??=
        TextEditingController(text: widget!.courseDoc?.description);
    _model.courseDescriptionTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550.0,
      constraints: BoxConstraints(
        maxHeight: 880.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget!.courseDoc!.hasTitle()
                        ? 'Edit Course'
                        : 'Create New Course',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleLargeFamily,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleLargeFamily),
                        ),
                  ),
                  FlutterFlowChoiceChips(
                    options: [ChipData('Group'), ChipData('Private')],
                    onChanged: (val) => safeSetState(
                        () => _model.accessChoiceChipsValue = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFF3D4451),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).white,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      iconColor: FlutterFlowTheme.of(context).white,
                      iconSize: 18.0,
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: Colors.transparent,
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
                          ),
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                      iconSize: 18.0,
                      elevation: 0.0,
                      borderColor: Color(0x1A18281A),
                      borderWidth: 0.8,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    chipSpacing: 12.0,
                    rowSpacing: 12.0,
                    multiselect: false,
                    initialized: _model.accessChoiceChipsValue != null,
                    alignment: WrapAlignment.start,
                    controller: _model.accessChoiceChipsValueController ??=
                        FormFieldController<List<String>>(
                      [
                        valueOrDefault<String>(
                          widget!.courseDoc?.accessType,
                          'Group',
                        )
                      ],
                    ),
                    wrapped: true,
                  ),
                ],
              ),
            ),
            Text(
              'Course Name',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleSmallFamily),
                  ),
            ),
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  controller: _model.courseNameTextFieldTextController,
                  focusNode: _model.courseNameTextFieldFocusNode,
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                        lineHeight: 1.1,
                      ),
                  maxLength: 50,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  keyboardType: TextInputType.multiline,
                  validator: _model.courseNameTextFieldTextControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
            Text(
              'Course Description',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleSmallFamily),
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _model.courseDescriptionTextFieldTextController,
                    focusNode: _model.courseDescriptionTextFieldFocusNode,
                    autofocus: false,
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondaryText,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Open Sans'),
                          lineHeight: 1.1,
                        ),
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    validator: _model
                        .courseDescriptionTextFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Image',
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((_model.uploadedFileUrl != null &&
                              _model.uploadedFileUrl != '') ||
                          (widget!.courseDoc?.featuredImage != null &&
                              widget!.courseDoc?.featuredImage != ''))
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            _model.uploadedFileUrl != null &&
                                    _model.uploadedFileUrl != ''
                                ? _model.uploadedFileUrl
                                : widget!.courseDoc!.featuredImage,
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, -1.0),
                          ),
                        ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (false)
                              Text(
                                'No course image added',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                              ),
                            Text(
                              'Images with 3:2 aspect ratio work best\n(1080x720p)',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                            ),
                          ].divide(SizedBox(height: 2.0)),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'COURSE_EDIT_DIALOG_uploadImageButton_ON_');
                          logFirebaseEvent(
                              'uploadImageButton_upload_media_to_fireba');
                          final selectedMedia = await selectMedia(
                            maxWidth: 1280.00,
                            maxHeight: 720.00,
                            mediaSource: MediaSource.photoGallery,
                            multiImage: false,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            safeSetState(() => _model.isDataUploading = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            var downloadUrls = <String>[];
                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
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

                              downloadUrls = (await Future.wait(
                                selectedMedia.map(
                                  (m) async =>
                                      await uploadData(m.storagePath, m.bytes),
                                ),
                              ))
                                  .where((u) => u != null)
                                  .map((u) => u!)
                                  .toList();
                            } finally {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              _model.isDataUploading = false;
                            }
                            if (selectedUploadedFiles.length ==
                                    selectedMedia.length &&
                                downloadUrls.length == selectedMedia.length) {
                              safeSetState(() {
                                _model.uploadedLocalFile =
                                    selectedUploadedFiles.first;
                                _model.uploadedFileUrl = downloadUrls.first;
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
                        text: 'Upload image',
                        icon: Icon(
                          Icons.file_upload_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 18.0,
                        ),
                        options: FFButtonOptions(
                          height: 34.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ].divide(SizedBox(width: 14.0)),
                  ),
                ].divide(SizedBox(height: 2.0)),
              ),
            ),
            Flexible(
              child: StreamBuilder<List<MembersListRecord>>(
                stream: queryMembersListRecord(
                  parent: widget!.courseDoc?.reference,
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
                  List<MembersListRecord> queryContainerMembersListRecordList =
                      snapshot.data!;

                  return Container(
                    constraints: BoxConstraints(
                      maxHeight: 230.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Members',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                  ),
                                  Text(
                                    () {
                                      if (_model.accessChoiceChipsValue ==
                                          'Group') {
                                        return 'All group members have access to this course';
                                      } else if (!(queryContainerMembersListRecordList
                                          .isNotEmpty)) {
                                        return 'No members added';
                                      } else {
                                        return ' ';
                                      }
                                    }(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                  ),
                                ],
                              ),
                              if ((_model.accessChoiceChipsValue ==
                                      'Private') &&
                                  (widget!.courseDoc != null))
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'COURSE_EDIT_DIALOG_ADD_MEMBERS_BTN_ON_TA');
                                      logFirebaseEvent('Button_alert_dialog');
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: WebViewAware(
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.8,
                                                child:
                                                    CourseInviteMemberDialogWidget(
                                                  courseDoc: widget!.courseDoc!,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    text: 'Add members',
                                    icon: Icon(
                                      Icons.person_add_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 16.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 34.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (_model.accessChoiceChipsValue == 'Private')
                          Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 180.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final queryContainerVar =
                                        queryContainerMembersListRecordList
                                            .toList();

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: queryContainerVar.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 14.0),
                                      itemBuilder:
                                          (context, queryContainerVarIndex) {
                                        final queryContainerVarItem =
                                            queryContainerVar[
                                                queryContainerVarIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 24.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child:
                                                    StreamBuilder<UserRecord>(
                                                  stream:
                                                      UserRecord.getDocument(
                                                          queryContainerVarItem
                                                              .userRef!),
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

                                                    final userRowUserRecord =
                                                        snapshot.data!;

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              userRowUserRecord
                                                                  .photoUrl,
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                            ),
                                                            width: 40.0,
                                                            height: 40.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Text(
                                                          userRowUserRecord
                                                              .displayName,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodySmallFamily),
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child:
                                                          CourseMemberRoleDropdownWidget(
                                                        key: Key(
                                                            'Keycf0_${queryContainerVarIndex}_of_${queryContainerVar.length}'),
                                                        role:
                                                            queryContainerVarItem
                                                                .role,
                                                        selectionCallback:
                                                            (selection) async {
                                                          logFirebaseEvent(
                                                              'COURSE_EDIT_DIALOG_Container_cf0ql36f_CA');
                                                          logFirebaseEvent(
                                                              'courseMemberRoleDropdown_backend_call');

                                                          await queryContainerVarItem
                                                              .reference
                                                              .update(
                                                                  createMembersListRecordData(
                                                            role: selection,
                                                          ));
                                                          logFirebaseEvent(
                                                              'courseMemberRoleDropdown_action_block');
                                                          await action_blocks
                                                              .displaySnackbar(
                                                            context,
                                                            message:
                                                                'User access updated!',
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 20.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .trashAlt,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        size: 18.0,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'COURSE_EDIT_DIALOG_removeIconButton_ON_T');
                                                        logFirebaseEvent(
                                                            'removeIconButton_alert_dialog');
                                                        var confirmDialogResponse =
                                                            await showDialog<
                                                                    bool>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return WebViewAware(
                                                                      child:
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            'Remove user from this course?'),
                                                                        content:
                                                                            Text('You are about to remove this user to course. Confirm to continue'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, true),
                                                                            child:
                                                                                Text('Confirm'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ) ??
                                                                false;
                                                        if (!confirmDialogResponse) {
                                                          return;
                                                        }
                                                        logFirebaseEvent(
                                                            'removeIconButton_backend_call');
                                                        await queryContainerVarItem
                                                            .reference
                                                            .delete();
                                                        logFirebaseEvent(
                                                            'removeIconButton_backend_call');

                                                        await queryContainerVarItem
                                                            .userRef!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'privateCourses':
                                                                  FieldValue
                                                                      .arrayRemove([
                                                                widget!
                                                                    .courseDoc
                                                                    ?.reference
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                        logFirebaseEvent(
                                                            'removeIconButton_action_block');
                                                        await action_blocks
                                                            .displaySnackbar(
                                                          context,
                                                          message:
                                                              'User removed from course!',
                                                        );
                                                      },
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 16.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'COURSE_EDIT_DIALOG_cancelButton_ON_TAP');
                        logFirebaseEvent(
                            'cancelButton_close_dialog_drawer_etc');
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).accent1,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'COURSE_EDIT_DIALOG_saveButton_ON_TAP');
                        logFirebaseEvent('saveButton_validate_form');
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                        // Update course doc
                        logFirebaseEvent('saveButton_Updatecoursedoc');

                        await widget!.courseDoc!.reference
                            .update(createTribeCourseRecordData(
                          title: _model.courseNameTextFieldTextController.text,
                          description: _model
                              .courseDescriptionTextFieldTextController.text,
                          featuredImage: _model.uploadedFileUrl != null &&
                                  _model.uploadedFileUrl != ''
                              ? _model.uploadedFileUrl
                              : widget!.courseDoc?.featuredImage,
                          accessType: _model.accessChoiceChipsValue,
                        ));
                        logFirebaseEvent('saveButton_action_block');
                        await action_blocks.displaySnackbar(
                          context,
                          message: 'Course updated!',
                        );
                        logFirebaseEvent('saveButton_bottom_sheet');
                        Navigator.pop(context);
                      },
                      text: widget!.courseDoc!.hasTitle() ? 'Save' : 'Create',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
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
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
            if ((widget!.courseDoc != null) && false)
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('COURSE_EDIT_DIALOG_deleteButton_ON_TAP');
                  logFirebaseEvent('deleteButton_alert_dialog');
                  var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'This action is permanent and cannot be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            ),
                          );
                        },
                      ) ??
                      false;
                  if (confirmDialogResponse) {
                    logFirebaseEvent('deleteButton_backend_call');
                    await widget!.courseDoc!.reference.delete();
                    logFirebaseEvent('deleteButton_action_block');
                    await action_blocks.displaySnackbar(
                      context,
                      message: 'Course deleted.',
                    );
                    logFirebaseEvent('deleteButton_bottom_sheet');
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
                text: 'Delete',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).tertiary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).error,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
