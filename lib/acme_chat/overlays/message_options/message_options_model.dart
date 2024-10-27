import '/acme_chat/general/grey_divider/grey_divider_widget.dart';
import '/acme_chat/general/option_list_row/option_list_row_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'message_options_widget.dart' show MessageOptionsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageOptionsModel extends FlutterFlowModel<MessageOptionsWidget> {
  ///  Local state fields for this component.

  bool messageCopied = false;

  ///  State fields for stateful widgets in this component.

  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel1;
  // Model for OptionListRow component.
  late OptionListRowModel optionListRowModel;
  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel2;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel3;
  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel4;

  @override
  void initState(BuildContext context) {
    greyDividerModel1 = createModel(context, () => GreyDividerModel());
    optionListRowModel = createModel(context, () => OptionListRowModel());
    greyDividerModel2 = createModel(context, () => GreyDividerModel());
    greyDividerModel3 = createModel(context, () => GreyDividerModel());
    greyDividerModel4 = createModel(context, () => GreyDividerModel());
  }

  @override
  void dispose() {
    greyDividerModel1.dispose();
    optionListRowModel.dispose();
    greyDividerModel2.dispose();
    greyDividerModel3.dispose();
    greyDividerModel4.dispose();
  }
}
