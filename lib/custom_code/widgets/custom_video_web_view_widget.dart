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

import 'package:webviewx_plus/webviewx_plus.dart';

class CustomVideoWebViewWidget extends StatefulWidget {
  const CustomVideoWebViewWidget({
    Key? key,
    required this.videoUrl,
    this.width,
    this.height,
  }) : super(key: key);

  final String videoUrl;
  final double? width;
  final double? height;

  @override
  _CustomVideoWebViewWidgetState createState() =>
      _CustomVideoWebViewWidgetState();
}

class _CustomVideoWebViewWidgetState extends State<CustomVideoWebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return WebViewX(
        width: widget.width ?? MediaQuery.sizeOf(context).width * 1.0,
        height: widget.height ?? MediaQuery.sizeOf(context).height * 1.0,
        initialContent: widget.videoUrl);
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
