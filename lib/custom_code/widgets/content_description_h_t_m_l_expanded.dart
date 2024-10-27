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

import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart'
    as domCustom; // Correctly prefixed import for html package

class ContentDescriptionHTMLExpanded extends StatefulWidget {
  final String htmlContent;
  final double width;
  final double height;
  final bool isExpanded;

  const ContentDescriptionHTMLExpanded({
    Key? key,
    required this.htmlContent,
    required this.width,
    required this.height,
    required this.isExpanded,
  }) : super(key: key);

  @override
  _ContentDescriptionHTMLExpandedState createState() =>
      _ContentDescriptionHTMLExpandedState();
}

class _ContentDescriptionHTMLExpandedState
    extends State<ContentDescriptionHTMLExpanded> {
  String decodeHtml(String input) {
    String convert = input
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"');
    ;
    print(convert);
    return convert;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.isExpanded ? null : widget.height,
      child: SingleChildScrollView(
        child: Html(
          data: widget.isExpanded
              ? decodeHtml(widget.htmlContent)
              : _truncatedHtml(),
          style: {
            "body": Style(
              color: Colors.black87,
            ),
          },
          onLinkTap: (url, _, __) {
            if (url != null) {
              _launchURL(url);
            }
          },
          // Use a custom image render or another callback for image tap events
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    await launchURL(url);
  }

  String _truncatedHtml() {
    String decoded = decodeHtml(widget.htmlContent);
    // Check if content length is less than or equal to 160 characters
    if (decoded.length <= 160) {
      return decoded;
    } else {
      // Find the last space before character 160 to avoid breaking a word
      int cutoffIndex = decoded.lastIndexOf(' ', 160);
      cutoffIndex = cutoffIndex > 0 ? cutoffIndex : 160;
      String truncatedContent = decoded.substring(0, cutoffIndex);
      // Only add 'read more' link if truncated content is longer than 140 characters
      if (cutoffIndex > 140) {
        truncatedContent += '... <a href="readmore">read more</a>';
      }
      return truncatedContent;
    }
  }
}
