// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({
    Key? key,
    this.width,
    this.height,
    required this.link,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String link;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      // Mobile platforms: Request permissions
      requestPermissions();
    }
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.link)),
        initialSettings: settings,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
              resources: request.resources,
              action: PermissionResponseAction.GRANT);
        },
      ),
    );
  }
}
