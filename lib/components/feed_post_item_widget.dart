import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/create_account_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/post_options_f_b/post_options_f_b_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'feed_post_item_model.dart';
export 'feed_post_item_model.dart';

class FeedPostItemWidget extends StatefulWidget {
  const FeedPostItemWidget({
    super.key,
    required this.broadcastDoc,
    required this.groupDoc,
    required this.refreshFeed,
  });

  final BroadcastsRecord? broadcastDoc;
  final TribeGroupsRecord? groupDoc;
  final Future Function()? refreshFeed;

  @override
  State<FeedPostItemWidget> createState() => _FeedPostItemWidgetState();
}

class _FeedPostItemWidgetState extends State<FeedPostItemWidget> {
  late FeedPostItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedPostItemModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
      child: FutureBuilder<UserRecord>(
        future: _model.userBadges(
          uniqueQueryKey: valueOrDefault<String>(
            widget!.broadcastDoc?.userId?.id,
            '1',
          ),
          requestFn: () =>
              UserRecord.getDocumentOnce(widget!.broadcastDoc!.userId!),
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

          final containerUserRecord = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color(0x337090B0),
                  offset: Offset(
                    0.0,
                    16.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(12.0),
              shape: BoxShape.rectangle,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('FEED_POST_ITEM_COMP_PostItem_ON_TAP');
                logFirebaseEvent('PostItem_navigate_to');

                context.pushNamed(
                  'DiscussionPost',
                  queryParameters: {
                    'broadcastDoc': serializeParam(
                      widget!.broadcastDoc,
                      ParamType.Document,
                    ),
                    'groupDoc': serializeParam(
                      widget!.groupDoc,
                      ParamType.Document,
                    ),
                    'isEditMode': serializeParam(
                      false,
                      ParamType.bool,
                    ),
                  }.withoutNulls,
                  extra: <String, dynamic>{
                    'broadcastDoc': widget!.broadcastDoc,
                    'groupDoc': widget!.groupDoc,
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              onDoubleTap: () async {
                logFirebaseEvent('FEED_POST_ITEM_PostItem_ON_DOUBLE_TAP');
                logFirebaseEvent('PostItem_backend_call');

                await widget!.broadcastDoc!.reference.update({
                  ...mapToFirestore(
                    {
                      'likeCount': FieldValue.increment(1),
                    },
                  ),
                });
                logFirebaseEvent('PostItem_backend_call');

                await currentUserReference!.update({
                  ...mapToFirestore(
                    {
                      'likePosts': FieldValue.arrayUnion(
                          [widget!.broadcastDoc?.reference]),
                    },
                  ),
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget!.broadcastDoc?.pinnedToTop ?? true)
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 3.0, 0.0),
                              child: Icon(
                                Icons.push_pin,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 14.0,
                              ),
                            ),
                            Text(
                              'Pinned',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context).accent1,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'FEED_POST_ITEM_COMP_Row_u371cqrn_ON_TAP');
                                  logFirebaseEvent('Row_action_block');
                                  await action_blocks.openUserProfileDialog(
                                    context,
                                    userDoc: containerUserRecord,
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 35.0,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .gray200,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              Duration(milliseconds: 300),
                                          fadeOutDuration:
                                              Duration(milliseconds: 300),
                                          imageUrl: valueOrDefault<String>(
                                            widget!.broadcastDoc?.authorImg,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/urudd5qbm9oj/blank-200.jpeg',
                                          ),
                                          fit: BoxFit.cover,
                                          errorWidget:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  widget!
                                                      .broadcastDoc?.authorName,
                                                  'Unknown User',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor4,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                  'Open Sans'),
                                                      lineHeight: 1.0,
                                                    ),
                                              ),
                                              if (widget!.broadcastDoc
                                                      ?.authorRole ==
                                                  'admin')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'ADMIN',
                                                    options: FFButtonOptions(
                                                      height: 18.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  3.0,
                                                                  0.0,
                                                                  3.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                                lineHeight: 1.2,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    showLoadingIndicator: false,
                                                  ),
                                                ),
                                              if (valueOrDefault<bool>(
                                                widget!.broadcastDoc?.isLive,
                                                false,
                                              ))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Live',
                                                    options: FFButtonOptions(
                                                      height: 18.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  3.0,
                                                                  0.0,
                                                                  3.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Open Sans'),
                                                                lineHeight: 1.2,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    showLoadingIndicator: false,
                                                  ),
                                                ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final userBadges =
                                                        containerUserRecord
                                                            .userBadges
                                                            .toList()
                                                            .take(5)
                                                            .toList();

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          userBadges.length,
                                                          (userBadgesIndex) {
                                                        final userBadgesItem =
                                                            userBadges[
                                                                userBadgesIndex];
                                                        return Builder(
                                                          builder: (context) {
                                                            if (userBadgesItem
                                                                        .badgeImg !=
                                                                    null &&
                                                                userBadgesItem
                                                                        .badgeImg !=
                                                                    '') {
                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  fadeInDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  fadeOutDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  imageUrl:
                                                                      userBadgesItem
                                                                          .badgeImg,
                                                                  width: 20.0,
                                                                  height: 20.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorWidget: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/images/error_image.jpg',
                                                                    width: 20.0,
                                                                    height:
                                                                        20.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Container(
                                                                height: 18.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grayIcon,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          6.0,
                                                                          0.0,
                                                                          6.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    userBadgesItem
                                                                        .badgeName,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }).divide(
                                                          SizedBox(width: 2.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 1.0, 0.0, 0.0),
                                            child: Text(
                                              dateTimeFormat("relative",
                                                  widget!.broadcastDoc!.time!),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grayIcon,
                                                    fontSize: 11.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w200,
                                                    fontStyle: FontStyle.italic,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                                'Open Sans'),
                                                    lineHeight: 1.0,
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
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: FaIcon(
                                  FontAwesomeIcons.broadcastTower,
                                  color:
                                      FlutterFlowTheme.of(context).customColor3,
                                  size: 22.0,
                                ),
                              ),
                            Builder(
                              builder: (context) => FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 0.0,
                                buttonSize: 45.0,
                                icon: FaIcon(
                                  FontAwesomeIcons.ellipsisV,
                                  color: FlutterFlowTheme.of(context).grayIcon,
                                  size: 22.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'FEED_POST_ITEM_COMP_ellipsisV_ICN_ON_TAP');
                                  logFirebaseEvent('IconButton_alert_dialog');
                                  await showAlignedDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    isGlobal: false,
                                    avoidOverflow: false,
                                    targetAnchor: AlignmentDirectional(
                                            1.0, -1.0)
                                        .resolve(Directionality.of(context)),
                                    followerAnchor: AlignmentDirectional(
                                            1.0, -1.0)
                                        .resolve(Directionality.of(context)),
                                    builder: (dialogContext) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: WebViewAware(
                                          child: Container(
                                            height: 240.0,
                                            width: 200.0,
                                            child: PostOptionsFBWidget(
                                              postId: widget!
                                                  .broadcastDoc?.contentID,
                                              groupDoc: widget!.groupDoc!,
                                              postAuthorRef:
                                                  widget!.broadcastDoc?.userId,
                                              pinned: widget!
                                                  .broadcastDoc?.pinnedToTop,
                                              discussionPost: widget!
                                                  .broadcastDoc?.reference,
                                              callback: () async {
                                                logFirebaseEvent(
                                                    '_navigate_to');

                                                context.pushNamed(
                                                  'DiscussionPost',
                                                  queryParameters: {
                                                    'broadcastDoc':
                                                        serializeParam(
                                                      widget!.broadcastDoc,
                                                      ParamType.Document,
                                                    ),
                                                    'groupDoc': serializeParam(
                                                      widget!.groupDoc,
                                                      ParamType.Document,
                                                    ),
                                                    'isEditMode':
                                                        serializeParam(
                                                      true,
                                                      ParamType.bool,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'broadcastDoc':
                                                        widget!.broadcastDoc,
                                                    'groupDoc':
                                                        widget!.groupDoc,
                                                  },
                                                );
                                              },
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
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (!widget!.broadcastDoc!.isLive) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget!.broadcastDoc?.title != null &&
                                  widget!.broadcastDoc?.title != '')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 5.0, 12.0, 0.0),
                                  child: Text(
                                    widget!.broadcastDoc!.title
                                        .maybeHandleOverflow(
                                      maxChars: 275,
                                      replacement: '…',
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                  ),
                                ),
                              if ((widget!.broadcastDoc?.name != null &&
                                      widget!.broadcastDoc?.name != '') &&
                                  responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 8.0),
                                  child: Text(
                                    widget!.broadcastDoc!.name
                                        .maybeHandleOverflow(
                                      maxChars: 275,
                                      replacement: '…',
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 7,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .customColor4,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                  ),
                                ),
                              if (widget!.broadcastDoc?.name != null &&
                                  widget!.broadcastDoc?.name != '')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 5.0, 12.0, 5.0),
                                  child: custom_widgets.LinkableTextV2(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 100.0,
                                    text: widget!.broadcastDoc!.name,
                                    textSize: 16.0,
                                    limitTextLength: true,
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FEED_POST_ITEM_COMP_mediaStack_ON_TAP');
                                    logFirebaseEvent('mediaStack_navigate_to');

                                    context.pushNamed(
                                      'DiscussionPost',
                                      queryParameters: {
                                        'broadcastDoc': serializeParam(
                                          widget!.broadcastDoc,
                                          ParamType.Document,
                                        ),
                                        'groupDoc': serializeParam(
                                          widget!.groupDoc,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'broadcastDoc': widget!.broadcastDoc,
                                        'groupDoc': widget!.groupDoc,
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  },
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      if (widget!.broadcastDoc?.video != null &&
                                          widget!.broadcastDoc?.video != '')
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xB200C2CB),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Icon(
                                              Icons.play_arrow_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              size: 70.0,
                                            ),
                                          ),
                                        ),
                                      if (widget!.broadcastDoc?.featuredImage !=
                                              null &&
                                          widget!.broadcastDoc?.featuredImage !=
                                              '')
                                        Hero(
                                          tag: widget!
                                              .broadcastDoc!.featuredImage,
                                          transitionOnUserGestures: true,
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 300),
                                            fadeOutDuration:
                                                Duration(milliseconds: 300),
                                            imageUrl: widget!
                                                .broadcastDoc!.featuredImage,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.jpg',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 6.0, 10.0, 7.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (widget!.broadcastDoc?.likedBy
                                                    ?.contains(
                                                        containerUserRecord
                                                            .reference) ??
                                                false) {
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'FEED_POST_ITEM_COMP_Liked_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Liked_backend_call');

                                                  await widget!
                                                      .broadcastDoc!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'likeCount': FieldValue
                                                            .increment(-(1)),
                                                      },
                                                    ),
                                                  });
                                                  logFirebaseEvent(
                                                      'Liked_backend_call');

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'likePosts': FieldValue
                                                            .arrayRemove([
                                                          widget!.broadcastDoc
                                                              ?.reference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor3,
                                                      size: 24.0,
                                                    ),
                                                    Text(
                                                      '${widget!.broadcastDoc?.likeCount?.toString()} likes',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'FEED_POST_ITEM_COMP_NotLiked_ON_TAP');
                                                  logFirebaseEvent(
                                                      'NotLiked_backend_call');

                                                  await widget!
                                                      .broadcastDoc!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'likeCount': FieldValue
                                                            .increment(1),
                                                      },
                                                    ),
                                                  });
                                                  logFirebaseEvent(
                                                      'NotLiked_backend_call');

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'likePosts': FieldValue
                                                            .arrayUnion([
                                                          widget!.broadcastDoc
                                                              ?.reference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  // LikedPostNotification
                                                  logFirebaseEvent(
                                                      'NotLiked_LikedPostNotification');

                                                  await NotificationsRecord
                                                      .collection
                                                      .doc()
                                                      .set({
                                                    ...createNotificationsRecordData(
                                                      title:
                                                          '${currentUserDisplayName} has liked your post!',
                                                      timeCreated:
                                                          getCurrentTimestamp,
                                                      discussionPostRef: widget!
                                                          .broadcastDoc
                                                          ?.reference,
                                                      description: widget!
                                                          .broadcastDoc?.name,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'UserRefList': [
                                                          widget!.broadcastDoc
                                                              ?.userId
                                                        ],
                                                      },
                                                    ),
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grayIcon,
                                                      size: 24.0,
                                                    ),
                                                    Text(
                                                      '${widget!.broadcastDoc?.likeCount?.toString()} likes',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    if (!loggedIn)
                                      Stack(
                                        children: [
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                            tabletLandscape: false,
                                            desktop: false,
                                          ))
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'FEED_POST_ITEM_COMP_NotLiked_ON_TAP');
                                                logFirebaseEvent(
                                                    'NotLiked_bottom_sheet');
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      Color(0x00000000),
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CreateAccountWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.favorite_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grayIcon,
                                                    size: 24.0,
                                                  ),
                                                  Text(
                                                    '${widget!.broadcastDoc?.likeCount?.toString()} likes',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FutureBuilder<int>(
                                          future: queryChatMessagesRecordCount(
                                            queryBuilder:
                                                (chatMessagesRecord) =>
                                                    chatMessagesRecord.where(
                                              'broadcastRef',
                                              isEqualTo: widget!
                                                  .broadcastDoc?.reference,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: Image.asset(
                                                  '',
                                                ),
                                              );
                                            }
                                            int textCount = snapshot.data!;

                                            return Text(
                                              '${textCount.toString()} comments',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily),
                                                  ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${containerUserRecord.displayName} is live, join now!',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'FEED_POST_ITEM_JOIN_LIVE_STREAM_BTN_ON_T');
                                    logFirebaseEvent('Button_navigate_to');

                                    context.pushNamed(
                                      'StartBroadcast_FB',
                                      queryParameters: {
                                        'groupDoc': serializeParam(
                                          widget!.groupDoc,
                                          ParamType.Document,
                                        ),
                                        'broadcast': serializeParam(
                                          widget!.broadcastDoc?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'groupDoc': widget!.groupDoc,
                                      },
                                    );
                                  },
                                  text: 'Join Live Stream',
                                  options: FFButtonOptions(
                                    width: 150.0,
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 6.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ].divide(SizedBox(height: 15.0)),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
