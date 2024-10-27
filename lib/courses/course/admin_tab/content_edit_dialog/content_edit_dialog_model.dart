import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/alert_dialog_widget.dart';
import '/courses/add_edit_attachment_dialog/add_edit_attachment_dialog_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'content_edit_dialog_widget.dart' show ContentEditDialogWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ContentEditDialogModel extends FlutterFlowModel<ContentEditDialogWidget> {
  ///  Local state fields for this component.

  bool isImageUploaded = false;

  String selectedMediaType = 'video';

  String? fileUploadUrl = '';

  String? richTextEditorOutput = '';

  int? contentID;

  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  // State field(s) for contentNameTextField widget.
  FocusNode? contentNameTextFieldFocusNode;
  TextEditingController? contentNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      contentNameTextFieldTextControllerValidator;
  String? _contentNameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Lesson name cannot be empty';
    }

    return null;
  }

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for videoEmbedTypeTextField widget.
  FocusNode? videoEmbedTypeTextFieldFocusNode;
  TextEditingController? videoEmbedTypeTextFieldTextController;
  String? Function(BuildContext, String?)?
      videoEmbedTypeTextFieldTextControllerValidator;
  String? _videoEmbedTypeTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Link cannot be empty';
    }

    return null;
  }

  // State field(s) for ctaText widget.
  FocusNode? ctaTextFocusNode;
  TextEditingController? ctaTextTextController;
  String? Function(BuildContext, String?)? ctaTextTextControllerValidator;
  String? _ctaTextTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please provide CTA description';
    }

    return null;
  }

  // State field(s) for ctaLink widget.
  FocusNode? ctaLinkFocusNode;
  TextEditingController? ctaLinkTextController;
  String? Function(BuildContext, String?)? ctaLinkTextControllerValidator;
  String? _ctaLinkTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please provide link to CTA';
    }

    return null;
  }

  // State field(s) for linkTypeTextField widget.
  FocusNode? linkTypeTextFieldFocusNode;
  TextEditingController? linkTypeTextFieldTextController;
  String? Function(BuildContext, String?)?
      linkTypeTextFieldTextControllerValidator;
  String? _linkTypeTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Link cannot be empty';
    }

    return null;
  }

  // State field(s) for searchieTextField widget.
  FocusNode? searchieTextFieldFocusNode;
  TextEditingController? searchieTextFieldTextController;
  String? Function(BuildContext, String?)?
      searchieTextFieldTextControllerValidator;
  String? _searchieTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Link cannot be empty';
    }

    return null;
  }

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Alert Dialog - Custom Dialog] action in deleteAttachment widget.
  bool? deleteDialogResponse;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in deleteButton widget.
  bool? deleteContentDialogResponse;
  // Stores action output result for [Backend Call - API (Upsert Content Karol)] action in saveButton widget.
  ApiCallResponse? updateContentAPI;
  // Stores action output result for [Backend Call - API (Upsert Content Karol)] action in saveButton widget.
  ApiCallResponse? createContentAPI;
  // Stores action output result for [Firestore Query - Query a collection] action in saveButton widget.
  TribeCollectionsRecord? collectionsDoc;
  // Stores action output result for [Backend Call - Create Document] action in saveButton widget.
  TribeCollectionsRecord? newCollectionsDoc;

  @override
  void initState(BuildContext context) {
    contentNameTextFieldTextControllerValidator =
        _contentNameTextFieldTextControllerValidator;
    videoEmbedTypeTextFieldTextControllerValidator =
        _videoEmbedTypeTextFieldTextControllerValidator;
    ctaTextTextControllerValidator = _ctaTextTextControllerValidator;
    ctaLinkTextControllerValidator = _ctaLinkTextControllerValidator;
    linkTypeTextFieldTextControllerValidator =
        _linkTypeTextFieldTextControllerValidator;
    searchieTextFieldTextControllerValidator =
        _searchieTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    contentNameTextFieldFocusNode?.dispose();
    contentNameTextFieldTextController?.dispose();

    tabBarController?.dispose();
    videoEmbedTypeTextFieldFocusNode?.dispose();
    videoEmbedTypeTextFieldTextController?.dispose();

    ctaTextFocusNode?.dispose();
    ctaTextTextController?.dispose();

    ctaLinkFocusNode?.dispose();
    ctaLinkTextController?.dispose();

    linkTypeTextFieldFocusNode?.dispose();
    linkTypeTextFieldTextController?.dispose();

    searchieTextFieldFocusNode?.dispose();
    searchieTextFieldTextController?.dispose();
  }
}
