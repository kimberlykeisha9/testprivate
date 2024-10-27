import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'button_with_icon_right_model.dart';
export 'button_with_icon_right_model.dart';

class ButtonWithIconRightWidget extends StatefulWidget {
  const ButtonWithIconRightWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  final String? text;
  final Widget? icon;

  @override
  State<ButtonWithIconRightWidget> createState() =>
      _ButtonWithIconRightWidgetState();
}

class _ButtonWithIconRightWidgetState extends State<ButtonWithIconRightWidget> {
  late ButtonWithIconRightModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ButtonWithIconRightModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: widget!.text!,
            options: FFButtonOptions(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primary10Percent,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                    color: FlutterFlowTheme.of(context).primary60Percent,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleSmallFamily),
                  ),
              elevation: 0.0,
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary20Percent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.0, 0.0),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: widget!.icon!,
          ),
        ),
      ],
    );
  }
}
