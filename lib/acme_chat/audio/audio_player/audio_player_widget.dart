import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'audio_player_model.dart';
export 'audio_player_model.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    super.key,
    required this.audio,
    required this.type,
    bool? reply,
  }) : this.reply = reply ?? false;

  final String? audio;
  final MessageType? type;
  final bool reply;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioPlayerModel());

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
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.0,
            decoration: BoxDecoration(),
            child: Builder(
              builder: (context) {
                if (_model.audioPlaying) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'AUDIO_PLAYER_COMP_Icon_29fkkjxz_ON_TAP');
                      logFirebaseEvent('Icon_lottie_animation');
                      safeSetState(() => _model.lottieAnimationStatus = true);
                      logFirebaseEvent('Icon_stop_sound');
                      _model.soundPlayer?.stop();
                      logFirebaseEvent('Icon_update_component_state');
                      _model.audioPlaying = false;
                      safeSetState(() {});
                    },
                    child: Icon(
                      Icons.pause_rounded,
                      color: valueOrDefault<Color>(
                        () {
                          if (widget!.reply) {
                            return FlutterFlowTheme.of(context).grey2;
                          } else if (widget!.type == MessageType.Sent) {
                            return FlutterFlowTheme.of(context).white;
                          } else {
                            return FlutterFlowTheme.of(context).black;
                          }
                        }(),
                        FlutterFlowTheme.of(context).black,
                      ),
                      size: widget!.reply ? 20.0 : 24.0,
                    ),
                  );
                } else {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'AUDIO_PLAYER_COMP_Icon_7nqqmzw7_ON_TAP');
                      logFirebaseEvent('Icon_update_component_state');
                      _model.audioPlaying = true;
                      safeSetState(() {});
                      logFirebaseEvent('Icon_lottie_animation');
                      safeSetState(() => _model.lottieAnimationStatus =
                          !_model.lottieAnimationStatus);
                      logFirebaseEvent('Icon_play_sound');
                      _model.soundPlayer ??= AudioPlayer();
                      if (_model.soundPlayer!.playing) {
                        await _model.soundPlayer!.stop();
                      }
                      _model.soundPlayer!.setVolume(1.0);
                      await _model.soundPlayer!
                          .setUrl(widget!.audio!)
                          .then((_) => _model.soundPlayer!.play());

                      await Future.wait([
                        Future(() async {
                          logFirebaseEvent('Icon_update_component_state');
                          _model.audioPlaying = false;
                          safeSetState(() {});
                        }),
                        Future(() async {
                          logFirebaseEvent('Icon_lottie_animation');
                          safeSetState(() => _model.lottieAnimationStatus =
                              !_model.lottieAnimationStatus);
                        }),
                      ]);
                    },
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: valueOrDefault<Color>(
                        () {
                          if (widget!.reply) {
                            return FlutterFlowTheme.of(context).grey2;
                          } else if (widget!.type == MessageType.Sent) {
                            return FlutterFlowTheme.of(context).white;
                          } else {
                            return FlutterFlowTheme.of(context).black;
                          }
                        }(),
                        FlutterFlowTheme.of(context).black,
                      ),
                      size: widget!.reply ? 20.0 : 24.0,
                    ),
                  );
                }
              },
            ),
          ),
          ClipRRect(
            child: Container(
              width: widget!.reply ? 120.0 : 160.0,
              height: 36.0,
              decoration: BoxDecoration(),
              child: Lottie.network(
                  valueOrDefault<String>(
                    () {
                      if (widget!.type == MessageType.Sent) {
                        return 'https://lottie.host/b72f8323-40bf-44f0-b90d-404713987a6e/sGn7VA0Yym.json';
                      } else if ((widget!.type == MessageType.ReplyTo) &&
                          widget!.reply) {
                        return 'https://lottie.host/2c4eae30-8ad5-4f89-99d9-0a64d6056039/uCPC2hQexq.json';
                      } else {
                        return 'https://lottie.host/8a6c64c1-f522-4340-9e13-a7fca958df2c/lsa1X44uoK.json';
                      }
                    }(),
                    'https://lottie.host/2c4eae30-8ad5-4f89-99d9-0a64d6056039/uCPC2hQexq.json',
                  ),
                  width: widget!.reply ? 120.0 : 160.0,
                  height: 36.0,
                  fit: BoxFit.cover,
                  frameRate: FrameRate(24.0),
                  reverse: true,
                  animate: _model.lottieAnimationStatus),
            ),
          ),
        ].divide(SizedBox(width: 0.0)),
      ),
    );
  }
}
