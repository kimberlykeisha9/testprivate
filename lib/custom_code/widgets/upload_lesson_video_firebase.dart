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

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class UploadLessonVideoFirebase extends StatefulWidget {
  const UploadLessonVideoFirebase({
    super.key,
    this.width,
    this.height,
    required this.onSuccessfulUpload,
    required this.group,
  });

  final double? width;
  final double? height;
  final Future Function(String link) onSuccessfulUpload;
  final String group;

  @override
  State<UploadLessonVideoFirebase> createState() =>
      _UploadLessonVideoFirebaseState();
}

class _UploadLessonVideoFirebaseState extends State<UploadLessonVideoFirebase> {
  bool _uploading = false;
  double _progress = 0.0;
  String? _downloadUrl;

  Future<void> _uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      Uint8List? videoBytes = result.files.single.bytes;

      if (videoBytes!.lengthInBytes > (5 * 1024 * 1024 * 1024)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File size exceeds 5GB limit")),
        );
        return;
      }

      setState(() {
        _uploading = true;
        _downloadUrl = null; // Reset download URL
      });

      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        String fileName = result.files.single.name;
        Reference ref = storage.ref().child('videos/${widget.group}/$fileName');
        UploadTask uploadTask = ref.putData(videoBytes!);

        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            _progress =
                snapshot.bytesTransferred / snapshot.totalBytes.toDouble();
          });
        });

        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          setState(() {
            _downloadUrl = downloadUrl;
            widget.onSuccessfulUpload(downloadUrl);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Upload complete")),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: $e")),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _uploading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: _progress),
              SizedBox(height: 20),
              Text('${(_progress * 100).toStringAsFixed(2)}% uploaded'),
            ],
          )
        : Center(
            child: ElevatedButton(
              onPressed: _uploadVideo,
              child: Text("Upload Video"),
            ),
          );
  }
}
