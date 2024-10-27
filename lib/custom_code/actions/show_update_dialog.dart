// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:upgrader/upgrader.dart';

Future showUpdateDialog(
  BuildContext context,
  String? customTitle,
  String? customMessage,
  bool? force,
  bool? showReleaseNotes,
  Future Function()? onIgnore,
  Future Function()? onLater,
  Future Function()? onUpdate,
) async {
  if (Platform.isAndroid || Platform.isIOS) {
    final upgrader = Upgrader();
    await upgrader.initialize();
    if (context.mounted &&
        upgrader.verifyInit() &&
        upgrader.state.versionInfo != null &&
        upgrader.shouldDisplayUpgrade()) {
      final messageData = upgrader.determineMessages(context);
      final isBlocked = (force ?? false) || upgrader.blocked();
      final isCupertino = Platform.isIOS;
      final title =
          customTitle ?? messageData.message(UpgraderMessage.title) ?? '';
      final releaseNotes =
          (showReleaseNotes ?? false) ? upgrader.releaseNotes : null;

      final content = Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: isCupertino
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(customMessage ??
                  messageData.message(UpgraderMessage.prompt) ??
                  ''),
              if (releaseNotes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: isCupertino
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        messageData.message(UpgraderMessage.releaseNotes) ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(releaseNotes),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
      final actions = [
        if (isBlocked ? false : true)
          button(isCupertino,
              messageData.message(UpgraderMessage.buttonTitleIgnore), () {
            if (upgrader.state.debugLogging)
              debugPrint('upgrader: button tapped: ignore');
            onIgnore?.call();
            upgrader.saveIgnored();
            Navigator.of(context).pop();
          }),
        if (isBlocked ? false : true)
          button(isCupertino,
              messageData.message(UpgraderMessage.buttonTitleLater), () {
            if (upgrader.state.debugLogging)
              debugPrint('upgrader: button tapped: later');
            onLater?.call();
            Navigator.of(context).pop();
          }),
        button(
            isCupertino, messageData.message(UpgraderMessage.buttonTitleUpdate),
            () {
          if (upgrader.state.debugLogging)
            debugPrint('upgrader: button tapped: update now');
          onUpdate?.call();
          upgrader.sendUserToAppStore();
          if (!isBlocked) Navigator.of(context).pop();
        }),
      ];

      await upgrader.saveLastAlerted();
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: !isBlocked,
          builder: (context) => isCupertino
              ? CupertinoAlertDialog(
                  title: Text(title), content: content, actions: actions)
              : AlertDialog(
                  title: Text(title), content: content, actions: actions),
        );
      }
    }
  }
}

Widget button(bool isCupertino, String? text, VoidCallback? onPressed) {
  return isCupertino
      ? CupertinoDialogAction(onPressed: onPressed, child: Text(text ?? ''))
      : TextButton(onPressed: onPressed, child: Text(text ?? ''));
}
