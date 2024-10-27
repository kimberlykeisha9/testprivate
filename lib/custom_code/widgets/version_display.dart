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

import 'package:package_info_plus/package_info_plus.dart';

class VersionDisplay extends StatefulWidget {
  const VersionDisplay({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<VersionDisplay> createState() => _VersionDisplayState();
}

class _VersionDisplayState extends State<VersionDisplay> {
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(10), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Colors.white, // Adjust background color as needed
        borderRadius: BorderRadius.circular(10), // Optional rounded corners
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Version: $_version',
            style: TextStyle(fontSize: 16), // Adjust text style as needed
          ),
          SizedBox(height: 4), // Space between version and build number
          Text(
            'Build: $_buildNumber',
            style: TextStyle(fontSize: 16), // Adjust text style as needed
          ),
        ],
      ),
    );
  }
}
