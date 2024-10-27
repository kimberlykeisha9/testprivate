import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/create_account_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/groups/group_components/post_options_f_b/post_options_f_b_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/request_manager.dart';

import 'feed_post_item_widget.dart' show FeedPostItemWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class FeedPostItemModel extends FlutterFlowModel<FeedPostItemWidget> {
  /// Query cache managers for this widget.

  final _userBadgesManager = FutureRequestManager<UserRecord>();
  Future<UserRecord> userBadges({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UserRecord> Function() requestFn,
  }) =>
      _userBadgesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserBadgesCache() => _userBadgesManager.clear();
  void clearUserBadgesCacheKey(String? uniqueKey) =>
      _userBadgesManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearUserBadgesCache();
  }
}
