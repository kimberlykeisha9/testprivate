import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'option_list_row_model.dart';
export 'option_list_row_model.dart';

class OptionListRowWidget extends StatefulWidget {
  const OptionListRowWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  final String? text;
  final Widget? icon;

  @override
  State<OptionListRowWidget> createState() => _OptionListRowWidgetState();
}

class _OptionListRowWidgetState extends State<OptionListRowWidget> {
  late OptionListRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionListRowModel());

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
      padding: EdgeInsets.all(4.0),
      child: MouseRegion(
        opaque: false,
        cursor: MouseCursor.defer ?? MouseCursor.defer,
        child: Container(
          decoration: BoxDecoration(
            color: _model.componentHoverHovered!
                ? FlutterFlowTheme.of(context).grey1
                : Color(0x00000000),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: valueOrDefault<Color>(
                _model.componentHoverHovered!
                    ? FlutterFlowTheme.of(context).greyBorder
                    : Colors.transparent,
                Colors.transparent,
              ),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget!.text!,
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelSmallFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).labelSmallFamily),
                      ),
                ),
                widget!.icon!,
              ],
            ),
          ),
        ),
        onEnter: ((event) async {
          safeSetState(() => _model.componentHoverHovered = true);
        }),
        onExit: ((event) async {
          safeSetState(() => _model.componentHoverHovered = false);
        }),
      ),
    );
  }
}
