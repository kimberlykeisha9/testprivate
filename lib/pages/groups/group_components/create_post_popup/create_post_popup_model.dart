import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_post_popup_widget.dart' show CreatePostPopupWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreatePostPopupModel extends FlutterFlowModel<CreatePostPopupWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> usersList = [];
  void addToUsersList(DocumentReference item) => usersList.add(item);
  void removeFromUsersList(DocumentReference item) => usersList.remove(item);
  void removeAtIndexFromUsersList(int index) => usersList.removeAt(index);
  void insertAtIndexInUsersList(int index, DocumentReference item) =>
      usersList.insert(index, item);
  void updateUsersListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      usersList[index] = updateFn(usersList[index]);

  MediaUrlWithTypeStruct? uploadedMediaType;
  void updateUploadedMediaTypeStruct(
      Function(MediaUrlWithTypeStruct) updateFn) {
    updateFn(uploadedMediaType ??= MediaUrlWithTypeStruct());
  }

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for EnablePushNotification widget.
  bool? enablePushNotificationValue;
  // State field(s) for notificationTitleTextField widget.
  FocusNode? notificationTitleTextFieldFocusNode;
  TextEditingController? notificationTitleTextFieldTextController;
  String? Function(BuildContext, String?)?
      notificationTitleTextFieldTextControllerValidator;
  String? _notificationTitleTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter notification title';
    }

    return null;
  }

  // State field(s) for notificationMessageTextField widget.
  FocusNode? notificationMessageTextFieldFocusNode;
  TextEditingController? notificationMessageTextFieldTextController;
  String? Function(BuildContext, String?)?
      notificationMessageTextFieldTextControllerValidator;
  String? _notificationMessageTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter notification message';
    }

    return null;
  }

  // Stores action output result for [Action Block - createLiveStream] action in goLiveButton widget.
  DocumentReference? newBroadcast;
  // Stores action output result for [Firestore Query - Query a collection] action in goLiveButton widget.
  List<UserRecord>? queryGroupUsersGoLive;
  // Stores action output result for [Action Block - createLiveStream] action in goLiveButton widget.
  DocumentReference? newBroadcastNoNotification;
  // Stores action output result for [Backend Call - Create Document] action in postButton widget.
  BroadcastsRecord? createdPostWithNotification;
  // Stores action output result for [Firestore Query - Query a collection] action in postButton widget.
  List<UserRecord>? queryGroupUsers;
  // Stores action output result for [Firestore Query - Query a collection] action in postButton widget.
  List<UserRecord>? queryGroupAdmins;
  // Stores action output result for [Backend Call - Create Document] action in postButton widget.
  NotificationsRecord? mentionNotificat;
  // Stores action output result for [Backend Call - Create Document] action in postButton widget.
  BroadcastsRecord? newPost;
  // Stores action output result for [Backend Call - Create Document] action in postButton widget.
  NotificationsRecord? mentionNotification;

  @override
  void initState(BuildContext context) {
    notificationTitleTextFieldTextControllerValidator =
        _notificationTitleTextFieldTextControllerValidator;
    notificationMessageTextFieldTextControllerValidator =
        _notificationMessageTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    notificationTitleTextFieldFocusNode?.dispose();
    notificationTitleTextFieldTextController?.dispose();

    notificationMessageTextFieldFocusNode?.dispose();
    notificationMessageTextFieldTextController?.dispose();
  }
}
