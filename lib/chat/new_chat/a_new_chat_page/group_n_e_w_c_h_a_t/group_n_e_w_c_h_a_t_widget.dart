import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/new_chat/main_components/new_chat_component/new_chat_component_widget.dart';
import '/components/bottom_nav_widget.dart';
import '/components/profile_button_widget.dart';
import '/components/top_web_nav/top_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_n_e_w_c_h_a_t_model.dart';
export 'group_n_e_w_c_h_a_t_model.dart';

class GroupNEWCHATWidget extends StatefulWidget {
  const GroupNEWCHATWidget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<GroupNEWCHATWidget> createState() => _GroupNEWCHATWidgetState();
}

class _GroupNEWCHATWidgetState extends State<GroupNEWCHATWidget> {
  late GroupNEWCHATModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupNEWCHATModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'GroupNEWCHAT'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('GROUP_N_E_W_C_H_A_T_GroupNEWCHAT_ON_INIT');
      if (loggedIn) {
        logFirebaseEvent('GroupNEWCHAT_custom_action');
        await actions.triggerAppTrackingPermissionDialog();
      } else {
        logFirebaseEvent('GroupNEWCHAT_navigate_to');

        context.pushNamed('EntryPage');

        return;
      }

      logFirebaseEvent('GroupNEWCHAT_wait__delay');
      await Future.delayed(const Duration(milliseconds: 1200));
      logFirebaseEvent('GroupNEWCHAT_update_app_state');
      FFAppState().userGroupsID =
          (currentUserDocument?.tribeGroups?.toList() ?? [])
              .map((e) => e.tribeGroupID)
              .toList()
              .toList()
              .cast<int>();
      safeSetState(() {});
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
    context.watch<FFAppState>();

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
                        Icons.refresh,
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'GROUP_N_E_W_C_H_A_T_refresh_ICN_ON_TAP');
                        logFirebaseEvent('IconButton_navigate_to');

                        context.pushNamed('ReturningRedirect');
                      },
                    ),
                    CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeOutDuration: Duration(milliseconds: 300),
                      imageUrl: valueOrDefault<String>(
                        functions.stringToImgPath(
                            getRemoteConfigString('AppLogoDark')),
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/lg0etvjtmesz/Tribe_2023_TM_Dark_trim.png',
                      ),
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
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
                        child: TopWebNavWidget(),
                      ),
                    ),
                ],
              ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            valueOrDefault<double>(
                              () {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return 20.0;
                                } else if (MediaQuery.sizeOf(context).width <
                                    1200.0) {
                                  return 40.0;
                                } else {
                                  return 100.0;
                                }
                              }(),
                              100.0,
                            ),
                            valueOrDefault<double>(
                              MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium
                                  ? 20.0
                                  : 40.0,
                              40.0,
                            ),
                            valueOrDefault<double>(
                              () {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return 20.0;
                                } else if (MediaQuery.sizeOf(context).width <
                                    1200.0) {
                                  return 40.0;
                                } else {
                                  return 100.0;
                                }
                              }(),
                              100.0,
                            ),
                            valueOrDefault<double>(
                              MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium
                                  ? 20.0
                                  : 40.0,
                              40.0,
                            )),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<ConversationsRecord>>(
                              stream: queryConversationsRecord(
                                queryBuilder: (conversationsRecord) =>
                                    conversationsRecord
                                        .where(
                                          'Users',
                                          arrayContains: currentUserReference,
                                        )
                                        .orderBy('LastMessageTime',
                                            descending: true),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).appBG,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<ConversationsRecord>
                                    newChatComponentConversationsRecordList =
                                    snapshot.data!;

                                return wrapWithModel(
                                  model: _model.newChatComponentModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: NewChatComponentWidget(
                                    conversations:
                                        newChatComponentConversationsRecordList,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            ))
              wrapWithModel(
                model: _model.bottomNavModel,
                updateCallback: () => safeSetState(() {}),
                child: BottomNavWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
