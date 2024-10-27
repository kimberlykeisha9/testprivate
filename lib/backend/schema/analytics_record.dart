import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AnalyticsRecord extends FirestoreRecord {
  AnalyticsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "tribeGroupId" field.
  int? _tribeGroupId;
  int get tribeGroupId => _tribeGroupId ?? 0;
  bool hasTribeGroupId() => _tribeGroupId != null;

  // "period" field.
  AnalyticsPeriod? _period;
  AnalyticsPeriod? get period => _period;
  bool hasPeriod() => _period != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "totalPosts" field.
  double? _totalPosts;
  double get totalPosts => _totalPosts ?? 0.0;
  bool hasTotalPosts() => _totalPosts != null;

  // "totalLivePosts" field.
  double? _totalLivePosts;
  double get totalLivePosts => _totalLivePosts ?? 0.0;
  bool hasTotalLivePosts() => _totalLivePosts != null;

  // "totalComments" field.
  double? _totalComments;
  double get totalComments => _totalComments ?? 0.0;
  bool hasTotalComments() => _totalComments != null;

  void _initializeFields() {
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _tribeGroupId = castToType<int>(snapshotData['tribeGroupId']);
    _period = deserializeEnum<AnalyticsPeriod>(snapshotData['period']);
    _startDate = snapshotData['startDate'] as DateTime?;
    _endDate = snapshotData['endDate'] as DateTime?;
    _groupName = snapshotData['groupName'] as String?;
    _totalPosts = castToType<double>(snapshotData['totalPosts']);
    _totalLivePosts = castToType<double>(snapshotData['totalLivePosts']);
    _totalComments = castToType<double>(snapshotData['totalComments']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Analytics');

  static Stream<AnalyticsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AnalyticsRecord.fromSnapshot(s));

  static Future<AnalyticsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AnalyticsRecord.fromSnapshot(s));

  static AnalyticsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AnalyticsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AnalyticsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AnalyticsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AnalyticsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AnalyticsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAnalyticsRecordData({
  DocumentReference? groupRef,
  int? tribeGroupId,
  AnalyticsPeriod? period,
  DateTime? startDate,
  DateTime? endDate,
  String? groupName,
  double? totalPosts,
  double? totalLivePosts,
  double? totalComments,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'groupRef': groupRef,
      'tribeGroupId': tribeGroupId,
      'period': period,
      'startDate': startDate,
      'endDate': endDate,
      'groupName': groupName,
      'totalPosts': totalPosts,
      'totalLivePosts': totalLivePosts,
      'totalComments': totalComments,
    }.withoutNulls,
  );

  return firestoreData;
}

class AnalyticsRecordDocumentEquality implements Equality<AnalyticsRecord> {
  const AnalyticsRecordDocumentEquality();

  @override
  bool equals(AnalyticsRecord? e1, AnalyticsRecord? e2) {
    return e1?.groupRef == e2?.groupRef &&
        e1?.tribeGroupId == e2?.tribeGroupId &&
        e1?.period == e2?.period &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.groupName == e2?.groupName &&
        e1?.totalPosts == e2?.totalPosts &&
        e1?.totalLivePosts == e2?.totalLivePosts &&
        e1?.totalComments == e2?.totalComments;
  }

  @override
  int hash(AnalyticsRecord? e) => const ListEquality().hash([
        e?.groupRef,
        e?.tribeGroupId,
        e?.period,
        e?.startDate,
        e?.endDate,
        e?.groupName,
        e?.totalPosts,
        e?.totalLivePosts,
        e?.totalComments
      ]);

  @override
  bool isValidKey(Object? o) => o is AnalyticsRecord;
}
