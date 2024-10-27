import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_other_user_posts_model.dart';
export 'empty_other_user_posts_model.dart';

class EmptyOtherUserPostsWidget extends StatefulWidget {
  const EmptyOtherUserPostsWidget({super.key});

  @override
  State<EmptyOtherUserPostsWidget> createState() =>
      _EmptyOtherUserPostsWidgetState();
}

class _EmptyOtherUserPostsWidgetState extends State<EmptyOtherUserPostsWidget> {
  late EmptyOtherUserPostsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyOtherUserPostsModel());

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
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No posts from this user!',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                    color: FlutterFlowTheme.of(context).secondary,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleSmallFamily),
                  ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/Post-Placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ].divide(SizedBox(height: 16.0)).around(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
