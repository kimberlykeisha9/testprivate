import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/new_chat/general/option_list_row/option_list_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'archive_overlay_widget.dart' show ArchiveOverlayWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ArchiveOverlayModel extends FlutterFlowModel<ArchiveOverlayWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for OptionListRow component.
  late OptionListRowModel optionListRowModel;

  @override
  void initState(BuildContext context) {
    optionListRowModel = createModel(context, () => OptionListRowModel());
  }

  @override
  void dispose() {
    optionListRowModel.dispose();
  }
}
