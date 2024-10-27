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

import 'package:custom_quill_html_editor/custom_quill_html_editor.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichContentEditor extends StatefulWidget {
  const CustomRichContentEditor({
    super.key,
    this.width,
    this.height,
    this.initialContent,
  });

  final double? width;
  final double? height;
  final String? initialContent;

  @override
  State<CustomRichContentEditor> createState() =>
      _CustomRichContentEditorState();
}

class _CustomRichContentEditorState extends State<CustomRichContentEditor> {
  late QuillEditorController controller;

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      // FFAppState().CustomRichTextEditorOutput = text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customToolBarList = [
      ToolBarStyle.bold,
      ToolBarStyle.italic,
      ToolBarStyle.listBullet,
      ToolBarStyle.listOrdered,
      ToolBarStyle.link,
      ToolBarStyle.headerOne,
      ToolBarStyle.headerTwo
    ];

    return Column(
      children: [
        ToolBar(
          toolBarColor: Colors.white,
          activeIconColor: Colors.green,
          padding: const EdgeInsets.all(8),
          iconSize: 20,
          controller: controller,
          toolBarConfig: customToolBarList,
        ),
        QuillHtmlEditor(
          minHeight: widget.height ?? 150,
          controller: controller,
          // text: widget.initialContent,
          hintTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Open Sans',
              fontSize: 12.0,
              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans')),
          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Open Sans',
              fontSize: 12.0,
              useGoogleFonts: GoogleFonts.asMap().containsKey('Open Sans')),
          hintText: "Lesson Description",
        )
      ],
    );
  }
}
