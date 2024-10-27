import '/acme_chat/audio/audio_player/audio_player_widget.dart';
import '/acme_chat/audio/audio_record_button/audio_record_button_widget.dart';
import '/acme_chat/general/acme_button/acme_button_widget.dart';
import '/acme_chat/general/empty_state/empty_state_widget.dart';
import '/acme_chat/message_types/received_message/received_message_widget.dart';
import '/acme_chat/message_types/reply_to_message/reply_to_message_widget.dart';
import '/acme_chat/message_types/sent_message/sent_message_widget.dart';
import '/acme_chat/overlays/message_options/message_options_widget.dart';
import '/acme_chat/overlays/upload_media_options/upload_media_options_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'messages_component_widget.dart' show MessagesComponentWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MessagesComponentModel extends FlutterFlowModel<MessagesComponentWidget> {
  ///  Local state fields for this component.

  MessagesRecord? replyingMessage;

  bool replyingVisible = true;

  MessagesRecord? detailsMessage;

  bool detailsVisible = false;

  List<String> uploadingImages = [];
  void addToUploadingImages(String item) => uploadingImages.add(item);
  void removeFromUploadingImages(String item) => uploadingImages.remove(item);
  void removeAtIndexFromUploadingImages(int index) =>
      uploadingImages.removeAt(index);
  void insertAtIndexInUploadingImages(int index, String item) =>
      uploadingImages.insert(index, item);
  void updateUploadingImagesAtIndex(int index, Function(String) updateFn) =>
      uploadingImages[index] = updateFn(uploadingImages[index]);

  String? uploadingVideo;

  String? uploadingAudio;

  bool viewArchive = false;

  bool searchVisible = false;

  bool audioRecording = false;

  bool typing = false;

  int? clearingImagesIndex = 0;

  List<MessagesRecord> messagesList = [];
  void addToMessagesList(MessagesRecord item) => messagesList.add(item);
  void removeFromMessagesList(MessagesRecord item) => messagesList.remove(item);
  void removeAtIndexFromMessagesList(int index) => messagesList.removeAt(index);
  void insertAtIndexInMessagesList(int index, MessagesRecord item) =>
      messagesList.insert(index, item);
  void updateMessagesListAtIndex(
          int index, Function(MessagesRecord) updateFn) =>
      messagesList[index] = updateFn(messagesList[index]);

  bool sendingMessage = false;

  bool draftMessageSet = false;

  String? uploadingFile;

  ///  State fields for stateful widgets in this component.

  List<MessagesRecord>? messagesPreviousSnapshot;
  // Model for emptyState component.
  late EmptyStateModel emptyStateModel;
  // Models for SentMessage dynamic component.
  late FlutterFlowDynamicModels<SentMessageModel> sentMessageModels;
  // Models for ReceivedMessage dynamic component.
  late FlutterFlowDynamicModels<ReceivedMessageModel> receivedMessageModels;
  // Model for ReplyToMessage component.
  late ReplyToMessageModel replyToMessageModel;
  // Model for AudioPlayer component.
  late AudioPlayerModel audioPlayerModel;
  // State field(s) for MessageInput widget.
  FocusNode? messageInputFocusNode;
  TextEditingController? messageInputTextController;
  String? Function(BuildContext, String?)? messageInputTextControllerValidator;
  // Model for PhotoUpload.
  late AcmeButtonModel photoUploadModel;
  bool isDataUploading1 = false;
  List<FFUploadedFile> uploadedLocalFiles1 = [];
  List<String> uploadedFileUrls1 = [];

  // Model for VideoUpload.
  late AcmeButtonModel videoUploadModel;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Model for FileUpload.
  late AcmeButtonModel fileUploadModel;
  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  // Model for AudioRecordButton component.
  late AudioRecordButtonModel audioRecordButtonModel;
  // Model for MobileOptions.
  late AcmeButtonModel mobileOptionsModel;
  // Model for SendButton.
  late AcmeButtonModel sendButtonModel;
  // Stores action output result for [Backend Call - Create Document] action in SendButton widget.
  MessagesRecord? newMessageText;
  // Stores action output result for [Backend Call - Create Document] action in SendButton widget.
  MessagesRecord? newMessageImages;
  // Stores action output result for [Backend Call - Create Document] action in SendButton widget.
  MessagesRecord? newMessageVideo;
  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl4 = '';

  // Stores action output result for [Backend Call - Create Document] action in SendButton widget.
  MessagesRecord? newMessageAudio;
  // Stores action output result for [Backend Call - Create Document] action in SendButton widget.
  MessagesRecord? newMessageFile;

  @override
  void initState(BuildContext context) {
    emptyStateModel = createModel(context, () => EmptyStateModel());
    sentMessageModels = FlutterFlowDynamicModels(() => SentMessageModel());
    receivedMessageModels =
        FlutterFlowDynamicModels(() => ReceivedMessageModel());
    replyToMessageModel = createModel(context, () => ReplyToMessageModel());
    audioPlayerModel = createModel(context, () => AudioPlayerModel());
    photoUploadModel = createModel(context, () => AcmeButtonModel());
    videoUploadModel = createModel(context, () => AcmeButtonModel());
    fileUploadModel = createModel(context, () => AcmeButtonModel());
    audioRecordButtonModel =
        createModel(context, () => AudioRecordButtonModel());
    mobileOptionsModel = createModel(context, () => AcmeButtonModel());
    sendButtonModel = createModel(context, () => AcmeButtonModel());
  }

  @override
  void dispose() {
    emptyStateModel.dispose();
    sentMessageModels.dispose();
    receivedMessageModels.dispose();
    replyToMessageModel.dispose();
    audioPlayerModel.dispose();
    messageInputFocusNode?.dispose();
    messageInputTextController?.dispose();

    photoUploadModel.dispose();
    videoUploadModel.dispose();
    fileUploadModel.dispose();
    audioRecordButtonModel.dispose();
    mobileOptionsModel.dispose();
    sendButtonModel.dispose();
  }
}
