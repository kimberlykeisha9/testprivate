// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VersionCheckerStruct extends FFFirebaseStruct {
  VersionCheckerStruct({
    bool? updateAvailable,
    String? currentVersion,
    String? updateVersion,
    String? storeUpdateLink,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _updateAvailable = updateAvailable,
        _currentVersion = currentVersion,
        _updateVersion = updateVersion,
        _storeUpdateLink = storeUpdateLink,
        super(firestoreUtilData);

  // "updateAvailable" field.
  bool? _updateAvailable;
  bool get updateAvailable => _updateAvailable ?? false;
  set updateAvailable(bool? val) => _updateAvailable = val;

  bool hasUpdateAvailable() => _updateAvailable != null;

  // "currentVersion" field.
  String? _currentVersion;
  String get currentVersion => _currentVersion ?? '';
  set currentVersion(String? val) => _currentVersion = val;

  bool hasCurrentVersion() => _currentVersion != null;

  // "updateVersion" field.
  String? _updateVersion;
  String get updateVersion => _updateVersion ?? '';
  set updateVersion(String? val) => _updateVersion = val;

  bool hasUpdateVersion() => _updateVersion != null;

  // "storeUpdateLink" field.
  String? _storeUpdateLink;
  String get storeUpdateLink => _storeUpdateLink ?? '';
  set storeUpdateLink(String? val) => _storeUpdateLink = val;

  bool hasStoreUpdateLink() => _storeUpdateLink != null;

  static VersionCheckerStruct fromMap(Map<String, dynamic> data) =>
      VersionCheckerStruct(
        updateAvailable: data['updateAvailable'] as bool?,
        currentVersion: data['currentVersion'] as String?,
        updateVersion: data['updateVersion'] as String?,
        storeUpdateLink: data['storeUpdateLink'] as String?,
      );

  static VersionCheckerStruct? maybeFromMap(dynamic data) => data is Map
      ? VersionCheckerStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'updateAvailable': _updateAvailable,
        'currentVersion': _currentVersion,
        'updateVersion': _updateVersion,
        'storeUpdateLink': _storeUpdateLink,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'updateAvailable': serializeParam(
          _updateAvailable,
          ParamType.bool,
        ),
        'currentVersion': serializeParam(
          _currentVersion,
          ParamType.String,
        ),
        'updateVersion': serializeParam(
          _updateVersion,
          ParamType.String,
        ),
        'storeUpdateLink': serializeParam(
          _storeUpdateLink,
          ParamType.String,
        ),
      }.withoutNulls;

  static VersionCheckerStruct fromSerializableMap(Map<String, dynamic> data) =>
      VersionCheckerStruct(
        updateAvailable: deserializeParam(
          data['updateAvailable'],
          ParamType.bool,
          false,
        ),
        currentVersion: deserializeParam(
          data['currentVersion'],
          ParamType.String,
          false,
        ),
        updateVersion: deserializeParam(
          data['updateVersion'],
          ParamType.String,
          false,
        ),
        storeUpdateLink: deserializeParam(
          data['storeUpdateLink'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VersionCheckerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VersionCheckerStruct &&
        updateAvailable == other.updateAvailable &&
        currentVersion == other.currentVersion &&
        updateVersion == other.updateVersion &&
        storeUpdateLink == other.storeUpdateLink;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([updateAvailable, currentVersion, updateVersion, storeUpdateLink]);
}

VersionCheckerStruct createVersionCheckerStruct({
  bool? updateAvailable,
  String? currentVersion,
  String? updateVersion,
  String? storeUpdateLink,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VersionCheckerStruct(
      updateAvailable: updateAvailable,
      currentVersion: currentVersion,
      updateVersion: updateVersion,
      storeUpdateLink: storeUpdateLink,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VersionCheckerStruct? updateVersionCheckerStruct(
  VersionCheckerStruct? versionChecker, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    versionChecker
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVersionCheckerStructData(
  Map<String, dynamic> firestoreData,
  VersionCheckerStruct? versionChecker,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (versionChecker == null) {
    return;
  }
  if (versionChecker.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && versionChecker.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final versionCheckerData =
      getVersionCheckerFirestoreData(versionChecker, forFieldValue);
  final nestedData =
      versionCheckerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = versionChecker.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVersionCheckerFirestoreData(
  VersionCheckerStruct? versionChecker, [
  bool forFieldValue = false,
]) {
  if (versionChecker == null) {
    return {};
  }
  final firestoreData = mapToFirestore(versionChecker.toMap());

  // Add any Firestore field values
  versionChecker.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVersionCheckerListFirestoreData(
  List<VersionCheckerStruct>? versionCheckers,
) =>
    versionCheckers
        ?.map((e) => getVersionCheckerFirestoreData(e, true))
        .toList() ??
    [];
