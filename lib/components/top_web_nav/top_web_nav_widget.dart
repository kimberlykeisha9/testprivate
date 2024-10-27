import '/backend/backend.dart';
import '/components/group_list_content_web/group_list_content_web_widget.dart';
import '/components/profile_button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/groups/group_components/group_navigation/group_navigation_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'top_web_nav_model.dart';
export 'top_web_nav_model.dart';

class TopWebNavWidget extends StatefulWidget {
  const TopWebNavWidget({
    super.key,
    this.groupDoc,
  });

  final TribeGroupsRecord? groupDoc;

  @override
  State<TopWebNavWidget> createState() => _TopWebNavWidgetState();
}

class _TopWebNavWidgetState extends State<TopWebNavWidget> {
  late TopWebNavModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopWebNavModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, -1.0),
        child: Container(
          width: 1000.0,
          decoration: BoxDecoration(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'TOP_WEB_NAV_Container_14k2h665_ON_TAP');
                                  logFirebaseEvent('Container_navigate_to');

                                  context.pushNamed(
                                    'GroupList',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  constraints: BoxConstraints(
                                    minWidth: 0.0,
                                    maxWidth: 200.0,
                                    maxHeight: 50.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        Duration(milliseconds: 500),
                                    imageUrl: valueOrDefault<String>(
                                      functions.stringToImgPath(
                                          getRemoteConfigString('AppLogo')),
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/eYvlXG3XFCRvJh9O3gRm/assets/ckno2i5pqlpe/Tribe_2023_TM_Light_trim.png',
                                    ),
                                    fit: BoxFit.contain,
                                    alignment: Alignment(-1.0, 0.0),
                                    errorWidget: (context, error, stackTrace) =>
                                        Image.asset(
                                      'assets/images/error_image.jpg',
                                      fit: BoxFit.contain,
                                      alignment: Alignment(-1.0, 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: 200.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Color(0x3757636C),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 0.0, 0.0),
                                          child: SelectionArea(
                                              child: AutoSizeText(
                                            valueOrDefault<String>(
                                              widget!.groupDoc == null
                                                  ? 'Select ${getRemoteConfigString('Copy_Group')}'
                                                  : widget!.groupDoc?.name,
                                              'Select ',
                                            ),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            minFontSize: 14.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) =>
                                          FlutterFlowIconButton(
                                        borderWidth: 1.0,
                                        buttonSize: 44.0,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'TOP_WEB_NAV_keyboard_arrow_down_outlined');
                                          logFirebaseEvent(
                                              'IconButton_alert_dialog');
                                          showAlignedDialog(
                                            barrierColor: Colors.transparent,
                                            context: context,
                                            isGlobal: false,
                                            avoidOverflow: true,
                                            targetAnchor: AlignmentDirectional(
                                                    1.0, -1.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            followerAnchor:
                                                AlignmentDirectional(1.0, -1.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                            builder: (dialogContext) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: WebViewAware(
                                                  child:
                                                      GroupListContentWebWidget(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.profileButtonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ProfileButtonWidget(),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(width: 12.0)),
                  ),
                ),
                if (valueOrDefault<bool>(
                  widget!.groupDoc != null,
                  false,
                ))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: wrapWithModel(
                          model: _model.groupNavigationModel,
                          updateCallback: () => safeSetState(() {}),
                          child: GroupNavigationWidget(
                            groupDoc: widget!.groupDoc!,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
