import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppVersionRecord extends FirestoreRecord {
  AppVersionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "AppVersion" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  bool hasAppVersion() => _appVersion != null;

  // "Index" field.
  String? _index;
  String get index => _index ?? '';
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _appVersion = snapshotData['AppVersion'] as String?;
    _index = snapshotData['Index'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('AppVersion');

  static Stream<AppVersionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppVersionRecord.fromSnapshot(s));

  static Future<AppVersionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppVersionRecord.fromSnapshot(s));

  static AppVersionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppVersionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppVersionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppVersionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppVersionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppVersionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppVersionRecordData({
  String? appVersion,
  String? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'AppVersion': appVersion,
      'Index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppVersionRecordDocumentEquality implements Equality<AppVersionRecord> {
  const AppVersionRecordDocumentEquality();

  @override
  bool equals(AppVersionRecord? e1, AppVersionRecord? e2) {
    return e1?.appVersion == e2?.appVersion && e1?.index == e2?.index;
  }

  @override
  int hash(AppVersionRecord? e) =>
      const ListEquality().hash([e?.appVersion, e?.index]);

  @override
  bool isValidKey(Object? o) => o is AppVersionRecord;
}
