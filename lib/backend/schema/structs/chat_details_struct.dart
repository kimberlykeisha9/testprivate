// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatDetailsStruct extends FFFirebaseStruct {
  ChatDetailsStruct({
    int? id,
    DocumentReference? userRef,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _userRef = userRef,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  static ChatDetailsStruct fromMap(Map<String, dynamic> data) =>
      ChatDetailsStruct(
        id: castToType<int>(data['id']),
        userRef: data['userRef'] as DocumentReference?,
      );

  static ChatDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'userRef': _userRef,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static ChatDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatDetailsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['user'],
        ),
      );

  @override
  String toString() => 'ChatDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatDetailsStruct &&
        id == other.id &&
        userRef == other.userRef;
  }

  @override
  int get hashCode => const ListEquality().hash([id, userRef]);
}

ChatDetailsStruct createChatDetailsStruct({
  int? id,
  DocumentReference? userRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatDetailsStruct(
      id: id,
      userRef: userRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatDetailsStruct? updateChatDetailsStruct(
  ChatDetailsStruct? chatDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatDetailsStructData(
  Map<String, dynamic> firestoreData,
  ChatDetailsStruct? chatDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatDetails == null) {
    return;
  }
  if (chatDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatDetailsData =
      getChatDetailsFirestoreData(chatDetails, forFieldValue);
  final nestedData =
      chatDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chatDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatDetailsFirestoreData(
  ChatDetailsStruct? chatDetails, [
  bool forFieldValue = false,
]) {
  if (chatDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatDetails.toMap());

  // Add any Firestore field values
  chatDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatDetailsListFirestoreData(
  List<ChatDetailsStruct>? chatDetailss,
) =>
    chatDetailss?.map((e) => getChatDetailsFirestoreData(e, true)).toList() ??
    [];
