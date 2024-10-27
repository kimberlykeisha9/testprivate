import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'audio_player_widget.dart' show AudioPlayerWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AudioPlayerModel extends FlutterFlowModel<AudioPlayerWidget> {
  ///  Local state fields for this component.

  bool audioPlaying = false;

  ///  State fields for stateful widgets in this component.

  AudioPlayer? soundPlayer;
  // State field(s) for LottieAnimation widget.
  late bool lottieAnimationStatus;

  @override
  void initState(BuildContext context) {
    lottieAnimationStatus = false;
  }

  @override
  void dispose() {}
}
