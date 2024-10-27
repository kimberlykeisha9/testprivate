import '/auth/base_auth_user_provider.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'entry_page_model.dart';
export 'entry_page_model.dart';

class EntryPageWidget extends StatefulWidget {
  const EntryPageWidget({super.key});

  @override
  State<EntryPageWidget> createState() => _EntryPageWidgetState();
}

class _EntryPageWidgetState extends State<EntryPageWidget> {
  late EntryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EntryPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'EntryPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ENTRY_PAGE_PAGE_EntryPage_ON_INIT_STATE');
      if (loggedIn) {
        logFirebaseEvent('EntryPage_navigate_to');

        context.pushNamed('GroupList');
      } else {
        return;
      }
    });

    _model.loginEmailAddressTextController ??= TextEditingController();
    _model.loginEmailAddressFocusNode ??= FocusNode();

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
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              constraints: BoxConstraints(
                maxWidth: 500.0,
              ),
              decoration: BoxDecoration(),
              alignment: AlignmentDirectional(0.0, -1.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 20.0),
                                      child: Text(
                                        'Enter your email address to find your account.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                    focusNode:
                                        _model.loginEmailAddressFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.loginEmailAddressTextController',
                                      Duration(milliseconds: 500),
                                      () => safeSetState(() {}),
                                    ),
                                    onFieldSubmitted: (_) async {
                                      logFirebaseEvent(
                                          'ENTRY_login_emailAddress_ON_TEXTFIELD_SU');
                                      var _shouldSetState = false;
                                      logFirebaseEvent(
                                          'login_emailAddress_validate_form');
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      logFirebaseEvent(
                                          'login_emailAddress_backend_call');
                                      _model.validateUserCallTextField =
                                          await ValidateUserCall.call(
                                        email: _model
                                            .loginEmailAddressTextController
                                            .text,
                                        baseURL: getRemoteConfigString(
                                            'AppBaseApiUrl'),
                                        platformId:
                                            getRemoteConfigInt('AppPlatformId')
                                                .toString(),
                                      );

                                      _shouldSetState = true;
                                      if ((_model.validateUserCallTextField
                                              ?.succeeded ??
                                          true)) {
                                        if (ValidateUserCall.isPasswordSet(
                                          (_model.validateUserCallTextField
                                                  ?.jsonBody ??
                                              ''),
                                        )!) {
                                          logFirebaseEvent(
                                              'login_emailAddress_navigate_to');

                                          context.pushNamed(
                                            'ExistingUser',
                                            queryParameters: {
                                              'email': serializeParam(
                                                _model
                                                    .loginEmailAddressTextController
                                                    .text,
                                                ParamType.String,
                                              ),
                                              'name': serializeParam(
                                                ValidateUserCall.name(
                                                  (_model.validateUserCallTextField
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        } else {
                                          logFirebaseEvent(
                                              'login_emailAddress_navigate_to');

                                          context.pushNamed(
                                            'NewUser',
                                            queryParameters: {
                                              'email': serializeParam(
                                                _model
                                                    .loginEmailAddressTextController
                                                    .text,
                                                ParamType.String,
                                              ),
                                              'firstTimeUser': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                              'tribeUID': serializeParam(
                                                getJsonField(
                                                  (_model.validateUserCallTextField
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.id''',
                                                ),
                                                ParamType.int,
                                              ),
                                              'fullName': serializeParam(
                                                ValidateUserCall.name(
                                                  (_model.validateUserCallTextField
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }
                                      } else {
                                        if ((_model.validateUserCallTextField
                                                    ?.statusCode ??
                                                200) ==
                                            404) {
                                          logFirebaseEvent(
                                              'login_emailAddress_navigate_to');

                                          context.pushNamed(
                                            'NewUser',
                                            queryParameters: {
                                              'email': serializeParam(
                                                _model
                                                    .loginEmailAddressTextController
                                                    .text,
                                                ParamType.String,
                                              ),
                                              'firstTimeUser': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                              'tribeUID': serializeParam(
                                                getJsonField(
                                                  (_model.validateUserCallTextField
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.id''',
                                                ),
                                                ParamType.int,
                                              ),
                                              'fullName': serializeParam(
                                                '',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        } else {
                                          logFirebaseEvent(
                                              'login_emailAddress_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Something went wrong... try again later',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
                                                  fontWeight: FontWeight.w600,
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
                                      }

                                      if (_shouldSetState) safeSetState(() {});
                                    },
                                    autofillHints: [AutofillHints.email],
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
                                      suffixIcon: _model
                                              .loginEmailAddressTextController!
                                              .text
                                              .isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                _model
                                                    .loginEmailAddressTextController
                                                    ?.clear();
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 22.0,
                                              ),
                                            )
                                          : null,
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
                                        0.0, 12.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'ENTRY_PAGE_PAGE_Button-Login_ON_TAP');
                                        var _shouldSetState = false;
                                        logFirebaseEvent(
                                            'Button-Login_validate_form');
                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        logFirebaseEvent(
                                            'Button-Login_backend_call');
                                        _model.validateUserCall =
                                            await ValidateUserCall.call(
                                          email: _model
                                              .loginEmailAddressTextController
                                              .text,
                                          baseURL: getRemoteConfigString(
                                              'AppBaseApiUrl'),
                                          platformId: getRemoteConfigInt(
                                                  'AppPlatformId')
                                              .toString(),
                                        );

                                        _shouldSetState = true;
                                        if ((_model
                                                .validateUserCall?.succeeded ??
                                            true)) {
                                          if (ValidateUserCall.isPasswordSet(
                                            (_model.validateUserCall
                                                    ?.jsonBody ??
                                                ''),
                                          )!) {
                                            logFirebaseEvent(
                                                'Button-Login_navigate_to');

                                            context.pushNamed(
                                              'ExistingUser',
                                              queryParameters: {
                                                'email': serializeParam(
                                                  _model
                                                      .loginEmailAddressTextController
                                                      .text,
                                                  ParamType.String,
                                                ),
                                                'name': serializeParam(
                                                  ValidateUserCall.name(
                                                    (_model.validateUserCall
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );
                                          } else {
                                            logFirebaseEvent(
                                                'Button-Login_navigate_to');

                                            context.pushNamed(
                                              'NewUser',
                                              queryParameters: {
                                                'email': serializeParam(
                                                  _model
                                                      .loginEmailAddressTextController
                                                      .text,
                                                  ParamType.String,
                                                ),
                                                'firstTimeUser': serializeParam(
                                                  false,
                                                  ParamType.bool,
                                                ),
                                                'tribeUID': serializeParam(
                                                  getJsonField(
                                                    (_model.validateUserCall
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.id''',
                                                  ),
                                                  ParamType.int,
                                                ),
                                                'fullName': serializeParam(
                                                  ValidateUserCall.name(
                                                    (_model.validateUserCall
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );

                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }
                                        } else {
                                          if ((_model.validateUserCall
                                                      ?.statusCode ??
                                                  200) ==
                                              404) {
                                            logFirebaseEvent(
                                                'Button-Login_navigate_to');

                                            context.pushNamed(
                                              'NewUser',
                                              queryParameters: {
                                                'email': serializeParam(
                                                  _model
                                                      .loginEmailAddressTextController
                                                      .text,
                                                  ParamType.String,
                                                ),
                                                'firstTimeUser': serializeParam(
                                                  true,
                                                  ParamType.bool,
                                                ),
                                                'tribeUID': serializeParam(
                                                  getJsonField(
                                                    (_model.validateUserCall
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.id''',
                                                  ),
                                                  ParamType.int,
                                                ),
                                                'fullName': serializeParam(
                                                  '',
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );

                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          } else {
                                            logFirebaseEvent(
                                                'Button-Login_show_snack_bar');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Something went wrong... try again later',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .customColor3,
                                              ),
                                            );
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                            return;
                                          }
                                        }

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                      },
                                      text: 'Find my account',
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding: EdgeInsets.all(0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Open Sans'),
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      showLoadingIndicator: false,
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
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onLongPress: () async {
                          logFirebaseEvent(
                              'ENTRY_NEED_HELP_CONTACT_SUPPORT_BTN_ON_L');
                          logFirebaseEvent('Button_navigate_to');

                          context.pushNamed('SearchieTest');
                        },
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'ENTRY_NEED_HELP_CONTACT_SUPPORT_BTN_ON_T');
                            logFirebaseEvent('Button_launch_u_r_l');
                            await launchURL(
                                getRemoteConfigString('AppSupportUrl'));
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
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Open Sans'),
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
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      SelectionArea(
                          child: Text(
                        'App Version: ${FFAppState().AppVersion}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              letterSpacing: 0.0,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Open Sans'),
                            ),
                      )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
