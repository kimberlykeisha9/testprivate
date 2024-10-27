import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CompletedTasksRecord extends FirestoreRecord {
  CompletedTasksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "collectionRef" field.
  DocumentReference? _collectionRef;
  DocumentReference? get collectionRef => _collectionRef;
  bool hasCollectionRef() => _collectionRef != null;

  // "comments" field.
  String? _comments;
  String get comments => _comments ?? '';
  bool hasComments() => _comments != null;

  // "completedDate" field.
  DateTime? _completedDate;
  DateTime? get completedDate => _completedDate;
  bool hasCompletedDate() => _completedDate != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "todoRef" field.
  DocumentReference? _todoRef;
  DocumentReference? get todoRef => _todoRef;
  bool hasTodoRef() => _todoRef != null;

  // "pointsEarned" field.
  int? _pointsEarned;
  int get pointsEarned => _pointsEarned ?? 0;
  bool hasPointsEarned() => _pointsEarned != null;

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _collectionRef = snapshotData['collectionRef'] as DocumentReference?;
    _comments = snapshotData['comments'] as String?;
    _completedDate = snapshotData['completedDate'] as DateTime?;
    _completed = snapshotData['completed'] as bool?;
    _todoRef = snapshotData['todoRef'] as DocumentReference?;
    _pointsEarned = castToType<int>(snapshotData['pointsEarned']);
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('CompletedTasks')
          : FirebaseFirestore.instance.collectionGroup('CompletedTasks');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('CompletedTasks').doc(id);

  static Stream<CompletedTasksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CompletedTasksRecord.fromSnapshot(s));

  static Future<CompletedTasksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CompletedTasksRecord.fromSnapshot(s));

  static CompletedTasksRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CompletedTasksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CompletedTasksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CompletedTasksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CompletedTasksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CompletedTasksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCompletedTasksRecordData({
  DocumentReference? collectionRef,
  String? comments,
  DateTime? completedDate,
  bool? completed,
  DocumentReference? todoRef,
  int? pointsEarned,
  DocumentReference? groupRef,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'collectionRef': collectionRef,
      'comments': comments,
      'completedDate': completedDate,
      'completed': completed,
      'todoRef': todoRef,
      'pointsEarned': pointsEarned,
      'groupRef': groupRef,
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class CompletedTasksRecordDocumentEquality
    implements Equality<CompletedTasksRecord> {
  const CompletedTasksRecordDocumentEquality();

  @override
  bool equals(CompletedTasksRecord? e1, CompletedTasksRecord? e2) {
    return e1?.collectionRef == e2?.collectionRef &&
        e1?.comments == e2?.comments &&
        e1?.completedDate == e2?.completedDate &&
        e1?.completed == e2?.completed &&
        e1?.todoRef == e2?.todoRef &&
        e1?.pointsEarned == e2?.pointsEarned &&
        e1?.groupRef == e2?.groupRef &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(CompletedTasksRecord? e) => const ListEquality().hash([
        e?.collectionRef,
        e?.comments,
        e?.completedDate,
        e?.completed,
        e?.todoRef,
        e?.pointsEarned,
        e?.groupRef,
        e?.userRef
      ]);

  @override
  bool isValidKey(Object? o) => o is CompletedTasksRecord;
}
