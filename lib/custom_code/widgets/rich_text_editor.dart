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

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'dart:convert';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({
    super.key,
    this.width,
    this.height,
    this.initialText,
    required this.onChangeText,
  });

  final double? width;
  final double? height;
  final String? initialText;
  final Future Function(String text) onChangeText;

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  late QuillController _controller;
  late Delta delta;
  final FocusNode _focusNode = FocusNode();
  QuillDeltaToHtmlConverter converter(List<Map<String, dynamic>> ops) {
    return QuillDeltaToHtmlConverter(ops);
  }

  String escapeDoubleQuotes(String input) {
    print(input.replaceAll('"', r'\"'));
    return input.replaceAll('"', r'\"');
  }

  String encodeHtml(String input) {
    String convert = input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;');
    ;
    print(convert);
    return convert;
  }

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
  void initState() {
    super.initState();
    if (widget.initialText == null || (widget.initialText ?? '').isEmpty) {
      _controller = QuillController.basic();
    } else {
      Delta content =
          HtmlToDelta().convert(decodeHtml(widget.initialText ?? '<p></p>'));
      print(content.toJson());
      _controller = QuillController(
        document: Document.fromJson(content.toJson()),
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    _controller.addListener(() async {
      String newText =
          converter(_controller.document.toDelta().toJson()).convert();
      await widget.onChangeText(encodeHtml(newText));
      print(newText);
      setState(() {
        FFAppState().update(() {
          // FFAppState().CustomRichTextEditorOutput = newText;
        });
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        QuillToolbar.simple(
          controller: _controller,
          configurations: QuillSimpleToolbarConfigurations(
            toolbarIconAlignment: WrapAlignment.start,
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                iconTheme: QuillIconTheme(
                  iconButtonSelectedData:
                      IconButtonData(color: Colors.green, iconSize: 20),
                  iconButtonUnselectedData: IconButtonData(iconSize: 20),
                ),
              ),
            ),
            sectionDividerColor: Colors.transparent,
            toolbarSectionSpacing: 10,
            showDividers: false,
            showFontFamily: false,
            showFontSize: false,
            showStrikeThrough: false,
            showInlineCode: false,
            showColorButton: false,
            showBackgroundColorButton: false,
            showClearFormat: false,
            showListCheck: false,
            showLeftAlignment: false,
            showCenterAlignment: false,
            showRightAlignment: false,
            showJustifyAlignment: false,
            showCodeBlock: false,
            showQuote: false,
            showIndent: false,
            showUndo: false,
            showRedo: false,
            showSearchButton: false,
            showSubscript: false,
            showSuperscript: false,
            showUnderLineButton: false,
            showClipboardCut: false,
            showClipboardCopy: false,
            showClipboardPaste: false,
          ),
        ),
        Expanded(
          child: QuillEditor.basic(
            focusNode: _focusNode,
            controller: _controller,
            configurations: QuillEditorConfigurations(
              autoFocus: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}

dynamic convertToJson(String json) {
  json = json.replaceAll('{', '{"');
  json = json.replaceAll(': ', '": "');
  json = json.replaceAll(', ', '", "');
  json = json.replaceAll('}', '"}');

  json = json.replaceAll('"{', '{');
  json = json.replaceAll('}"', '}');
  json = json.replaceAll('\n', '\\n');
  json = json.replaceAll('""', '"null"');
  return json;
}
