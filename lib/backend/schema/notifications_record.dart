import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "time_created" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "DiscussionPostRef" field.
  DocumentReference? _discussionPostRef;
  DocumentReference? get discussionPostRef => _discussionPostRef;
  bool hasDiscussionPostRef() => _discussionPostRef != null;

  // "TribeCollectionsRef" field.
  DocumentReference? _tribeCollectionsRef;
  DocumentReference? get tribeCollectionsRef => _tribeCollectionsRef;
  bool hasTribeCollectionsRef() => _tribeCollectionsRef != null;

  // "UserRefList" field.
  List<DocumentReference>? _userRefList;
  List<DocumentReference> get userRefList => _userRefList ?? const [];
  bool hasUserRefList() => _userRefList != null;

  // "hasBeenRead" field.
  bool? _hasBeenRead;
  bool get hasBeenRead => _hasBeenRead ?? false;
  bool hasHasBeenRead() => _hasBeenRead != null;

  // "viewedBy" field.
  List<DocumentReference>? _viewedBy;
  List<DocumentReference> get viewedBy => _viewedBy ?? const [];
  bool hasViewedBy() => _viewedBy != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _timeCreated = snapshotData['time_created'] as DateTime?;
    _discussionPostRef =
        snapshotData['DiscussionPostRef'] as DocumentReference?;
    _tribeCollectionsRef =
        snapshotData['TribeCollectionsRef'] as DocumentReference?;
    _userRefList = getDataList(snapshotData['UserRefList']);
    _hasBeenRead = snapshotData['hasBeenRead'] as bool?;
    _viewedBy = getDataList(snapshotData['viewedBy']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? title,
  String? description,
  DateTime? timeCreated,
  DocumentReference? discussionPostRef,
  DocumentReference? tribeCollectionsRef,
  bool? hasBeenRead,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'time_created': timeCreated,
      'DiscussionPostRef': discussionPostRef,
      'TribeCollectionsRef': tribeCollectionsRef,
      'hasBeenRead': hasBeenRead,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.discussionPostRef == e2?.discussionPostRef &&
        e1?.tribeCollectionsRef == e2?.tribeCollectionsRef &&
        listEquality.equals(e1?.userRefList, e2?.userRefList) &&
        e1?.hasBeenRead == e2?.hasBeenRead &&
        listEquality.equals(e1?.viewedBy, e2?.viewedBy);
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.timeCreated,
        e?.discussionPostRef,
        e?.tribeCollectionsRef,
        e?.userRefList,
        e?.hasBeenRead,
        e?.viewedBy
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
