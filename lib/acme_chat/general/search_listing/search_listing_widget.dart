import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_listing_model.dart';
export 'search_listing_model.dart';

class SearchListingWidget extends StatefulWidget {
  const SearchListingWidget({
    super.key,
    this.image,
    this.name,
  });

  final String? image;
  final String? name;

  @override
  State<SearchListingWidget> createState() => _SearchListingWidgetState();
}

class _SearchListingWidgetState extends State<SearchListingWidget> {
  late SearchListingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchListingModel());

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
      padding: EdgeInsets.all(8.0),
      child: MouseRegion(
        opaque: false,
        cursor: MouseCursor.defer ?? MouseCursor.defer,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              _model.componentHoverHovered!
                  ? FlutterFlowTheme.of(context).offWhite
                  : Color(0x00F1F3F7),
              Color(0x00F1F3F7),
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: valueOrDefault<Color>(
                _model.componentHoverHovered!
                    ? FlutterFlowTheme.of(context).greyBorder
                    : Color(0x00F1F3F7),
                Color(0x00F1F3F7),
              ),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        widget!.image!,
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).white40,
                      width: 2.0,
                    ),
                  ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.name,
                    'Name',
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: valueOrDefault<Color>(
                          _model.componentHoverHovered!
                              ? FlutterFlowTheme.of(context).deepPurple
                              : FlutterFlowTheme.of(context).grey2,
                          FlutterFlowTheme.of(context).grey2,
                        ),
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).headlineSmallFamily),
                        lineHeight: 1.0,
                      ),
                ),
              ].divide(SizedBox(width: 12.0)),
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
