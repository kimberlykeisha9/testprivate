import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContentSharesRecord extends FirestoreRecord {
  ContentSharesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "contentid" field.
  int? _contentid;
  int get contentid => _contentid ?? 0;
  bool hasContentid() => _contentid != null;

  // "userEmail" field.
  String? _userEmail;
  String get userEmail => _userEmail ?? '';
  bool hasUserEmail() => _userEmail != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "userDisplayName" field.
  String? _userDisplayName;
  String get userDisplayName => _userDisplayName ?? '';
  bool hasUserDisplayName() => _userDisplayName != null;

  // "CreatedTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "ContentRef" field.
  DocumentReference? _contentRef;
  DocumentReference? get contentRef => _contentRef;
  bool hasContentRef() => _contentRef != null;

  void _initializeFields() {
    _contentid = castToType<int>(snapshotData['contentid']);
    _userEmail = snapshotData['userEmail'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _userDisplayName = snapshotData['userDisplayName'] as String?;
    _createdTime = snapshotData['CreatedTime'] as DateTime?;
    _contentRef = snapshotData['ContentRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ContentShares');

  static Stream<ContentSharesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContentSharesRecord.fromSnapshot(s));

  static Future<ContentSharesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContentSharesRecord.fromSnapshot(s));

  static ContentSharesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContentSharesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContentSharesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContentSharesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContentSharesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContentSharesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContentSharesRecordData({
  int? contentid,
  String? userEmail,
  DocumentReference? userRef,
  String? userDisplayName,
  DateTime? createdTime,
  DocumentReference? contentRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'contentid': contentid,
      'userEmail': userEmail,
      'userRef': userRef,
      'userDisplayName': userDisplayName,
      'CreatedTime': createdTime,
      'ContentRef': contentRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContentSharesRecordDocumentEquality
    implements Equality<ContentSharesRecord> {
  const ContentSharesRecordDocumentEquality();

  @override
  bool equals(ContentSharesRecord? e1, ContentSharesRecord? e2) {
    return e1?.contentid == e2?.contentid &&
        e1?.userEmail == e2?.userEmail &&
        e1?.userRef == e2?.userRef &&
        e1?.userDisplayName == e2?.userDisplayName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.contentRef == e2?.contentRef;
  }

  @override
  int hash(ContentSharesRecord? e) => const ListEquality().hash([
        e?.contentid,
        e?.userEmail,
        e?.userRef,
        e?.userDisplayName,
        e?.createdTime,
        e?.contentRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ContentSharesRecord;
}
