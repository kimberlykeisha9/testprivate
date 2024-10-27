import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/group_list_drawer_content/group_list_drawer_content_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/pages/groups/group_components/group_sidebar/group_sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'groups_events2_model.dart';
export 'groups_events2_model.dart';

class GroupsEvents2Widget extends StatefulWidget {
  const GroupsEvents2Widget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupsEvents2Widget> createState() => _GroupsEvents2WidgetState();
}

class _GroupsEvents2WidgetState extends State<GroupsEvents2Widget> {
  late GroupsEvents2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupsEvents2Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupsEvents2'});
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
                              'GROUPS_EVENTS2_groups_rounded_ICN_ON_TAP');
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
                            'GROUPS_EVENTS2_Image_lzjdaleq_ON_LONG_PR');
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
                              'GROUPS_EVENTS2_PAGE_Text_g1g1zw3p_ON_TAP');
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
        body: Container(
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
                tabletLandscape: false,
              ))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                  child: wrapWithModel(
                    model: _model.topWebNavModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopWebNavWidget(
                      groupDoc: widget!.groupDoc,
                    ),
                  ),
                ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    constraints: BoxConstraints(
                      maxWidth: 1000.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                  if (widget!.groupDoc?.addEventUrl != null &&
                                      widget!.groupDoc?.addEventUrl != '')
                                    FlutterFlowWebView(
                                      content: valueOrDefault<String>(
                                        widget!.groupDoc?.addEventUrl,
                                        'https://www.addevent.com/calendar/nI635763',
                                      ),
                                      bypass: false,
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.8,
                                      verticalScroll: true,
                                      horizontalScroll: false,
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
    );
  }
}
