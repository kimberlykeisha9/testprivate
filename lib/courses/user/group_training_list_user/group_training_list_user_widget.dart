import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_training_list_user_model.dart';
export 'group_training_list_user_model.dart';

class GroupTrainingListUserWidget extends StatefulWidget {
  const GroupTrainingListUserWidget({
    super.key,
    this.collectionDoc,
    required this.contentCallback,
  });

  final TribeCollectionRecord? collectionDoc;
  final Future Function(
          TribeContentRecord? contentDoc, DocumentReference contentRef)?
      contentCallback;

  @override
  State<GroupTrainingListUserWidget> createState() =>
      _GroupTrainingListUserWidgetState();
}

class _GroupTrainingListUserWidgetState
    extends State<GroupTrainingListUserWidget> {
  late GroupTrainingListUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupTrainingListUserModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TribeContentRecord>>(
      future: _model.getCourseModuleContents(
        requestFn: () => queryTribeContentRecordOnce(
          queryBuilder: (tribeContentRecord) => tribeContentRecord
              .where(
                'tribeCollectionID',
                isEqualTo: widget!.collectionDoc?.id,
              )
              .orderBy('position'),
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
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            color: FlutterFlowTheme.of(context).white,
            child: ExpandableNotifier(
              controller: _model.expandableExpandableController,
              child: ExpandablePanel(
                header: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 16.0, 12.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          valueOrDefault<String>(
                            widget!.collectionDoc?.title,
                            'Module name',
                          ).maybeHandleOverflow(
                            maxChars: 29,
                            replacement: '…',
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                                lineHeight: 1.0,
                              ),
                        ),
                      ),
                      AuthUserStreamWidget(
                        builder: (context) => Text(
                          '${functions.returnCompletedContentNumber(containerTribeContentRecordList.map((e) => e.tribeContentID).toList(), (currentUserDocument?.contentCompletedIDs?.toList() ?? []).toList()).toString()}/${containerTribeContentRecordList.where((e) => e.tribeContentID > 0).toList().length.toString()}',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                color: Color(0xFF757B83),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(
                  width: 1.0,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
                expanded: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Divider(
                      height: 5.0,
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).accent4,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                      child: Builder(
                        builder: (context) {
                          final contentList =
                              containerTribeContentRecordList.toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: contentList.length,
                            itemBuilder: (context, contentListIndex) {
                              final contentListItem =
                                  contentList[contentListIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'GROUP_TRAINING_LIST_USER_clickContainer_');
                                  logFirebaseEvent(
                                      'clickContainer_execute_callback');
                                  await widget.contentCallback?.call(
                                    contentListItem,
                                    contentListItem.reference,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 14.0),
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
                                                  .contains(contentListItem
                                                      .tribeContentID),
                                              false,
                                            )) {
                                              return Icon(
                                                Icons.check_circle_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 24.0,
                                              );
                                            } else {
                                              return Icon(
                                                Icons.radio_button_off_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                                size: 24.0,
                                              );
                                            }
                                          },
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: Text(
                                            contentListItem.title
                                                .maybeHandleOverflow(
                                              maxChars: 50,
                                              replacement: '…',
                                            ),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
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
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ].divide(SizedBox(height: 14.0)),
                ),
                theme: ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: true,
                  iconSize: 20.0,
                  iconColor: Color(0xFF344054),
                  iconPadding: EdgeInsets.fromLTRB(0.0, 16.0, 30.0, 12.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
