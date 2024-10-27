// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MediaUrlWithTypeStruct extends FFFirebaseStruct {
  MediaUrlWithTypeStruct({
    String? url,
    MediaType? type,
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
  MediaType? _type;
  MediaType get type => _type ?? MediaType.image;
  set type(MediaType? val) => _type = val;

  bool hasType() => _type != null;

  static MediaUrlWithTypeStruct fromMap(Map<String, dynamic> data) =>
      MediaUrlWithTypeStruct(
        url: data['url'] as String?,
        type: deserializeEnum<MediaType>(data['type']),
      );

  static MediaUrlWithTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? MediaUrlWithTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'url': _url,
        'type': _type?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static MediaUrlWithTypeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MediaUrlWithTypeStruct(
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        type: deserializeParam<MediaType>(
          data['type'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'MediaUrlWithTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MediaUrlWithTypeStruct &&
        url == other.url &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([url, type]);
}

MediaUrlWithTypeStruct createMediaUrlWithTypeStruct({
  String? url,
  MediaType? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MediaUrlWithTypeStruct(
      url: url,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MediaUrlWithTypeStruct? updateMediaUrlWithTypeStruct(
  MediaUrlWithTypeStruct? mediaUrlWithType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mediaUrlWithType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMediaUrlWithTypeStructData(
  Map<String, dynamic> firestoreData,
  MediaUrlWithTypeStruct? mediaUrlWithType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mediaUrlWithType == null) {
    return;
  }
  if (mediaUrlWithType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mediaUrlWithType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mediaUrlWithTypeData =
      getMediaUrlWithTypeFirestoreData(mediaUrlWithType, forFieldValue);
  final nestedData =
      mediaUrlWithTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mediaUrlWithType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMediaUrlWithTypeFirestoreData(
  MediaUrlWithTypeStruct? mediaUrlWithType, [
  bool forFieldValue = false,
]) {
  if (mediaUrlWithType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mediaUrlWithType.toMap());

  // Add any Firestore field values
  mediaUrlWithType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMediaUrlWithTypeListFirestoreData(
  List<MediaUrlWithTypeStruct>? mediaUrlWithTypes,
) =>
    mediaUrlWithTypes
        ?.map((e) => getMediaUrlWithTypeFirestoreData(e, true))
        .toList() ??
    [];
