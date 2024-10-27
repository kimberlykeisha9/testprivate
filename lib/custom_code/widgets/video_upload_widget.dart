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

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class VideoUploadWidget extends StatefulWidget {
  final double width;
  final double height;
  final String apiKey;

  const VideoUploadWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.apiKey,
  }) : super(key: key);

  @override
  _VideoUploadWidgetState createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  bool _isUploading = false;
  String _uploadStatus = '';

  Future<void> _pickAndUploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );

    if (result != null) {
      setState(() {
        _isUploading = true;
        _uploadStatus = 'Uploading video...';
      });

      PlatformFile file = result.files.first;
      Uint8List? fileBytes = file.bytes;
      String fileName = file.name;

      if (fileBytes != null) {
        try {
          String? assetId = await _uploadFileToLivepeer(fileBytes, fileName);
          if (assetId != null) {
            // Set the assetId in the app state.
            FFAppState().uploadedVideoAssetId = assetId;
            _uploadStatus = 'Upload complete! Asset ID: $assetId';
          } else {
            _uploadStatus = 'Failed to get asset ID';
          }
        } catch (e) {
          _uploadStatus = 'Failed to upload video: $e';
        } finally {
          setState(() {
            _isUploading = false;
          });
        }
      } else {
        _uploadStatus = 'Failed to load video bytes';
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<String?> _uploadFileToLivepeer(
      Uint8List fileBytes, String fileName) async {
    final response = await http.post(
      Uri.parse('https://livepeer.studio/api/asset/request-upload'),
      headers: {
        'Authorization': 'Bearer ${widget.apiKey}',
        'Content-Type': 'application/json',
      },
      body: json.encode({'name': fileName}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final assetId = data['asset']['id'];
      final uploadUrl = data['url'];

      final uploadResponse = await http.put(
        Uri.parse(uploadUrl),
        headers: {'Content-Type': 'video/mp4'},
        body: fileBytes,
      );

      if (uploadResponse.statusCode == 200) {
        return assetId;
      } else {
        throw Exception('Failed to upload video to Livepeer');
      }
    } else {
      throw Exception(
          'Failed to request upload URL from Livepeer: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _isUploading ? null : _pickAndUploadVideo,
            child: Text(_isUploading ? 'Uploading...' : 'Upload Video'),
          ),
          SizedBox(height: 20),
          Text(_uploadStatus),
        ],
      ),
    );
  }
}
