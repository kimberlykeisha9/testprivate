import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_grid_model.dart';
export 'dashboard_grid_model.dart';

class DashboardGridWidget extends StatefulWidget {
  const DashboardGridWidget({
    super.key,
    this.groupRef,
  });

  final DocumentReference? groupRef;

  @override
  State<DashboardGridWidget> createState() => _DashboardGridWidgetState();
}

class _DashboardGridWidgetState extends State<DashboardGridWidget> {
  late DashboardGridModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardGridModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder<TribeGroupsRecord>(
          stream: TribeGroupsRecord.getDocument(widget!.groupRef!),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).appBG,
                    ),
                  ),
                ),
              );
            }

            final getGridTribeGroupsRecord = snapshot.data!;

            return Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 50.0),
                child: Builder(
                  builder: (context) {
                    final nextSteps =
                        getGridTribeGroupsRecord.nextSteps.toList();

                    return Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children:
                          List.generate(nextSteps.length, (nextStepsIndex) {
                        final nextStepsItem = nextSteps[nextStepsIndex];
                        return Visibility(
                          visible: nextStepsItem.featureOnToday,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'DASHBOARD_GRID_Image_t287m52i_ON_TAP');
                              if (functions
                                  .isExternalUrl(nextStepsItem.ctaLink)) {
                                logFirebaseEvent('Image_launch_u_r_l');
                                await launchURL(nextStepsItem.ctaLink);
                              } else {
                                if (nextStepsItem.ctaLink == 'Events') {
                                  logFirebaseEvent('Image_navigate_to');

                                  context.pushNamed(
                                    'GroupsEvents2',
                                    queryParameters: {
                                      'groupDoc': serializeParam(
                                        getGridTribeGroupsRecord,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'groupDoc': getGridTribeGroupsRecord,
                                    },
                                  );
                                } else {
                                  if (nextStepsItem.ctaLink == 'Replays') {
                                    logFirebaseEvent('Image_navigate_to');

                                    context.pushNamed(
                                      'GroupsReplay',
                                      queryParameters: {
                                        'groupDoc': serializeParam(
                                          getGridTribeGroupsRecord,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'groupDoc': getGridTribeGroupsRecord,
                                      },
                                    );
                                  } else {
                                    if (nextStepsItem.ctaLink == 'Training') {
                                      logFirebaseEvent('Image_navigate_to');

                                      context.pushNamed(
                                        'GroupsTraining',
                                        queryParameters: {
                                          'groupDoc': serializeParam(
                                            getGridTribeGroupsRecord,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'groupDoc': getGridTribeGroupsRecord,
                                        },
                                      );
                                    } else {
                                      if (nextStepsItem.ctaLink ==
                                          'NextSteps') {
                                        logFirebaseEvent('Image_navigate_to');

                                        context.pushNamed(
                                          'GroupsNextSteps',
                                          queryParameters: {
                                            'groupRef': serializeParam(
                                              widget!.groupRef,
                                              ParamType.DocumentReference,
                                            ),
                                            'groupDoc': serializeParam(
                                              getGridTribeGroupsRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'groupDoc':
                                                getGridTribeGroupsRecord,
                                          },
                                        );
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              fadeOutDuration: Duration(milliseconds: 500),
                              imageUrl: valueOrDefault<String>(
                                nextStepsItem.featuredImage,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/ud9hnylna4th/100x-Hero-app.png',
                              ),
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
