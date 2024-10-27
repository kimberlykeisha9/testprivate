import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/alert_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'module_edit_dialog_model.dart';
export 'module_edit_dialog_model.dart';

class ModuleEditDialogWidget extends StatefulWidget {
  const ModuleEditDialogWidget({
    super.key,
    required this.saveCallback,
    required this.deleteCallback,
    required this.groupDoc,
    required this.collectionDoc,
  });

  final Future Function()? saveCallback;
  final Future Function()? deleteCallback;
  final TribeGroupsRecord? groupDoc;
  final TribeCollectionRecord? collectionDoc;

  @override
  State<ModuleEditDialogWidget> createState() => _ModuleEditDialogWidgetState();
}

class _ModuleEditDialogWidgetState extends State<ModuleEditDialogWidget> {
  late ModuleEditDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModuleEditDialogModel());

    _model.collectionNameTextFieldTextController ??=
        TextEditingController(text: widget!.collectionDoc?.title);
    _model.collectionNameTextFieldFocusNode ??= FocusNode();

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      valueOrDefault<String>(
                        'Edit ${valueOrDefault<String>(
                          widget!.collectionDoc?.title,
                          'Module',
                        )}',
                        'Edit Module',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent(
                          'MODULE_EDIT_DIALOG_close_rounded_ICN_ON_');
                      logFirebaseEvent('IconButton_close_dialog_drawer_etc');
                      Navigator.pop(context);
                    },
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
            Text(
              'Module Name',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleLargeFamily),
                  ),
            ),
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: TextFormField(
                controller: _model.collectionNameTextFieldTextController,
                focusNode: _model.collectionNameTextFieldFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_model.collectionNameTextFieldTextController',
                  Duration(milliseconds: 2000),
                  () => safeSetState(() {}),
                ),
                autofocus: false,
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Open Sans'),
                        lineHeight: 1.1,
                      ),
                  alignLabelWithHint: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).secondaryText,
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
                  suffixIcon: _model.collectionNameTextFieldTextController!.text
                          .isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            _model.collectionNameTextFieldTextController
                                ?.clear();
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
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator: _model.collectionNameTextFieldTextControllerValidator
                    .asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'MODULE_EDIT_DIALOG_deleteButton_ON_TAP');
                          var _shouldSetState = false;
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
                                        'You are about to delete an entire module. This action is permament. Do you want to continue?',
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(
                              () => _model.alertDialogResponse = value));

                          _shouldSetState = true;
                          if (_model.alertDialogResponse!) {
                            logFirebaseEvent('deleteButton_backend_call');
                            await widget!.collectionDoc!.reference.delete();
                            logFirebaseEvent(
                                'deleteButton_close_dialog_drawer_etc');
                            Navigator.pop(context);
                            logFirebaseEvent('deleteButton_execute_callback');
                            await widget.deleteCallback?.call();
                          } else {
                            if (_shouldSetState) safeSetState(() {});
                            return;
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'MODULE_EDIT_DIALOG_saveButton_ON_TAP');
                        logFirebaseEvent('saveButton_validate_form');
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                        logFirebaseEvent('saveButton_backend_call');

                        await widget!.collectionDoc!.reference
                            .update(createTribeCollectionRecordData(
                          title:
                              _model.collectionNameTextFieldTextController.text,
                        ));
                        logFirebaseEvent('saveButton_execute_callback');
                        await widget.saveCallback?.call();
                        logFirebaseEvent('saveButton_close_dialog_drawer_etc');
                        Navigator.pop(context);
                      },
                      text: 'Save',
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
    );
  }
}
