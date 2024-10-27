// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomDataStruct extends FFFirebaseStruct {
  RoomDataStruct({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    String? viewerCode,
    String? broadcasterCode,
    List<String>? sessions,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _description = description,
        _createdAt = createdAt,
        _viewerCode = viewerCode,
        _broadcasterCode = broadcasterCode,
        _sessions = sessions,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "viewerCode" field.
  String? _viewerCode;
  String get viewerCode => _viewerCode ?? '';
  set viewerCode(String? val) => _viewerCode = val;

  bool hasViewerCode() => _viewerCode != null;

  // "broadcasterCode" field.
  String? _broadcasterCode;
  String get broadcasterCode => _broadcasterCode ?? '';
  set broadcasterCode(String? val) => _broadcasterCode = val;

  bool hasBroadcasterCode() => _broadcasterCode != null;

  // "sessions" field.
  List<String>? _sessions;
  List<String> get sessions => _sessions ?? const [];
  set sessions(List<String>? val) => _sessions = val;

  void updateSessions(Function(List<String>) updateFn) {
    updateFn(_sessions ??= []);
  }

  bool hasSessions() => _sessions != null;

  static RoomDataStruct fromMap(Map<String, dynamic> data) => RoomDataStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        createdAt: data['createdAt'] as String?,
        viewerCode: data['viewerCode'] as String?,
        broadcasterCode: data['broadcasterCode'] as String?,
        sessions: getDataList(data['sessions']),
      );

  static RoomDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? RoomDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'description': _description,
        'createdAt': _createdAt,
        'viewerCode': _viewerCode,
        'broadcasterCode': _broadcasterCode,
        'sessions': _sessions,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'viewerCode': serializeParam(
          _viewerCode,
          ParamType.String,
        ),
        'broadcasterCode': serializeParam(
          _broadcasterCode,
          ParamType.String,
        ),
        'sessions': serializeParam(
          _sessions,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static RoomDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
        viewerCode: deserializeParam(
          data['viewerCode'],
          ParamType.String,
          false,
        ),
        broadcasterCode: deserializeParam(
          data['broadcasterCode'],
          ParamType.String,
          false,
        ),
        sessions: deserializeParam<String>(
          data['sessions'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'RoomDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RoomDataStruct &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        createdAt == other.createdAt &&
        viewerCode == other.viewerCode &&
        broadcasterCode == other.broadcasterCode &&
        listEquality.equals(sessions, other.sessions);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        description,
        createdAt,
        viewerCode,
        broadcasterCode,
        sessions
      ]);
}

RoomDataStruct createRoomDataStruct({
  String? id,
  String? name,
  String? description,
  String? createdAt,
  String? viewerCode,
  String? broadcasterCode,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomDataStruct(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      viewerCode: viewerCode,
      broadcasterCode: broadcasterCode,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomDataStruct? updateRoomDataStruct(
  RoomDataStruct? roomData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomDataStructData(
  Map<String, dynamic> firestoreData,
  RoomDataStruct? roomData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomData == null) {
    return;
  }
  if (roomData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomDataData = getRoomDataFirestoreData(roomData, forFieldValue);
  final nestedData = roomDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = roomData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomDataFirestoreData(
  RoomDataStruct? roomData, [
  bool forFieldValue = false,
]) {
  if (roomData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomData.toMap());

  // Add any Firestore field values
  roomData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomDataListFirestoreData(
  List<RoomDataStruct>? roomDatas,
) =>
    roomDatas?.map((e) => getRoomDataFirestoreData(e, true)).toList() ?? [];
