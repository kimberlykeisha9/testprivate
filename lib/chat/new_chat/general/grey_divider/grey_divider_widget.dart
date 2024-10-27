import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'grey_divider_model.dart';
export 'grey_divider_model.dart';

class GreyDividerWidget extends StatefulWidget {
  const GreyDividerWidget({super.key});

  @override
  State<GreyDividerWidget> createState() => _GreyDividerWidgetState();
}

class _GreyDividerWidgetState extends State<GreyDividerWidget> {
  late GreyDividerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GreyDividerModel());

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
      width: double.infinity,
      height: 2.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).greyBorder,
        borderRadius: BorderRadius.circular(99.0),
      ),
    );
  }
}
