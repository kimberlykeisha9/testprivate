import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/chat/message_container/message_container_widget.dart';
import '/components/empty_chat/empty_chat_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'chat_thread_component_model.dart';
export 'chat_thread_component_model.dart';

class ChatThreadComponentWidget extends StatefulWidget {
  const ChatThreadComponentWidget({
    super.key,
    this.chatRef,
  });

  final DirectMessagesChatRecord? chatRef;

  @override
  State<ChatThreadComponentWidget> createState() =>
      _ChatThreadComponentWidgetState();
}

class _ChatThreadComponentWidgetState extends State<ChatThreadComponentWidget> {
  late ChatThreadComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
              child: StreamBuilder<List<DirectMessagesRecord>>(
                stream: queryDirectMessagesRecord(
                  queryBuilder: (directMessagesRecord) => directMessagesRecord
                      .where(
                        'chat',
                        isEqualTo: widget!.chatRef?.reference,
                      )
                      .orderBy('timestamp', descending: true),
                  limit: 200,
                )..listen((snapshot) {
                    List<DirectMessagesRecord>
                        listViewDirectMessagesRecordList = snapshot;
                    if (_model.listViewPreviousSnapshot != null &&
                        !const ListEquality(
                                DirectMessagesRecordDocumentEquality())
                            .equals(listViewDirectMessagesRecordList,
                                _model.listViewPreviousSnapshot)) {
                      () async {
                        logFirebaseEvent(
                            'CHAT_THREAD_COMPONENT_ListView_xu8iwosq_');
                        if (!widget!.chatRef!.lastMessageSeenBy
                            .contains(currentUserReference)) {
                          logFirebaseEvent('ListView_backend_call');

                          await widget!.chatRef!.reference.update({
                            ...mapToFirestore(
                              {
                                'last_message_seen_by': FieldValue.arrayUnion(
                                    [currentUserReference]),
                              },
                            ),
                          });
                        }

                        safeSetState(() {});
                      }();
                    }
                    _model.listViewPreviousSnapshot = snapshot;
                  }),
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
                  List<DirectMessagesRecord> listViewDirectMessagesRecordList =
                      snapshot.data!;
                  if (listViewDirectMessagesRecordList.isEmpty) {
                    return Center(
                      child: Container(
                        width: 350.0,
                        child: EmptyChatWidget(),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      12.0,
                      0,
                      24.0,
                    ),
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewDirectMessagesRecordList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.0),
                    itemBuilder: (context, listViewIndex) {
                      final listViewDirectMessagesRecord =
                          listViewDirectMessagesRecordList[listViewIndex];
                      return MessageContainerWidget(
                        key: Key(
                            'Key8j8_${listViewIndex}_of_${listViewDirectMessagesRecordList.length}'),
                        chatMessagesRef: listViewDirectMessagesRecord,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    -2.0,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if ((_model.uploadedFileUrl != null &&
                        _model.uploadedFileUrl != '') &&
                    responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlutterFlowMediaDisplay(
                                  path: _model.uploadedFileUrl,
                                  imageBuilder: (path) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          Duration(milliseconds: 500),
                                      imageUrl: path,
                                      width: 120.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  videoPlayerBuilder: (path) =>
                                      FlutterFlowVideoPlayer(
                                    path: path,
                                    width: 300.0,
                                    autoPlay: false,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).error,
                                    borderRadius: 20.0,
                                    borderWidth: 2.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: FlutterFlowTheme.of(context).error,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CHAT_THREAD_COMPONENT_delete_outline_rou');
                                      logFirebaseEvent(
                                          'IconButton_clear_uploaded_data');
                                      safeSetState(() {
                                        _model.isDataUploading = false;
                                        _model.uploadedLocalFile =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl = '';
                                      });
                                    },
                                  ),
                                ),
                              ]
                                  .divide(SizedBox(width: 8.0))
                                  .addToStart(SizedBox(width: 16.0))
                                  .addToEnd(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (_model.uploadedFileUrl != null &&
                            _model.uploadedFileUrl != '')
                          Container(
                            width: 300.0,
                            height: 200.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (functions.checkAttachmentType(
                                              _model.uploadedFileUrl) ==
                                          'image') {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            _model.uploadedFileUrl,
                                            width: 300.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else if (functions.checkAttachmentType(
                                              _model.uploadedFileUrl) ==
                                          'video') {
                                        return FlutterFlowVideoPlayer(
                                          path: _model.uploadedFileUrl,
                                          videoType: VideoType.network,
                                          width: 300.0,
                                          height: 200.0,
                                          autoPlay: true,
                                          looping: true,
                                          showControls: true,
                                          allowFullScreen: false,
                                          allowPlaybackSpeedMenu: false,
                                        );
                                      } else {
                                        return Container(
                                          width: 300.0,
                                          height: 200.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .gray200,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.attach_file,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 32.0,
                                                ),
                                                Flexible(
                                                  child: AutoSizeText(
                                                    'Uploaded: ${functions.extractAttachmentFileName(_model.uploadedFileUrl)}',
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: MouseRegion(
                                                    opaque: true,
                                                    cursor: SystemMouseCursors
                                                            .click ??
                                                        MouseCursor.defer,
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
                                                            'CHAT_THREAD_COMPONENT_Text_pgjtw6my_ON_T');
                                                        logFirebaseEvent(
                                                            'Text_launch_u_r_l');
                                                        await launchURL(_model
                                                            .uploadedFileUrl);
                                                      },
                                                      child: Text(
                                                        'Click to preview',
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
                                                                      .primary,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                    ),
                                                    onEnter: ((event) async {
                                                      safeSetState(() => _model
                                                              .mouseRegionHovered =
                                                          true);
                                                    }),
                                                    onExit: ((event) async {
                                                      safeSetState(() => _model
                                                              .mouseRegionHovered =
                                                          false);
                                                    }),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 80.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).error,
                                    icon: Icon(
                                      Icons.delete,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 24.0,
                                    ),
                                    showLoadingIndicator: true,
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CHAT_THREAD_COMPONENT_delete_ICN_ON_TAP');
                                      logFirebaseEvent(
                                          'IconButton_alert_dialog');
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          'Delete Attachment'),
                                                      content: Text(
                                                          'Are you sure you want to delete this attachment?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child: Text('Delete'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        logFirebaseEvent(
                                            'IconButton_clear_uploaded_data');
                                        safeSetState(() {
                                          _model.isDataUploading = false;
                                          _model.uploadedLocalFile =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl = '';
                                        });

                                        return;
                                      } else {
                                        return;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderRadius: 60.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              fillColor: Colors.white,
                              icon: Icon(
                                Icons.attach_file,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CHAT_THREAD_COMPONENT_attach_file_ICN_ON');
                                logFirebaseEvent(
                                    'IconButton_upload_file_to_firebase');
                                final selectedFiles = await selectFiles(
                                  multiFile: false,
                                );
                                if (selectedFiles != null) {
                                  safeSetState(
                                      () => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  var downloadUrls = <String>[];
                                  try {
                                    showUploadMessage(
                                      context,
                                      'Uploading file...',
                                      showLoading: true,
                                    );
                                    selectedUploadedFiles = selectedFiles
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedFiles.map(
                                        (f) async => await uploadData(
                                            f.storagePath, f.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    _model.isDataUploading = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedFiles.length &&
                                      downloadUrls.length ==
                                          selectedFiles.length) {
                                    safeSetState(() {
                                      _model.uploadedLocalFile =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl =
                                          downloadUrls.first;
                                    });
                                    showUploadMessage(
                                      context,
                                      'Success!',
                                    );
                                  } else {
                                    safeSetState(() {});
                                    showUploadMessage(
                                      context,
                                      'Failed to upload file',
                                    );
                                    return;
                                  }
                                }

                                if (_model.uploadedFileUrl != null &&
                                    _model.uploadedFileUrl != '') {
                                  logFirebaseEvent(
                                      'IconButton_update_component_state');
                                  _model.addToImagesUploaded(
                                      _model.uploadedFileUrl);
                                  safeSetState(() {});
                                }
                              },
                            ),
                            Flexible(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        onFieldSubmitted: (_) async {
                                          logFirebaseEvent(
                                              'CHAT_THREAD_COMPONENT_TextField_9amzs4wj');
                                          logFirebaseEvent(
                                              'TextField_validate_form');
                                          if (_model.formKey.currentState ==
                                                  null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          // newChatMessage
                                          logFirebaseEvent(
                                              'TextField_newChatMessage');

                                          var directMessagesRecordReference =
                                              DirectMessagesRecord.collection
                                                  .doc();
                                          await directMessagesRecordReference
                                              .set(
                                                  createDirectMessagesRecordData(
                                            user: currentUserReference,
                                            chat: widget!.chatRef?.reference,
                                            text: _model.textController.text,
                                            timestamp: getCurrentTimestamp,
                                            attachmentLink:
                                                _model.uploadedFileUrl,
                                          ));
                                          _model.newChatCopy = DirectMessagesRecord
                                              .getDocumentFromData(
                                                  createDirectMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget!
                                                        .chatRef?.reference,
                                                    text: _model
                                                        .textController.text,
                                                    timestamp:
                                                        getCurrentTimestamp,
                                                    attachmentLink:
                                                        _model.uploadedFileUrl,
                                                  ),
                                                  directMessagesRecordReference);
                                          // clearUsers
                                          logFirebaseEvent(
                                              'TextField_clearUsers');
                                          _model.lastSeenBy = [];
                                          // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                          //
                                          // We will then set the value of the user reference list from this page state.
                                          // addMyUserToList
                                          logFirebaseEvent(
                                              'TextField_addMyUserToList');
                                          _model.addToLastSeenBy(
                                              currentUserReference!);
                                          // updateChatDocument
                                          logFirebaseEvent(
                                              'TextField_updateChatDocument');

                                          await widget!.chatRef!.reference
                                              .update({
                                            ...createDirectMessagesChatRecordData(
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSentBy:
                                                  currentUserReference,
                                              lastMessage:
                                                  _model.textController.text,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'last_message_seen_by':
                                                    _model.lastSeenBy,
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'TextField_clear_text_fields_pin_codes');
                                          safeSetState(() {
                                            _model.textController?.clear();
                                          });
                                          logFirebaseEvent(
                                              'TextField_clear_uploaded_data');
                                          safeSetState(() {
                                            _model.isDataUploading = false;
                                            _model.uploadedLocalFile =
                                                FFUploadedFile(
                                                    bytes:
                                                        Uint8List.fromList([]));
                                            _model.uploadedFileUrl = '';
                                          });

                                          logFirebaseEvent(
                                              'TextField_update_component_state');
                                          _model.imagesUploaded = [];
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        autofocus: true,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.send,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Start typing here...',
                                          errorStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 16.0, 56.0, 16.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                        maxLines: null,
                                        minLines: 1,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        validator: _model
                                            .textControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 6.0, 4.0),
                                      child: FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        borderRadius: 20.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .accent1,
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CHAT_THREAD_COMPONENT_send_rounded_ICN_O');
                                          final firestoreBatch =
                                              FirebaseFirestore.instance
                                                  .batch();
                                          try {
                                            logFirebaseEvent(
                                                'IconButton_validate_form');
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            // newChatMessage
                                            logFirebaseEvent(
                                                'IconButton_newChatMessage');

                                            var directMessagesRecordReference =
                                                DirectMessagesRecord.collection
                                                    .doc();
                                            firestoreBatch.set(
                                                directMessagesRecordReference,
                                                createDirectMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: widget!
                                                      .chatRef?.reference,
                                                  text: _model
                                                      .textController.text,
                                                  timestamp:
                                                      getCurrentTimestamp,
                                                  attachmentLink:
                                                      _model.uploadedFileUrl,
                                                ));
                                            _model.newChat = DirectMessagesRecord
                                                .getDocumentFromData(
                                                    createDirectMessagesRecordData(
                                                      user:
                                                          currentUserReference,
                                                      chat: widget!
                                                          .chatRef?.reference,
                                                      text: _model
                                                          .textController.text,
                                                      timestamp:
                                                          getCurrentTimestamp,
                                                      attachmentLink: _model
                                                          .uploadedFileUrl,
                                                    ),
                                                    directMessagesRecordReference);
                                            // clearUsers
                                            logFirebaseEvent(
                                                'IconButton_clearUsers');
                                            _model.lastSeenBy = [];
                                            // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                            //
                                            // We will then set the value of the user reference list from this page state.
                                            // addMyUserToList
                                            logFirebaseEvent(
                                                'IconButton_addMyUserToList');
                                            _model.addToLastSeenBy(
                                                currentUserReference!);
                                            // updateChatDocument
                                            logFirebaseEvent(
                                                'IconButton_updateChatDocument');

                                            firestoreBatch.update(
                                                widget!.chatRef!.reference, {
                                              ...createDirectMessagesChatRecordData(
                                                lastMessageTime:
                                                    getCurrentTimestamp,
                                                lastMessageSentBy:
                                                    currentUserReference,
                                                lastMessage:
                                                    _model.textController.text,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'last_message_seen_by':
                                                      _model.lastSeenBy,
                                                },
                                              ),
                                            });
                                            logFirebaseEvent(
                                                'IconButton_clear_text_fields_pin_codes');
                                            safeSetState(() {
                                              _model.textController?.clear();
                                            });
                                            logFirebaseEvent(
                                                'IconButton_clear_uploaded_data');
                                            safeSetState(() {
                                              _model.isDataUploading = false;
                                              _model.uploadedLocalFile =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                              _model.uploadedFileUrl = '';
                                            });

                                            logFirebaseEvent(
                                                'IconButton_update_component_state');
                                            _model.imagesUploaded = [];
                                            safeSetState(() {});
                                          } finally {
                                            await firestoreBatch.commit();
                                          }

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
                      ].divide(SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
