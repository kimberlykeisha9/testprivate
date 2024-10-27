import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'groups_next_steps_model.dart';
export 'groups_next_steps_model.dart';

class GroupsNextStepsWidget extends StatefulWidget {
  const GroupsNextStepsWidget({
    super.key,
    this.groupName,
    this.groupCoverImg,
    this.currentUserRole,
    this.groupSlug,
    this.groupId,
    int? openTab,
    this.groupDoc,
    this.groupRef,
  }) : this.openTab = openTab ?? 0;

  final String? groupName;
  final String? groupCoverImg;
  final String? currentUserRole;
  final String? groupSlug;
  final int? groupId;
  final int openTab;
  final TribeGroupsRecord? groupDoc;
  final DocumentReference? groupRef;

  @override
  State<GroupsNextStepsWidget> createState() => _GroupsNextStepsWidgetState();
}

class _GroupsNextStepsWidgetState extends State<GroupsNextStepsWidget> {
  late GroupsNextStepsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupsNextStepsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupsNextSteps'});
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
        backgroundColor: FlutterFlowTheme.of(context).appBG,
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
                ) &&
                (MediaQuery.sizeOf(context).width < 768.0)
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 0.0,
                        buttonSize: 45.0,
                        icon: Icon(
                          Icons.groups_rounded,
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'GROUPS_NEXT_STEPS_groups_rounded_ICN_ON_');
                          logFirebaseEvent('IconButton_drawer');
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onLongPress: () async {
                        logFirebaseEvent(
                            'GROUPS_NEXT_STEPS_Image_k2hh6aur_ON_LONG');
                        logFirebaseEvent('Image_update_app_state');
                        FFAppState().deleteUserID();
                        FFAppState().userID = 0;

                        FFAppState().deleteCurrentUserGroupList();
                        FFAppState().currentUserGroupList = [];

                        FFAppState().update(() {});
                        logFirebaseEvent('Image_auth');
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        logFirebaseEvent('Image_navigate_to');

                        context.pushNamedAuth('EntryPage', context.mounted);
                      },
                      child: Image.network(
                        widget!.groupDoc!.featuredImg,
                        width: 100.0,
                        height: 50.0,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'GROUPS_NEXT_STEPS_Text_14akb5zd_ON_TAP');
                          logFirebaseEvent('Text_navigate_to');

                          context.pushNamed(
                            'EditGroupAdmin',
                            queryParameters: {
                              'groupRef': serializeParam(
                                widget!.groupDoc?.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Text(
                          'EDIT GROUP',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
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
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                      child: wrapWithModel(
                        model: _model.topWebNavModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TopWebNavWidget(
                          groupDoc: widget!.groupDoc,
                        ),
                      ),
                    ),
                  Flexible(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      constraints: BoxConstraints(
                        maxWidth: 1000.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                width: 800.0,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                constraints: BoxConstraints(
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (responsiveVisibility(
                                        context: context,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        wrapWithModel(
                                          model: _model.groupNavigationModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: GroupNavigationWidget(
                                            groupDoc: widget!.groupDoc!,
                                          ),
                                        ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 15.0, 50.0),
                                          child: Builder(
                                            builder: (context) {
                                              final nextSteps = widget!
                                                      .groupDoc?.nextSteps
                                                      ?.toList() ??
                                                  [];

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.vertical,
                                                itemCount: nextSteps.length,
                                                itemBuilder:
                                                    (context, nextStepsIndex) {
                                                  final nextStepsItem =
                                                      nextSteps[nextStepsIndex];
                                                  return Visibility(
                                                    visible: !nextStepsItem
                                                        .featureOnToday,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  15.0,
                                                                  0.0,
                                                                  15.0),
                                                      child: InkWell(
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
                                                              'GROUPS_NEXT_STEPS_Row_2vs87ctn_ON_TAP');
                                                          if (valueOrDefault<
                                                              bool>(
                                                            nextStepsItem
                                                                        .ctaText !=
                                                                    null &&
                                                                nextStepsItem
                                                                        .ctaText !=
                                                                    '',
                                                            false,
                                                          )) {
                                                            logFirebaseEvent(
                                                                'Row_launch_u_r_l');
                                                            await launchURL(
                                                                nextStepsItem
                                                                    .ctaLink);
                                                            return;
                                                          } else {
                                                            return;
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  nextStepsItem
                                                                      .featuredImage,
                                                                  'https://ik.imagekit.io/wisdomly/1673219311792.png?tr=h-288',
                                                                ),
                                                                width: 120.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 5,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      nextStepsItem
                                                                          .title,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey('Open Sans'),
                                                                            lineHeight:
                                                                                1.1,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      nextStepsItem
                                                                          .description,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey('Open Sans'),
                                                                          ),
                                                                    ),
                                                                    if (valueOrDefault<
                                                                        bool>(
                                                                      nextStepsItem.ctaText !=
                                                                              null &&
                                                                          nextStepsItem.ctaText !=
                                                                              '',
                                                                      false,
                                                                    ))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            logFirebaseEvent('GROUPS_NEXT_STEPS_LEARN_MORE_BTN_ON_TAP');
                                                                            logFirebaseEvent('Button_launch_u_r_l');
                                                                            await launchURL(nextStepsItem.ctaLink);
                                                                          },
                                                                          text:
                                                                              nextStepsItem.ctaText,
                                                                          options:
                                                                              FFButtonOptions(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                7.0,
                                                                                0.0,
                                                                                7.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                  color: Colors.white,
                                                                                  fontSize: 15.0,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 0.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                          ),
                                                                          showLoadingIndicator:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    wrapWithModel(
                                      model: _model.groupSidebarModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: GroupSidebarWidget(
                                        groupDoc: widget!.groupDoc!,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
