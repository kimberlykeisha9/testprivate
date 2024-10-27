import '/acme_chat/general/grey_divider/grey_divider_widget.dart';
import '/acme_chat/general/option_list_row/option_list_row_widget.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'upload_media_options_model.dart';
export 'upload_media_options_model.dart';

class UploadMediaOptionsWidget extends StatefulWidget {
  const UploadMediaOptionsWidget({
    super.key,
    this.uploadPhoto,
    this.uploadVideo,
    this.uploadFile,
  });

  final Future Function(List<String> photos)? uploadPhoto;
  final Future Function(String video)? uploadVideo;
  final Future Function(String file)? uploadFile;

  @override
  State<UploadMediaOptionsWidget> createState() =>
      _UploadMediaOptionsWidgetState();
}

class _UploadMediaOptionsWidgetState extends State<UploadMediaOptionsWidget> {
  late UploadMediaOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadMediaOptionsModel());

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
      width: 140.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).offWhite,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).greyBorder,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('UPLOAD_MEDIA_OPTIONS_Container_vdkhz53j_');
              logFirebaseEvent('OptionListRow_upload_media_to_firebase');
              final selectedMedia = await selectMedia(
                maxWidth: 1000.00,
                maxHeight: 1000.00,
                mediaSource: MediaSource.photoGallery,
                multiImage: true,
              );
              if (selectedMedia != null &&
                  selectedMedia.every(
                      (m) => validateFileFormat(m.storagePath, context))) {
                safeSetState(() => _model.isDataUploading = true);
                var selectedUploadedFiles = <FFUploadedFile>[];

                var downloadUrls = <String>[];
                try {
                  showUploadMessage(
                    context,
                    'Uploading file...',
                    showLoading: true,
                  );
                  selectedUploadedFiles = selectedMedia
                      .map((m) => FFUploadedFile(
                            name: m.storagePath.split('/').last,
                            bytes: m.bytes,
                            height: m.dimensions?.height,
                            width: m.dimensions?.width,
                            blurHash: m.blurHash,
                          ))
                      .toList();

                  downloadUrls = (await Future.wait(
                    selectedMedia.map(
                      (m) async => await uploadData(m.storagePath, m.bytes),
                    ),
                  ))
                      .where((u) => u != null)
                      .map((u) => u!)
                      .toList();
                } finally {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _model.isDataUploading = false;
                }
                if (selectedUploadedFiles.length == selectedMedia.length &&
                    downloadUrls.length == selectedMedia.length) {
                  safeSetState(() {
                    _model.uploadedLocalFiles = selectedUploadedFiles;
                    _model.uploadedFileUrls = downloadUrls;
                  });
                  showUploadMessage(context, 'Success!');
                } else {
                  safeSetState(() {});
                  showUploadMessage(context, 'Failed to upload data');
                  return;
                }
              }

              logFirebaseEvent('OptionListRow_execute_callback');
              await widget.uploadPhoto?.call(
                _model.uploadedFileUrls,
              );
            },
            child: wrapWithModel(
              model: _model.optionListRowModel1,
              updateCallback: () => safeSetState(() {}),
              child: OptionListRowWidget(
                text: 'Add Photo',
                icon: Icon(
                  Icons.photo_library_outlined,
                  size: 16.0,
                ),
              ),
            ),
          ),
          Flexible(
            child: wrapWithModel(
              model: _model.greyDividerModel1,
              updateCallback: () => safeSetState(() {}),
              child: GreyDividerWidget(),
            ),
          ),
          wrapWithModel(
            model: _model.optionListRowModel2,
            updateCallback: () => safeSetState(() {}),
            child: OptionListRowWidget(
              text: 'Add Video',
              icon: Icon(
                Icons.video_camera_back_outlined,
                size: 16.0,
              ),
            ),
          ),
          Flexible(
            child: wrapWithModel(
              model: _model.greyDividerModel2,
              updateCallback: () => safeSetState(() {}),
              child: GreyDividerWidget(),
            ),
          ),
          wrapWithModel(
            model: _model.optionListRowModel3,
            updateCallback: () => safeSetState(() {}),
            child: OptionListRowWidget(
              text: 'Add File',
              icon: Icon(
                Icons.file_present,
                size: 16.0,
              ),
            ),
          ),
        ]
            .divide(SizedBox(height: 0.0))
            .addToStart(SizedBox(height: 4.0))
            .addToEnd(SizedBox(height: 2.0)),
      ),
    );
  }
}
