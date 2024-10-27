// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AspectRatioStruct extends FFFirebaseStruct {
  AspectRatioStruct({
    String? name,
    double? ratio,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _ratio = ratio,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "ratio" field.
  double? _ratio;
  double get ratio => _ratio ?? 0.0;
  set ratio(double? val) => _ratio = val;

  void incrementRatio(double amount) => ratio = ratio + amount;

  bool hasRatio() => _ratio != null;

  static AspectRatioStruct fromMap(Map<String, dynamic> data) =>
      AspectRatioStruct(
        name: data['name'] as String?,
        ratio: castToType<double>(data['ratio']),
      );

  static AspectRatioStruct? maybeFromMap(dynamic data) => data is Map
      ? AspectRatioStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'ratio': _ratio,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'ratio': serializeParam(
          _ratio,
          ParamType.double,
        ),
      }.withoutNulls;

  static AspectRatioStruct fromSerializableMap(Map<String, dynamic> data) =>
      AspectRatioStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        ratio: deserializeParam(
          data['ratio'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'AspectRatioStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AspectRatioStruct &&
        name == other.name &&
        ratio == other.ratio;
  }

  @override
  int get hashCode => const ListEquality().hash([name, ratio]);
}

AspectRatioStruct createAspectRatioStruct({
  String? name,
  double? ratio,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AspectRatioStruct(
      name: name,
      ratio: ratio,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AspectRatioStruct? updateAspectRatioStruct(
  AspectRatioStruct? aspectRatio, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    aspectRatio
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAspectRatioStructData(
  Map<String, dynamic> firestoreData,
  AspectRatioStruct? aspectRatio,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (aspectRatio == null) {
    return;
  }
  if (aspectRatio.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && aspectRatio.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final aspectRatioData =
      getAspectRatioFirestoreData(aspectRatio, forFieldValue);
  final nestedData =
      aspectRatioData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = aspectRatio.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAspectRatioFirestoreData(
  AspectRatioStruct? aspectRatio, [
  bool forFieldValue = false,
]) {
  if (aspectRatio == null) {
    return {};
  }
  final firestoreData = mapToFirestore(aspectRatio.toMap());

  // Add any Firestore field values
  aspectRatio.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAspectRatioListFirestoreData(
  List<AspectRatioStruct>? aspectRatios,
) =>
    aspectRatios?.map((e) => getAspectRatioFirestoreData(e, true)).toList() ??
    [];
