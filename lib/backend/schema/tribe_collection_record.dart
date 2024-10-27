import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeCollectionRecord extends FirestoreRecord {
  TribeCollectionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "descriptionHtml" field.
  String? _descriptionHtml;
  String get descriptionHtml => _descriptionHtml ?? '';
  bool hasDescriptionHtml() => _descriptionHtml != null;

  // "descriptionPlain" field.
  String? _descriptionPlain;
  String get descriptionPlain => _descriptionPlain ?? '';
  bool hasDescriptionPlain() => _descriptionPlain != null;

  // "featuredImage" field.
  String? _featuredImage;
  String get featuredImage => _featuredImage ?? '';
  bool hasFeaturedImage() => _featuredImage != null;

  // "authorName" field.
  String? _authorName;
  String get authorName => _authorName ?? '';
  bool hasAuthorName() => _authorName != null;

  // "authorUserId" field.
  int? _authorUserId;
  int get authorUserId => _authorUserId ?? 0;
  bool hasAuthorUserId() => _authorUserId != null;

  // "publishDate" field.
  DateTime? _publishDate;
  DateTime? get publishDate => _publishDate;
  bool hasPublishDate() => _publishDate != null;

  // "showOnHomepage" field.
  bool? _showOnHomepage;
  bool get showOnHomepage => _showOnHomepage ?? false;
  bool hasShowOnHomepage() => _showOnHomepage != null;

  // "position" field.
  int? _position;
  int get position => _position ?? 0;
  bool hasPosition() => _position != null;

  // "sortPreference" field.
  String? _sortPreference;
  String get sortPreference => _sortPreference ?? '';
  bool hasSortPreference() => _sortPreference != null;

  // "tribeGroupIds" field.
  List<int>? _tribeGroupIds;
  List<int> get tribeGroupIds => _tribeGroupIds ?? const [];
  bool hasTribeGroupIds() => _tribeGroupIds != null;

  // "tribeContentIds" field.
  List<int>? _tribeContentIds;
  List<int> get tribeContentIds => _tribeContentIds ?? const [];
  bool hasTribeContentIds() => _tribeContentIds != null;

  // "tribeContentRefs" field.
  List<DocumentReference>? _tribeContentRefs;
  List<DocumentReference> get tribeContentRefs => _tribeContentRefs ?? const [];
  bool hasTribeContentRefs() => _tribeContentRefs != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  bool hasId() => _id != null;

  // "tribeCourseRef" field.
  DocumentReference? _tribeCourseRef;
  DocumentReference? get tribeCourseRef => _tribeCourseRef;
  bool hasTribeCourseRef() => _tribeCourseRef != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _descriptionHtml = snapshotData['descriptionHtml'] as String?;
    _descriptionPlain = snapshotData['descriptionPlain'] as String?;
    _featuredImage = snapshotData['featuredImage'] as String?;
    _authorName = snapshotData['authorName'] as String?;
    _authorUserId = castToType<int>(snapshotData['authorUserId']);
    _publishDate = snapshotData['publishDate'] as DateTime?;
    _showOnHomepage = snapshotData['showOnHomepage'] as bool?;
    _position = castToType<int>(snapshotData['position']);
    _sortPreference = snapshotData['sortPreference'] as String?;
    _tribeGroupIds = getDataList(snapshotData['tribeGroupIds']);
    _tribeContentIds = getDataList(snapshotData['tribeContentIds']);
    _tribeContentRefs = getDataList(snapshotData['tribeContentRefs']);
    _id = castToType<int>(snapshotData['id']);
    _tribeCourseRef = snapshotData['tribeCourseRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TribeCollection');

  static Stream<TribeCollectionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TribeCollectionRecord.fromSnapshot(s));

  static Future<TribeCollectionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TribeCollectionRecord.fromSnapshot(s));

  static TribeCollectionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TribeCollectionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TribeCollectionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TribeCollectionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TribeCollectionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TribeCollectionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTribeCollectionRecordData({
  String? title,
  String? descriptionHtml,
  String? descriptionPlain,
  String? featuredImage,
  String? authorName,
  int? authorUserId,
  DateTime? publishDate,
  bool? showOnHomepage,
  int? position,
  String? sortPreference,
  int? id,
  DocumentReference? tribeCourseRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'descriptionHtml': descriptionHtml,
      'descriptionPlain': descriptionPlain,
      'featuredImage': featuredImage,
      'authorName': authorName,
      'authorUserId': authorUserId,
      'publishDate': publishDate,
      'showOnHomepage': showOnHomepage,
      'position': position,
      'sortPreference': sortPreference,
      'id': id,
      'tribeCourseRef': tribeCourseRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class TribeCollectionRecordDocumentEquality
    implements Equality<TribeCollectionRecord> {
  const TribeCollectionRecordDocumentEquality();

  @override
  bool equals(TribeCollectionRecord? e1, TribeCollectionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.descriptionHtml == e2?.descriptionHtml &&
        e1?.descriptionPlain == e2?.descriptionPlain &&
        e1?.featuredImage == e2?.featuredImage &&
        e1?.authorName == e2?.authorName &&
        e1?.authorUserId == e2?.authorUserId &&
        e1?.publishDate == e2?.publishDate &&
        e1?.showOnHomepage == e2?.showOnHomepage &&
        e1?.position == e2?.position &&
        e1?.sortPreference == e2?.sortPreference &&
        listEquality.equals(e1?.tribeGroupIds, e2?.tribeGroupIds) &&
        listEquality.equals(e1?.tribeContentIds, e2?.tribeContentIds) &&
        listEquality.equals(e1?.tribeContentRefs, e2?.tribeContentRefs) &&
        e1?.id == e2?.id &&
        e1?.tribeCourseRef == e2?.tribeCourseRef;
  }

  @override
  int hash(TribeCollectionRecord? e) => const ListEquality().hash([
        e?.title,
        e?.descriptionHtml,
        e?.descriptionPlain,
        e?.featuredImage,
        e?.authorName,
        e?.authorUserId,
        e?.publishDate,
        e?.showOnHomepage,
        e?.position,
        e?.sortPreference,
        e?.tribeGroupIds,
        e?.tribeContentIds,
        e?.tribeContentRefs,
        e?.id,
        e?.tribeCourseRef
      ]);

  @override
  bool isValidKey(Object? o) => o is TribeCollectionRecord;
}
