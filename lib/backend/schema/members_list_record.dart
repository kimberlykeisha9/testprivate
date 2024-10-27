import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MembersListRecord extends FirestoreRecord {
  MembersListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _role = snapshotData['role'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('membersList')
          : FirebaseFirestore.instance.collectionGroup('membersList');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('membersList').doc(id);

  static Stream<MembersListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MembersListRecord.fromSnapshot(s));

  static Future<MembersListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MembersListRecord.fromSnapshot(s));

  static MembersListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MembersListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MembersListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MembersListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MembersListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MembersListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMembersListRecordData({
  DocumentReference? userRef,
  String? role,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'role': role,
    }.withoutNulls,
  );

  return firestoreData;
}

class MembersListRecordDocumentEquality implements Equality<MembersListRecord> {
  const MembersListRecordDocumentEquality();

  @override
  bool equals(MembersListRecord? e1, MembersListRecord? e2) {
    return e1?.userRef == e2?.userRef && e1?.role == e2?.role;
  }

  @override
  int hash(MembersListRecord? e) =>
      const ListEquality().hash([e?.userRef, e?.role]);

  @override
  bool isValidKey(Object? o) => o is MembersListRecord;
}
