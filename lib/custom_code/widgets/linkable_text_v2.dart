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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class LinkableTextV2 extends StatefulWidget {
  const LinkableTextV2({
    super.key,
    this.width,
    this.height, // Optional, could be removed if you always want it dynamic
    required this.text,
    this.textSize,
    this.limitTextLength, // Nullable boolean parameter
  });

  final double? width;
  final double? height;
  final String text;
  final double? textSize;
  final bool? limitTextLength; // Nullable boolean parameter

  @override
  State<LinkableTextV2> createState() => _LinkableTextState();
}

class _LinkableTextState extends State<LinkableTextV2> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    TextStyle normalStyle = TextStyle(
      fontSize: widget.textSize ?? 14.0,
      color: Colors.black,
    );

    TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: widget.textSize ?? 14.0,
      color: Colors.black,
    );

    TextStyle linkStyle = TextStyle(
      color: theme.primaryColor,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.bold,
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
          return text.substring(0, urlStart) + url;
        }
      }
      return text.substring(0, maxLength) + '...';
    }

    // Function to parse bold text
    List<InlineSpan> parseBoldText(
        String text, TextStyle normalStyle, TextStyle boldStyle) {
      final boldRegExp = RegExp(r'<b>(.*?)<\/b>', caseSensitive: false);
      List<InlineSpan> spans = [];
      int lastMatchEnd = 0;

      final matches = boldRegExp.allMatches(text);
      for (final match in matches) {
        // Add normal text before the bold tag
        if (match.start > lastMatchEnd) {
          spans.add(TextSpan(
              text: text.substring(lastMatchEnd, match.start),
              style: normalStyle));
        }

        // Add bold text
        spans.add(TextSpan(text: match.group(1), style: boldStyle));

        lastMatchEnd = match.end;
      }

      // Add remaining normal text after the last bold tag
      if (lastMatchEnd < text.length) {
        spans.add(
            TextSpan(text: text.substring(lastMatchEnd), style: normalStyle));
      }

      return spans;
    }

    // Function to handle both <b> tags and URLs
    List<InlineSpan> parseText(String text) {
      final urlRegExp = RegExp(r'(https?:\/\/[^\s]+)');
      final boldRegExp = RegExp(r'<b>(.*?)<\/b>', caseSensitive: false);
      List<InlineSpan> spans = [];
      int lastMatchEnd = 0;

      final matches = urlRegExp.allMatches(text);
      for (final match in matches) {
        // Add normal and bold text before the URL
        if (match.start > lastMatchEnd) {
          final normalText = text.substring(lastMatchEnd, match.start);
          spans.addAll(parseBoldText(normalText, normalStyle, boldStyle));
        }

        // Add the URL text
        spans.add(
          TextSpan(
            text: match.group(0),
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final url = match.group(0);
                if (await canLaunch(url!)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
          ),
        );
        lastMatchEnd = match.end;
      }

      // Add remaining text after the last URL
      if (lastMatchEnd < text.length) {
        spans.addAll(parseBoldText(
            text.substring(lastMatchEnd), normalStyle, boldStyle));
      }

      return spans;
    }

    // Determine the displayed text
    String displayText = (widget.limitTextLength ?? false)
        ? truncateTextWithUrl(widget.text, 275)
        : widget.text;

    return Container(
      width: widget.width,
      child: RichText(
        text: TextSpan(
          children: parseText(displayText),
        ),
      ),
    );
  }
}
