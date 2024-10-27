import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeContentRecord extends FirestoreRecord {
  TribeContentRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "FeaturedImage" field.
  String? _featuredImage;
  String get featuredImage => _featuredImage ?? '';
  bool hasFeaturedImage() => _featuredImage != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "publishDate" field.
  DateTime? _publishDate;
  DateTime? get publishDate => _publishDate;
  bool hasPublishDate() => _publishDate != null;

  // "visibility" field.
  String? _visibility;
  String get visibility => _visibility ?? '';
  bool hasVisibility() => _visibility != null;

  // "FeaturedVideo" field.
  String? _featuredVideo;
  String get featuredVideo => _featuredVideo ?? '';
  bool hasFeaturedVideo() => _featuredVideo != null;

  // "chatEnabled" field.
  bool? _chatEnabled;
  bool get chatEnabled => _chatEnabled ?? false;
  bool hasChatEnabled() => _chatEnabled != null;

  // "tribeContentID" field.
  int? _tribeContentID;
  int get tribeContentID => _tribeContentID ?? 0;
  bool hasTribeContentID() => _tribeContentID != null;

  // "cta_link" field.
  String? _ctaLink;
  String get ctaLink => _ctaLink ?? '';
  bool hasCtaLink() => _ctaLink != null;

  // "cta_btn_text" field.
  String? _ctaBtnText;
  String get ctaBtnText => _ctaBtnText ?? '';
  bool hasCtaBtnText() => _ctaBtnText != null;

  // "authorRef" field.
  DocumentReference? _authorRef;
  DocumentReference? get authorRef => _authorRef;
  bool hasAuthorRef() => _authorRef != null;

  // "contentType" field.
  String? _contentType;
  String get contentType => _contentType ?? '';
  bool hasContentType() => _contentType != null;

  // "FeaturedVideoM3U8" field.
  String? _featuredVideoM3U8;
  String get featuredVideoM3U8 => _featuredVideoM3U8 ?? '';
  bool hasFeaturedVideoM3U8() => _featuredVideoM3U8 != null;

  // "endDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "position" field.
  int? _position;
  int get position => _position ?? 0;
  bool hasPosition() => _position != null;

  // "descriptionHtml" field.
  String? _descriptionHtml;
  String get descriptionHtml => _descriptionHtml ?? '';
  bool hasDescriptionHtml() => _descriptionHtml != null;

  // "tribeCollectionID" field.
  int? _tribeCollectionID;
  int get tribeCollectionID => _tribeCollectionID ?? 0;
  bool hasTribeCollectionID() => _tribeCollectionID != null;

  // "tribeCollectionRef" field.
  DocumentReference? _tribeCollectionRef;
  DocumentReference? get tribeCollectionRef => _tribeCollectionRef;
  bool hasTribeCollectionRef() => _tribeCollectionRef != null;

  // "tribeCourseRef" field.
  DocumentReference? _tribeCourseRef;
  DocumentReference? get tribeCourseRef => _tribeCourseRef;
  bool hasTribeCourseRef() => _tribeCourseRef != null;

  // "completedBy" field.
  List<DocumentReference>? _completedBy;
  List<DocumentReference> get completedBy => _completedBy ?? const [];
  bool hasCompletedBy() => _completedBy != null;

  // "groupRefs" field.
  List<DocumentReference>? _groupRefs;
  List<DocumentReference> get groupRefs => _groupRefs ?? const [];
  bool hasGroupRefs() => _groupRefs != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _featuredImage = snapshotData['FeaturedImage'] as String?;
    _description = snapshotData['description'] as String?;
    _publishDate = snapshotData['publishDate'] as DateTime?;
    _visibility = snapshotData['visibility'] as String?;
    _featuredVideo = snapshotData['FeaturedVideo'] as String?;
    _chatEnabled = snapshotData['chatEnabled'] as bool?;
    _tribeContentID = castToType<int>(snapshotData['tribeContentID']);
    _ctaLink = snapshotData['cta_link'] as String?;
    _ctaBtnText = snapshotData['cta_btn_text'] as String?;
    _authorRef = snapshotData['authorRef'] as DocumentReference?;
    _contentType = snapshotData['contentType'] as String?;
    _featuredVideoM3U8 = snapshotData['FeaturedVideoM3U8'] as String?;
    _endDate = snapshotData['endDate'] as DateTime?;
    _position = castToType<int>(snapshotData['position']);
    _descriptionHtml = snapshotData['descriptionHtml'] as String?;
    _tribeCollectionID = castToType<int>(snapshotData['tribeCollectionID']);
    _tribeCollectionRef =
        snapshotData['tribeCollectionRef'] as DocumentReference?;
    _tribeCourseRef = snapshotData['tribeCourseRef'] as DocumentReference?;
    _completedBy = getDataList(snapshotData['completedBy']);
    _groupRefs = getDataList(snapshotData['groupRefs']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TribeContent');

  static Stream<TribeContentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TribeContentRecord.fromSnapshot(s));

  static Future<TribeContentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TribeContentRecord.fromSnapshot(s));

  static TribeContentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TribeContentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TribeContentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TribeContentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TribeContentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TribeContentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTribeContentRecordData({
  String? title,
  DocumentReference? groupRef,
  String? featuredImage,
  String? description,
  DateTime? publishDate,
  String? visibility,
  String? featuredVideo,
  bool? chatEnabled,
  int? tribeContentID,
  String? ctaLink,
  String? ctaBtnText,
  DocumentReference? authorRef,
  String? contentType,
  String? featuredVideoM3U8,
  DateTime? endDate,
  int? position,
  String? descriptionHtml,
  int? tribeCollectionID,
  DocumentReference? tribeCollectionRef,
  DocumentReference? tribeCourseRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'groupRef': groupRef,
      'FeaturedImage': featuredImage,
      'description': description,
      'publishDate': publishDate,
      'visibility': visibility,
      'FeaturedVideo': featuredVideo,
      'chatEnabled': chatEnabled,
      'tribeContentID': tribeContentID,
      'cta_link': ctaLink,
      'cta_btn_text': ctaBtnText,
      'authorRef': authorRef,
      'contentType': contentType,
      'FeaturedVideoM3U8': featuredVideoM3U8,
      'endDate': endDate,
      'position': position,
      'descriptionHtml': descriptionHtml,
      'tribeCollectionID': tribeCollectionID,
      'tribeCollectionRef': tribeCollectionRef,
      'tribeCourseRef': tribeCourseRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class TribeContentRecordDocumentEquality
    implements Equality<TribeContentRecord> {
  const TribeContentRecordDocumentEquality();

  @override
  bool equals(TribeContentRecord? e1, TribeContentRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.groupRef == e2?.groupRef &&
        e1?.featuredImage == e2?.featuredImage &&
        e1?.description == e2?.description &&
        e1?.publishDate == e2?.publishDate &&
        e1?.visibility == e2?.visibility &&
        e1?.featuredVideo == e2?.featuredVideo &&
        e1?.chatEnabled == e2?.chatEnabled &&
        e1?.tribeContentID == e2?.tribeContentID &&
        e1?.ctaLink == e2?.ctaLink &&
        e1?.ctaBtnText == e2?.ctaBtnText &&
        e1?.authorRef == e2?.authorRef &&
        e1?.contentType == e2?.contentType &&
        e1?.featuredVideoM3U8 == e2?.featuredVideoM3U8 &&
        e1?.endDate == e2?.endDate &&
        e1?.position == e2?.position &&
        e1?.descriptionHtml == e2?.descriptionHtml &&
        e1?.tribeCollectionID == e2?.tribeCollectionID &&
        e1?.tribeCollectionRef == e2?.tribeCollectionRef &&
        e1?.tribeCourseRef == e2?.tribeCourseRef &&
        listEquality.equals(e1?.completedBy, e2?.completedBy) &&
        listEquality.equals(e1?.groupRefs, e2?.groupRefs);
  }

  @override
  int hash(TribeContentRecord? e) => const ListEquality().hash([
        e?.title,
        e?.groupRef,
        e?.featuredImage,
        e?.description,
        e?.publishDate,
        e?.visibility,
        e?.featuredVideo,
        e?.chatEnabled,
        e?.tribeContentID,
        e?.ctaLink,
        e?.ctaBtnText,
        e?.authorRef,
        e?.contentType,
        e?.featuredVideoM3U8,
        e?.endDate,
        e?.position,
        e?.descriptionHtml,
        e?.tribeCollectionID,
        e?.tribeCollectionRef,
        e?.tribeCourseRef,
        e?.completedBy,
        e?.groupRefs
      ]);

  @override
  bool isValidKey(Object? o) => o is TribeContentRecord;
}
