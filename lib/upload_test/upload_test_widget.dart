import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'upload_test_model.dart';
export 'upload_test_model.dart';

class UploadTestWidget extends StatefulWidget {
  const UploadTestWidget({super.key});

  @override
  State<UploadTestWidget> createState() => _UploadTestWidgetState();
}

class _UploadTestWidgetState extends State<UploadTestWidget> {
  late UploadTestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadTestModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'UploadTest'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).black600,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 54.0,
                  icon: Icon(
                    Icons.chevron_left_sharp,
                    color: FlutterFlowTheme.of(context).accent1,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    logFirebaseEvent(
                        'UPLOAD_TEST_chevron_left_sharp_ICN_ON_TA');
                    logFirebaseEvent('IconButton_navigate_back');
                    context.pop();
                  },
                ),
                title: Text(
                  'Upload',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).headlineSmallFamily),
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: custom_widgets.VideoUploadWidget(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  apiKey: '2be639a4-6cd1-4a3e-8d47-3438bffb4a28',
                ),
              ),
              Text(
                valueOrDefault<String>(
                  FFAppState().uploadedVideoAssetId,
                  'Uploading...',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
