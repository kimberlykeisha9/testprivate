import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'o_l_dcontent_add_video_dialog_widget.dart'
    show OLDcontentAddVideoDialogWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OLDcontentAddVideoDialogModel
    extends FlutterFlowModel<OLDcontentAddVideoDialogWidget> {
  ///  Local state fields for this component.

  String? uploadFIleUrl;

  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for typeChoiceChips widget.
  FormFieldController<List<String>>? typeChoiceChipsValueController;
  String? get typeChoiceChipsValue =>
      typeChoiceChipsValueController?.value?.firstOrNull;
  set typeChoiceChipsValue(String? val) =>
      typeChoiceChipsValueController?.value = val != null ? [val] : [];
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

  @override
  void initState(BuildContext context) {
    videoEmbedTypeTextFieldTextControllerValidator =
        _videoEmbedTypeTextFieldTextControllerValidator;
    ctaTextTextControllerValidator = _ctaTextTextControllerValidator;
    ctaLinkTextControllerValidator = _ctaLinkTextControllerValidator;
    searchieTextFieldTextControllerValidator =
        _searchieTextFieldTextControllerValidator;
    linkTypeTextFieldTextControllerValidator =
        _linkTypeTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    videoEmbedTypeTextFieldFocusNode?.dispose();
    videoEmbedTypeTextFieldTextController?.dispose();

    ctaTextFocusNode?.dispose();
    ctaTextTextController?.dispose();

    ctaLinkFocusNode?.dispose();
    ctaLinkTextController?.dispose();

    searchieTextFieldFocusNode?.dispose();
    searchieTextFieldTextController?.dispose();

    linkTypeTextFieldFocusNode?.dispose();
    linkTypeTextFieldTextController?.dispose();
  }
}
