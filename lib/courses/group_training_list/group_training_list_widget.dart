import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_training_list_model.dart';
export 'group_training_list_model.dart';

class GroupTrainingListWidget extends StatefulWidget {
  const GroupTrainingListWidget({
    super.key,
    this.groupId,
    this.groupSlug,
    required this.contents,
    this.collectionName,
    this.collectionDescription,
    this.totalItems,
    this.completedItems,
    required this.groupDoc,
    this.showThumbnails,
    bool? showContentTitleOnly,
  }) : this.showContentTitleOnly = showContentTitleOnly ?? false;

  final int? groupId;
  final String? groupSlug;
  final List<dynamic>? contents;
  final String? collectionName;
  final String? collectionDescription;
  final int? totalItems;
  final int? completedItems;
  final TribeGroupsRecord? groupDoc;
  final bool? showThumbnails;
  final bool showContentTitleOnly;

  @override
  State<GroupTrainingListWidget> createState() =>
      _GroupTrainingListWidgetState();
}

class _GroupTrainingListWidgetState extends State<GroupTrainingListWidget> {
  late GroupTrainingListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupTrainingListModel());

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
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 500.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40.0,
                            color: Color(0x337090B0),
                            offset: Offset(
                              0.0,
                              16.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        color: FlutterFlowTheme.of(context).white,
                        child: ExpandableNotifier(
                          controller: _model.expandableExpandableController,
                          child: ExpandablePanel(
                            header: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 5.0, 15.0, 5.0),
                                      child: AutoSizeText(
                                        widget!.collectionName!,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        minFontSize: 18.0,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(FlutterFlowTheme
                                                          .of(context)
                                                      .headlineMediumFamily),
                                              lineHeight: 1.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget!.completedItems?.toString()}/${widget!.totalItems?.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .headlineMediumFamily),
                                      ),
                                ),
                              ],
                            ),
                            collapsed: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(),
                            ),
                            expanded: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget!.collectionDescription != null &&
                                    widget!.collectionDescription != '')
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (widget!.collectionDescription !=
                                              null &&
                                          widget!.collectionDescription != '')
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 15.0, 0.0),
                                            child: AutoSizeText(
                                              widget!.collectionDescription!,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 5.0, 15.0, 5.0),
                                  child: Builder(
                                    builder: (context) {
                                      final collectionContents =
                                          widget!.contents!.toList();

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: collectionContents.length,
                                        itemBuilder:
                                            (context, collectionContentsIndex) {
                                          final collectionContentsItem =
                                              collectionContents[
                                                  collectionContentsIndex];
                                          return Visibility(
                                            visible: valueOrDefault<bool>(
                                              functions.shouldDisplayContent(
                                                  getJsonField(
                                                    collectionContentsItem,
                                                    r'''$.publishedDate''',
                                                  ).toString(),
                                                  getJsonField(
                                                    collectionContentsItem,
                                                    r'''$.expireDate''',
                                                  ).toString()),
                                              false,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 15.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'GROUP_TRAINING_LIST_Row_w2v0hhta_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Row_update_app_state');
                                                  FFAppState().showDescription =
                                                      getJsonField(
                                                            collectionContentsItem,
                                                            r'''$.descriptionPlain''',
                                                          ) !=
                                                          null;
                                                  FFAppState().update(() {});
                                                  logFirebaseEvent(
                                                      'Row_navigate_to');
                                                  if (Navigator.of(context)
                                                      .canPop()) {
                                                    context.pop();
                                                  }
                                                  context.pushNamed(
                                                    'PostView',
                                                    queryParameters: {
                                                      'postID': serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.id''',
                                                        ),
                                                        ParamType.int,
                                                      ),
                                                      'pageSource':
                                                          serializeParam(
                                                        'content',
                                                        ParamType.String,
                                                      ),
                                                      'completed':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.isCompleted''',
                                                        ),
                                                        ParamType.bool,
                                                      ),
                                                      'title': serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'hasLiked':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                      'video': serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.video''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'type': serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.type''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'contentURI':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.contentURI''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'descriptionPlain':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.descriptionPlain''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'featuredImage':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.featuredImage''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'userName':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.User.name''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'userPic': serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.User.photoUrl''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'chatEnabled':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.chatEnabled''',
                                                        ),
                                                        ParamType.bool,
                                                      ),
                                                      'likeCount':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.likeCount''',
                                                        ),
                                                        ParamType.int,
                                                      ),
                                                      'commentCount':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.commentCount''',
                                                        ),
                                                        ParamType.int,
                                                      ),
                                                      'commentFocus':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                      'descriptionHtml':
                                                          serializeParam(
                                                        getJsonField(
                                                          collectionContentsItem,
                                                          r'''$.descriptionHtml''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                      'userId': serializeParam(
                                                        FFAppState().userID,
                                                        ParamType.int,
                                                      ),
                                                      'groupDoc':
                                                          serializeParam(
                                                        widget!.groupDoc,
                                                        ParamType.Document,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      'groupDoc':
                                                          widget!.groupDoc,
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Builder(
                                                      builder: (context) {
                                                        if (widget!
                                                                .showThumbnails ??
                                                            false) {
                                                          return Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  '${getRemoteConfigString('AppImgBaseUrl')}${getJsonField(
                                                                    collectionContentsItem,
                                                                    r'''$.featuredImage''',
                                                                  ).toString()}?tr=w-200,h-112',
                                                                  width: 112.0,
                                                                  height: 63.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/images/error_image.jpg',
                                                                    width:
                                                                        112.0,
                                                                    height:
                                                                        63.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              if (getJsonField(
                                                                collectionContentsItem,
                                                                r'''$.isCompleted''',
                                                              ))
                                                                Opacity(
                                                                  opacity: 0.8,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        112.0,
                                                                    height:
                                                                        63.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (getJsonField(
                                                                collectionContentsItem,
                                                                r'''$.isCompleted''',
                                                              ))
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .checkCircle,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'COMPLETED',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                            ],
                                                          );
                                                        } else {
                                                          return Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            children: [
                                                              if (getJsonField(
                                                                collectionContentsItem,
                                                                r'''$.isCompleted''',
                                                              ))
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .checkCircle,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 24.0,
                                                                ),
                                                              if (!getJsonField(
                                                                collectionContentsItem,
                                                                r'''$.isCompleted''',
                                                              ))
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .checkCircle,
                                                                  color: Color(
                                                                      0x5557636C),
                                                                  size: 24.0,
                                                                ),
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                collectionContentsItem,
                                                                r'''$.title''',
                                                              )?.toString(),
                                                              'loading...',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily),
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                          ),
                                                          if (!widget!
                                                              .showContentTitleOnly)
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    '${getJsonField(
                                                                      collectionContentsItem,
                                                                      r'''$.User.name''',
                                                                    ).toString()} | ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Open Sans',
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey('Open Sans'),
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                        "yMMMd",
                                                                        functions
                                                                            .formatDate(getJsonField(
                                                                          collectionContentsItem,
                                                                          r'''$.publishedDate''',
                                                                        ).toString())),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Open Sans',
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey('Open Sans'),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(width: 20.0))
                                                      .addToEnd(
                                                          SizedBox(width: 0.0)),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            theme: ExpandableThemeData(
                              tapHeaderToExpand: true,
                              tapBodyToExpand: true,
                              tapBodyToCollapse: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              hasIcon: true,
                              iconSize: 35.0,
                              iconColor: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
