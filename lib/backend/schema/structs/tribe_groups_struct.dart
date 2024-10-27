// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeGroupsStruct extends FFFirebaseStruct {
  TribeGroupsStruct({
    int? tribeGroupID,
    DocumentReference? groupRef,
    String? role,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _tribeGroupID = tribeGroupID,
        _groupRef = groupRef,
        _role = role,
        super(firestoreUtilData);

  // "TribeGroupID" field.
  int? _tribeGroupID;
  int get tribeGroupID => _tribeGroupID ?? 0;
  set tribeGroupID(int? val) => _tribeGroupID = val;

  void incrementTribeGroupID(int amount) =>
      tribeGroupID = tribeGroupID + amount;

  bool hasTribeGroupID() => _tribeGroupID != null;

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  set groupRef(DocumentReference? val) => _groupRef = val;

  bool hasGroupRef() => _groupRef != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  static TribeGroupsStruct fromMap(Map<String, dynamic> data) =>
      TribeGroupsStruct(
        tribeGroupID: castToType<int>(data['TribeGroupID']),
        groupRef: data['groupRef'] as DocumentReference?,
        role: data['role'] as String?,
      );

  static TribeGroupsStruct? maybeFromMap(dynamic data) => data is Map
      ? TribeGroupsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'TribeGroupID': _tribeGroupID,
        'groupRef': _groupRef,
        'role': _role,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'TribeGroupID': serializeParam(
          _tribeGroupID,
          ParamType.int,
        ),
        'groupRef': serializeParam(
          _groupRef,
          ParamType.DocumentReference,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
      }.withoutNulls;

  static TribeGroupsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TribeGroupsStruct(
        tribeGroupID: deserializeParam(
          data['TribeGroupID'],
          ParamType.int,
          false,
        ),
        groupRef: deserializeParam(
          data['groupRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['TribeGroups'],
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TribeGroupsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TribeGroupsStruct &&
        tribeGroupID == other.tribeGroupID &&
        groupRef == other.groupRef &&
        role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([tribeGroupID, groupRef, role]);
}

TribeGroupsStruct createTribeGroupsStruct({
  int? tribeGroupID,
  DocumentReference? groupRef,
  String? role,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TribeGroupsStruct(
      tribeGroupID: tribeGroupID,
      groupRef: groupRef,
      role: role,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TribeGroupsStruct? updateTribeGroupsStruct(
  TribeGroupsStruct? tribeGroups, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tribeGroups
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTribeGroupsStructData(
  Map<String, dynamic> firestoreData,
  TribeGroupsStruct? tribeGroups,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tribeGroups == null) {
    return;
  }
  if (tribeGroups.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tribeGroups.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tribeGroupsData =
      getTribeGroupsFirestoreData(tribeGroups, forFieldValue);
  final nestedData =
      tribeGroupsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tribeGroups.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTribeGroupsFirestoreData(
  TribeGroupsStruct? tribeGroups, [
  bool forFieldValue = false,
]) {
  if (tribeGroups == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tribeGroups.toMap());

  // Add any Firestore field values
  tribeGroups.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTribeGroupsListFirestoreData(
  List<TribeGroupsStruct>? tribeGroupss,
) =>
    tribeGroupss?.map((e) => getTribeGroupsFirestoreData(e, true)).toList() ??
    [];
