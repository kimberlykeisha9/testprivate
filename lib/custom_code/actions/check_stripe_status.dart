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

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool?> checkStripeStatus(
  String productId,
  String email,
  String apiKey,
) async {
  // Add your function code here!
  final apiUrl =
      'https://api.stripe.com/v1/subscriptions?status=active&customer_email=$email&plan=$productId';

  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/x-www-form-urlencoded',
  });

  if (response.statusCode == 200) {
    // Parse the response JSON
    final jsonResponse = json.decode(response.body);

    // Check if the customer has an active subscription for the given product ID
    if (jsonResponse['data'].isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else {
    // If the response status code is not 200, the request failed
    return false;
  }
}
