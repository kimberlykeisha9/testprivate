import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'broadcast_name_o_l_d_model.dart';
export 'broadcast_name_o_l_d_model.dart';

class BroadcastNameOLDWidget extends StatefulWidget {
  const BroadcastNameOLDWidget({
    super.key,
    this.groupSlug,
    this.postDescription,
    this.postTitle,
    this.fbEnabled,
    this.groupID,
    required this.groupDoc,
  });

  final String? groupSlug;
  final String? postDescription;
  final String? postTitle;
  final bool? fbEnabled;
  final int? groupID;
  final TribeGroupsRecord? groupDoc;

  @override
  State<BroadcastNameOLDWidget> createState() => _BroadcastNameOLDWidgetState();
}

class _BroadcastNameOLDWidgetState extends State<BroadcastNameOLDWidget> {
  late BroadcastNameOLDModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BroadcastNameOLDModel());

    _model.titleTextController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

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
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 370.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 0.0),
                child: Text(
                  'Start a Live Broadcast',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).headlineMediumFamily),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: TextFormField(
                    controller: _model.titleTextController,
                    focusNode: _model.titleFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.titleTextController',
                      Duration(milliseconds: 2000),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Broadcast Title (optional)',
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Open Sans',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Open Sans'),
                          ),
                      hintText: 'Enter a title',
                      hintStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Open Sans',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Open Sans'),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).accent2,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      suffixIcon: _model.titleTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.titleTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 22.0,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Open Sans'),
                        ),
                    validator: _model.titleTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(),
                  child: TextFormField(
                    controller: _model.descriptionTextController,
                    focusNode: _model.descriptionFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.descriptionTextController',
                      Duration(milliseconds: 2000),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Description (optional)',
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Open Sans',
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Open Sans'),
                          ),
                      hintText: 'Write a description',
                      hintStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Open Sans',
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Open Sans'),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).accent2,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      suffixIcon: _model
                              .descriptionTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.descriptionTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 22.0,
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
                        ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    validator: _model.descriptionTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 30.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'BROADCAST_NAME_O_L_D_START_LIVE_BROADCAS');
                        if (widget!.fbEnabled!) {
                          logFirebaseEvent('Button_update_app_state');
                          FFAppState().processing = false;
                          FFAppState().update(() {});
                        } else {
                          return;
                        }

                        logFirebaseEvent('Button_bottom_sheet');
                        Navigator.pop(context);
                      },
                      text: 'Start Live Broadcast!',
                      icon: Icon(
                        Icons.record_voice_over_sharp,
                        color: FlutterFlowTheme.of(context).accent1,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Open Sans'),
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
