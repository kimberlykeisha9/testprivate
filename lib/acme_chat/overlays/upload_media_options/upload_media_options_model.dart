import '/acme_chat/general/grey_divider/grey_divider_widget.dart';
import '/acme_chat/general/option_list_row/option_list_row_widget.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'upload_media_options_widget.dart' show UploadMediaOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadMediaOptionsModel
    extends FlutterFlowModel<UploadMediaOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for OptionListRow component.
  late OptionListRowModel optionListRowModel1;
  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];
  List<String> uploadedFileUrls = [];

  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel1;
  // Model for OptionListRow component.
  late OptionListRowModel optionListRowModel2;
  // Model for GreyDivider component.
  late GreyDividerModel greyDividerModel2;
  // Model for OptionListRow component.
  late OptionListRowModel optionListRowModel3;

  @override
  void initState(BuildContext context) {
    optionListRowModel1 = createModel(context, () => OptionListRowModel());
    greyDividerModel1 = createModel(context, () => GreyDividerModel());
    optionListRowModel2 = createModel(context, () => OptionListRowModel());
    greyDividerModel2 = createModel(context, () => GreyDividerModel());
    optionListRowModel3 = createModel(context, () => OptionListRowModel());
  }

  @override
  void dispose() {
    optionListRowModel1.dispose();
    greyDividerModel1.dispose();
    optionListRowModel2.dispose();
    greyDividerModel2.dispose();
    optionListRowModel3.dispose();
  }
}
