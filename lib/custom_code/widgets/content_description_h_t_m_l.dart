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

class ContentDescriptionHTML extends StatefulWidget {
  final String htmlContent;
  final double width;
  final double height;

  const ContentDescriptionHTML({
    Key? key,
    required this.htmlContent,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ContentDescriptionHTMLState createState() => _ContentDescriptionHTMLState();
}

class _ContentDescriptionHTMLState extends State<ContentDescriptionHTML> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isExpanded)
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpanded = false;
                });
              },
              child: const Text('Close Description'),
            ),
          ),
        Container(
          width: widget.width,
          height: isExpanded ? null : widget.height,
          child: SingleChildScrollView(
            child: Html(
              data: isExpanded ? widget.htmlContent : _truncatedHtml(),
              style: {
                "body": Style(
                  color: Colors.black87,
                ),
              },
              onLinkTap:
                  (String? url, Map<String, String> attributes, Element) {
                if (url != null) {
                  _launchUrl(url);
                }
              },
              // Use a custom image render or another callback for image tap events
            ),
          ),
        ),
      ],
    );
  }

  String _truncatedHtml() {
    // Check if content length is less than or equal to 160 characters
    if (widget.htmlContent.length <= 160) {
      return widget.htmlContent;
    } else {
      // Find the last space before character 160 to avoid breaking a word
      int cutoffIndex = widget.htmlContent.lastIndexOf(' ', 160);
      cutoffIndex = cutoffIndex > 0 ? cutoffIndex : 160;
      String truncatedContent = widget.htmlContent.substring(0, cutoffIndex);
      // Only add 'read more' link if truncated content is longer than 140 characters
      if (cutoffIndex > 140) {
        truncatedContent += '... <a href="readmore">read more</a>';
      }
      return truncatedContent;
    }
  }

  void _launchUrl(String url) async {
    if (url == 'readmore') {
      setState(() {
        isExpanded = true;
      });
    } else if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
