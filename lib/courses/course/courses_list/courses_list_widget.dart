import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/courses/course/course_edit_dialog/course_edit_dialog_widget.dart';
import '/courses/course/courses_dialog/courses_dialog_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'courses_list_model.dart';
export 'courses_list_model.dart';

class CoursesListWidget extends StatefulWidget {
  const CoursesListWidget({
    super.key,
    required this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<CoursesListWidget> createState() => _CoursesListWidgetState();
}

class _CoursesListWidgetState extends State<CoursesListWidget>
    with TickerProviderStateMixin {
  late CoursesListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoursesListModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'coursesList'});
    _model.desktopFilterTextFieldTextController ??= TextEditingController();
    _model.desktopFilterTextFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'wrapOnPageLoadAnimation': AnimationInfo(
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
    return StreamBuilder<List<TribeCourseRecord>>(
      stream: _model.courseList(
        requestFn: () => queryTribeCourseRecord(
          queryBuilder: (tribeCourseRecord) => tribeCourseRecord
              .where(
                'groupRef',
                isEqualTo: widget!.groupDoc?.reference,
              )
              .orderBy('accessType', descending: true)
              .orderBy('createdTime'),
        ),
      )..listen((snapshot) {
          List<TribeCourseRecord> coursesListTribeCourseRecordList = snapshot;
          if (_model.coursesListPreviousSnapshot != null &&
              !const ListEquality(TribeCourseRecordDocumentEquality()).equals(
                  coursesListTribeCourseRecordList,
                  _model.coursesListPreviousSnapshot)) {
            () async {}();
          }
          _model.coursesListPreviousSnapshot = snapshot;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).appBG,
                  ),
                ),
              ),
            ),
          );
        }
        List<TribeCourseRecord> coursesListTribeCourseRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            drawer: Drawer(
              elevation: 16.0,
              child: WebViewAware(
                child: wrapWithModel(
                  model: _model.groupListDrawerContentModel,
                  updateCallback: () => safeSetState(() {}),
                  child: GroupListDrawerContentWidget(),
                ),
              ),
            ),
            appBar: responsiveVisibility(
              context: context,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).alternate,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 0.0,
                            buttonSize: 45.0,
                            icon: Icon(
                              Icons.groups,
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'COURSES_LIST_PAGE_groups_ICN_ON_TAP');
                              logFirebaseEvent('IconButton_drawer');
                              scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                        ),
                        Flexible(
                          child: Image.network(
                            widget!.groupDoc!.featuredImg,
                            width: 100.0,
                            height: 50.0,
                            fit: BoxFit.contain,
                            alignment: Alignment(0.0, 0.0),
                          ),
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
                    elevation: 0.0,
                  )
                : null,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Expanded(
                        child: wrapWithModel(
                          model: _model.topWebNavModel,
                          updateCallback: () => safeSetState(() {}),
                          child: TopWebNavWidget(
                            groupDoc: widget!.groupDoc,
                          ),
                        ),
                      ),
                  ],
                ),
                if (responsiveVisibility(
                  context: context,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  wrapWithModel(
                    model: _model.groupNavigationModel,
                    updateCallback: () => safeSetState(() {}),
                    child: GroupNavigationWidget(
                      groupDoc: widget!.groupDoc!,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      constraints: BoxConstraints(
                        maxWidth: 1440.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 30.0, 20.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (responsiveVisibility(
                                context: context,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'My Courses',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLargeFamily,
                                                fontSize: 30.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLargeFamily),
                                              ),
                                        ),
                                        Container(
                                          child: FlutterFlowChoiceChips(
                                            options: [
                                              ChipData('All'),
                                              ChipData('Group'),
                                              ChipData('Private')
                                            ],
                                            onChanged: (val) => safeSetState(() =>
                                                _model.mobileFilterChoiceChipsValue =
                                                    val?.firstOrNull),
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily),
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              iconSize: 18.0,
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily),
                                                      ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 18.0,
                                              elevation: 0.0,
                                              borderColor: Color(0x19101828),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            chipSpacing: 12.0,
                                            rowSpacing: 12.0,
                                            multiselect: false,
                                            initialized: _model
                                                    .mobileFilterChoiceChipsValue !=
                                                null,
                                            alignment: WrapAlignment.start,
                                            controller: _model
                                                    .mobileFilterChoiceChipsValueController ??=
                                                FormFieldController<
                                                    List<String>>(
                                              ['All'],
                                            ),
                                            wrapped: false,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                              ))
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'COURSES_LIST_PAGE_Text_a76ck6su_ON_TAP');
                                        if (kDebugMode) {
                                          logFirebaseEvent(
                                              'Text_custom_action');
                                          await actions.printToConsole(
                                            valueOrDefault(
                                                currentUserDocument?.tribeToken,
                                                ''),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'My Courses',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLargeFamily,
                                              fontSize: 30.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                            ),
                                      ),
                                    ),
                                    if (_model.desktopFilterTextFieldTextController
                                                .text ==
                                            null ||
                                        _model.desktopFilterTextFieldTextController
                                                .text ==
                                            '')
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: FlutterFlowChoiceChips(
                                            options: [
                                              ChipData('All'),
                                              ChipData('Group'),
                                              ChipData('Private')
                                            ],
                                            onChanged: (val) => safeSetState(() =>
                                                _model.desktopFilterChoiceChipsValue =
                                                    val?.firstOrNull),
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily),
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              iconSize: 18.0,
                                              labelPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 5.0, 8.0, 5.0),
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLargeFamily,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily),
                                                      ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 18.0,
                                              labelPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 5.0, 10.0, 5.0),
                                              elevation: 0.0,
                                              borderColor: Color(0x19101828),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            chipSpacing: 12.0,
                                            rowSpacing: 12.0,
                                            multiselect: false,
                                            initialized: _model
                                                    .desktopFilterChoiceChipsValue !=
                                                null,
                                            alignment: WrapAlignment.start,
                                            controller: _model
                                                    .desktopFilterChoiceChipsValueController ??=
                                                FormFieldController<
                                                    List<String>>(
                                              ['All'],
                                            ),
                                            wrapped: false,
                                          ),
                                        ),
                                      ),
                                    Stack(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      children: [
                                        Container(
                                          width: 320.0,
                                          child: TextFormField(
                                            controller: _model
                                                .desktopFilterTextFieldTextController,
                                            focusNode: _model
                                                .desktopFilterTextFieldFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.desktopFilterTextFieldTextController',
                                              Duration(milliseconds: 1500),
                                              () async {
                                                logFirebaseEvent(
                                                    'COURSES_LIST_desktopFilterTextField_ON_T');
                                                logFirebaseEvent(
                                                    'desktopFilterTextField_simple_search');
                                                safeSetState(() {
                                                  _model.simpleSearchResults =
                                                      TextSearch(
                                                    coursesListTribeCourseRecordList
                                                        .map(
                                                          (record) =>
                                                              TextSearchItem
                                                                  .fromTerms(
                                                                      record, [
                                                            record.title!
                                                          ]),
                                                        )
                                                        .toList(),
                                                  )
                                                          .search(_model
                                                              .desktopFilterTextFieldTextController
                                                              .text)
                                                          .map((r) => r.object)
                                                          .toList();
                                                  ;
                                                });
                                                logFirebaseEvent(
                                                    'desktopFilterTextField_set_form_field');
                                                safeSetState(() {
                                                  _model
                                                      .desktopFilterChoiceChipsValueController
                                                      ?.value = ['All'];
                                                });
                                                logFirebaseEvent(
                                                    'desktopFilterTextField_update_page_state');

                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Search',
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            Color(0xFF757B83),
                                                        fontSize: 16.0,
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
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          'Plus Jakarta Sans'),
                                                ),
                                            validator: _model
                                                .desktopFilterTextFieldTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 5.0, 5.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            borderWidth: 1.0,
                                            buttonSize: 35.0,
                                            icon: Icon(
                                              Icons.clear,
                                              color: Color(0xFF757B83),
                                              size: 18.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'COURSES_LIST_PAGE_clear_ICN_ON_TAP');
                                              logFirebaseEvent(
                                                  'IconButton_clear_text_fields_pin_codes');
                                              safeSetState(() {
                                                _model
                                                    .desktopFilterTextFieldTextController
                                                    ?.clear();
                                              });
                                              logFirebaseEvent(
                                                  'IconButton_set_form_field');
                                              safeSetState(() {
                                                _model
                                                    .desktopFilterChoiceChipsValueController
                                                    ?.value = ['All'];
                                              });
                                              logFirebaseEvent(
                                                  'IconButton_update_app_state');

                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (((valueOrDefault(
                                                    currentUserDocument
                                                        ?.userRole,
                                                    '') ==
                                                'admin') ||
                                            ((currentUserDocument?.tribeGroups
                                                            ?.toList() ??
                                                        [])
                                                    .where((e) =>
                                                        e.groupRef ==
                                                        widget!.groupDoc
                                                            ?.reference)
                                                    .toList()
                                                    .first
                                                    .role ==
                                                'admin')) &&
                                        responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                      Builder(
                                        builder: (context) =>
                                            AuthUserStreamWidget(
                                          builder: (context) => FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'COURSES_LIST_PAGE_addCourseButton_ON_TAP');
                                              logFirebaseEvent(
                                                  'addCourseButton_backend_call');

                                              var tribeCourseRecordReference =
                                                  TribeCourseRecord.collection
                                                      .doc();
                                              await tribeCourseRecordReference
                                                  .set(
                                                      createTribeCourseRecordData(
                                                groupRef:
                                                    widget!.groupDoc?.reference,
                                                createdTime:
                                                    getCurrentTimestamp,
                                                featuredImage: widget!
                                                    .groupDoc?.featuredImg,
                                                accessType: 'Group',
                                                isEmptyCourse: true,
                                              ));
                                              _model.newCourseDoc = TribeCourseRecord
                                                  .getDocumentFromData(
                                                      createTribeCourseRecordData(
                                                        groupRef: widget!
                                                            .groupDoc
                                                            ?.reference,
                                                        createdTime:
                                                            getCurrentTimestamp,
                                                        featuredImage: widget!
                                                            .groupDoc
                                                            ?.featuredImg,
                                                        accessType: 'Group',
                                                        isEmptyCourse: true,
                                                      ),
                                                      tribeCourseRecordReference);
                                              logFirebaseEvent(
                                                  'addCourseButton_alert_dialog');
                                              await showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus(),
                                                        child:
                                                            CourseEditDialogWidget(
                                                          groupDoc:
                                                              widget!.groupDoc,
                                                          courseDoc: _model
                                                              .newCourseDoc!,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              safeSetState(() {});
                                            },
                                            text: 'New Course',
                                            icon: Icon(
                                              Icons.add,
                                              size: 28.0,
                                            ),
                                            options: FFButtonOptions(
                                              height: 48.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 8.0, 15.0, 8.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFF3D4451),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily),
                                                      ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            showLoadingIndicator: false,
                                          ),
                                        ),
                                      ),
                                  ].addToEnd(SizedBox(width: 0.0)),
                                ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 34.0, 0.0, 0.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Builder(
                                      builder: (context) {
                                        final desktopGridviewChildren =
                                            (valueOrDefault(
                                                            currentUserDocument
                                                                ?.userRole,
                                                            '') ==
                                                        'admin'
                                                    ? () {
                                                        if (_model.desktopFilterTextFieldTextController
                                                                    .text !=
                                                                null &&
                                                            _model.desktopFilterTextFieldTextController
                                                                    .text !=
                                                                '') {
                                                          return _model
                                                              .simpleSearchResults;
                                                        } else if (_model
                                                                .desktopFilterChoiceChipsValue !=
                                                            'All') {
                                                          return coursesListTribeCourseRecordList
                                                              .where((e) =>
                                                                  e.accessType ==
                                                                  _model
                                                                      .desktopFilterChoiceChipsValue)
                                                              .toList();
                                                        } else {
                                                          return coursesListTribeCourseRecordList;
                                                        }
                                                      }()
                                                    : () {
                                                        if (_model.desktopFilterTextFieldTextController
                                                                    .text !=
                                                                null &&
                                                            _model.desktopFilterTextFieldTextController
                                                                    .text !=
                                                                '') {
                                                          return _model
                                                              .simpleSearchResults
                                                              .where((e) =>
                                                                  (e.accessType !=
                                                                      'Private') ||
                                                                  (currentUserDocument
                                                                              ?.privateCourses
                                                                              ?.toList() ??
                                                                          [])
                                                                      .contains(
                                                                          e.reference))
                                                              .toList();
                                                        } else if (_model
                                                                .desktopFilterChoiceChipsValue !=
                                                            'All') {
                                                          return coursesListTribeCourseRecordList
                                                              .where((e) =>
                                                                  (e.accessType ==
                                                                      _model
                                                                          .desktopFilterChoiceChipsValue) &&
                                                                  ((e.accessType !=
                                                                          'Private') ||
                                                                      (currentUserDocument?.privateCourses?.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              e.reference)))
                                                              .toList();
                                                        } else {
                                                          return coursesListTribeCourseRecordList
                                                              .where((e) =>
                                                                  (e.accessType !=
                                                                      'Private') ||
                                                                  (currentUserDocument
                                                                              ?.privateCourses
                                                                              ?.toList() ??
                                                                          [])
                                                                      .contains(
                                                                          e.reference))
                                                              .toList();
                                                        }
                                                      }())
                                                .toList();

                                        return Wrap(
                                          spacing: 20.0,
                                          runSpacing: 20.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: List.generate(
                                              desktopGridviewChildren.length,
                                              (desktopGridviewChildrenIndex) {
                                            final desktopGridviewChildrenItem =
                                                desktopGridviewChildren[
                                                    desktopGridviewChildrenIndex];
                                            return StreamBuilder<
                                                List<MembersListRecord>>(
                                              stream: queryMembersListRecord(
                                                parent:
                                                    desktopGridviewChildrenItem
                                                        .reference,
                                                queryBuilder:
                                                    (membersListRecord) =>
                                                        membersListRecord
                                                            .where(
                                                              'userRef',
                                                              isEqualTo:
                                                                  currentUserReference,
                                                            )
                                                            .where(
                                                              'role',
                                                              isEqualTo:
                                                                  'Coach',
                                                            ),
                                                singleRecord: true,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .appBG,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<MembersListRecord>
                                                    courseContainerMembersListRecordList =
                                                    snapshot.data!;
                                                final courseContainerMembersListRecord =
                                                    courseContainerMembersListRecordList
                                                            .isNotEmpty
                                                        ? courseContainerMembersListRecordList
                                                            .first
                                                        : null;

                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'COURSES_LIST_PAGE_courseContainer_ON_TAP');
                                                    logFirebaseEvent(
                                                        'courseContainer_navigate_to');

                                                    context.pushNamed(
                                                      'PostViewUserAdmin',
                                                      queryParameters: {
                                                        'groupDoc':
                                                            serializeParam(
                                                          widget!.groupDoc,
                                                          ParamType.Document,
                                                        ),
                                                        'courseDoc':
                                                            serializeParam(
                                                          desktopGridviewChildrenItem
                                                              .reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'groupDoc':
                                                            widget!.groupDoc,
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 312.0,
                                                      maxHeight: 320.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            8.0,
                                                                            8.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth:
                                                                        332.0,
                                                                    maxHeight:
                                                                        200.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Stack(
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          fadeInDuration:
                                                                              Duration(milliseconds: 500),
                                                                          fadeOutDuration:
                                                                              Duration(milliseconds: 500),
                                                                          imageUrl:
                                                                              desktopGridviewChildrenItem.featuredImage,
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 1.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorWidget: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.jpg',
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 1.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if ((valueOrDefault(currentUserDocument?.userRole, '') == 'admin') ||
                                                                          ((currentUserDocument?.tribeGroups?.toList() ?? []).where((e) => e.groupRef == widget!.groupDoc?.reference).toList().first.role ==
                                                                              'admin') ||
                                                                          (courseContainerMembersListRecord !=
                                                                              null))
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Builder(
                                                                            builder: (context) =>
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
                                                                              child: FlutterFlowIconButton(
                                                                                borderRadius: 30.0,
                                                                                borderWidth: 1.0,
                                                                                buttonSize: 30.0,
                                                                                fillColor: FlutterFlowTheme.of(context).accent2,
                                                                                icon: Icon(
                                                                                  Icons.more_vert,
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  size: 14.0,
                                                                                ),
                                                                                onPressed: () async {
                                                                                  logFirebaseEvent('COURSES_LIST_editCourseIconButton_ON_TAP');
                                                                                  logFirebaseEvent('editCourseIconButton_alert_dialog');
                                                                                  await showAlignedDialog(
                                                                                    barrierColor: Colors.transparent,
                                                                                    context: context,
                                                                                    isGlobal: false,
                                                                                    avoidOverflow: false,
                                                                                    targetAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                    followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                    builder: (dialogContext) {
                                                                                      return Material(
                                                                                        color: Colors.transparent,
                                                                                        child: WebViewAware(
                                                                                          child: GestureDetector(
                                                                                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                                                                                            child: CoursesDialogWidget(
                                                                                              courseDoc: desktopGridviewChildrenItem,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              8.0,
                                                                              8.0),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0x4D000000),
                                                                              borderRadius: BorderRadius.circular(32.0),
                                                                              border: Border.all(
                                                                                color: Color(0x22FFFFFF),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Visibility(
                                                                              visible: desktopGridviewChildrenItem.accessType == 'Private',
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 2.0),
                                                                                child: Text(
                                                                                  desktopGridviewChildrenItem.accessType,
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          20.0,
                                                                          20.0,
                                                                          8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                desktopGridviewChildrenItem
                                                                    .title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                minFontSize:
                                                                    14.0,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelLargeFamily,
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).labelLargeFamily),
                                                                      lineHeight:
                                                                          1.0,
                                                                    ),
                                                              ),
                                                            ),
                                                            if ((desktopGridviewChildrenItem
                                                                            .description !=
                                                                        null &&
                                                                    desktopGridviewChildrenItem
                                                                            .description !=
                                                                        '') &&
                                                                responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                ))
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                child: Text(
                                                                  desktopGridviewChildrenItem
                                                                      .description,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        color: Color(
                                                                            0xFF757B83),
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
                                                              ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          5.0,
                                                                          8.0,
                                                                          8.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        if (((currentUserDocument?.contentCompletedIDs?.toList() ?? []).length !=
                                                                                0) &&
                                                                            (desktopGridviewChildrenItem.contentIDs.length !=
                                                                                0)) {
                                                                          return Visibility(
                                                                            visible:
                                                                                coursesListTribeCourseRecordList.isNotEmpty,
                                                                            child:
                                                                                StreamBuilder<List<TribeContentRecord>>(
                                                                              stream: queryTribeContentRecord(
                                                                                queryBuilder: (tribeContentRecord) => tribeContentRecord.where(
                                                                                  'tribeCourseRef',
                                                                                  isEqualTo: desktopGridviewChildrenItem.reference,
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
                                                                                List<TribeContentRecord> progressContainerTribeContentRecordList = snapshot.data!;

                                                                                return Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: LinearPercentIndicator(
                                                                                          percent: valueOrDefault<double>(
                                                                                            functions.filterContentIDs((currentUserDocument?.contentCompletedIDs?.toList() ?? []).toList(), progressContainerTribeContentRecordList.toList()).length /
                                                                                                valueOrDefault<int>(
                                                                                                  desktopGridviewChildrenItem.contentIDs.length,
                                                                                                  1,
                                                                                                ),
                                                                                            0.0,
                                                                                          ),
                                                                                          lineHeight: 12.0,
                                                                                          animation: true,
                                                                                          animateFromLastPercent: true,
                                                                                          progressColor: FlutterFlowTheme.of(context).primary,
                                                                                          backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                                          barRadius: Radius.circular(32.0),
                                                                                          padding: EdgeInsets.zero,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          formatNumber(
                                                                                            functions.filterContentIDs((currentUserDocument?.contentCompletedIDs?.toList() ?? []).toList(), progressContainerTribeContentRecordList.toList()).length /
                                                                                                valueOrDefault<int>(
                                                                                                  desktopGridviewChildrenItem.contentIDs.length,
                                                                                                  1,
                                                                                                ),
                                                                                            formatType: FormatType.percent,
                                                                                          ),
                                                                                          '0%',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                            ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 6.0)),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          return Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Expanded(
                                                                                child: LinearPercentIndicator(
                                                                                  percent: 0.0,
                                                                                  lineHeight: 10.0,
                                                                                  animation: false,
                                                                                  animateFromLastPercent: true,
                                                                                  progressColor: FlutterFlowTheme.of(context).primary,
                                                                                  backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                                  barRadius: Radius.circular(32.0),
                                                                                  padding: EdgeInsets.zero,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '0%',
                                                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 6.0)),
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                        ).animateOnPageLoad(animationsMap[
                                            'wrapOnPageLoadAnimation']!);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
