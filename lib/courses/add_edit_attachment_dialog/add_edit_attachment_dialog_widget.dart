import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_edit_attachment_dialog_model.dart';
export 'add_edit_attachment_dialog_model.dart';

class AddEditAttachmentDialogWidget extends StatefulWidget {
  const AddEditAttachmentDialogWidget({
    super.key,
    required this.contentRef,
    this.attachmentDoc,
  });

  final DocumentReference? contentRef;
  final AttachmentsRecord? attachmentDoc;

  @override
  State<AddEditAttachmentDialogWidget> createState() =>
      _AddEditAttachmentDialogWidgetState();
}

class _AddEditAttachmentDialogWidgetState
    extends State<AddEditAttachmentDialogWidget> with TickerProviderStateMixin {
  late AddEditAttachmentDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddEditAttachmentDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADD_EDIT_ATTACHMENT_DIALOG_addEditAttach');
      if (widget!.attachmentDoc != null) {
        logFirebaseEvent('addEditAttachmentDialog_tab_bar');
        safeSetState(() {
          _model.tabBarController!.animateTo(
            _model.tabBarController!.length - 1,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.urlTextFieldTextController ??=
        TextEditingController(text: widget!.attachmentDoc?.url);
    _model.urlTextFieldFocusNode ??= FocusNode();

    _model.nameTextFieldTextController ??=
        TextEditingController(text: widget!.attachmentDoc?.name);
    _model.nameTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 400.0,
        height: 450.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget!.attachmentDoc != null
                        ? 'Edit your attachment'
                        : 'Add new attachment',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context)
                                  .headlineMediumFamily),
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent(
                          'ADD_EDIT_ATTACHMENT_DIALOG_close_ICN_ON_');
                      logFirebaseEvent('IconButton_close_dialog_drawer_etc');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: FlutterFlowButtonTabBar(
                        useToggleButtonStyle: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleMediumFamily),
                                ),
                        unselectedLabelStyle: TextStyle(),
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).primaryText,
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        unselectedBackgroundColor: Color(0xFFF2F4F7),
                        borderColor: Color(0xFFF2F4F7),
                        borderWidth: 4.0,
                        borderRadius: 8.0,
                        elevation: 0.0,
                        buttonMargin:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        padding: EdgeInsets.all(4.0),
                        tabs: [
                          Tab(
                            text: 'Upload',
                          ),
                          Tab(
                            text: 'URL',
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
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 12.0, 4.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'ADD_EDIT_ATTACHMENT_DIALOG_Container_onc');
                                logFirebaseEvent(
                                    'Container_upload_file_to_firebase');
                                final selectedFiles = await selectFiles(
                                  multiFile: false,
                                );
                                if (selectedFiles != null) {
                                  safeSetState(
                                      () => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  var downloadUrls = <String>[];
                                  try {
                                    showUploadMessage(
                                      context,
                                      'Uploading file...',
                                      showLoading: true,
                                    );
                                    selectedUploadedFiles = selectedFiles
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedFiles.map(
                                        (f) async => await uploadData(
                                            f.storagePath, f.bytes),
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
                                          selectedFiles.length &&
                                      downloadUrls.length ==
                                          selectedFiles.length) {
                                    safeSetState(() {
                                      _model.uploadedLocalFile =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl =
                                          downloadUrls.first;
                                    });
                                    showUploadMessage(
                                      context,
                                      'Success!',
                                    );
                                  } else {
                                    safeSetState(() {});
                                    showUploadMessage(
                                      context,
                                      'Failed to upload file',
                                    );
                                    return;
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0x1A18281A),
                                  ),
                                ),
                                child: Builder(
                                  builder: (context) {
                                    if (_model.uploadedFileUrl != null &&
                                        _model.uploadedFileUrl != '') {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Icon(
                                              Icons.cloud_upload,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                              size: 20.0,
                                            ),
                                          ),
                                          Text(
                                            'File is uploaded!',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                          Text(
                                            'Click to upload another file',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: Color(0xFF757B83),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      );
                                    } else {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Icon(
                                              Icons.cloud_upload_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                          ),
                                          Text(
                                            'Click to upload file',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                          Text(
                                            'PNG, JPG or JPEG',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: Color(0xFF757B83),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'URL',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily),
                                      ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Form(
                                    key: _model.formKey1,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: TextFormField(
                                      controller:
                                          _model.urlTextFieldTextController,
                                      focusNode: _model.urlTextFieldFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.urlTextFieldTextController',
                                        Duration(milliseconds: 30),
                                        () async {
                                          logFirebaseEvent(
                                              'ADD_EDIT_ATTACHMENT_DIALOG_urlTextField_');
                                          logFirebaseEvent(
                                              'urlTextField_update_app_state');

                                          safeSetState(() {});
                                        },
                                      ),
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Provide URL',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                              lineHeight: 1.1,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
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
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Open Sans'),
                                            lineHeight: 1.1,
                                          ),
                                      keyboardType: TextInputType.multiline,
                                      validator: _model
                                          .urlTextFieldTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 14.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                child: Text(
                  'Attachment name',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelLargeFamily,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).labelLargeFamily),
                      ),
                ),
              ),
              Form(
                key: _model.formKey2,
                autovalidateMode: AutovalidateMode.disabled,
                child: TextFormField(
                  controller: _model.nameTextFieldTextController,
                  focusNode: _model.nameTextFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.nameTextFieldTextController',
                    Duration(milliseconds: 30),
                    () async {
                      logFirebaseEvent(
                          'ADD_EDIT_ATTACHMENT_DIALOG_nameTextField');
                      logFirebaseEvent('nameTextField_update_app_state');

                      safeSetState(() {});
                    },
                  ),
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Name Attachment',
                    labelStyle:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Open Sans'),
                              lineHeight: 1.1,
                            ),
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
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Open Sans'),
                        lineHeight: 1.1,
                      ),
                  maxLines: 4,
                  minLines: 1,
                  maxLength: 50,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: _model.nameTextFieldTextControllerValidator
                      .asValidator(context),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('ADD_EDIT_ATTACHMENT_DIALOG_saveAttachmen');
                  logFirebaseEvent('saveAttachmentButton_validate_form');
                  if (_model.formKey2.currentState == null ||
                      !_model.formKey2.currentState!.validate()) {
                    return;
                  }
                  if (_model.tabBarCurrentIndex == 0) {
                    if (!(_model.uploadedFileUrl != null &&
                        _model.uploadedFileUrl != '')) {
                      logFirebaseEvent('saveAttachmentButton_show_snack_bar');
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please upload attachment file',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          duration: Duration(milliseconds: 5000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                      return;
                    }
                    if (widget!.attachmentDoc != null) {
                      // Update attachment
                      logFirebaseEvent('saveAttachmentButton_Updateattachment');

                      await widget!.attachmentDoc!.reference
                          .update(createAttachmentsRecordData(
                        name: _model.nameTextFieldTextController.text,
                        url: _model.uploadedFileUrl,
                      ));
                    } else {
                      // Create new attachment
                      logFirebaseEvent(
                          'saveAttachmentButton_Createnewattachment');

                      await AttachmentsRecord.createDoc(widget!.contentRef!)
                          .set(createAttachmentsRecordData(
                        name: _model.nameTextFieldTextController.text,
                        url: _model.uploadedFileUrl,
                      ));
                    }
                  } else {
                    logFirebaseEvent('saveAttachmentButton_validate_form');
                    if (_model.formKey1.currentState == null ||
                        !_model.formKey1.currentState!.validate()) {
                      return;
                    }
                    if (widget!.attachmentDoc != null) {
                      // Update attachment
                      logFirebaseEvent('saveAttachmentButton_Updateattachment');

                      await widget!.attachmentDoc!.reference
                          .update(createAttachmentsRecordData(
                        name: _model.nameTextFieldTextController.text,
                        url: _model.urlTextFieldTextController.text,
                      ));
                    } else {
                      // Create new attachment
                      logFirebaseEvent(
                          'saveAttachmentButton_Createnewattachment');

                      await AttachmentsRecord.createDoc(widget!.contentRef!)
                          .set(createAttachmentsRecordData(
                        name: _model.nameTextFieldTextController.text,
                        url: _model.urlTextFieldTextController.text,
                      ));
                    }
                  }

                  logFirebaseEvent('saveAttachmentButton_action_block');
                  await action_blocks.displaySnackbar(
                    context,
                    message: widget!.attachmentDoc != null
                        ? 'Attachment updated!'
                        : 'Attachment uploaded!',
                  );
                  logFirebaseEvent('saveAttachmentButton_dismiss_dialog');
                  Navigator.pop(context);
                },
                text: widget!.attachmentDoc != null ? 'Update' : 'Save',
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).accent1,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
