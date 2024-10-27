// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VideoTypeStruct extends FFFirebaseStruct {
  VideoTypeStruct({
    String? url,
    String? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _url = url,
        _type = type,
        super(firestoreUtilData);

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static VideoTypeStruct fromMap(Map<String, dynamic> data) => VideoTypeStruct(
        url: data['url'] as String?,
        type: data['type'] as String?,
      );

  static VideoTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? VideoTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'url': _url,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static VideoTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      VideoTypeStruct(
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VideoTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VideoTypeStruct && url == other.url && type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([url, type]);
}

VideoTypeStruct createVideoTypeStruct({
  String? url,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VideoTypeStruct(
      url: url,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VideoTypeStruct? updateVideoTypeStruct(
  VideoTypeStruct? videoType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    videoType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVideoTypeStructData(
  Map<String, dynamic> firestoreData,
  VideoTypeStruct? videoType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (videoType == null) {
    return;
  }
  if (videoType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && videoType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final videoTypeData = getVideoTypeFirestoreData(videoType, forFieldValue);
  final nestedData = videoTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = videoType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVideoTypeFirestoreData(
  VideoTypeStruct? videoType, [
  bool forFieldValue = false,
]) {
  if (videoType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(videoType.toMap());

  // Add any Firestore field values
  videoType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVideoTypeListFirestoreData(
  List<VideoTypeStruct>? videoTypes,
) =>
    videoTypes?.map((e) => getVideoTypeFirestoreData(e, true)).toList() ?? [];
