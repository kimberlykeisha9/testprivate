import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'audio_record_button_widget.dart' show AudioRecordButtonWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class AudioRecordButtonModel extends FlutterFlowModel<AudioRecordButtonWidget> {
  ///  Local state fields for this component.

  bool recording = false;

  ///  State fields for stateful widgets in this component.

  AudioRecorder? audioRecorder;
  String? newAudioMessage;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  // State field(s) for AudioHover widget.
  bool audioHoverHovered = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
