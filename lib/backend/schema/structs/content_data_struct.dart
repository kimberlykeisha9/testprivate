// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContentDataStruct extends FFFirebaseStruct {
  ContentDataStruct({
    DocumentReference? contentRef,
    int? contentID,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _contentRef = contentRef,
        _contentID = contentID,
        super(firestoreUtilData);

  // "contentRef" field.
  DocumentReference? _contentRef;
  DocumentReference? get contentRef => _contentRef;
  set contentRef(DocumentReference? val) => _contentRef = val;

  bool hasContentRef() => _contentRef != null;

  // "contentID" field.
  int? _contentID;
  int get contentID => _contentID ?? 0;
  set contentID(int? val) => _contentID = val;

  void incrementContentID(int amount) => contentID = contentID + amount;

  bool hasContentID() => _contentID != null;

  static ContentDataStruct fromMap(Map<String, dynamic> data) =>
      ContentDataStruct(
        contentRef: data['contentRef'] as DocumentReference?,
        contentID: castToType<int>(data['contentID']),
      );

  static ContentDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ContentDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'contentRef': _contentRef,
        'contentID': _contentID,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'contentRef': serializeParam(
          _contentRef,
          ParamType.DocumentReference,
        ),
        'contentID': serializeParam(
          _contentID,
          ParamType.int,
        ),
      }.withoutNulls;

  static ContentDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContentDataStruct(
        contentRef: deserializeParam(
          data['contentRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['TribeContent'],
        ),
        contentID: deserializeParam(
          data['contentID'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ContentDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContentDataStruct &&
        contentRef == other.contentRef &&
        contentID == other.contentID;
  }

  @override
  int get hashCode => const ListEquality().hash([contentRef, contentID]);
}

ContentDataStruct createContentDataStruct({
  DocumentReference? contentRef,
  int? contentID,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContentDataStruct(
      contentRef: contentRef,
      contentID: contentID,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContentDataStruct? updateContentDataStruct(
  ContentDataStruct? contentData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contentData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContentDataStructData(
  Map<String, dynamic> firestoreData,
  ContentDataStruct? contentData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contentData == null) {
    return;
  }
  if (contentData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contentData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contentDataData =
      getContentDataFirestoreData(contentData, forFieldValue);
  final nestedData =
      contentDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contentData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContentDataFirestoreData(
  ContentDataStruct? contentData, [
  bool forFieldValue = false,
]) {
  if (contentData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contentData.toMap());

  // Add any Firestore field values
  contentData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContentDataListFirestoreData(
  List<ContentDataStruct>? contentDatas,
) =>
    contentDatas?.map((e) => getContentDataFirestoreData(e, true)).toList() ??
    [];
