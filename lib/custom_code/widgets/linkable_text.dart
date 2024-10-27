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

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkableText extends StatefulWidget {
  const LinkableText({
    super.key,
    this.width,
    this.height, // Optional, could be removed if you always want it dynamic
    required this.text,
    this.textSize,
    this.limitTextLength, // Nullable boolean parameter
    this.textColor, // Add the textColor parameter
  });

  final double? width;
  final double? height;
  final String text;
  final double? textSize;
  final bool? limitTextLength; // Nullable boolean parameter
  final Color? textColor; // New textColor parameter

  @override
  State<LinkableText> createState() => _LinkableTextState();
}

class _LinkableTextState extends State<LinkableText> {
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context); // Access your theme data

    TextStyle normalStyle = TextStyle(
      fontSize: widget.textSize ?? 14.0,
      color: widget.textColor ??
          Colors
              .white, // Dynamically use the provided textColor or default to white
      decoration: TextDecoration.none,
    );

    TextStyle linkStyle = TextStyle(
      decoration: TextDecoration.underline, // Underline for link text
      fontWeight: FontWeight.bold, // Optional: Make link text bold
    );

    // Function to extract URLs
    String? extractUrl(String text) {
      final RegExp urlRegExp = RegExp(
        r'(https?:\/\/[^\s]+)',
        caseSensitive: false,
      );
      final urlMatch = urlRegExp.firstMatch(text);
      return urlMatch?.group(0);
    }

    // Function to truncate text and keep URLs intact
    String truncateTextWithUrl(String text, int maxLength) {
      if (text.length <= maxLength) return text;

      final url = extractUrl(text);
      if (url != null) {
        // Check if URL starts within the limit
        int urlStart = text.indexOf(url);
        if (urlStart < maxLength) {
          // Allow the URL to extend beyond the maxLength if it starts within limit
          return text.substring(0, urlStart) + url;
        }
      }
      return text.substring(0, maxLength) + '...';
    }

    // Determine the displayed text
    String displayText = (widget.limitTextLength ?? false)
        ? truncateTextWithUrl(widget.text, 275)
        : widget.text;

    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
            text: displayText,
            style: normalStyle,
            linkStyle: linkStyle,
          ),
        ],
      ),
    );
  }
}
