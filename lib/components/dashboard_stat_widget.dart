import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_stat_model.dart';
export 'dashboard_stat_model.dart';

class DashboardStatWidget extends StatefulWidget {
  const DashboardStatWidget({
    super.key,
    required this.number,
    String? label,
  }) : this.label = label ?? ' ';

  final double? number;
  final String label;

  @override
  State<DashboardStatWidget> createState() => _DashboardStatWidgetState();
}

class _DashboardStatWidgetState extends State<DashboardStatWidget> {
  late DashboardStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardStatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
      child: Container(
        height: 120.0,
        constraints: BoxConstraints(
          maxWidth: 270.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xFFE5E7EB),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: Color(0xFF39D2C0),
                  size: 32.0,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 4.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              formatNumber(
                                widget!.number,
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.automatic,
                              ),
                              '0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Color(0xFF15161E),
                                  fontSize: 36.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Inter Tight'),
                                ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget!.label,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter Tight',
                            color: Color(0xFF606A85),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter Tight'),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
