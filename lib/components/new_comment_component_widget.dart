import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_comment_component_model.dart';
export 'new_comment_component_model.dart';

class NewCommentComponentWidget extends StatefulWidget {
  const NewCommentComponentWidget({
    super.key,
    required this.contentDoc,
    required this.collectionsRef,
  });

  final TribeContentRecord? contentDoc;
  final TribeCollectionsRecord? collectionsRef;

  @override
  State<NewCommentComponentWidget> createState() =>
      _NewCommentComponentWidgetState();
}

class _NewCommentComponentWidgetState extends State<NewCommentComponentWidget> {
  late NewCommentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewCommentComponentModel());

    _model.commentBoxTextController ??= TextEditingController();
    _model.commentBoxFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget!.contentDoc!.tribeContentID > 0,
      child: Container(
        width: 800.0,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x26000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 80.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.network(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
                                        width: 35.0,
                                        height: 35.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Image.network(
                                          currentUserPhoto,
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Form(
                                  key: _model.formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18.0, 0.0, 4.0, 0.0),
                                    child: TextFormField(
                                      controller:
                                          _model.commentBoxTextController,
                                      focusNode: _model.commentBoxFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Leave a Comment',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grayIcon,
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 16.0, 0.0, 0.0),
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
                                          .commentBoxTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 15.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'NEW_COMMENT_COMPONENT_COMP__BTN_ON_TAP');
                                    logFirebaseEvent('Button_validate_form');
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    logFirebaseEvent('Button_backend_call');

                                    await ChatMessagesRecord.collection
                                        .doc()
                                        .set(createChatMessagesRecordData(
                                          message: _model
                                              .commentBoxTextController.text,
                                          user: currentUserReference,
                                          date: getCurrentTimestamp,
                                          deleted: false,
                                          contentID: widget!
                                              .contentDoc?.tribeContentID,
                                          authorName: currentUserDisplayName,
                                          authorImg: currentUserPhoto,
                                          tribeCollectionRef:
                                              widget!.collectionsRef?.reference,
                                        ));
                                    logFirebaseEvent('Button_backend_call');

                                    await widget!.collectionsRef!.reference
                                        .update({
                                      ...mapToFirestore(
                                        {
                                          'commentCount':
                                              FieldValue.increment(1),
                                        },
                                      ),
                                    });
                                    // NewInboxNotification
                                    logFirebaseEvent(
                                        'Button_NewInboxNotification');

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        title:
                                            'New comment from ${currentUserDisplayName}',
                                        description: _model
                                            .commentBoxTextController.text,
                                        timeCreated: getCurrentTimestamp,
                                        tribeCollectionsRef:
                                            widget!.collectionsRef?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'UserRefList': [
                                            widget!.collectionsRef?.authorRef
                                          ],
                                        },
                                      ),
                                    });
                                    logFirebaseEvent(
                                        'Button_clear_text_fields_pin_codes');
                                    safeSetState(() {
                                      _model.commentBoxTextController?.clear();
                                    });
                                  },
                                  text: '',
                                  icon: Icon(
                                    Icons.send,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: 40.0,
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Outfit'),
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
