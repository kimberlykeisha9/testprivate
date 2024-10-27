// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserBadgesStruct extends FFFirebaseStruct {
  UserBadgesStruct({
    String? badgeName,
    DocumentReference? badgeGroupRef,
    String? badgeImg,
    int? badgeOrder,
    List<DocumentReference>? badgeUsers,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _badgeName = badgeName,
        _badgeGroupRef = badgeGroupRef,
        _badgeImg = badgeImg,
        _badgeOrder = badgeOrder,
        _badgeUsers = badgeUsers,
        super(firestoreUtilData);

  // "BadgeName" field.
  String? _badgeName;
  String get badgeName => _badgeName ?? '';
  set badgeName(String? val) => _badgeName = val;

  bool hasBadgeName() => _badgeName != null;

  // "BadgeGroupRef" field.
  DocumentReference? _badgeGroupRef;
  DocumentReference? get badgeGroupRef => _badgeGroupRef;
  set badgeGroupRef(DocumentReference? val) => _badgeGroupRef = val;

  bool hasBadgeGroupRef() => _badgeGroupRef != null;

  // "BadgeImg" field.
  String? _badgeImg;
  String get badgeImg => _badgeImg ?? '';
  set badgeImg(String? val) => _badgeImg = val;

  bool hasBadgeImg() => _badgeImg != null;

  // "BadgeOrder" field.
  int? _badgeOrder;
  int get badgeOrder => _badgeOrder ?? 0;
  set badgeOrder(int? val) => _badgeOrder = val;

  void incrementBadgeOrder(int amount) => badgeOrder = badgeOrder + amount;

  bool hasBadgeOrder() => _badgeOrder != null;

  // "BadgeUsers" field.
  List<DocumentReference>? _badgeUsers;
  List<DocumentReference> get badgeUsers => _badgeUsers ?? const [];
  set badgeUsers(List<DocumentReference>? val) => _badgeUsers = val;

  void updateBadgeUsers(Function(List<DocumentReference>) updateFn) {
    updateFn(_badgeUsers ??= []);
  }

  bool hasBadgeUsers() => _badgeUsers != null;

  static UserBadgesStruct fromMap(Map<String, dynamic> data) =>
      UserBadgesStruct(
        badgeName: data['BadgeName'] as String?,
        badgeGroupRef: data['BadgeGroupRef'] as DocumentReference?,
        badgeImg: data['BadgeImg'] as String?,
        badgeOrder: castToType<int>(data['BadgeOrder']),
        badgeUsers: getDataList(data['BadgeUsers']),
      );

  static UserBadgesStruct? maybeFromMap(dynamic data) => data is Map
      ? UserBadgesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'BadgeName': _badgeName,
        'BadgeGroupRef': _badgeGroupRef,
        'BadgeImg': _badgeImg,
        'BadgeOrder': _badgeOrder,
        'BadgeUsers': _badgeUsers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'BadgeName': serializeParam(
          _badgeName,
          ParamType.String,
        ),
        'BadgeGroupRef': serializeParam(
          _badgeGroupRef,
          ParamType.DocumentReference,
        ),
        'BadgeImg': serializeParam(
          _badgeImg,
          ParamType.String,
        ),
        'BadgeOrder': serializeParam(
          _badgeOrder,
          ParamType.int,
        ),
        'BadgeUsers': serializeParam(
          _badgeUsers,
          ParamType.DocumentReference,
          isList: true,
        ),
      }.withoutNulls;

  static UserBadgesStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserBadgesStruct(
        badgeName: deserializeParam(
          data['BadgeName'],
          ParamType.String,
          false,
        ),
        badgeGroupRef: deserializeParam(
          data['BadgeGroupRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['TribeGroups'],
        ),
        badgeImg: deserializeParam(
          data['BadgeImg'],
          ParamType.String,
          false,
        ),
        badgeOrder: deserializeParam(
          data['BadgeOrder'],
          ParamType.int,
          false,
        ),
        badgeUsers: deserializeParam<DocumentReference>(
          data['BadgeUsers'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['user'],
        ),
      );

  @override
  String toString() => 'UserBadgesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserBadgesStruct &&
        badgeName == other.badgeName &&
        badgeGroupRef == other.badgeGroupRef &&
        badgeImg == other.badgeImg &&
        badgeOrder == other.badgeOrder &&
        listEquality.equals(badgeUsers, other.badgeUsers);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([badgeName, badgeGroupRef, badgeImg, badgeOrder, badgeUsers]);
}

UserBadgesStruct createUserBadgesStruct({
  String? badgeName,
  DocumentReference? badgeGroupRef,
  String? badgeImg,
  int? badgeOrder,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserBadgesStruct(
      badgeName: badgeName,
      badgeGroupRef: badgeGroupRef,
      badgeImg: badgeImg,
      badgeOrder: badgeOrder,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserBadgesStruct? updateUserBadgesStruct(
  UserBadgesStruct? userBadges, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userBadges
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserBadgesStructData(
  Map<String, dynamic> firestoreData,
  UserBadgesStruct? userBadges,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userBadges == null) {
    return;
  }
  if (userBadges.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userBadges.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userBadgesData = getUserBadgesFirestoreData(userBadges, forFieldValue);
  final nestedData = userBadgesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userBadges.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserBadgesFirestoreData(
  UserBadgesStruct? userBadges, [
  bool forFieldValue = false,
]) {
  if (userBadges == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userBadges.toMap());

  // Add any Firestore field values
  userBadges.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserBadgesListFirestoreData(
  List<UserBadgesStruct>? userBadgess,
) =>
    userBadgess?.map((e) => getUserBadgesFirestoreData(e, true)).toList() ?? [];
