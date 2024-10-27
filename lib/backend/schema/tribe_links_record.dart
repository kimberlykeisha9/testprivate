import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeLinksRecord extends FirestoreRecord {
  TribeLinksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "link" field.
  String? _link;
  String get link => _link ?? '';
  bool hasLink() => _link != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  void _initializeFields() {
    _link = snapshotData['link'] as String?;
    _text = snapshotData['text'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TribeLinks');

  static Stream<TribeLinksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TribeLinksRecord.fromSnapshot(s));

  static Future<TribeLinksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TribeLinksRecord.fromSnapshot(s));

  static TribeLinksRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TribeLinksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TribeLinksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TribeLinksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TribeLinksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TribeLinksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTribeLinksRecordData({
  String? link,
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'link': link,
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class TribeLinksRecordDocumentEquality implements Equality<TribeLinksRecord> {
  const TribeLinksRecordDocumentEquality();

  @override
  bool equals(TribeLinksRecord? e1, TribeLinksRecord? e2) {
    return e1?.link == e2?.link && e1?.text == e2?.text;
  }

  @override
  int hash(TribeLinksRecord? e) =>
      const ListEquality().hash([e?.link, e?.text]);

  @override
  bool isValidKey(Object? o) => o is TribeLinksRecord;
}
