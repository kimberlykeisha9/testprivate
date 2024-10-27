import '/acme_chat/general/option_list_row/option_list_row_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'archive_overlay_model.dart';
export 'archive_overlay_model.dart';

class ArchiveOverlayWidget extends StatefulWidget {
  const ArchiveOverlayWidget({
    super.key,
    required this.conversation,
    bool? archiveView,
  }) : this.archiveView = archiveView ?? false;

  final ConversationsRecord? conversation;
  final bool archiveView;

  @override
  State<ArchiveOverlayWidget> createState() => _ArchiveOverlayWidgetState();
}

class _ArchiveOverlayWidgetState extends State<ArchiveOverlayWidget> {
  late ArchiveOverlayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArchiveOverlayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).offWhite,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).greyBorder,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ARCHIVE_OVERLAY_Container_hw2xq8sb_ON_TA');
                if (widget!.archiveView) {
                  // Un-Archive Conversation
                  logFirebaseEvent('OptionListRow_Un-ArchiveConversation');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'ArchivedConversations': FieldValue.arrayRemove(
                            [widget!.conversation?.reference]),
                      },
                    ),
                  });
                } else {
                  // Archive Conversation
                  logFirebaseEvent('OptionListRow_ArchiveConversation');

                  await currentUserReference!.update({
                    ...mapToFirestore(
                      {
                        'ArchivedConversations': FieldValue.arrayUnion(
                            [widget!.conversation?.reference]),
                      },
                    ),
                  });
                }

                logFirebaseEvent('OptionListRow_close_dialog_drawer_etc');
                Navigator.pop(context);
              },
              child: wrapWithModel(
                model: _model.optionListRowModel,
                updateCallback: () => safeSetState(() {}),
                child: OptionListRowWidget(
                  text: widget!.archiveView ? 'Un-Archive' : 'Archive',
                  icon: Icon(
                    Icons.all_inbox_rounded,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
