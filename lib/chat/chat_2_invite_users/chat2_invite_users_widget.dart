import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/empty_state_simple/empty_state_simple_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'chat2_invite_users_model.dart';
export 'chat2_invite_users_model.dart';

class Chat2InviteUsersWidget extends StatefulWidget {
  const Chat2InviteUsersWidget({
    super.key,
    this.chatRef,
  });

  final DirectMessagesChatRecord? chatRef;

  @override
  State<Chat2InviteUsersWidget> createState() => _Chat2InviteUsersWidgetState();
}

class _Chat2InviteUsersWidgetState extends State<Chat2InviteUsersWidget> {
  late Chat2InviteUsersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Chat2InviteUsersModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'chat_2_InviteUsers'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHAT_2_INVITE_USERS_chat_2_InviteUsers_O');
      // Add user to userPair
      logFirebaseEvent('chat_2_InviteUsers_AddusertouserPair');
      _model.addToUserPair(currentUserReference!);
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? AppBar(
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                iconTheme:
                    IconThemeData(color: FlutterFlowTheme.of(context).primary),
                automaticallyImplyLeading: true,
                title: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite Friends',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineSmallFamily),
                              ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        'Select users from below to start a chat.',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelSmallFamily),
                            ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 4.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderRadius: 12.0,
                      borderWidth: 1.0,
                      buttonSize: 44.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.close_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'CHAT_2_INVITE_USERS_close_rounded_ICN_ON');
                        logFirebaseEvent('IconButton_navigate_back');
                        context.safePop();
                      },
                    ),
                  ),
                ],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: Stack(
          children: [
            StreamBuilder<List<UserRecord>>(
              stream: queryUserRecord(
                queryBuilder: (userRecord) =>
                    userRecord.orderBy('display_name'),
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
                List<UserRecord> containerUserRecordList = snapshot.data!
                    .where((u) => u.uid != currentUserUid)
                    .toList();

                return Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 0.0, 0.0),
                        child: Text(
                          'Select user to start chat',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelMediumFamily),
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              Duration(milliseconds: 2000),
                              () async {
                                logFirebaseEvent(
                                    'CHAT_2_INVITE_USERS_TextField_y9pyximi_O');
                                logFirebaseEvent('TextField_simple_search');
                                await queryUserRecordOnce()
                                    .then(
                                      (records) => _model
                                          .simpleSearchResults = TextSearch(
                                        records
                                            .map(
                                              (record) =>
                                                  TextSearchItem.fromTerms(
                                                      record, [
                                                record.email!,
                                                record.displayName!
                                              ]),
                                            )
                                            .toList(),
                                      )
                                          .search(_model.textController.text)
                                          .map((r) => r.object)
                                          .take(20)
                                          .toList(),
                                    )
                                    .onError((_, __) =>
                                        _model.simpleSearchResults = [])
                                    .whenComplete(() => safeSetState(() {}));
                              },
                            ),
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelMediumFamily),
                                  ),
                              hintText: 'Search People...',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: Color(0x97222222),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelMediumFamily),
                                    lineHeight: 1.0,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).accent2,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                  lineHeight: 1.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final containerVar =
                                  (_model.textController.text != null &&
                                              _model.textController.text != ''
                                          ? _model.simpleSearchResults
                                          : containerUserRecordList)
                                      .toList();
                              if (containerVar.isEmpty) {
                                return EmptyStateSimpleWidget(
                                  icon: Icon(
                                    Icons.groups_outlined,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 90.0,
                                  ),
                                  title: 'No Friends',
                                  body: 'No users exist to create a chat with.',
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  160.0,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: containerVar.length,
                                itemBuilder: (context, containerVarIndex) {
                                  final containerVarItem =
                                      containerVar[containerVarIndex];
                                  return Visibility(
                                    visible: containerVarItem.reference !=
                                        currentUserReference,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 8.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 70.0,
                                        decoration: BoxDecoration(
                                          color: _model.userPair.contains(
                                                  containerVarItem.reference)
                                              ? FlutterFlowTheme.of(context)
                                                  .accent1
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: _model.userPair.contains(
                                                    containerVarItem.reference)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 44.0,
                                                height: 44.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(
                                                          milliseconds: 200),
                                                      fadeOutDuration: Duration(
                                                          milliseconds: 200),
                                                      imageUrl: containerVarItem
                                                          .photoUrl,
                                                      width: 44.0,
                                                      height: 44.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'CHAT_2_INVITE_USERS_Column_mgu3vo76_ON_T');
                                                // addUser
                                                logFirebaseEvent(
                                                    'Column_addUser');
                                                _model.addToUserPair(
                                                    containerVarItem.reference);
                                                safeSetState(() {});
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    containerVarItem.displayName
                                                        .maybeHandleOverflow(
                                                      maxChars: 20,
                                                      replacement: '…',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLargeFamily,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeFamily),
                                                        ),
                                                  ),
                                                  Text(
                                                    containerVarItem.email
                                                        .maybeHandleOverflow(
                                                      maxChars: 40,
                                                      replacement: '…',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmallFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmallFamily),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
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
                );
              },
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                width: double.infinity,
                height: 140.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).accent4,
                      FlutterFlowTheme.of(context).secondaryBackground
                    ],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CHAT_2_INVITE_USERS_SEND_INVITES_BTN_ON_');
                      var _shouldSetState = false;
                      if (_model.userPair.length >= 2) {
                        if (widget!.chatRef != null) {
                          // updateChat
                          logFirebaseEvent('Button_updateChat');

                          await widget!.chatRef!.reference.update({
                            ...mapToFirestore(
                              {
                                'users': _model.userPair,
                              },
                            ),
                          });
                          // updateChat
                          logFirebaseEvent('Button_updateChat');
                          _model.updatedChatThread =
                              await queryDirectMessagesChatRecordOnce(
                            queryBuilder: (directMessagesChatRecord) =>
                                directMessagesChatRecord.where(
                              'group_chat_id',
                              isEqualTo: widget!.chatRef?.groupChatId,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _shouldSetState = true;
                          logFirebaseEvent('Button_navigate_to');
                          if (Navigator.of(context).canPop()) {
                            context.pop();
                          }
                          context.pushNamed(
                            'chat_2_main',
                            queryParameters: {
                              'chat': serializeParam(
                                _model.updatedChatThread,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'chat': _model.updatedChatThread,
                            },
                          );
                        } else {
                          // newChat
                          logFirebaseEvent('Button_newChat');

                          var directMessagesChatRecordReference =
                              DirectMessagesChatRecord.collection.doc();
                          await directMessagesChatRecordReference.set({
                            ...createDirectMessagesChatRecordData(
                              lastMessage: '',
                              lastMessageTime: getCurrentTimestamp,
                              lastMessageSentBy: currentUserReference,
                              groupChatId:
                                  random_data.randomInteger(1000000, 9999999),
                            ),
                            ...mapToFirestore(
                              {
                                'users': _model.userPair,
                              },
                            ),
                          });
                          _model.newChatThread =
                              DirectMessagesChatRecord.getDocumentFromData({
                            ...createDirectMessagesChatRecordData(
                              lastMessage: '',
                              lastMessageTime: getCurrentTimestamp,
                              lastMessageSentBy: currentUserReference,
                              groupChatId:
                                  random_data.randomInteger(1000000, 9999999),
                            ),
                            ...mapToFirestore(
                              {
                                'users': _model.userPair,
                              },
                            ),
                          }, directMessagesChatRecordReference);
                          _shouldSetState = true;
                          logFirebaseEvent('Button_navigate_to');
                          if (Navigator.of(context).canPop()) {
                            context.pop();
                          }
                          context.pushNamed(
                            'chat_2_main',
                            queryParameters: {
                              'chat': serializeParam(
                                _model.newChatThread,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'chat': _model.newChatThread,
                            },
                          );
                        }

                        if (_shouldSetState) safeSetState(() {});
                        return;
                      } else {
                        logFirebaseEvent('Button_show_snack_bar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You must select at least one other user to start a chat.',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                            ),
                            duration: Duration(milliseconds: 3000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                          ),
                        );
                        if (_shouldSetState) safeSetState(() {});
                        return;
                      }

                      if (_shouldSetState) safeSetState(() {});
                    },
                    text:
                        widget!.chatRef != null ? 'Add to Chat' : 'Send Invite',
                    options: FFButtonOptions(
                      width: 300.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
