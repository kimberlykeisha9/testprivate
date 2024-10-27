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

Future<RoomDataStruct> createRoom(
    String name, String description, String templateId, String token) async {
  // Add your function code here!
  var _headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  // Create a new room
  var _body = json.encode(
      {"name": name, "description": description, "template_id": templateId});

  var roomResponse = await http.post(
    Uri.parse('https://api.100ms.live/v2/rooms'),
    headers: _headers,
    body: _body,
  );

  print(roomResponse.statusCode);
  print(roomResponse.body);

  if (roomResponse.statusCode != 200) {
    print('Error creating room: ${roomResponse.body}');
    throw Exception('Failed to create room');
  }

  var roomData = jsonDecode(roomResponse.body);
  RoomData room = RoomData(
    id: roomData['id'],
    name: roomData['name'],
    description: roomData['description'],
    createdAt: roomData['created_at'],
  );

  // Create room codes
  var codeResponse = await http.post(
    Uri.parse('https://api.100ms.live/v2/room-codes/room/${room.id}'),
    headers: _headers,
  );

  print(codeResponse.statusCode);
  print(codeResponse.body);

  if (codeResponse.statusCode != 200) {
    print('Error creating room codes: ${codeResponse.body}');
    throw Exception('Failed to create room codes');
  }

  var codes = jsonDecode(codeResponse.body)['data'];

  // Use `firstWhere` to find the broadcaster and viewer codes
  String? broadcasterCode = codes.firstWhere(
      (item) => item['role'] == 'broadcaster',
      orElse: () => null)?['code'];
  String? viewerCode = codes.firstWhere((item) => item['role'] == 'viewer',
      orElse: () => null)?['code'];

  // Return the room with updated codes
  room = room.copyWith(
    broadcasterCode: broadcasterCode,
    viewerCode: viewerCode,
  );

  return RoomDataStruct(
    id: room.id,
    name: room.name,
    description: room.description,
    createdAt: room.createdAt,
    viewerCode: room.viewerCode,
    broadcasterCode: room.broadcasterCode,
  );
}

class RoomData {
  String id;
  String name;
  String description;
  String createdAt;
  String? viewerCode;
  String? broadcasterCode;

  RoomData({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    this.viewerCode,
    this.broadcasterCode,
  });

  RoomData copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    String? viewerCode,
    String? broadcasterCode,
  }) {
    return RoomData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      viewerCode: viewerCode ?? this.viewerCode,
      broadcasterCode: broadcasterCode ?? this.broadcasterCode,
    );
  }
}
