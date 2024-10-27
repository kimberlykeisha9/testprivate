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

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    Key? key,
    required this.endTime,
    this.width,
    this.height,
  }) : super(key: key);

  final DateTime endTime;
  final double? width;
  final double? height;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _timeUntilEnd = Duration.zero;

  Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeUntilEnd = widget.endTime.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntilEnd = widget.endTime.difference(DateTime.now());
      });

      if (_timeUntilEnd.inSeconds <= 0) {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int days = _timeUntilEnd.inDays;
    int hours = _timeUntilEnd.inHours.remainder(24);
    int minutes = _timeUntilEnd.inMinutes.remainder(60);
    int seconds = _timeUntilEnd.inSeconds.remainder(60);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCountdownItem('DAYS', days.toString().padLeft(2, '0')),
          _buildCountdownItem('HRS', hours.toString().padLeft(2, '0')),
          _buildCountdownItem('MIN', minutes.toString().padLeft(2, '0')),
          _buildCountdownItem('SEC', seconds.toString().padLeft(2, '0')),
        ],
      ),
    );
  }

  Widget _buildCountdownItem(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!
