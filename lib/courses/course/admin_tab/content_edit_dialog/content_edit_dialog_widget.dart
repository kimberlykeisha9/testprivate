import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/alert_dialog_widget.dart';
import '/courses/add_edit_attachment_dialog/add_edit_attachment_dialog_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'content_edit_dialog_model.dart';
export 'content_edit_dialog_model.dart';

class ContentEditDialogWidget extends StatefulWidget {
  const ContentEditDialogWidget({
    super.key,
    this.deleteCallback,
    required this.saveCallback,
    required this.contentDoc,
    required this.groupDoc,
    required this.courseRef,
    int? tabBarIndex,
    required this.collectionDoc,
  }) : this.tabBarIndex = tabBarIndex ?? 0;

  final Future Function()? deleteCallback;
  final Future Function()? saveCallback;
  final TribeContentRecord? contentDoc;
  final TribeGroupsRecord? groupDoc;
  final DocumentReference? courseRef;
  final int tabBarIndex;
  final TribeCollectionRecord? collectionDoc;

  @override
  State<ContentEditDialogWidget> createState() =>
      _ContentEditDialogWidgetState();
}

class _ContentEditDialogWidgetState extends State<ContentEditDialogWidget>
    with TickerProviderStateMixin {
  late ContentEditDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContentEditDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CONTENT_EDIT_DIALOG_contentEditDialog_ON');
      logFirebaseEvent('contentEditDialog_reset_form_fields');
      safeSetState(() {
        _model.contentNameTextFieldTextController?.clear();
        _model.ctaTextTextController?.clear();
        _model.ctaLinkTextController?.clear();
        _model.linkTypeTextFieldTextController?.clear();
        _model.searchieTextFieldTextController?.clear();
        _model.videoEmbedTypeTextFieldTextController?.clear();
      });
      logFirebaseEvent('contentEditDialog_update_component_state');
      _model.selectedMediaType = widget!.contentDoc!.contentType;
      _model.contentID = widget!.contentDoc?.tribeContentID;
      _model.richTextEditorOutput = widget!.contentDoc?.description;
      _model.fileUploadUrl = '';
      safeSetState(() {});
      logFirebaseEvent('contentEditDialog_tab_bar');
      safeSetState(() {
        _model.tabBarController!.animateTo(
          widget!.tabBarIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });

      // Set title
      logFirebaseEvent('contentEditDialog_Settitle');
      safeSetState(() {
        _model.contentNameTextFieldTextController?.text =
            widget!.contentDoc!.title;
        _model.contentNameTextFieldTextController?.selection =
            TextSelection.collapsed(
                offset: _model.contentNameTextFieldTextController!.text.length);
      });
      logFirebaseEvent('contentEditDialog_clear_uploaded_data');
      safeSetState(() {
        _model.isDataUploading = false;
        _model.uploadedLocalFile =
            FFUploadedFile(bytes: Uint8List.fromList([]));
        _model.uploadedFileUrl = '';
      });

      if (widget!.contentDoc?.contentType == 'video embed') {
        // Set embed link
        logFirebaseEvent('contentEditDialog_Setembedlink');
        safeSetState(() {
          _model.videoEmbedTypeTextFieldTextController?.text =
              (widget!.contentDoc?.contentType == 'video embed'
                  ? widget!.contentDoc!.featuredVideo
                  : null!);
          _model.videoEmbedTypeTextFieldTextController?.selection =
              TextSelection.collapsed(
                  offset: _model
                      .videoEmbedTypeTextFieldTextController!.text.length);
        });
        return;
      } else if (widget!.contentDoc?.contentType == 'download') {
        // Set CTA Text
        logFirebaseEvent('contentEditDialog_SetCTAText');
        safeSetState(() {
          _model.ctaTextTextController?.text =
              (widget!.contentDoc?.contentType == 'download'
                  ? widget!.contentDoc!.ctaBtnText
                  : null!);
          _model.ctaTextTextController?.selection = TextSelection.collapsed(
              offset: _model.ctaTextTextController!.text.length);
        });
        // Set CTA Link
        logFirebaseEvent('contentEditDialog_SetCTALink');
        safeSetState(() {
          _model.ctaLinkTextController?.text =
              (widget!.contentDoc?.contentType == 'download'
                  ? widget!.contentDoc!.ctaLink
                  : null!);
          _model.ctaLinkTextController?.selection = TextSelection.collapsed(
              offset: _model.ctaLinkTextController!.text.length);
        });
        return;
      } else if (widget!.contentDoc?.contentType == 'link') {
        // Set Link URL
        logFirebaseEvent('contentEditDialog_SetLinkURL');
        safeSetState(() {
          _model.linkTypeTextFieldTextController?.text =
              (widget!.contentDoc?.contentType == 'link'
                  ? widget!.contentDoc!.ctaLink
                  : null!);
          _model.linkTypeTextFieldTextController?.selection =
              TextSelection.collapsed(
                  offset: _model.linkTypeTextFieldTextController!.text.length);
        });
        return;
      } else if ((widget!.contentDoc?.contentType == 'video') ||
          (widget!.contentDoc?.contentType == 'Video')) {
        logFirebaseEvent('contentEditDialog_update_component_state');
        _model.fileUploadUrl = (widget!.contentDoc?.contentType == 'video') ||
                (widget!.contentDoc?.contentType == 'Video')
            ? widget!.contentDoc?.featuredVideo
            : null;
        safeSetState(() {});
        return;
      } else {
        return;
      }
    });

    _model.contentNameTextFieldTextController ??= TextEditingController();
    _model.contentNameTextFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.videoEmbedTypeTextFieldTextController ??= TextEditingController();
    _model.videoEmbedTypeTextFieldFocusNode ??= FocusNode();

    _model.ctaTextTextController ??= TextEditingController();
    _model.ctaTextFocusNode ??= FocusNode();

    _model.ctaLinkTextController ??= TextEditingController();
    _model.ctaLinkFocusNode ??= FocusNode();

    _model.linkTypeTextFieldTextController ??= TextEditingController();
    _model.linkTypeTextFieldFocusNode ??= FocusNode();

    _model.searchieTextFieldTextController ??= TextEditingController();
    _model.searchieTextFieldFocusNode ??= FocusNode();

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
      width: 800.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30.0, 24.0, 30.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: Text(
                  valueOrDefault<String>(
                    'Edit ${valueOrDefault<String>(
                      widget!.contentDoc?.title,
                      'content',
                    )}',
                    'Edit Lesson Content',
                  ),
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleLargeFamily,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleLargeFamily),
                      ),
                ),
              ),
              Text(
                'Lesson Name',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleLargeFamily),
                    ),
              ),
              Form(
                key: _model.formKey1,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                  child: TextFormField(
                    controller: _model.contentNameTextFieldTextController,
                    focusNode: _model.contentNameTextFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.contentNameTextFieldTextController',
                      Duration(milliseconds: 300),
                      () async {
                        logFirebaseEvent(
                            'CONTENT_EDIT_DIALOG_contentNameTextField');
                        if (widget!.contentDoc!.hasTribeContentID() &&
                            (widget!.contentDoc!.tribeContentID > 0)) {
                          return;
                        }

                        logFirebaseEvent('contentNameTextField_backend_call');

                        await widget!.contentDoc!.reference
                            .update(createTribeContentRecordData(
                          title: _model.contentNameTextFieldTextController.text,
                        ));
                        return;
                      },
                    ),
                    autofocus: false,
                    textCapitalization: TextCapitalization.words,
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
                      suffixIcon: _model.contentNameTextFieldTextController!
                              .text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.contentNameTextFieldTextController
                                    ?.clear();
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_contentNameTextField');
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent(
                                    'contentNameTextField_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  title: _model
                                      .contentNameTextFieldTextController.text,
                                ));
                                return;
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 18.0,
                              ),
                            )
                          : null,
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
                    keyboardType: TextInputType.multiline,
                    validator: _model
                        .contentNameTextFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
              Text(
                'Lesson Description',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleLargeFamily),
                    ),
              ),
              Container(
                width: double.infinity,
                height: 350.0,
                child: custom_widgets.RichTextEditor(
                  width: double.infinity,
                  height: 350.0,
                  initialText: widget!.contentDoc?.descriptionHtml,
                  onChangeText: (text) async {
                    logFirebaseEvent(
                        'CONTENT_EDIT_DIALOG_Container_4se5zdo3_C');
                    logFirebaseEvent('RichTextEditor_update_component_state');
                    _model.richTextEditorOutput = text;
                    safeSetState(() {});
                    if (widget!.contentDoc!.hasTribeContentID() &&
                        (widget!.contentDoc!.tribeContentID > 0)) {
                      return;
                    }

                    logFirebaseEvent('RichTextEditor_backend_call');

                    await widget!.contentDoc!.reference
                        .update(createTribeContentRecordData(
                      description: _model.richTextEditorOutput,
                      descriptionHtml: _model.richTextEditorOutput,
                    ));
                    return;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 8.0),
                child: Text(
                  'Add Lesson Content',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleLargeFamily,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleLargeFamily),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 550.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: FlutterFlowButtonTabBar(
                          useToggleButtonStyle: false,
                          labelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                          unselectedLabelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          backgroundColor: FlutterFlowTheme.of(context).accent1,
                          borderWidth: 0.0,
                          borderRadius: 10.0,
                          elevation: 0.0,
                          padding: EdgeInsets.all(4.0),
                          tabs: [
                            Tab(
                              text: 'File Upload',
                            ),
                            Tab(
                              text: 'Embed',
                            ),
                            Tab(
                              text: 'Download',
                            ),
                            Tab(
                              text: 'URL',
                            ),
                            Tab(
                              text: 'Searchie',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [
                              () async {
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_Tab_wgs1z5j9_ON_TAP');
                                logFirebaseEvent('Tab_update_component_state');
                                _model.selectedMediaType = 'video';
                                safeSetState(() {});
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent('Tab_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  contentType: _model.selectedMediaType,
                                ));
                                return;
                              },
                              () async {
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_Tab_yd6elhd5_ON_TAP');
                                logFirebaseEvent('Tab_update_component_state');
                                _model.selectedMediaType = 'video embed';
                                safeSetState(() {});
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent('Tab_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  contentType: _model.selectedMediaType,
                                ));
                                return;
                              },
                              () async {
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_Tab_7tpyahcm_ON_TAP');
                                logFirebaseEvent('Tab_update_component_state');
                                _model.selectedMediaType = 'download';
                                safeSetState(() {});
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent('Tab_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  contentType: _model.selectedMediaType,
                                ));
                                return;
                              },
                              () async {
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_Tab_kkdxnocc_ON_TAP');
                                logFirebaseEvent('Tab_update_component_state');
                                _model.selectedMediaType = 'link';
                                safeSetState(() {});
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent('Tab_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  contentType: _model.selectedMediaType,
                                ));
                                return;
                              },
                              () async {
                                logFirebaseEvent(
                                    'CONTENT_EDIT_DIALOG_COMP_Searchie_ON_TAP');
                                logFirebaseEvent(
                                    'Searchie_update_component_state');
                                _model.selectedMediaType = 'searchie';
                                safeSetState(() {});
                                if (widget!.contentDoc!.hasTribeContentID() &&
                                    (widget!.contentDoc!.tribeContentID > 0)) {
                                  return;
                                }

                                logFirebaseEvent('Searchie_backend_call');

                                await widget!.contentDoc!.reference
                                    .update(createTribeContentRecordData(
                                  contentType: _model.selectedMediaType,
                                ));
                                return;
                              }
                            ][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 24.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'CONTENT_EDIT_DIALOG_Text_q8033r5j_ON_TAP');
                                          logFirebaseEvent(
                                              'Text_update_component_state');

                                          safeSetState(() {});
                                        },
                                        child: Text(
                                          'Upload your video here (up to 5GB)',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLargeFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 100.0,
                                        child: custom_widgets.Uploader(
                                          width: double.infinity,
                                          height: 100.0,
                                          title: 'title',
                                          description: 'title',
                                          videoAlreadyUploaded:
                                              _model.fileUploadUrl != null &&
                                                  _model.fileUploadUrl != '',
                                          onSuccessfulUpload: (link) async {
                                            logFirebaseEvent(
                                                'CONTENT_EDIT_DIALOG_Container_yrk777sa_C');
                                            logFirebaseEvent(
                                                'Uploader_update_component_state');
                                            _model.fileUploadUrl = link;
                                            _model.selectedMediaType = 'video';
                                            safeSetState(() {});
                                            if (widget!.contentDoc!
                                                    .hasTribeContentID() &&
                                                (widget!.contentDoc!
                                                        .tribeContentID >
                                                    0)) {
                                              return;
                                            }

                                            logFirebaseEvent(
                                                'Uploader_backend_call');

                                            await widget!.contentDoc!.reference
                                                .update(
                                                    createTribeContentRecordData(
                                              featuredVideo: link,
                                            ));
                                            return;
                                          },
                                          onDelete: () async {
                                            logFirebaseEvent(
                                                'CONTENT_EDIT_DIALOG_Container_yrk777sa_C');
                                            logFirebaseEvent(
                                                'Uploader_alert_dialog');
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return WebViewAware(
                                                          child: AlertDialog(
                                                            title: Text(
                                                                'Remove video'),
                                                            content: Text(
                                                                'Sre you sure you want to remove this video from the lesson?'),
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
                                                                    'Delete'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              logFirebaseEvent(
                                                  'Uploader_update_component_state');
                                              _model.fileUploadUrl = '';
                                              _model.selectedMediaType =
                                                  'video';
                                              safeSetState(() {});
                                              if (widget!.contentDoc!
                                                      .hasTribeContentID() &&
                                                  (widget!.contentDoc!
                                                          .tribeContentID >
                                                      0)) {
                                                return;
                                              }

                                              logFirebaseEvent(
                                                  'Uploader_backend_call');

                                              await widget!
                                                  .contentDoc!.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'FeaturedVideo':
                                                        FieldValue.delete(),
                                                  },
                                                ),
                                              });
                                              return;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          if (valueOrDefault<bool>(
                                            _model.fileUploadUrl != null &&
                                                _model.fileUploadUrl != '',
                                            false,
                                          ))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: FlutterFlowVideoPlayer(
                                                path: functions
                                                    .convertToVideoPath(
                                                        _model.fileUploadUrl!),
                                                videoType: VideoType.network,
                                                width: double.infinity,
                                                height: double.infinity,
                                                autoPlay: false,
                                                looping: true,
                                                showControls: true,
                                                allowFullScreen: true,
                                                allowPlaybackSpeedMenu: false,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Video URL',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLargeFamily),
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 5.0, 0.0, 0.0),
                                            child: Text(
                                              '(YouTube Only)',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily),
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Form(
                                      key: _model.formKey2,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: TextFormField(
                                          controller: _model
                                              .videoEmbedTypeTextFieldTextController,
                                          focusNode: _model
                                              .videoEmbedTypeTextFieldFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.videoEmbedTypeTextFieldTextController',
                                            Duration(milliseconds: 300),
                                            () async {
                                              logFirebaseEvent(
                                                  'CONTENT_EDIT_DIALOG_videoEmbedTypeTextFi');
                                              logFirebaseEvent(
                                                  'videoEmbedTypeTextField_custom_action');
                                              await actions.printToConsole(
                                                functions
                                                    .detectVideoType(_model
                                                        .videoEmbedTypeTextFieldTextController
                                                        .text)
                                                    .url,
                                              );
                                              logFirebaseEvent(
                                                  'videoEmbedTypeTextField_custom_action');
                                              await actions.printToConsole(
                                                functions
                                                    .detectVideoType(_model
                                                        .videoEmbedTypeTextFieldTextController
                                                        .text)
                                                    .type,
                                              );
                                              if (widget!.contentDoc!
                                                      .hasTribeContentID() &&
                                                  (widget!.contentDoc!
                                                          .tribeContentID >
                                                      0)) {
                                                return;
                                              }

                                              logFirebaseEvent(
                                                  'videoEmbedTypeTextField_backend_call');

                                              await widget!
                                                  .contentDoc!.reference
                                                  .update(
                                                      createTribeContentRecordData(
                                                featuredVideo: functions
                                                    .getYoutubeEmbedURL(_model
                                                        .videoEmbedTypeTextFieldTextController
                                                        .text),
                                              ));
                                              return;
                                            },
                                          ),
                                          autofocus: false,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            suffixIcon: _model
                                                    .videoEmbedTypeTextFieldTextController!
                                                    .text
                                                    .isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model
                                                          .videoEmbedTypeTextFieldTextController
                                                          ?.clear();
                                                      logFirebaseEvent(
                                                          'CONTENT_EDIT_DIALOG_videoEmbedTypeTextFi');
                                                      logFirebaseEvent(
                                                          'videoEmbedTypeTextField_custom_action');
                                                      await actions
                                                          .printToConsole(
                                                        functions
                                                            .detectVideoType(_model
                                                                .videoEmbedTypeTextFieldTextController
                                                                .text)
                                                            .url,
                                                      );
                                                      logFirebaseEvent(
                                                          'videoEmbedTypeTextField_custom_action');
                                                      await actions
                                                          .printToConsole(
                                                        functions
                                                            .detectVideoType(_model
                                                                .videoEmbedTypeTextFieldTextController
                                                                .text)
                                                            .type,
                                                      );
                                                      if (widget!.contentDoc!
                                                              .hasTribeContentID() &&
                                                          (widget!.contentDoc!
                                                                  .tribeContentID >
                                                              0)) {
                                                        return;
                                                      }

                                                      logFirebaseEvent(
                                                          'videoEmbedTypeTextField_backend_call');

                                                      await widget!
                                                          .contentDoc!.reference
                                                          .update(
                                                              createTribeContentRecordData(
                                                        featuredVideo: functions
                                                            .getYoutubeEmbedURL(
                                                                _model
                                                                    .videoEmbedTypeTextFieldTextController
                                                                    .text),
                                                      ));
                                                      return;
                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color: Color(0xFF757575),
                                                      size: 18.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Open Sans'),
                                                lineHeight: 1.1,
                                              ),
                                          maxLines: 4,
                                          minLines: 1,
                                          keyboardType: TextInputType.url,
                                          validator: _model
                                              .videoEmbedTypeTextFieldTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    if ((_model.videoEmbedTypeTextFieldTextController
                                                    .text !=
                                                null &&
                                            _model.videoEmbedTypeTextFieldTextController
                                                    .text !=
                                                '') &&
                                        kDebugMode &&
                                        false)
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Detected video type is ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text: functions
                                                        .detectVideoType(_model
                                                            .videoEmbedTypeTextFieldTextController
                                                            .text)
                                                        .type,
                                                    style: TextStyle(),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily),
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Converted video url is ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text: functions
                                                        .getYoutubeEmbedURL(_model
                                                            .videoEmbedTypeTextFieldTextController
                                                            .text),
                                                    style: TextStyle(),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily),
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (_model.videoEmbedTypeTextFieldTextController
                                                .text !=
                                            null &&
                                        _model.videoEmbedTypeTextFieldTextController
                                                .text !=
                                            '')
                                      Expanded(
                                        child: FlutterFlowWebView(
                                          content: _model.videoEmbedTypeTextFieldTextController
                                                          .text !=
                                                      null &&
                                                  _model.videoEmbedTypeTextFieldTextController
                                                          .text !=
                                                      ''
                                              ? functions.getYoutubeEmbedURL(_model
                                                  .videoEmbedTypeTextFieldTextController
                                                  .text)
                                              : widget!
                                                  .contentDoc!.featuredVideo,
                                          bypass: false,
                                          height: 325.0,
                                          verticalScroll: false,
                                          horizontalScroll: false,
                                        ),
                                      ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Form(
                                      key: _model.formKey3,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 2.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Button Text',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily),
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 5.0, 0.0),
                                                child: TextFormField(
                                                  controller: _model
                                                      .ctaTextTextController,
                                                  focusNode:
                                                      _model.ctaTextFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.ctaTextTextController',
                                                    Duration(milliseconds: 300),
                                                    () async {
                                                      logFirebaseEvent(
                                                          'CONTENT_EDIT_DIALOG_ctaText_ON_TEXTFIELD');
                                                      if (widget!.contentDoc!
                                                              .hasTribeContentID() &&
                                                          (widget!.contentDoc!
                                                                  .tribeContentID >
                                                              0)) {
                                                        return;
                                                      }

                                                      logFirebaseEvent(
                                                          'ctaText_backend_call');

                                                      await widget!
                                                          .contentDoc!.reference
                                                          .update(
                                                              createTribeContentRecordData(
                                                        ctaBtnText: _model
                                                            .ctaTextTextController
                                                            .text,
                                                      ));
                                                      return;
                                                    },
                                                  ),
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'CTA Button',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        width: 0.0,
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
                                                        width: 0.0,
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
                                                        width: 0.0,
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
                                                        width: 0.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    suffixIcon: _model
                                                            .ctaTextTextController!
                                                            .text
                                                            .isNotEmpty
                                                        ? InkWell(
                                                            onTap: () async {
                                                              _model
                                                                  .ctaTextTextController
                                                                  ?.clear();
                                                              logFirebaseEvent(
                                                                  'CONTENT_EDIT_DIALOG_ctaText_ON_TEXTFIELD');
                                                              if (widget!
                                                                      .contentDoc!
                                                                      .hasTribeContentID() &&
                                                                  (widget!.contentDoc!
                                                                          .tribeContentID >
                                                                      0)) {
                                                                return;
                                                              }

                                                              logFirebaseEvent(
                                                                  'ctaText_backend_call');

                                                              await widget!
                                                                  .contentDoc!
                                                                  .reference
                                                                  .update(
                                                                      createTribeContentRecordData(
                                                                ctaBtnText: _model
                                                                    .ctaTextTextController
                                                                    .text,
                                                              ));
                                                              return;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: Color(
                                                                  0xFF757575),
                                                              size: 18.0,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                        lineHeight: 1.1,
                                                      ),
                                                  maxLines: 4,
                                                  minLines: 1,
                                                  maxLength: 50,
                                                  maxLengthEnforcement:
                                                      MaxLengthEnforcement
                                                          .enforced,
                                                  validator: _model
                                                      .ctaTextTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 6.0, 0.0, 0.0),
                                              child: Text(
                                                'Button URL',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily),
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 5.0, 0.0),
                                                child: TextFormField(
                                                  controller: _model
                                                      .ctaLinkTextController,
                                                  focusNode:
                                                      _model.ctaLinkFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.ctaLinkTextController',
                                                    Duration(milliseconds: 300),
                                                    () async {
                                                      logFirebaseEvent(
                                                          'CONTENT_EDIT_DIALOG_ctaLink_ON_TEXTFIELD');
                                                      if (widget!.contentDoc!
                                                              .hasTribeContentID() &&
                                                          (widget!.contentDoc!
                                                                  .tribeContentID >
                                                              0)) {
                                                        return;
                                                      }

                                                      logFirebaseEvent(
                                                          'ctaLink_backend_call');

                                                      await widget!
                                                          .contentDoc!.reference
                                                          .update(
                                                              createTribeContentRecordData(
                                                        ctaLink: _model
                                                            .ctaLinkTextController
                                                            .text,
                                                      ));
                                                      return;
                                                    },
                                                  ),
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'URL',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        width: 0.0,
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
                                                        width: 0.0,
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
                                                        width: 0.0,
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
                                                        width: 0.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    suffixIcon: _model
                                                            .ctaLinkTextController!
                                                            .text
                                                            .isNotEmpty
                                                        ? InkWell(
                                                            onTap: () async {
                                                              _model
                                                                  .ctaLinkTextController
                                                                  ?.clear();
                                                              logFirebaseEvent(
                                                                  'CONTENT_EDIT_DIALOG_ctaLink_ON_TEXTFIELD');
                                                              if (widget!
                                                                      .contentDoc!
                                                                      .hasTribeContentID() &&
                                                                  (widget!.contentDoc!
                                                                          .tribeContentID >
                                                                      0)) {
                                                                return;
                                                              }

                                                              logFirebaseEvent(
                                                                  'ctaLink_backend_call');

                                                              await widget!
                                                                  .contentDoc!
                                                                  .reference
                                                                  .update(
                                                                      createTribeContentRecordData(
                                                                ctaLink: _model
                                                                    .ctaLinkTextController
                                                                    .text,
                                                              ));
                                                              return;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: Color(
                                                                  0xFF757575),
                                                              size: 18.0,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                        lineHeight: 1.1,
                                                      ),
                                                  maxLines: 4,
                                                  minLines: 1,
                                                  keyboardType:
                                                      TextInputType.url,
                                                  validator: _model
                                                      .ctaLinkTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'External URL',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily),
                                            ),
                                      ),
                                    ),
                                    Form(
                                      key: _model.formKey4,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: TextFormField(
                                          controller: _model
                                              .linkTypeTextFieldTextController,
                                          focusNode:
                                              _model.linkTypeTextFieldFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.linkTypeTextFieldTextController',
                                            Duration(milliseconds: 300),
                                            () async {
                                              logFirebaseEvent(
                                                  'CONTENT_EDIT_DIALOG_linkTypeTextField_ON');
                                              if (widget!.contentDoc!
                                                      .hasTribeContentID() &&
                                                  (widget!.contentDoc!
                                                          .tribeContentID >
                                                      0)) {
                                                return;
                                              }

                                              logFirebaseEvent(
                                                  'linkTypeTextField_backend_call');

                                              await widget!
                                                  .contentDoc!.reference
                                                  .update(
                                                      createTribeContentRecordData(
                                                ctaLink: _model
                                                    .linkTypeTextFieldTextController
                                                    .text,
                                              ));
                                              return;
                                            },
                                          ),
                                          autofocus: false,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Open Sans'),
                                                lineHeight: 1.1,
                                              ),
                                          maxLines: 4,
                                          minLines: 1,
                                          keyboardType: TextInputType.url,
                                          validator: _model
                                              .linkTypeTextFieldTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Searchie ID Number',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily),
                                            ),
                                      ),
                                    ),
                                    Form(
                                      key: _model.formKey5,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: TextFormField(
                                          controller: _model
                                              .searchieTextFieldTextController,
                                          focusNode:
                                              _model.searchieTextFieldFocusNode,
                                          autofocus: false,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Open Sans'),
                                                lineHeight: 1.1,
                                              ),
                                          maxLines: 4,
                                          minLines: 1,
                                          keyboardType: TextInputType.multiline,
                                          validator: _model
                                              .searchieTextFieldTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lesson Image',
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if ((_model.uploadedFileUrl != null &&
                                    _model.uploadedFileUrl != '') ||
                                (widget!.contentDoc?.featuredImage != null &&
                                    widget!.contentDoc?.featuredImage != ''))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 12.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    _model.uploadedFileUrl != null &&
                                            _model.uploadedFileUrl != ''
                                        ? _model.uploadedFileUrl
                                        : widget!.contentDoc!.featuredImage,
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((_model.uploadedFileUrl == null ||
                                        _model.uploadedFileUrl == '') &&
                                    (widget!.contentDoc?.featuredImage ==
                                            null ||
                                        widget!.contentDoc?.featuredImage ==
                                            ''))
                                  Text(
                                    'No lesson image added',
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
                                Text(
                                  'Images with 16:9 aspect ratio works best\n(1920x1080p or 1280x720p)',
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
                          ],
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CONTENT_EDIT_DIALOG_uploadImageButton_ON');
                      logFirebaseEvent(
                          'uploadImageButton_upload_media_to_fireba');
                      final selectedMedia = await selectMedia(
                        maxWidth: 1080.00,
                        maxHeight: 720.00,
                        imageQuality: 100,
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
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                          showUploadMessage(context, 'Failed to upload data');
                          return;
                        }
                      }

                      logFirebaseEvent(
                          'uploadImageButton_update_component_state');
                      _model.isImageUploaded = true;
                      safeSetState(() {});
                      if (widget!.contentDoc!.hasTribeContentID() &&
                          (widget!.contentDoc!.tribeContentID > 0)) {
                        return;
                      }

                      logFirebaseEvent('uploadImageButton_backend_call');

                      await widget!.contentDoc!.reference
                          .update(createTribeContentRecordData(
                        featuredImage: _model.uploadedFileUrl,
                      ));
                      return;
                    },
                    text: 'Upload image',
                    icon: Icon(
                      Icons.file_upload_outlined,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      height: 34.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).tertiary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).appBG,
                          ),
                        ),
                      ),
                    );
                  }
                  List<AttachmentsRecord> queryContainerAttachmentsRecordList =
                      snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Attachments',
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                    ),
                                    if (!(queryContainerAttachmentsRecordList
                                        .isNotEmpty))
                                      Text(
                                        'No attachments',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CONTENT_EDIT_DIALOG_uploadAttachmentButt');
                                    logFirebaseEvent(
                                        'uploadAttachmentButton_alert_dialog');
                                    await showDialog(
                                      barrierColor: Color(0x32000000),
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
                                            child:
                                                AddEditAttachmentDialogWidget(
                                              contentRef:
                                                  widget!.contentDoc!.reference,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  text: 'Upload Attachment',
                                  icon: Icon(
                                    Icons.file_upload_outlined,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 34.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
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
                            ].divide(SizedBox(width: 14.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Builder(
                            builder: (context) {
                              final queryContainerVar =
                                  queryContainerAttachmentsRecordList.toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: queryContainerVar.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.0),
                                itemBuilder: (context, queryContainerVarIndex) {
                                  final queryContainerVarItem =
                                      queryContainerVar[queryContainerVarIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'CONTENT_EDIT_DIALOG_attachmentContainer_');
                                      logFirebaseEvent(
                                          'attachmentContainer_launch_u_r_l');
                                      await launchURL(
                                          queryContainerVarItem.url);
                                    },
                                    child: Container(
                                      height: 48.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            14.0, 0.0, 14.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if (functions.returnFileType(
                                                        queryContainerVarItem
                                                            .url) ==
                                                    DocumentType.link) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 0.0,
                                                                0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.link,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 18.0,
                                                    ),
                                                  );
                                                } else if (functions
                                                        .returnFileType(
                                                            queryContainerVarItem
                                                                .url) ==
                                                    DocumentType.media) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 0.0,
                                                                0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.image,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 18.0,
                                                    ),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 0.0,
                                                                0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.file,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 18.0,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                queryContainerVarItem.name,
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily),
                                                          lineHeight: 1.0,
                                                        ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 0.0,
                                                borderWidth: 1.0,
                                                buttonSize: 48.0,
                                                icon: FaIcon(
                                                  FontAwesomeIcons.pen,
                                                  color: Color(0xFF757B83),
                                                  size: 18.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'CONTENT_EDIT_DIALOG_editAttachment_ON_TA');
                                                  logFirebaseEvent(
                                                      'editAttachment_alert_dialog');
                                                  await showDialog(
                                                    barrierColor:
                                                        Color(0x32000000),
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: WebViewAware(
                                                          child:
                                                              AddEditAttachmentDialogWidget(
                                                            contentRef: widget!
                                                                .contentDoc!
                                                                .reference,
                                                            attachmentDoc:
                                                                queryContainerVarItem,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 0.0,
                                                borderWidth: 1.0,
                                                buttonSize: 48.0,
                                                icon: FaIcon(
                                                  FontAwesomeIcons.trashAlt,
                                                  color: Color(0xFF757B83),
                                                  size: 18.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'CONTENT_EDIT_DIALOG_deleteAttachment_ON_');
                                                  var _shouldSetState = false;
                                                  logFirebaseEvent(
                                                      'deleteAttachment_alert_dialog');
                                                  await showAlignedDialog(
                                                    context: context,
                                                    isGlobal: false,
                                                    avoidOverflow: false,
                                                    targetAnchor:
                                                        AlignmentDirectional(
                                                                0.0, -1.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    followerAnchor:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    builder: (dialogContext) {
                                                      return Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: WebViewAware(
                                                          child:
                                                              AlertDialogWidget(
                                                            title: 'Warning!',
                                                            description:
                                                                'You are about to delete this attachment. Confirm to continue',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() => _model
                                                              .deleteDialogResponse =
                                                          value));

                                                  _shouldSetState = true;
                                                  if (_model
                                                      .deleteDialogResponse!) {
                                                    logFirebaseEvent(
                                                        'deleteAttachment_backend_call');
                                                    await queryContainerVarItem
                                                        .reference
                                                        .delete();
                                                    logFirebaseEvent(
                                                        'deleteAttachment_action_block');
                                                    await action_blocks
                                                        .displaySnackbar(
                                                      context,
                                                      message:
                                                          'Attachment deleted.',
                                                    );
                                                    safeSetState(() {});
                                                  } else {
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                    return;
                                                  }

                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CONTENT_EDIT_DIALOG_deleteButton_ON_TAP');
                            var _shouldSetState = false;
                            final firestoreBatch =
                                FirebaseFirestore.instance.batch();
                            try {
                              logFirebaseEvent('deleteButton_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: WebViewAware(
                                      child: AlertDialogWidget(
                                        title: 'Are you sure?',
                                        description:
                                            'You are about to delete entire lesson. This action is permament. Do You want to continue?',
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() =>
                                  _model.deleteContentDialogResponse = value));

                              _shouldSetState = true;
                              if (_model.deleteContentDialogResponse!) {
                                logFirebaseEvent('deleteButton_backend_call');
                                firestoreBatch
                                    .delete(widget!.contentDoc!.reference);
                                // Remove content to Course
                                logFirebaseEvent(
                                    'deleteButton_RemovecontenttoCourse');

                                firestoreBatch.update(widget!.courseRef!, {
                                  ...mapToFirestore(
                                    {
                                      'contentIDs': FieldValue.arrayRemove(
                                          [widget!.contentDoc?.tribeContentID]),
                                    },
                                  ),
                                });
                                logFirebaseEvent(
                                    'deleteButton_execute_callback');
                                await widget.deleteCallback?.call();
                              } else {
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }
                            } finally {
                              await firestoreBatch.commit();
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: 'Delete',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).accent1,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).tertiary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'CONTENT_EDIT_DIALOG_saveButton_ON_TAP');
                          logFirebaseEvent('saveButton_validate_form');
                          if (_model.formKey1.currentState == null ||
                              !_model.formKey1.currentState!.validate()) {
                            return;
                          }
                          logFirebaseEvent('saveButton_action_block');
                          await action_blocks.displaySnackbar(
                            context,
                            message: 'Lesson is being updated...',
                          );
                          // False branch is for creating new content only
                          if (widget!.contentDoc!.hasTribeContentID()) {
                            logFirebaseEvent('saveButton_backend_call');
                            _model.updateContentAPI =
                                await UpsertContentKarolCall.call(
                              postID: widget!.contentDoc?.tribeContentID,
                              token: valueOrDefault(
                                  currentUserDocument?.tribeToken, ''),
                              title: _model
                                  .contentNameTextFieldTextController.text,
                              description: _model.richTextEditorOutput,
                              groupID: widget!.groupDoc?.tribeGroupID,
                              userID: valueOrDefault(
                                  currentUserDocument?.tribeUserId, 0),
                              platformID: getRemoteConfigInt('AppPlatformId'),
                              baseURL: getRemoteConfigString('AppBaseApiUrl'),
                              type: _model.selectedMediaType,
                              contentUrl: () {
                                if (_model.selectedMediaType == 'download') {
                                  return _model.ctaLinkTextController.text;
                                } else if (_model.selectedMediaType == 'link') {
                                  return _model
                                      .linkTypeTextFieldTextController.text;
                                } else {
                                  return null;
                                }
                              }(),
                              featuredImage: _model.isImageUploaded
                                  ? _model.uploadedFileUrl
                                  : widget!.contentDoc?.featuredImage,
                              featuredVideo: () {
                                if ((_model.selectedMediaType == 'video') ||
                                    (_model.selectedMediaType == 'Video')) {
                                  return _model.fileUploadUrl;
                                } else if (_model.selectedMediaType ==
                                    'video embed') {
                                  return functions.getYoutubeEmbedURL(_model
                                      .videoEmbedTypeTextFieldTextController
                                      .text);
                                } else if (_model.selectedMediaType ==
                                    'searchie') {
                                  return 'https://app.searchie.io/file/${_model.searchieTextFieldTextController.text}/embed';
                                } else {
                                  return null;
                                }
                              }(),
                              publishedDate:
                                  widget!.contentDoc?.publishDate?.toString(),
                            );

                            logFirebaseEvent('saveButton_custom_action');
                            await actions.printToConsole(
                              (_model.updateContentAPI?.jsonBody ?? '')
                                  .toString(),
                            );
                            logFirebaseEvent(
                                'saveButton_update_component_state');
                            _model.contentID =
                                widget!.contentDoc?.tribeContentID;
                            safeSetState(() {});
                          } else {
                            logFirebaseEvent('saveButton_backend_call');
                            _model.createContentAPI =
                                await UpsertContentKarolCall.call(
                              token: valueOrDefault(
                                  currentUserDocument?.tribeToken, ''),
                              title: _model
                                  .contentNameTextFieldTextController.text,
                              description: _model.richTextEditorOutput,
                              groupID: widget!.groupDoc?.tribeGroupID,
                              userID: valueOrDefault(
                                  currentUserDocument?.tribeUserId, 0),
                              platformID: getRemoteConfigInt('AppPlatformId'),
                              baseURL: getRemoteConfigString('AppBaseApiUrl'),
                              type: _model.selectedMediaType,
                              chatEnabled: true,
                              publishedDate: getCurrentTimestamp.toString(),
                              featuredImage: _model.uploadedFileUrl,
                              featuredVideo: () {
                                if ((_model.selectedMediaType == 'video') ||
                                    (_model.selectedMediaType == 'Video')) {
                                  return _model.fileUploadUrl;
                                } else if (_model.selectedMediaType ==
                                    'video embed') {
                                  return functions.getYoutubeEmbedURL(_model
                                      .videoEmbedTypeTextFieldTextController
                                      .text);
                                } else if (_model.selectedMediaType ==
                                    'searchie') {
                                  return 'https://app.searchie.io/file/${_model.searchieTextFieldTextController.text}/embed';
                                } else {
                                  return null;
                                }
                              }(),
                              contentUrl: () {
                                if (_model.selectedMediaType == 'video embed') {
                                  return _model
                                      .videoEmbedTypeTextFieldTextController
                                      .text;
                                } else if (_model.selectedMediaType ==
                                    'download') {
                                  return _model.ctaLinkTextController.text;
                                } else if (_model.selectedMediaType == 'link') {
                                  return _model
                                      .linkTypeTextFieldTextController.text;
                                } else {
                                  return null;
                                }
                              }(),
                            );

                            logFirebaseEvent('saveButton_custom_action');
                            await actions.printToConsole(
                              (_model.createContentAPI?.jsonBody ?? '')
                                  .toString(),
                            );
                            logFirebaseEvent(
                                'saveButton_update_component_state');
                            _model.contentID = UpsertContentKarolCall.id(
                              (_model.createContentAPI?.jsonBody ?? ''),
                            );
                            safeSetState(() {});
                            // Assign ID to Content
                            logFirebaseEvent('saveButton_AssignIDtoContent');

                            await widget!.contentDoc!.reference
                                .update(createTribeContentRecordData(
                              tribeContentID: UpsertContentKarolCall.id(
                                (_model.createContentAPI?.jsonBody ?? ''),
                              ),
                            ));
                            // Add content to Course
                            logFirebaseEvent('saveButton_AddcontenttoCourse');

                            await widget!.courseRef!.update({
                              ...mapToFirestore(
                                {
                                  'contentIDs': FieldValue.arrayUnion([
                                    UpsertContentKarolCall.id(
                                      (_model.createContentAPI?.jsonBody ?? ''),
                                    )
                                  ]),
                                },
                              ),
                            });
                          }

                          // Create collections doc
                          logFirebaseEvent('saveButton_Createcollectionsdoc');
                          _model.collectionsDoc =
                              await queryTribeCollectionsRecordOnce(
                            queryBuilder: (tribeCollectionsRecord) =>
                                tribeCollectionsRecord.where(
                              'tribeContentID',
                              isEqualTo: _model.contentID,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          if (_model.collectionsDoc?.reference != null) {
                            logFirebaseEvent('saveButton_backend_call');

                            await _model.collectionsDoc!.reference
                                .update(createTribeCollectionsRecordData(
                              title: _model
                                  .contentNameTextFieldTextController.text,
                              description: _model.richTextEditorOutput,
                              tribecollectionID:
                                  widget!.contentDoc?.tribeCollectionID,
                            ));
                          } else {
                            // Create collections doc
                            logFirebaseEvent('saveButton_Createcollectionsdoc');

                            var tribeCollectionsRecordReference =
                                TribeCollectionsRecord.collection.doc();
                            await tribeCollectionsRecordReference
                                .set(createTribeCollectionsRecordData(
                              title: _model
                                  .contentNameTextFieldTextController.text,
                              tribecollectionID:
                                  widget!.contentDoc?.tribeCollectionID,
                              description: _model.richTextEditorOutput,
                              publishDate: widget!.contentDoc?.publishDate,
                              visibility: 'group',
                              chatEnabled: true,
                              tribeContentID: _model.contentID,
                              authorRef: widget!.contentDoc?.authorRef,
                              commentCount: 0,
                            ));
                            _model.newCollectionsDoc =
                                TribeCollectionsRecord.getDocumentFromData(
                                    createTribeCollectionsRecordData(
                                      title: _model
                                          .contentNameTextFieldTextController
                                          .text,
                                      tribecollectionID:
                                          widget!.contentDoc?.tribeCollectionID,
                                      description: _model.richTextEditorOutput,
                                      publishDate:
                                          widget!.contentDoc?.publishDate,
                                      visibility: 'group',
                                      chatEnabled: true,
                                      tribeContentID: _model.contentID,
                                      authorRef: widget!.contentDoc?.authorRef,
                                      commentCount: 0,
                                    ),
                                    tribeCollectionsRecordReference);
                          }

                          // Update content doc
                          logFirebaseEvent('saveButton_Updatecontentdoc');

                          await widget!.contentDoc!.reference
                              .update(createTribeContentRecordData(
                            title:
                                _model.contentNameTextFieldTextController.text,
                            descriptionHtml: _model.richTextEditorOutput,
                            contentType: _model.selectedMediaType,
                            description: _model.richTextEditorOutput,
                            ctaLink: () {
                              if (_model.selectedMediaType == 'download') {
                                return _model.ctaLinkTextController.text;
                              } else if (_model.selectedMediaType == 'link') {
                                return _model
                                    .linkTypeTextFieldTextController.text;
                              } else {
                                return null;
                              }
                            }(),
                            ctaBtnText: _model.selectedMediaType == 'download'
                                ? _model.ctaTextTextController.text
                                : null,
                            featuredVideo: () {
                              if ((_model.selectedMediaType == 'video') ||
                                  (_model.selectedMediaType == 'Video')) {
                                return _model.fileUploadUrl;
                              } else if (_model.selectedMediaType ==
                                  'video embed') {
                                return functions.getYoutubeEmbedURL(_model
                                    .videoEmbedTypeTextFieldTextController
                                    .text);
                              } else if (_model.selectedMediaType ==
                                  'searchie') {
                                return 'https://app.searchie.io/file/${_model.searchieTextFieldTextController.text}/embed';
                              } else {
                                return null;
                              }
                            }(),
                            featuredImage: _model.isImageUploaded
                                ? _model.uploadedFileUrl
                                : widget!.collectionDoc?.featuredImage,
                          ));
                          logFirebaseEvent('saveButton_clear_uploaded_data');
                          safeSetState(() {
                            _model.isDataUploading = false;
                            _model.uploadedLocalFile =
                                FFUploadedFile(bytes: Uint8List.fromList([]));
                            _model.uploadedFileUrl = '';
                          });

                          logFirebaseEvent('saveButton_update_component_state');
                          _model.isImageUploaded = false;
                          _model.selectedMediaType = 'video';
                          _model.fileUploadUrl = '';
                          _model.richTextEditorOutput = '';
                          safeSetState(() {});
                          logFirebaseEvent('saveButton_execute_callback');
                          await widget.saveCallback?.call();

                          safeSetState(() {});
                        },
                        text: 'Save',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 12.0)),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
