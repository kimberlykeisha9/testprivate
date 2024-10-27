import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'processing_live_model.dart';
export 'processing_live_model.dart';

class ProcessingLiveWidget extends StatefulWidget {
  const ProcessingLiveWidget({super.key});

  @override
  State<ProcessingLiveWidget> createState() => _ProcessingLiveWidgetState();
}

class _ProcessingLiveWidgetState extends State<ProcessingLiveWidget> {
  late ProcessingLiveModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProcessingLiveModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
          'https://lottie.host/ece9f5cc-bfe5-4f4f-b18f-a29235edfabf/Ct1Wb0FoGV.json',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
          animate: true,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Processing Live Stream...Please Wait',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodySmallFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodySmallFamily),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
