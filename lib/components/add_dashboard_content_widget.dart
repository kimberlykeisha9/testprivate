import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_dashboard_content_model.dart';
export 'add_dashboard_content_model.dart';

class AddDashboardContentWidget extends StatefulWidget {
  const AddDashboardContentWidget({super.key});

  @override
  State<AddDashboardContentWidget> createState() =>
      _AddDashboardContentWidgetState();
}

class _AddDashboardContentWidgetState extends State<AddDashboardContentWidget> {
  late AddDashboardContentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDashboardContentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
