import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'course_member_role_dropdown_model.dart';
export 'course_member_role_dropdown_model.dart';

class CourseMemberRoleDropdownWidget extends StatefulWidget {
  const CourseMemberRoleDropdownWidget({
    super.key,
    String? role,
    required this.selectionCallback,
  }) : this.role = role ?? 'member';

  final String role;
  final Future Function(String? selection)? selectionCallback;

  @override
  State<CourseMemberRoleDropdownWidget> createState() =>
      _CourseMemberRoleDropdownWidgetState();
}

class _CourseMemberRoleDropdownWidgetState
    extends State<CourseMemberRoleDropdownWidget> {
  late CourseMemberRoleDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseMemberRoleDropdownModel());

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
      child: FlutterFlowDropDown<String>(
        controller: _model.roleDropDownValueController ??=
            FormFieldController<String>(
          _model.roleDropDownValue ??= widget!.role,
        ),
        options: ['Member', 'Coach'],
        onChanged: (val) async {
          safeSetState(() => _model.roleDropDownValue = val);
          logFirebaseEvent('COURSE_MEMBER_ROLE_DROPDOWN_roleDropDown');
          logFirebaseEvent('roleDropDown_execute_callback');
          await widget.selectionCallback?.call(
            _model.roleDropDownValue,
          );
        },
        width: 140.0,
        height: 44.0,
        textStyle: FlutterFlowTheme.of(context).labelLarge.override(
              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.normal,
              useGoogleFonts: GoogleFonts.asMap()
                  .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
            ),
        hintText: 'Please select...',
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
        elevation: 2.0,
        borderColor: Color(0x1918281A),
        borderWidth: 1.0,
        borderRadius: 12.0,
        margin: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        hidesUnderline: true,
        isOverButton: true,
        isSearchable: false,
        isMultiSelect: false,
      ),
    );
  }
}
