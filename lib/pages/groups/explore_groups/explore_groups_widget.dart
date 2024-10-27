import '/backend/backend.dart';
import '/components/group_info_bottom_sheet_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/explore_groups_c_t_a/explore_groups_c_t_a_widget.dart';
import 'dart:math';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'explore_groups_model.dart';
export 'explore_groups_model.dart';

class ExploreGroupsWidget extends StatefulWidget {
  const ExploreGroupsWidget({
    super.key,
    int? openTab,
    String? activeGroupTab,
    this.groupDoc,
  })  : this.openTab = openTab ?? 0,
        this.activeGroupTab = activeGroupTab ?? 'Today';

  final int openTab;
  final String activeGroupTab;
  final TribeGroupsRecord? groupDoc;

  @override
  State<ExploreGroupsWidget> createState() => _ExploreGroupsWidgetState();
}

class _ExploreGroupsWidgetState extends State<ExploreGroupsWidget>
    with TickerProviderStateMixin {
  late ExploreGroupsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreGroupsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ExploreGroups'});
    _model.filterTextFieldTextController ??= TextEditingController();
    _model.filterTextFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'gridViewOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(0.0, 10.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'gridViewOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'gridViewOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
                  context: context,
                  desktop: false,
                ) &&
                (MediaQuery.sizeOf(context).width < 768.0)
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 45.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'EXPLORE_GROUPS_chevron_left_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed('GroupList');
                      },
                    ),
                    Image.network(
                      '',
                      width: 90.0,
                      fit: BoxFit.contain,
                    ),
                    wrapWithModel(
                      model: _model.profileButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ProfileButtonWidget(),
                    ),
                  ],
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                wrapWithModel(
                  model: _model.topWebNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TopWebNavWidget(
                    groupDoc: widget!.groupDoc,
                  ),
                ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: StreamBuilder<List<TribeGroupsRecord>>(
                    stream: queryTribeGroupsRecord(
                      queryBuilder: (tribeGroupsRecord) => tribeGroupsRecord
                          .where(
                            'visibility',
                            isEqualTo: 'public',
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
                      List<TribeGroupsRecord>
                          mainContainerTribeGroupsRecordList = snapshot.data!;

                      return Container(
                        width: 1000.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        constraints: BoxConstraints(
                          maxWidth: 1000.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6.0, 25.0, 0.0, 0.0),
                                            child: Text(
                                              'Explore all ${getRemoteConfigString('Copy_Groups')}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLargeFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily),
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                TextFormField(
                                                  controller: _model
                                                      .filterTextFieldTextController,
                                                  focusNode: _model
                                                      .filterTextFieldFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.filterTextFieldTextController',
                                                    Duration(
                                                        milliseconds: 1500),
                                                    () async {
                                                      logFirebaseEvent(
                                                          'EXPLORE_GROUPS_filterTextField_ON_TEXTFI');
                                                      logFirebaseEvent(
                                                          'filterTextField_simple_search');
                                                      safeSetState(() {
                                                        _model.simpleSearchResults =
                                                            TextSearch(
                                                          mainContainerTribeGroupsRecordList
                                                              .map(
                                                                (record) =>
                                                                    TextSearchItem
                                                                        .fromTerms(
                                                                            record,
                                                                            [
                                                                      record
                                                                          .name!,
                                                                      record
                                                                          .description!
                                                                    ]),
                                                              )
                                                              .toList(),
                                                        )
                                                                .search(_model
                                                                    .filterTextFieldTextController
                                                                    .text)
                                                                .map((r) =>
                                                                    r.object)
                                                                .toList();
                                                        ;
                                                      });
                                                      logFirebaseEvent(
                                                          'filterTextField_update_page_state');

                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Search ${getRemoteConfigString('Copy_Groups')}',
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Open Sans'),
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent1,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                5.0, 5.0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 20.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 35.0,
                                                      icon: Icon(
                                                        Icons.clear,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 18.0,
                                                      ),
                                                      onPressed: () async {
                                                        logFirebaseEvent(
                                                            'EXPLORE_GROUPS_PAGE_clear_ICN_ON_TAP');
                                                        logFirebaseEvent(
                                                            'IconButton_clear_text_fields_pin_codes');
                                                        safeSetState(() {
                                                          _model
                                                              .filterTextFieldTextController
                                                              ?.clear();
                                                        });
                                                        logFirebaseEvent(
                                                            'IconButton_update_page_state');

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Tap to learn more',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF57636C),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Plus Jakarta Sans'),
                                            ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Builder(
                                        builder: (context) {
                                          if (_model.filterTextFieldTextController
                                                      .text !=
                                                  null &&
                                              _model.filterTextFieldTextController
                                                      .text !=
                                                  '') {
                                            return Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 12.0, 15.0, 45.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final searchResults = _model
                                                        .simpleSearchResults
                                                        .sortedList(
                                                            keyOf: (e) =>
                                                                e.tribeGroupID,
                                                            desc: false)
                                                        .toList();

                                                    return GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return 2;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return 2;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return 3;
                                                          } else {
                                                            return 3;
                                                          }
                                                        }(),
                                                        crossAxisSpacing: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return 10.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return 14.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return 18.0;
                                                          } else {
                                                            return 10.0;
                                                          }
                                                        }(),
                                                        mainAxisSpacing: 12.0,
                                                        childAspectRatio: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return 1.2;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return 1.3;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return 1.3;
                                                          } else {
                                                            return 1.1;
                                                          }
                                                        }(),
                                                      ),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          searchResults.length,
                                                      itemBuilder: (context,
                                                          searchResultsIndex) {
                                                        final searchResultsItem =
                                                            searchResults[
                                                                searchResultsIndex];
                                                        return Builder(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              logFirebaseEvent(
                                                                  'EXPLORE_GROUPS_Column_8nq1tf6o_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Column_alert_dialog');
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        0,
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
                                                                            Directionality.of(context)),
                                                                    child:
                                                                        WebViewAware(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap: () =>
                                                                            FocusScope.of(dialogContext).unfocus(),
                                                                        child:
                                                                            GroupInfoBottomSheetWidget(
                                                                          groupName:
                                                                              searchResultsItem.name,
                                                                          groupId:
                                                                              searchResultsItem.tribeGroupID,
                                                                          groupPhoto:
                                                                              searchResultsItem.featuredImg,
                                                                          groupDescription:
                                                                              searchResultsItem.description,
                                                                          purchaseLink:
                                                                              searchResultsItem.purchaseLink,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      0.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                              20.0,
                                                                          color:
                                                                              Color(0x337090B0),
                                                                          offset:
                                                                              Offset(
                                                                            0.0,
                                                                            8.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        if (responsiveVisibility(
                                                                          context:
                                                                              context,
                                                                          phone:
                                                                              false,
                                                                          tablet:
                                                                              false,
                                                                        ))
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              fadeInDuration: Duration(milliseconds: 300),
                                                                              fadeOutDuration: Duration(milliseconds: 300),
                                                                              imageUrl: searchResultsItem.featuredImg,
                                                                              width: 360.0,
                                                                              height: 168.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        if (responsiveVisibility(
                                                                          context:
                                                                              context,
                                                                          tabletLandscape:
                                                                              false,
                                                                          desktop:
                                                                              false,
                                                                        ))
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              fadeInDuration: Duration(milliseconds: 300),
                                                                              fadeOutDuration: Duration(milliseconds: 300),
                                                                              imageUrl: searchResultsItem.featuredImg,
                                                                              width: 175.0,
                                                                              height: 100.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      searchResultsItem
                                                                          .name,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          14.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).labelLargeFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                            lineHeight:
                                                                                1.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                ))
                                                                  Text(
                                                                    searchResultsItem
                                                                        .description,
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                        ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'gridViewOnPageLoadAnimation1']!);
                                                  },
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Builder(
                                              builder: (context) {
                                                if (getRemoteConfigBool(
                                                    'isGroupTypeEnabled')) {
                                                  return Builder(
                                                    builder: (context) {
                                                      final groupTypeChild = functions
                                                          .convertJsonToListString(
                                                              getRemoteConfigString(
                                                                  'GroupTypes'))
                                                          .toList();

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            groupTypeChild
                                                                .length,
                                                            (groupTypeChildIndex) {
                                                          final groupTypeChildItem =
                                                              groupTypeChild[
                                                                  groupTypeChildIndex];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Visibility(
                                                              visible: mainContainerTribeGroupsRecordList
                                                                  .where((e) => e
                                                                      .groupType
                                                                      .contains(
                                                                          groupTypeChildItem))
                                                                  .toList()
                                                                  .isNotEmpty,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            25.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              15.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              groupTypeChildItem,
                                                                              'Member Education Center',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).headlineLargeFamily,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineLargeFamily),
                                                                                ),
                                                                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                                                                        ),
                                                                        if (getRemoteConfigBool('Feature_AllowExploreGroups') &&
                                                                            (groupTypeChildIndex ==
                                                                                0))
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                15.0,
                                                                                0.0),
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                logFirebaseEvent('EXPLORE_GROUPS_EXPLORE_ALL_GROUPS_BTN_ON');
                                                                                logFirebaseEvent('Button_navigate_to');

                                                                                context.pushNamed('ExploreGroups');
                                                                              },
                                                                              text: 'Explore ${getRemoteConfigString('Copy_Groups')}',
                                                                              options: FFButtonOptions(
                                                                                height: 40.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                      color: Colors.white,
                                                                                      fontSize: 15.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.transparent,
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            15.0,
                                                                            12.0,
                                                                            15.0,
                                                                            12.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final categoryGroupChild =
                                                                                mainContainerTribeGroupsRecordList.where((e) => e.groupType.contains(groupTypeChildItem)).toList();
                                                                            if (categoryGroupChild.isEmpty) {
                                                                              return ExploreGroupsCTAWidget();
                                                                            }

                                                                            return GridView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 2;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 2;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 3;
                                                                                  } else {
                                                                                    return 3;
                                                                                  }
                                                                                }(),
                                                                                crossAxisSpacing: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 10.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 14.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 18.0;
                                                                                  } else {
                                                                                    return 10.0;
                                                                                  }
                                                                                }(),
                                                                                mainAxisSpacing: 12.0,
                                                                                childAspectRatio: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 1.2;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 1.3;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 1.3;
                                                                                  } else {
                                                                                    return 1.1;
                                                                                  }
                                                                                }(),
                                                                              ),
                                                                              primary: false,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: categoryGroupChild.length,
                                                                              itemBuilder: (context, categoryGroupChildIndex) {
                                                                                final categoryGroupChildItem = categoryGroupChild[categoryGroupChildIndex];
                                                                                return InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    logFirebaseEvent('EXPLORE_GROUPS_Column_y4kio7ji_ON_TAP');
                                                                                    logFirebaseEvent('Column_action_block');
                                                                                    await action_blocks.groupTabRedirect(
                                                                                      context,
                                                                                      groupDoc: categoryGroupChildItem,
                                                                                    );
                                                                                  },
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Material(
                                                                                        color: Colors.transparent,
                                                                                        elevation: 0.0,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(12.0),
                                                                                        ),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                            boxShadow: [
                                                                                              BoxShadow(
                                                                                                blurRadius: 20.0,
                                                                                                color: Color(0x337090B0),
                                                                                                offset: Offset(
                                                                                                  0.0,
                                                                                                  8.0,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                          ),
                                                                                          child: Stack(
                                                                                            children: [
                                                                                              if (responsiveVisibility(
                                                                                                context: context,
                                                                                                phone: false,
                                                                                                tablet: false,
                                                                                              ))
                                                                                                ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                                  child: CachedNetworkImage(
                                                                                                    fadeInDuration: Duration(milliseconds: 500),
                                                                                                    fadeOutDuration: Duration(milliseconds: 500),
                                                                                                    imageUrl: categoryGroupChildItem.featuredImg,
                                                                                                    width: 360.0,
                                                                                                    height: 168.0,
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                              if (responsiveVisibility(
                                                                                                context: context,
                                                                                                tabletLandscape: false,
                                                                                                desktop: false,
                                                                                              ))
                                                                                                ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                                  child: CachedNetworkImage(
                                                                                                    fadeInDuration: Duration(milliseconds: 300),
                                                                                                    fadeOutDuration: Duration(milliseconds: 300),
                                                                                                    imageUrl: categoryGroupChildItem.featuredImg,
                                                                                                    width: 175.0,
                                                                                                    height: 100.0,
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                          child: AutoSizeText(
                                                                                            categoryGroupChildItem.name,
                                                                                            textAlign: TextAlign.start,
                                                                                            maxLines: 1,
                                                                                            minFontSize: 14.0,
                                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                  fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                                  letterSpacing: 0.0,
                                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                                                  lineHeight: 1.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      if ((categoryGroupChildItem.description != null && categoryGroupChildItem.description != '') &&
                                                                                          responsiveVisibility(
                                                                                            context: context,
                                                                                            phone: false,
                                                                                            tablet: false,
                                                                                          ))
                                                                                        Text(
                                                                                          categoryGroupChildItem.description,
                                                                                          maxLines: 2,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).animateOnPageLoad(animationsMap['gridViewOnPageLoadAnimation2']!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                12.0,
                                                                15.0,
                                                                50.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final allGroupsChildren =
                                                            mainContainerTribeGroupsRecordList
                                                                .toList();

                                                        return GridView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: () {
                                                              if (MediaQuery.sizeOf(
                                                                          context)
                                                                      .width <
                                                                  kBreakpointSmall) {
                                                                return 2;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointMedium) {
                                                                return 2;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointLarge) {
                                                                return 3;
                                                              } else {
                                                                return 3;
                                                              }
                                                            }(),
                                                            crossAxisSpacing:
                                                                () {
                                                              if (MediaQuery.sizeOf(
                                                                          context)
                                                                      .width <
                                                                  kBreakpointSmall) {
                                                                return 10.0;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointMedium) {
                                                                return 14.0;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointLarge) {
                                                                return 18.0;
                                                              } else {
                                                                return 10.0;
                                                              }
                                                            }(),
                                                            mainAxisSpacing:
                                                                12.0,
                                                            childAspectRatio:
                                                                () {
                                                              if (MediaQuery.sizeOf(
                                                                          context)
                                                                      .width <
                                                                  kBreakpointSmall) {
                                                                return 1.2;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointMedium) {
                                                                return 1.3;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width <
                                                                  kBreakpointLarge) {
                                                                return 1.3;
                                                              } else {
                                                                return 1.1;
                                                              }
                                                            }(),
                                                          ),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              allGroupsChildren
                                                                  .length,
                                                          itemBuilder: (context,
                                                              allGroupsChildrenIndex) {
                                                            final allGroupsChildrenItem =
                                                                allGroupsChildren[
                                                                    allGroupsChildrenIndex];
                                                            return Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'EXPLORE_GROUPS_Column_tcbrgwkf_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Column_alert_dialog');
                                                                  await showDialog(
                                                                    barrierDismissible:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Dialog(
                                                                        elevation:
                                                                            0,
                                                                        insetPadding:
                                                                            EdgeInsets.zero,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        alignment:
                                                                            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                        child:
                                                                            WebViewAware(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () =>
                                                                                FocusScope.of(dialogContext).unfocus(),
                                                                            child:
                                                                                GroupInfoBottomSheetWidget(
                                                                              groupName: allGroupsChildrenItem.name,
                                                                              groupId: allGroupsChildrenItem.tribeGroupID,
                                                                              groupPhoto: allGroupsChildrenItem.featuredImg,
                                                                              groupDescription: allGroupsChildrenItem.description,
                                                                              purchaseLink: allGroupsChildrenItem.purchaseLink,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          0.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 20.0,
                                                                              color: Color(0x337090B0),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                8.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            if (responsiveVisibility(
                                                                              context: context,
                                                                              phone: false,
                                                                              tablet: false,
                                                                            ))
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 300),
                                                                                  fadeOutDuration: Duration(milliseconds: 300),
                                                                                  imageUrl: allGroupsChildrenItem.featuredImg,
                                                                                  width: 360.0,
                                                                                  height: 168.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            if (responsiveVisibility(
                                                                              context: context,
                                                                              tabletLandscape: false,
                                                                              desktop: false,
                                                                            ))
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 300),
                                                                                  fadeOutDuration: Duration(milliseconds: 300),
                                                                                  imageUrl: allGroupsChildrenItem.featuredImg,
                                                                                  width: 175.0,
                                                                                  height: 100.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          allGroupsChildrenItem
                                                                              .name,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          maxLines:
                                                                              1,
                                                                          minFontSize:
                                                                              14.0,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelLarge
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                                lineHeight: 1.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                    ))
                                                                      Text(
                                                                        allGroupsChildrenItem
                                                                            .description,
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                            ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'gridViewOnPageLoadAnimation3']!);
                                                      },
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
