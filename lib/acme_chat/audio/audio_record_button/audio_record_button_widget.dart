import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'audio_record_button_model.dart';
export 'audio_record_button_model.dart';

class AudioRecordButtonWidget extends StatefulWidget {
  const AudioRecordButtonWidget({
    super.key,
    required this.audioRecording,
  });

  final Future Function(String audio)? audioRecording;

  @override
  State<AudioRecordButtonWidget> createState() =>
      _AudioRecordButtonWidgetState();
}

class _AudioRecordButtonWidgetState extends State<AudioRecordButtonWidget> {
  late AudioRecordButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioRecordButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('AUDIO_RECORD_BUTTON_Container_sg116z9q_O');
        if (_model.recording) {
          logFirebaseEvent('Container_stop_audio_recording');
          await stopAudioRecording(
            audioRecorder: _model.audioRecorder,
            audioName: 'recordedFileBytes.mp3',
            onRecordingComplete: (audioFilePath, audioBytes) {
              _model.newAudioMessage = audioFilePath;
              _model.recordedFileBytes = audioBytes;
            },
          );

          // Clear Recording State
          logFirebaseEvent('Container_ClearRecordingState');
          _model.recording = false;
          safeSetState(() {});
          // Set RecordedAudio as Audio state
          logFirebaseEvent('Container_SetRecordedAudioasAudiostate');
          await widget.audioRecording?.call(
            _model.newAudioMessage!,
          );
        }

        safeSetState(() {});
      },
      onLongPress: () async {
        logFirebaseEvent('AUDIO_RECORD_BUTTON_Container_sg116z9q_O');
        if (!_model.recording) {
          await Future.wait([
            Future(() async {
              // Set Recording State
              logFirebaseEvent('Container_SetRecordingState');
              _model.recording = true;
              safeSetState(() {});
            }),
            Future(() async {
              logFirebaseEvent('Container_start_audio_recording');
              await startAudioRecording(
                context,
                audioRecorder: _model.audioRecorder ??= AudioRecorder(),
              );
            }),
          ]);
        }
      },
      child: Container(
        height: 36.0,
        constraints: BoxConstraints(
          minWidth: 36.0,
        ),
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            _model.audioHoverHovered!
                ? FlutterFlowTheme.of(context).greyBorder
                : FlutterFlowTheme.of(context).offWhite,
            FlutterFlowTheme.of(context).offWhite,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: valueOrDefault<Color>(
              _model.audioHoverHovered!
                  ? FlutterFlowTheme.of(context).grey2
                  : FlutterFlowTheme.of(context).greyBorder,
              FlutterFlowTheme.of(context).greyBorder,
            ),
            width: 2.0,
          ),
        ),
        child: MouseRegion(
          opaque: false,
          cursor: MouseCursor.defer ?? MouseCursor.defer,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      valueOrDefault<double>(
                        _model.recording ? 12.0 : 0.0,
                        0.0,
                      ),
                      0.0,
                      0.0,
                      0.0),
                  child: Builder(
                    builder: (context) {
                      if (_model.recording) {
                        return Icon(
                          Icons.stop_rounded,
                          color: FlutterFlowTheme.of(context).deepPurple,
                          size: 18.0,
                        );
                      } else {
                        return Icon(
                          Icons.mic_rounded,
                          color: FlutterFlowTheme.of(context).deepPurple,
                          size: 20.0,
                        );
                      }
                    },
                  ),
                ),
              ),
              if (_model.recording)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 8.0, 0.0),
                  child: ClipRRect(
                    child: Container(
                      width: 100.0,
                      decoration: BoxDecoration(),
                      child: Lottie.network(
                        'https://lottie.host/8a6c64c1-f522-4340-9e13-a7fca958df2c/lsa1X44uoK.json',
                        width: 80.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                        frameRate: FrameRate(24.0),
                        reverse: true,
                        animate: true,
                      ),
                    ),
                  ),
                ),
            ].divide(SizedBox(width: 0.0)),
          ),
          onEnter: ((event) async {
            safeSetState(() => _model.audioHoverHovered = true);
          }),
          onExit: ((event) async {
            safeSetState(() => _model.audioHoverHovered = false);
          }),
        ),
      ),
    );
  }
}
