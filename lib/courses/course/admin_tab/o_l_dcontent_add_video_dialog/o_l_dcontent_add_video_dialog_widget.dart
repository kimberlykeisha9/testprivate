import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'o_l_dcontent_add_video_dialog_model.dart';
export 'o_l_dcontent_add_video_dialog_model.dart';

class OLDcontentAddVideoDialogWidget extends StatefulWidget {
  const OLDcontentAddVideoDialogWidget({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
    this.parameter4,
    this.parameter5,
  });

  final String? parameter1;
  final String? parameter2;
  final String? parameter3;
  final String? parameter4;
  final String? parameter5;

  @override
  State<OLDcontentAddVideoDialogWidget> createState() =>
      _OLDcontentAddVideoDialogWidgetState();
}

class _OLDcontentAddVideoDialogWidgetState
    extends State<OLDcontentAddVideoDialogWidget> {
  late OLDcontentAddVideoDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OLDcontentAddVideoDialogModel());

    _model.videoEmbedTypeTextFieldTextController ??= TextEditingController();
    _model.videoEmbedTypeTextFieldFocusNode ??= FocusNode();
    _model.videoEmbedTypeTextFieldFocusNode!
        .addListener(() => safeSetState(() {}));
    _model.ctaTextTextController ??=
        TextEditingController(text: widget!.parameter4);
    _model.ctaTextFocusNode ??= FocusNode();

    _model.ctaLinkTextController ??=
        TextEditingController(text: widget!.parameter5);
    _model.ctaLinkFocusNode ??= FocusNode();

    _model.searchieTextFieldTextController ??= TextEditingController();
    _model.searchieTextFieldFocusNode ??= FocusNode();
    _model.searchieTextFieldFocusNode!.addListener(() => safeSetState(() {}));
    _model.linkTypeTextFieldTextController ??= TextEditingController();
    _model.linkTypeTextFieldFocusNode ??= FocusNode();
    _model.linkTypeTextFieldFocusNode!.addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FlutterFlowChoiceChips(
              options: [
                ChipData('video', Icons.videocam_sharp),
                ChipData('video embed', Icons.video_label),
                ChipData('download', Icons.image),
                ChipData('link', Icons.link),
                ChipData('searchie', Icons.play_disabled)
              ],
              onChanged: (val) => safeSetState(
                  () => _model.typeChoiceChipsValue = val?.firstOrNull),
              selectedChipStyle: ChipStyle(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).white,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                iconColor: FlutterFlowTheme.of(context).white,
                iconSize: 18.0,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor: FlutterFlowTheme.of(context).tertiary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                iconColor: FlutterFlowTheme.of(context).secondaryText,
                iconSize: 18.0,
                elevation: 0.0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              chipSpacing: 12.0,
              rowSpacing: 12.0,
              multiselect: false,
              alignment: WrapAlignment.start,
              controller: _model.typeChoiceChipsValueController ??=
                  FormFieldController<List<String>>(
                [],
              ),
              wrapped: true,
            ),
            Builder(
              builder: (context) {
                if (widget!.parameter3 == 'video') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'O_L_DCONTENT_ADD_VIDEO_DIALOG_Text_atpzt');
                          logFirebaseEvent('Text_update_component_state');

                          safeSetState(() {});
                        },
                        child: Text(
                          'Upload your video here (up to 5GB)',
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelLargeFamily),
                              ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100.0,
                        child: custom_widgets.Uploader(
                          width: double.infinity,
                          height: 100.0,
                          title: 'title',
                          description: 'title',
                          videoAlreadyUploaded: _model.uploadFIleUrl != null &&
                              _model.uploadFIleUrl != '',
                          onSuccessfulUpload: (link) async {
                            logFirebaseEvent(
                                'O_L_DCONTENT_ADD_VIDEO_DIALOG_Container_');
                            logFirebaseEvent('Uploader_update_component_state');
                            _model.uploadFIleUrl = link;
                            safeSetState(() {});
                          },
                          onDelete: () async {},
                        ),
                      ),
                      if (valueOrDefault<bool>(
                        (_model.uploadFIleUrl != null &&
                                _model.uploadFIleUrl != '') ||
                            valueOrDefault<bool>(
                              widget!.parameter1 != null &&
                                  widget!.parameter1 != '',
                              true,
                            ),
                        true,
                      ))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 325.0,
                            child: custom_widgets.CustomVideoWebViewWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 325.0,
                              videoUrl: _model.uploadFIleUrl != null &&
                                      _model.uploadFIleUrl != ''
                                  ? _model.uploadFIleUrl!
                                  : widget!.parameter2!,
                            ),
                          ),
                        ),
                    ].divide(SizedBox(height: 12.0)),
                  );
                } else if (widget!.parameter3 == 'video embed') {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provide link to your media (Vimeo, external videos)',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelLargeFamily),
                            ),
                      ),
                      Form(
                        key: _model.formKey1,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: TextFormField(
                            controller:
                                _model.videoEmbedTypeTextFieldTextController,
                            focusNode: _model.videoEmbedTypeTextFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.videoEmbedTypeTextFieldTextController',
                              Duration(milliseconds: 500),
                              () async {
                                logFirebaseEvent(
                                    'O_L_DCONTENT_ADD_VIDEO_DIALOG_videoEmbed');
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
                              },
                            ),
                            autofocus: true,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Video URL',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Open Sans'),
                                    lineHeight: 1.1,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
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
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context).tertiary,
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
                            maxLines: 4,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            validator: _model
                                .videoEmbedTypeTextFieldTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      if ((_model.videoEmbedTypeTextFieldTextController.text !=
                                  null &&
                              _model.videoEmbedTypeTextFieldTextController
                                      .text !=
                                  '') &&
                          kDebugMode)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Detected video type is ',
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
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodySmallFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily),
                                    ),
                              ),
                            ),
                            RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Converted video url is ',
                                    style: TextStyle(),
                                  ),
                                  TextSpan(
                                    text: functions
                                        .detectVideoType(_model
                                            .videoEmbedTypeTextFieldTextController
                                            .text)
                                        .url,
                                    style: TextStyle(),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodySmallFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      if ((_model.videoEmbedTypeTextFieldTextController.text !=
                                  null &&
                              _model.videoEmbedTypeTextFieldTextController
                                      .text !=
                                  '') ||
                          (widget!.parameter1 != null &&
                              widget!.parameter1 != ''))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 325.0,
                            child: custom_widgets.CustomVideoWebViewWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 325.0,
                              videoUrl: /* NOT RECOMMENDED */ _model
                                          .videoEmbedTypeTextFieldTextController
                                          .text ==
                                      'true'
                                  ? _model.videoEmbedTypeTextFieldTextController
                                      .text
                                  : widget!.parameter2!,
                            ),
                          ),
                        ),
                    ].divide(SizedBox(height: 12.0)),
                  );
                } else if (widget!.parameter3 == 'download') {
                  return Form(
                    key: _model.formKey4,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _model.ctaTextTextController,
                                  focusNode: _model.ctaTextFocusNode,
                                  autofocus: true,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Add CTA Button Text here',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
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
                                  maxLines: 4,
                                  minLines: 1,
                                  keyboardType: TextInputType.multiline,
                                  validator: _model
                                      .ctaTextTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _model.ctaLinkTextController,
                                  focusNode: _model.ctaLinkFocusNode,
                                  autofocus: true,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Add link, which will be used in CTA Button',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
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
                                  maxLines: 4,
                                  minLines: 1,
                                  keyboardType: TextInputType.multiline,
                                  validator: _model
                                      .ctaLinkTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].divide(SizedBox(width: 24.0)),
                          ),
                        ),
                      ]
                          .divide(SizedBox(height: 8.0))
                          .around(SizedBox(height: 8.0)),
                    ),
                  );
                } else if (widget!.parameter3 == 'searchie') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provide your searchie ID',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelLargeFamily),
                            ),
                      ),
                      Form(
                        key: _model.formKey3,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: TextFormField(
                          controller: _model.searchieTextFieldTextController,
                          focusNode: _model.searchieTextFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.searchieTextFieldTextController',
                            Duration(milliseconds: 500),
                            () => safeSetState(() {}),
                          ),
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Provide searchie ID here',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Open Sans'),
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
                      if ((_model.searchieTextFieldTextController.text !=
                                  null &&
                              _model.searchieTextFieldTextController.text !=
                                  '') ||
                          (widget!.parameter1 != null &&
                              widget!.parameter1 != ''))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 325.0,
                            child: custom_widgets.CustomVideoWebViewWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 325.0,
                              videoUrl: /* NOT RECOMMENDED */ _model
                                          .searchieTextFieldTextController
                                          .text ==
                                      'true'
                                  ? 'https://app.searchie.io/file/${_model.searchieTextFieldTextController.text}/embed'
                                  : widget!.parameter2!,
                            ),
                          ),
                        ),
                    ].divide(SizedBox(height: 12.0)),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provide link to your media (External links or articles)',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelLargeFamily),
                            ),
                      ),
                      Form(
                        key: _model.formKey2,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: TextFormField(
                          controller: _model.linkTypeTextFieldTextController,
                          focusNode: _model.linkTypeTextFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.linkTypeTextFieldTextController',
                            Duration(milliseconds: 500),
                            () => safeSetState(() {}),
                          ),
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Provide link here',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Open Sans'),
                                    lineHeight: 1.1,
                                  ),
                          maxLines: 4,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          validator: _model
                              .linkTypeTextFieldTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ].divide(SizedBox(height: 12.0)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
