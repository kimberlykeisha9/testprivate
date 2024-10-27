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

import 'index.dart'; // Imports other custom widgets

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:chunked_stream/chunked_stream.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import '/auth/firebase_auth/auth_util.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Uploader extends StatefulWidget {
  const Uploader(
      {Key? key,
      this.width,
      this.height,
      required this.title,
      required this.description,
      required this.onSuccessfulUpload,
      required this.onDelete,
      required this.videoAlreadyUploaded})
      : super(key: key);

  final double? width;
  final double? height;
  final String title;
  final String description;
  final Future Function(String link) onSuccessfulUpload;
  final Future Function() onDelete;
  final bool videoAlreadyUploaded;

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  static const chunkSize = 64 * 1024 * 1024; // 64MB
  Uint8List? webImage;
  bool uploaded = false;
  String? result;
  String object = "";
  bool? isImageTapped;
  bool? isVideoTapped;
  var isLoaderStart = 0;
  String fileType = '';
  File? fileresult;
  double _uploadProgress = 0.0;
  bool _videoUploaded = false; // State variable to track video upload status

  @override
  void initState() {
    super.initState();
    _videoUploaded = widget.videoAlreadyUploaded; // Initialize state variable
  }

  @override
  void didUpdateWidget(covariant Uploader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoAlreadyUploaded != oldWidget.videoAlreadyUploaded) {
      setState(() {
        _videoUploaded = widget.videoAlreadyUploaded;
      });
    }
  }

  Future<void> showPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
      withData: false,
      withReadStream: true,
    );

    if (result != null) {
      var file = result.files.singleOrNull;
      if (file == null) {
        return;
      }

      String currentPhoneDate =
          DateTime.now().millisecondsSinceEpoch.toString();
      String ext = path.extension(file.name).toLowerCase();

      if (!_isFileSupported(ext)) {
        print('Invalid file format. Please select a .mov or .mp4 file.');
        return;
      }

      object = "$currentPhoneDate$ext";
      var stream = file.readStream;

      if (stream != null) {
        setState(() {
          isLoaderStart = 1;
          FFAppState().uploaded = object;
        });

        print('Uploading to $object');
        _uploadStreamToS3(stream, file.size);
      } else {
        print("Stream is null");
      }
    } else {
      // User cancelled the picker
      print('NO RESULT FROM VIDEO PICK');
    }
  }

  bool _isFileSupported(String ext) {
    return ext == '.mov' || ext == '.mp4';
  }

  _uploadStreamToS3(Stream<List<int>> fileStream, int totalSize) async {
    String s3AccessKey = getRemoteConfigString('s3AccessKey');
    String s3SecretKey = getRemoteConfigString('s3SecretKey');
    String s3EndpointURL = getRemoteConfigString('s3EndpointURL');
    String s3BucketName = getRemoteConfigString('s3BucketName');
    final bucketName = s3BucketName;

    AwsClientCredentials credentials = AwsClientCredentials(
      accessKey: s3AccessKey,
      secretKey: s3SecretKey,
    );

    S3 s3api = S3(
      region: 'us-east-2',
      endpointUrl: s3EndpointURL,
      credentials: credentials,
    );

    final objectKey = "videos/$object";

    var createUploadResult = await s3api.createMultipartUpload(
      bucket: bucketName,
      key: objectKey,
      acl: ObjectCannedACL.publicRead,
    );

    final uploadId = createUploadResult.uploadId;
    if (uploadId == null) {
      return;
    }

    int index = 0;
    List<CompletedPart> completedList = List.empty(growable: true);
    final reader = ChunkedStreamIterator(fileStream);
    int uploadedSize = 0;

    while (true) {
      var chunk = await reader.read(chunkSize);
      if (chunk.isEmpty) {
        break;
      }

      final result = await s3api.uploadPart(
        bucket: bucketName,
        key: objectKey,
        body: Uint8List.fromList(chunk),
        partNumber: index + 1,
        uploadId: uploadId,
      );

      completedList
          .add(CompletedPart(partNumber: index + 1, eTag: result.eTag));
      index++;

      uploadedSize += chunk.length;
      if (mounted) {
        setState(() {
          _uploadProgress = uploadedSize / totalSize;
        });
      }
    }

    CompletedMultipartUpload upload =
        CompletedMultipartUpload(parts: completedList);

    await s3api.completeMultipartUpload(
      bucket: bucketName,
      key: objectKey,
      uploadId: uploadId,
      multipartUpload: upload,
    );

    if (mounted) {
      setState(() {
        isLoaderStart = 0;
        uploaded = false;
        _videoUploaded = true; // Update state variable
        _uploadProgress = 1.0; // Set progress to 100%
      });
    }

    _updateUploadedDataUrlState("videos/$object");
  }

  _updateUploadedDataUrlState(String filename) async {
    final uploadedVideoUrl = "${getRemoteConfigString('cdnBaseUrl')}$filename";
    setState(() {
      print("Uploaded file url: $uploadedVideoUrl");
    });
    await widget.onSuccessfulUpload(uploadedVideoUrl);
  }

  String getRemoteConfigString(String key) =>
      FirebaseRemoteConfig.instance.getString(key);

  _clearImagePath() async {
    await widget.onDelete();
    setState(() {
      isLoaderStart = 0;
      _videoUploaded = false; // Update state variable
      object = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        if (isLoaderStart == 1)
          // Show uploading progress indicator
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Video is being uploaded..."),
              SizedBox(height: 20),
              LinearProgressIndicator(),
              SizedBox(height: 10),
            ],
          )
        else if (_videoUploaded)
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                _clearImagePath();
              },
              child: const Text("Clear"),
            ),
          )
        else
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                showPicker();
              },
              child: const Text("Upload New Video"),
            ),
          ),
      ],
    );
  }
}
