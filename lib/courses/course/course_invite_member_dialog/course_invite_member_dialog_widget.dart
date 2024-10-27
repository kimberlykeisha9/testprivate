import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/alert_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'course_invite_member_dialog_model.dart';
export 'course_invite_member_dialog_model.dart';

class CourseInviteMemberDialogWidget extends StatefulWidget {
  const CourseInviteMemberDialogWidget({
    super.key,
    required this.courseDoc,
  });

  final TribeCourseRecord? courseDoc;

  @override
  State<CourseInviteMemberDialogWidget> createState() =>
      _CourseInviteMemberDialogWidgetState();
}

class _CourseInviteMemberDialogWidgetState
    extends State<CourseInviteMemberDialogWidget> {
  late CourseInviteMemberDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseInviteMemberDialogModel());

    _model.filterTextFieldTextController ??= TextEditingController();
    _model.filterTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TribeGroupsRecord>(
      future: TribeGroupsRecord.getDocumentOnce(widget!.courseDoc!.groupRef!),
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

        return SafeArea(
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Invite Members',
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displaySmallFamily,
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .displaySmallFamily),
                                      ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.close_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'COURSE_INVITE_MEMBER_DIALOG_close_sharp_');
                                    logFirebaseEvent(
                                        'IconButton_close_dialog_drawer_etc');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<List<UserRecord>>(
                            stream: queryUserRecord(
                              queryBuilder: (userRecord) => userRecord.where(
                                'TribeGroups',
                                arrayContains: getTribeGroupsFirestoreData(
                                  TribeGroupsStruct(
                                    tribeGroupID:
                                        containerTribeGroupsRecord.tribeGroupID,
                                    groupRef:
                                        containerTribeGroupsRecord.reference,
                                    role: 'member',
                                  ),
                                  true,
                                ),
                              ),
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
                              List<UserRecord> queryContainerUserRecordList =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          TextFormField(
                                            controller: _model
                                                .filterTextFieldTextController,
                                            focusNode:
                                                _model.filterTextFieldFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.filterTextFieldTextController',
                                              Duration(milliseconds: 1500),
                                              () async {
                                                logFirebaseEvent(
                                                    'COURSE_INVITE_MEMBER_DIALOG_filterTextFi');
                                                logFirebaseEvent(
                                                    'filterTextField_simple_search');
                                                safeSetState(() {
                                                  _model.simpleSearchResults =
                                                      TextSearch(
                                                    queryContainerUserRecordList
                                                        .map(
                                                          (record) =>
                                                              TextSearchItem
                                                                  .fromTerms(
                                                                      record, [
                                                            record.displayName!,
                                                            record.email!
                                                          ]),
                                                        )
                                                        .toList(),
                                                  )
                                                          .search(_model
                                                              .filterTextFieldTextController
                                                              .text)
                                                          .map((r) => r.object)
                                                          .take(50)
                                                          .toList();
                                                  ;
                                                });
                                                logFirebaseEvent(
                                                    'filterTextField_update_component_state');

                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              labelText: 'Search',
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          'Plus Jakarta Sans'),
                                                ),
                                            validator: _model
                                                .filterTextFieldTextControllerValidator
                                                .asValidator(context),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 5.0, 5.0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                borderWidth: 1.0,
                                                buttonSize: 35.0,
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757B83),
                                                  size: 18.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'COURSE_INVITE_MEMBER_DIALOG_clear_ICN_ON');
                                                  logFirebaseEvent(
                                                      'IconButton_clear_text_fields_pin_codes');
                                                  safeSetState(() {
                                                    _model
                                                        .filterTextFieldTextController
                                                        ?.clear();
                                                  });
                                                  logFirebaseEvent(
                                                      'IconButton_update_app_state');

                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: 500.0,
                                      ),
                                      decoration: BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final userListviewChildren =
                                              (_model.filterTextFieldTextController
                                                                  .text !=
                                                              null &&
                                                          _model.filterTextFieldTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .simpleSearchResults
                                                      : queryContainerUserRecordList)
                                                  .toList();

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                userListviewChildren.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 20.0),
                                            itemBuilder: (context,
                                                userListviewChildrenIndex) {
                                              final userListviewChildrenItem =
                                                  userListviewChildren[
                                                      userListviewChildrenIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 1.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  userListviewChildrenItem
                                                                      .photoUrl,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                                                ),
                                                                width: 40.0,
                                                                height: 40.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  userListviewChildrenItem
                                                                      .displayName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelLargeFamily,
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                      ),
                                                                ),
                                                                Opacity(
                                                                  opacity: 0.6,
                                                                  child: Text(
                                                                    userListviewChildrenItem
                                                                        .email,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelLargeFamily,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 16.0)),
                                                        ),
                                                      ),
                                                      Builder(
                                                        builder: (context) =>
                                                            FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'COURSE_INVITE_MEMBER_DIALOG_inviteUserBu');
                                                            var _shouldSetState =
                                                                false;
                                                            logFirebaseEvent(
                                                                'inviteUserButton_alert_dialog');
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  alignment: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  child:
                                                                      WebViewAware(
                                                                    child:
                                                                        AlertDialogWidget(
                                                                      title:
                                                                          'Invite this user to course?',
                                                                      description:
                                                                          'You are about to add this user to course. Confirm to continue',
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(() =>
                                                                    _model.addUserDialog =
                                                                        value));

                                                            _shouldSetState =
                                                                true;
                                                            if (!_model
                                                                .addUserDialog!) {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                            logFirebaseEvent(
                                                                'inviteUserButton_backend_call');

                                                            await MembersListRecord
                                                                    .createDoc(widget!
                                                                        .courseDoc!
                                                                        .reference)
                                                                .set(
                                                                    createMembersListRecordData(
                                                              userRef:
                                                                  userListviewChildrenItem
                                                                      .reference,
                                                              role: 'Member',
                                                            ));
                                                            logFirebaseEvent(
                                                                'inviteUserButton_backend_call');

                                                            await userListviewChildrenItem
                                                                .reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'privateCourses':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    widget!
                                                                        .courseDoc
                                                                        ?.reference
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                            logFirebaseEvent(
                                                                'inviteUserButton_close_dialog_drawer_etc');
                                                            Navigator.pop(
                                                                context);
                                                            logFirebaseEvent(
                                                                'inviteUserButton_action_block');
                                                            await action_blocks
                                                                .displaySnackbar(
                                                              context,
                                                              message:
                                                                  'User added to the course!',
                                                            );
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                          },
                                                          text: 'Invite user',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 44.0,
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
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
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 20.0)),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
