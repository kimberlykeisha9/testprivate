import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeCourseRecord extends FirestoreRecord {
  TribeCourseRecord._(
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

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "featuredImage" field.
  String? _featuredImage;
  String get featuredImage => _featuredImage ?? '';
  bool hasFeaturedImage() => _featuredImage != null;

  // "tribeCollectionRef" field.
  List<DocumentReference>? _tribeCollectionRef;
  List<DocumentReference> get tribeCollectionRef =>
      _tribeCollectionRef ?? const [];
  bool hasTribeCollectionRef() => _tribeCollectionRef != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "contentIDs" field.
  List<int>? _contentIDs;
  List<int> get contentIDs => _contentIDs ?? const [];
  bool hasContentIDs() => _contentIDs != null;

  // "accessType" field.
  String? _accessType;
  String get accessType => _accessType ?? '';
  bool hasAccessType() => _accessType != null;

  // "isEmptyCourse" field.
  bool? _isEmptyCourse;
  bool get isEmptyCourse => _isEmptyCourse ?? false;
  bool hasIsEmptyCourse() => _isEmptyCourse != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _featuredImage = snapshotData['featuredImage'] as String?;
    _tribeCollectionRef = getDataList(snapshotData['tribeCollectionRef']);
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _contentIDs = getDataList(snapshotData['contentIDs']);
    _accessType = snapshotData['accessType'] as String?;
    _isEmptyCourse = snapshotData['isEmptyCourse'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TribeCourse');

  static Stream<TribeCourseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TribeCourseRecord.fromSnapshot(s));

  static Future<TribeCourseRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TribeCourseRecord.fromSnapshot(s));

  static TribeCourseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TribeCourseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TribeCourseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TribeCourseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TribeCourseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TribeCourseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTribeCourseRecordData({
  String? title,
  String? description,
  DocumentReference? groupRef,
  String? featuredImage,
  DateTime? createdTime,
  String? accessType,
  bool? isEmptyCourse,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'groupRef': groupRef,
      'featuredImage': featuredImage,
      'createdTime': createdTime,
      'accessType': accessType,
      'isEmptyCourse': isEmptyCourse,
    }.withoutNulls,
  );

  return firestoreData;
}

class TribeCourseRecordDocumentEquality implements Equality<TribeCourseRecord> {
  const TribeCourseRecordDocumentEquality();

  @override
  bool equals(TribeCourseRecord? e1, TribeCourseRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.groupRef == e2?.groupRef &&
        e1?.featuredImage == e2?.featuredImage &&
        listEquality.equals(e1?.tribeCollectionRef, e2?.tribeCollectionRef) &&
        e1?.createdTime == e2?.createdTime &&
        listEquality.equals(e1?.contentIDs, e2?.contentIDs) &&
        e1?.accessType == e2?.accessType &&
        e1?.isEmptyCourse == e2?.isEmptyCourse;
  }

  @override
  int hash(TribeCourseRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.groupRef,
        e?.featuredImage,
        e?.tribeCollectionRef,
        e?.createdTime,
        e?.contentIDs,
        e?.accessType,
        e?.isEmptyCourse
      ]);

  @override
  bool isValidKey(Object? o) => o is TribeCourseRecord;
}
