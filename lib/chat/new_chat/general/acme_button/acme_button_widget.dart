import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'acme_button_model.dart';
export 'acme_button_model.dart';

class AcmeButtonWidget extends StatefulWidget {
  const AcmeButtonWidget({
    super.key,
    bool? emojiOn,
    bool? iconOn,
    bool? textOn,
    this.emojiPath,
    this.icon,
    this.text,
    bool? colorLock,
  })  : this.emojiOn = emojiOn ?? false,
        this.iconOn = iconOn ?? false,
        this.textOn = textOn ?? false,
        this.colorLock = colorLock ?? false;

  final bool emojiOn;
  final bool iconOn;
  final bool textOn;
  final String? emojiPath;
  final Widget? icon;
  final String? text;
  final bool colorLock;

  @override
  State<AcmeButtonWidget> createState() => _AcmeButtonWidgetState();
}

class _AcmeButtonWidgetState extends State<AcmeButtonWidget> {
  late AcmeButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AcmeButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1.0, 0.0),
      child: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.click ?? MouseCursor.defer,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeIn,
          height: 36.0,
          constraints: BoxConstraints(
            minWidth: 36.0,
          ),
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              _model.buttonHoverHovered! || widget!.colorLock
                  ? FlutterFlowTheme.of(context).greyBorder
                  : FlutterFlowTheme.of(context).offWhite,
              FlutterFlowTheme.of(context).offWhite,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: valueOrDefault<Color>(
                _model.buttonHoverHovered! || widget!.colorLock
                    ? FlutterFlowTheme.of(context).grey2
                    : FlutterFlowTheme.of(context).greyBorder,
                FlutterFlowTheme.of(context).greyBorder,
              ),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget!.emojiOn)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      widget!.emojiPath!,
                      width: 14.0,
                      height: 14.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (widget!.iconOn) widget!.icon!,
                if (widget!.textOn)
                  AnimatedDefaultTextStyle(
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: valueOrDefault<Color>(
                            _model.buttonHoverHovered! || widget!.colorLock
                                ? FlutterFlowTheme.of(context).deepPurple
                                : FlutterFlowTheme.of(context).grey3,
                            FlutterFlowTheme.of(context).grey3,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelMediumFamily),
                          lineHeight: 1.0,
                        ),
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    child: Text(
                      valueOrDefault<String>(
                        widget!.text,
                        'Button',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
        ),
        onEnter: ((event) async {
          safeSetState(() => _model.buttonHoverHovered = true);
        }),
        onExit: ((event) async {
          safeSetState(() => _model.buttonHoverHovered = false);
        }),
      ),
    );
  }
}
