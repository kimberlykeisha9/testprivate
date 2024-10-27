import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'progress_bar_with_text_model.dart';
export 'progress_bar_with_text_model.dart';

class ProgressBarWithTextWidget extends StatefulWidget {
  const ProgressBarWithTextWidget({
    super.key,
    int? completed,
    int? total,
  })  : this.completed = completed ?? 0,
        this.total = total ?? 0;

  final int completed;
  final int total;

  @override
  State<ProgressBarWithTextWidget> createState() =>
      _ProgressBarWithTextWidgetState();
}

class _ProgressBarWithTextWidgetState extends State<ProgressBarWithTextWidget> {
  late ProgressBarWithTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressBarWithTextModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: LinearPercentIndicator(
            percent: valueOrDefault<double>(
              widget!.total == 0
                  ? 0.0
                  : valueOrDefault<double>(
                      widget!.completed / widget!.total,
                      0.0,
                    ),
              0.0,
            ),
            lineHeight: 12.0,
            animation: true,
            animateFromLastPercent: true,
            progressColor: FlutterFlowTheme.of(context).primary,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            barRadius: Radius.circular(32.0),
            padding: EdgeInsets.zero,
          ),
        ),
        Text(
          valueOrDefault<String>(
            formatNumber(
              widget!.total == 0
                  ? 0.0
                  : valueOrDefault<double>(
                      valueOrDefault<int>(
                            widget!.completed,
                            0,
                          ) /
                          valueOrDefault<int>(
                            widget!.total,
                            1,
                          ),
                      0.0,
                    ),
              formatType: FormatType.percent,
            ),
            '0%',
          ),
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts: GoogleFonts.asMap().containsKey(
                    FlutterFlowTheme.of(context).labelMediumFamily),
              ),
        ),
      ].divide(SizedBox(width: 6.0)),
    );
  }
}
