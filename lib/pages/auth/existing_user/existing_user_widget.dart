import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'existing_user_model.dart';
export 'existing_user_model.dart';

class ExistingUserWidget extends StatefulWidget {
  const ExistingUserWidget({
    super.key,
    this.email,
    this.name,
  });

  final String? email;
  final String? name;

  @override
  State<ExistingUserWidget> createState() => _ExistingUserWidgetState();
}

class _ExistingUserWidgetState extends State<ExistingUserWidget> {
  late ExistingUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExistingUserModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ExistingUser'});
    _model.loginEmailAddressTextController ??=
        TextEditingController(text: widget!.email);
    _model.loginEmailAddressFocusNode ??= FocusNode();

    _model.loginPasswordTextController ??= TextEditingController();
    _model.loginPasswordFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 1.0,
            constraints: BoxConstraints(
              maxWidth: 500.0,
            ),
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 300),
                          imageUrl: valueOrDefault<String>(
                            functions.stringToImgPath(
                                getRemoteConfigString('AppLogo')),
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/ckno2i5pqlpe/Tribe_2023_TM_Light_trim.png',
                          ),
                          width: 250.0,
                          height: 100.0,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    constraints: BoxConstraints(
                      maxWidth: 500.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            1.0,
                            2.0,
                          ),
                          spreadRadius: 1.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 20.0),
                                  child: Text(
                                    'Welcome back, ${widget!.name}!',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Form(
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller:
                                      _model.loginEmailAddressTextController,
                                  focusNode: _model.loginEmailAddressFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.loginEmailAddressTextController',
                                    Duration(milliseconds: 500),
                                    () => safeSetState(() {}),
                                  ),
                                  onFieldSubmitted: (_) async {
                                    logFirebaseEvent(
                                        'EXISTING_USER_login_emailAddress_ON_TEXT');
                                    logFirebaseEvent(
                                        'login_emailAddress_show_snack_bar');
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Testing...',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                      ),
                                    );
                                  },
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Your Email',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .accent2,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            10.0, 16.0, 10.0, 16.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey('Open Sans'),
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model
                                      .loginEmailAddressTextControllerValidator
                                      .asValidator(context),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller:
                                        _model.loginPasswordTextController,
                                    focusNode: _model.loginPasswordFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.loginPasswordTextController',
                                      Duration(milliseconds: 500),
                                      () => safeSetState(() {}),
                                    ),
                                    onFieldSubmitted: (_) async {
                                      logFirebaseEvent(
                                          'EXISTING_USER_login_password_ON_TEXTFIEL');
                                      var _shouldSetState = false;
                                      Function() _navigate = () {};
                                      logFirebaseEvent(
                                          'login_password_validate_form');
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      logFirebaseEvent(
                                          'login_password_action_block');
                                      await action_blocks.displaySnackbar(
                                        context,
                                        message: 'Logging in...',
                                      );
                                      logFirebaseEvent(
                                          'login_password_backend_call');
                                      _model.signInResponseTextField =
                                          await SignInCall.call(
                                        email: _model
                                            .loginEmailAddressTextController
                                            .text,
                                        password: _model
                                            .loginPasswordTextController.text,
                                        baseURL: getRemoteConfigString(
                                            'AppBaseApiUrl'),
                                        platformId:
                                            getRemoteConfigInt('AppPlatformId'),
                                      );

                                      _shouldSetState = true;
                                      if ((_model.signInResponseTextField
                                              ?.succeeded ??
                                          true)) {
                                        logFirebaseEvent(
                                            'login_password_update_app_state');
                                        FFAppState().userID = SignInCall.userID(
                                          (_model.signInResponseTextField
                                                  ?.jsonBody ??
                                              ''),
                                        );
                                        FFAppState().deleteCurrentGroup();
                                        FFAppState().currentGroup = null;

                                        FFAppState().update(() {});
                                        logFirebaseEvent('login_password_auth');
                                        GoRouter.of(context).prepareAuthEvent();
                                        final user = await authManager
                                            .signInWithJwtToken(
                                          context,
                                          SignInCall.customJWT(
                                            (_model.signInResponseTextField
                                                    ?.jsonBody ??
                                                ''),
                                          ).toString(),
                                        );
                                        if (user == null) {
                                          return;
                                        }

                                        _navigate = () => context.goNamedAuth(
                                            'ReturningRedirect',
                                            context.mounted);
                                      } else {
                                        logFirebaseEvent(
                                            'login_password_show_snack_bar');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please Check Email or Password',
                                              style: GoogleFonts.getFont(
                                                'Open Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .customColor3,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }

                                      _navigate();
                                      if (_shouldSetState) safeSetState(() {});
                                    },
                                    autofocus: true,
                                    textInputAction: TextInputAction.done,
                                    obscureText:
                                        !_model.loginPasswordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Your password',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Open Sans'),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .accent2,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10.0, 16.0, 10.0, 16.0),
                                      suffixIcon: InkWell(
                                        onTap: () => safeSetState(
                                          () => _model.loginPasswordVisibility =
                                              !_model.loginPasswordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.loginPasswordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    textAlign: TextAlign.start,
                                    validator: _model
                                        .loginPasswordTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'EXISTING_USER_PAGE_Button-Login_ON_TAP');
                                      var _shouldSetState = false;
                                      Function() _navigate = () {};
                                      logFirebaseEvent(
                                          'Button-Login_validate_form');
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      logFirebaseEvent(
                                          'Button-Login_backend_call');
                                      _model.signInResponseBtn =
                                          await SignInCall.call(
                                        email: _model
                                            .loginEmailAddressTextController
                                            .text,
                                        password: _model
                                            .loginPasswordTextController.text,
                                        baseURL: getRemoteConfigString(
                                            'AppBaseApiUrl'),
                                        platformId:
                                            getRemoteConfigInt('AppPlatformId'),
                                      );

                                      _shouldSetState = true;
                                      if ((_model
                                              .signInResponseBtn?.succeeded ??
                                          true)) {
                                        logFirebaseEvent(
                                            'Button-Login_update_app_state');
                                        FFAppState().userID = SignInCall.userID(
                                          (_model.signInResponseBtn?.jsonBody ??
                                              ''),
                                        );
                                        FFAppState().deleteCurrentGroup();
                                        FFAppState().currentGroup = null;

                                        FFAppState().update(() {});
                                        logFirebaseEvent('Button-Login_auth');
                                        GoRouter.of(context).prepareAuthEvent();
                                        final user = await authManager
                                            .signInWithJwtToken(
                                          context,
                                          SignInCall.customJWT(
                                            (_model.signInResponseBtn
                                                    ?.jsonBody ??
                                                ''),
                                          ).toString(),
                                        );
                                        if (user == null) {
                                          return;
                                        }

                                        _navigate = () => context.goNamedAuth(
                                            'ReturningRedirect',
                                            context.mounted);
                                      } else {
                                        logFirebaseEvent(
                                            'Button-Login_show_snack_bar');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please Check Email or Password',
                                              style: GoogleFonts.getFont(
                                                'Open Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .customColor3,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }

                                      _navigate();
                                      if (_shouldSetState) safeSetState(() {});
                                    },
                                    text: 'Sign In ',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Open Sans'),
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'EXISTING_USER_Button-ForgotPassword_ON_T');
                                    var _shouldSetState = false;
                                    if (_model.loginEmailAddressTextController
                                                .text !=
                                            null &&
                                        _model.loginEmailAddressTextController
                                                .text !=
                                            '') {
                                      logFirebaseEvent(
                                          'Button-ForgotPassword_backend_call');
                                      _model.forgotPasswordResponse =
                                          await ForgotPasswordCall.call(
                                        email: _model
                                            .loginEmailAddressTextController
                                            .text,
                                        baseURL: getRemoteConfigString(
                                            'AppBaseApiUrl'),
                                        platformId:
                                            getRemoteConfigInt('AppPlatformId'),
                                      );

                                      _shouldSetState = true;
                                      logFirebaseEvent(
                                          'Button-ForgotPassword_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please check your email.',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17.0,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                        ),
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      logFirebaseEvent(
                                          'Button-ForgotPassword_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter email address',
                                            style: TextStyle(),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor: Color(0x00000000),
                                        ),
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                  text: 'Forgot Password?',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                  child: VerticalDivider(
                                    thickness: 1.0,
                                    color: FlutterFlowTheme.of(context).accent2,
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'EXISTING_USER_Button-DifferentEmail_ON_T');
                                    logFirebaseEvent(
                                        'Button-DifferentEmail_navigate_to');

                                    context.pushNamed('EntryPage');
                                  },
                                  text: 'Try another email',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).accent4,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Open Sans'),
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 12.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'EXISTING_USER_NEED_HELP_CONTACT_SUPPORT_');
                        logFirebaseEvent('Button_launch_u_r_l');
                        await launchURL(getRemoteConfigString('AppSupportUrl'));
                      },
                      text: 'Need Help? Contact Support',
                      icon: Icon(
                        Icons.chat_outlined,
                        color: FlutterFlowTheme.of(context).accent1,
                        size: 20.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).alternate,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context).accent1,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Open Sans'),
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
