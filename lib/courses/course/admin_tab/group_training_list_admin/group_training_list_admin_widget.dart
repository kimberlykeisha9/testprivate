import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_training_list_admin_model.dart';
export 'group_training_list_admin_model.dart';

class GroupTrainingListAdminWidget extends StatefulWidget {
  const GroupTrainingListAdminWidget({
    super.key,
    this.collectionDoc,
    required this.collectionCallback,
    required this.contentCallback,
    required this.groupDoc,
    required this.courseRef,
  });

  final TribeCollectionRecord? collectionDoc;
  final Future Function()? collectionCallback;
  final Future Function(TribeContentRecord? contentDoc)? contentCallback;
  final TribeGroupsRecord? groupDoc;
  final DocumentReference? courseRef;

  @override
  State<GroupTrainingListAdminWidget> createState() =>
      _GroupTrainingListAdminWidgetState();
}

class _GroupTrainingListAdminWidgetState
    extends State<GroupTrainingListAdminWidget> {
  late GroupTrainingListAdminModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupTrainingListAdminModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TribeContentRecord>>(
      stream: queryTribeContentRecord(
        queryBuilder: (tribeContentRecord) => tribeContentRecord
            .where(
              'tribeCollectionID',
              isEqualTo: widget!.collectionDoc?.id,
            )
            .orderBy('position'),
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
        List<TribeContentRecord> containerTribeContentRecordList =
            snapshot.data!;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 500.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                height: 5.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).accent4,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30.0, 16.0, 32.0, 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        valueOrDefault<String>(
                          widget!.collectionDoc?.title,
                          'Module name',
                        ).maybeHandleOverflow(
                          maxChars: 28,
                          replacement: '…',
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleMediumFamily),
                                  lineHeight: 1.0,
                                ),
                      ),
                    ),
                    if (valueOrDefault(currentUserDocument?.userRole, '') ==
                        'admin')
                      AuthUserStreamWidget(
                        builder: (context) => FlutterFlowIconButton(
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 48.0,
                          icon: Icon(
                            Icons.edit,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 14.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'GROUP_TRAINING_LIST_ADMIN_editModuleIcon');
                            logFirebaseEvent(
                                'editModuleIconButton_execute_callback');
                            await widget.collectionCallback?.call();
                          },
                        ),
                      ),
                    AuthUserStreamWidget(
                      builder: (context) => Text(
                        '${functions.returnCompletedContentNumber(containerTribeContentRecordList.map((e) => e.tribeContentID).toList(), (currentUserDocument?.contentCompletedIDs?.toList() ?? []).toList()).toString()}/${containerTribeContentRecordList.length.toString()}',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: Color(0xFF757B83),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleMediumFamily),
                                ),
                      ),
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Divider(
                    height: 5.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 32.0, 16.0),
                    child: Builder(
                      builder: (context) {
                        final containerVar =
                            containerTribeContentRecordList.toList();

                        return ReorderableListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: containerVar.length,
                          itemBuilder: (context, containerVarIndex) {
                            final containerVarItem =
                                containerVar[containerVarIndex];
                            return Container(
                              key: ValueKey("ListView_2c6dy994" +
                                  '_' +
                                  containerVarIndex.toString()),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 2.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'GROUP_TRAINING_LIST_ADMIN_clickContainer');
                                    logFirebaseEvent(
                                        'clickContainer_execute_callback');
                                    await widget.contentCallback?.call(
                                      containerVarItem,
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: valueOrDefault<Color>(
                                        containerVarItem.tribeContentID > 0
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
                                        FlutterFlowTheme.of(context).tertiary,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Builder(
                                            builder: (context) {
                                              if (valueOrDefault<bool>(
                                                (currentUserDocument
                                                            ?.contentCompletedIDs
                                                            ?.toList() ??
                                                        [])
                                                    .contains(containerVarItem
                                                        .tribeContentID),
                                                false,
                                              )) {
                                                return Icon(
                                                  Icons.check_circle_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
                                                );
                                              } else {
                                                return Icon(
                                                  Icons.circle_outlined,
                                                  color: Color(0x5557636C),
                                                  size: 24.0,
                                                );
                                              }
                                            },
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Text(
                                              valueOrDefault<String>(
                                                containerVarItem.title,
                                                'Draft',
                                              ).maybeHandleOverflow(
                                                maxChars: 40,
                                                replacement: '…',
                                              ),
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                        lineHeight: 1.0,
                                                      ),
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(width: 12.0))
                                            .addToEnd(SizedBox(width: 0.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          onReorder: (int reorderableOldIndex,
                              int reorderableNewIndex) async {
                            logFirebaseEvent(
                                'GROUP_TRAINING_LIST_ADMIN_ListView_2c6dy');
                            logFirebaseEvent('ListView_custom_action');
                            await actions.reorderTribeContentList(
                              containerTribeContentRecordList.toList(),
                              reorderableOldIndex,
                              reorderableNewIndex,
                            );

                            safeSetState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ].divide(SizedBox(height: 14.0)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30.0, 14.0, 30.0, 16.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'GROUP_TRAINING_LIST_ADMIN_addContentButt');
                    // Create content doc
                    logFirebaseEvent('addContentButton_Createcontentdoc');

                    var tribeContentRecordReference =
                        TribeContentRecord.collection.doc();
                    await tribeContentRecordReference
                        .set(createTribeContentRecordData(
                      authorRef: currentUserReference,
                      position: containerTribeContentRecordList.length,
                      tribeCollectionID: widget!.collectionDoc?.id,
                      tribeCollectionRef: widget!.collectionDoc?.reference,
                      tribeCourseRef: widget!.collectionDoc?.tribeCourseRef,
                      visibility: 'group',
                      publishDate: getCurrentTimestamp,
                      chatEnabled: true,
                      contentType: 'video',
                    ));
                    _model.newContentDoc =
                        TribeContentRecord.getDocumentFromData(
                            createTribeContentRecordData(
                              authorRef: currentUserReference,
                              position: containerTribeContentRecordList.length,
                              tribeCollectionID: widget!.collectionDoc?.id,
                              tribeCollectionRef:
                                  widget!.collectionDoc?.reference,
                              tribeCourseRef:
                                  widget!.collectionDoc?.tribeCourseRef,
                              visibility: 'group',
                              publishDate: getCurrentTimestamp,
                              chatEnabled: true,
                              contentType: 'video',
                            ),
                            tribeContentRecordReference);
                    logFirebaseEvent('addContentButton_execute_callback');
                    await widget.contentCallback?.call(
                      _model.newContentDoc,
                    );
                    logFirebaseEvent('addContentButton_update_app_state');

                    _model.updatePage(() {});

                    safeSetState(() {});
                  },
                  text: 'Add Lesson',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).accent1,
                    textStyle: FlutterFlowTheme.of(context)
                        .titleMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleMediumFamily),
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).tertiary,
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
