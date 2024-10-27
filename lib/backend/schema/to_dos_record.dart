import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ToDosRecord extends FirestoreRecord {
  ToDosRecord._(
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

  // "link" field.
  String? _link;
  String get link => _link ?? '';
  bool hasLink() => _link != null;

  // "linkTxt" field.
  String? _linkTxt;
  String get linkTxt => _linkTxt ?? '';
  bool hasLinkTxt() => _linkTxt != null;

  // "showGoLiveButton" field.
  bool? _showGoLiveButton;
  bool get showGoLiveButton => _showGoLiveButton ?? false;
  bool hasShowGoLiveButton() => _showGoLiveButton != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  // "points" field.
  int? _points;
  int get points => _points ?? 0;
  bool hasPoints() => _points != null;

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "userCreated" field.
  bool? _userCreated;
  bool get userCreated => _userCreated ?? false;
  bool hasUserCreated() => _userCreated != null;

  // "creatorRef" field.
  DocumentReference? _creatorRef;
  DocumentReference? get creatorRef => _creatorRef;
  bool hasCreatorRef() => _creatorRef != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  bool hasValue() => _value != null;

  // "collectionRef" field.
  DocumentReference? _collectionRef;
  DocumentReference? get collectionRef => _collectionRef;
  bool hasCollectionRef() => _collectionRef != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _link = snapshotData['link'] as String?;
    _linkTxt = snapshotData['linkTxt'] as String?;
    _showGoLiveButton = snapshotData['showGoLiveButton'] as bool?;
    _order = castToType<int>(snapshotData['order']);
    _points = castToType<int>(snapshotData['points']);
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _userCreated = snapshotData['userCreated'] as bool?;
    _creatorRef = snapshotData['creatorRef'] as DocumentReference?;
    _value = snapshotData['value'] as String?;
    _collectionRef = snapshotData['collectionRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ToDos');

  static Stream<ToDosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ToDosRecord.fromSnapshot(s));

  static Future<ToDosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ToDosRecord.fromSnapshot(s));

  static ToDosRecord fromSnapshot(DocumentSnapshot snapshot) => ToDosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ToDosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ToDosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ToDosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ToDosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createToDosRecordData({
  String? title,
  String? description,
  String? link,
  String? linkTxt,
  bool? showGoLiveButton,
  int? order,
  int? points,
  DocumentReference? groupRef,
  bool? userCreated,
  DocumentReference? creatorRef,
  String? value,
  DocumentReference? collectionRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'link': link,
      'linkTxt': linkTxt,
      'showGoLiveButton': showGoLiveButton,
      'order': order,
      'points': points,
      'groupRef': groupRef,
      'userCreated': userCreated,
      'creatorRef': creatorRef,
      'value': value,
      'collectionRef': collectionRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ToDosRecordDocumentEquality implements Equality<ToDosRecord> {
  const ToDosRecordDocumentEquality();

  @override
  bool equals(ToDosRecord? e1, ToDosRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.link == e2?.link &&
        e1?.linkTxt == e2?.linkTxt &&
        e1?.showGoLiveButton == e2?.showGoLiveButton &&
        e1?.order == e2?.order &&
        e1?.points == e2?.points &&
        e1?.groupRef == e2?.groupRef &&
        e1?.userCreated == e2?.userCreated &&
        e1?.creatorRef == e2?.creatorRef &&
        e1?.value == e2?.value &&
        e1?.collectionRef == e2?.collectionRef;
  }

  @override
  int hash(ToDosRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.link,
        e?.linkTxt,
        e?.showGoLiveButton,
        e?.order,
        e?.points,
        e?.groupRef,
        e?.userCreated,
        e?.creatorRef,
        e?.value,
        e?.collectionRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ToDosRecord;
}
