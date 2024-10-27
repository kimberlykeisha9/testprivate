import '/backend/backend.dart';
import '/courses/course/admin_tab/delete_course_dialog/delete_course_dialog_widget.dart';
import '/courses/course/course_edit_dialog/course_edit_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'courses_dialog_model.dart';
export 'courses_dialog_model.dart';

class CoursesDialogWidget extends StatefulWidget {
  const CoursesDialogWidget({
    super.key,
    required this.courseDoc,
  });

  final TribeCourseRecord? courseDoc;

  @override
  State<CoursesDialogWidget> createState() => _CoursesDialogWidgetState();
}

class _CoursesDialogWidgetState extends State<CoursesDialogWidget> {
  late CoursesDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoursesDialogModel());

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
      width: 180.0,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) => FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('COURSES_DIALOG_COMP_editBtn_ON_TAP');
                  logFirebaseEvent('editBtn_dismiss_dialog');
                  Navigator.pop(context);
                  logFirebaseEvent('editBtn_alert_dialog');
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: WebViewAware(
                          child: CourseEditDialogWidget(
                            courseDoc: widget!.courseDoc!,
                          ),
                        ),
                      );
                    },
                  );
                },
                text: 'Edit course',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 36.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFFAFAFA),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                  hoverElevation: 0.0,
                ),
              ),
            ),
            Builder(
              builder: (context) => FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('COURSES_DIALOG_COMP_deteleButton_ON_TAP');
                  logFirebaseEvent('deteleButton_dismiss_dialog');
                  Navigator.pop(context);
                  logFirebaseEvent('deteleButton_alert_dialog');
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: WebViewAware(
                          child: DeleteCourseDialogWidget(
                            onDelete: () async {
                              logFirebaseEvent('_backend_call');
                              await widget!.courseDoc!.reference.delete();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                text: 'Delete course',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 36.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFFAFAFA),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  hoverColor: FlutterFlowTheme.of(context).primaryBackground,
                  hoverElevation: 0.0,
                ),
              ),
            ),
          ].divide(SizedBox(height: 2.0)),
        ),
      ),
    );
  }
}
