import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttachmentsRecord extends FirestoreRecord {
  AttachmentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _url = snapshotData['url'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('attachments')
          : FirebaseFirestore.instance.collectionGroup('attachments');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('attachments').doc(id);

  static Stream<AttachmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AttachmentsRecord.fromSnapshot(s));

  static Future<AttachmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AttachmentsRecord.fromSnapshot(s));

  static AttachmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AttachmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AttachmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AttachmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AttachmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AttachmentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAttachmentsRecordData({
  String? name,
  String? url,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'url': url,
    }.withoutNulls,
  );

  return firestoreData;
}

class AttachmentsRecordDocumentEquality implements Equality<AttachmentsRecord> {
  const AttachmentsRecordDocumentEquality();

  @override
  bool equals(AttachmentsRecord? e1, AttachmentsRecord? e2) {
    return e1?.name == e2?.name && e1?.url == e2?.url;
  }

  @override
  int hash(AttachmentsRecord? e) =>
      const ListEquality().hash([e?.name, e?.url]);

  @override
  bool isValidKey(Object? o) => o is AttachmentsRecord;
}
