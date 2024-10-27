import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/new_chat/main_components/new_chat_component/new_chat_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'page_new_chat_model.dart';
export 'page_new_chat_model.dart';

class PageNewChatWidget extends StatefulWidget {
  /// This is the WIP new chat page.
  const PageNewChatWidget({super.key});

  @override
  State<PageNewChatWidget> createState() => _PageNewChatWidgetState();
}

class _PageNewChatWidgetState extends State<PageNewChatWidget> {
  late PageNewChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageNewChatModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Page-NewChat'});
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(80.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('PAGE_NEW_CHAT_PAGE_Text_xgrxtt28_ON_TAP');
                    logFirebaseEvent('Text_navigate_back');
                    context.safePop();
                  },
                  child: Text(
                    'Groups Page',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          color: FlutterFlowTheme.of(context).grey2,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelLargeFamily),
                        ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(),
                    child: StreamBuilder<List<ConversationsRecord>>(
                      stream: queryConversationsRecord(
                        queryBuilder: (conversationsRecord) =>
                            conversationsRecord
                                .where(
                                  'Users',
                                  arrayContains: currentUserReference,
                                )
                                .orderBy('LastMessageTime', descending: true),
                      ),
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
                        List<ConversationsRecord>
                            newChatComponentConversationsRecordList =
                            snapshot.data!;

                        return wrapWithModel(
                          model: _model.newChatComponentModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NewChatComponentWidget(
                            conversations:
                                newChatComponentConversationsRecordList,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
