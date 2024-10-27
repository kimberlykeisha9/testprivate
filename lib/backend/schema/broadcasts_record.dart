import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BroadcastsRecord extends FirestoreRecord {
  BroadcastsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "is_live" field.
  bool? _isLive;
  bool get isLive => _isLive ?? false;
  bool hasIsLive() => _isLive != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "featuredImage" field.
  String? _featuredImage;
  String get featuredImage => _featuredImage ?? '';
  bool hasFeaturedImage() => _featuredImage != null;

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "groupId" field.
  int? _groupId;
  int get groupId => _groupId ?? 0;
  bool hasGroupId() => _groupId != null;

  // "ContentID" field.
  int? _contentID;
  int get contentID => _contentID ?? 0;
  bool hasContentID() => _contentID != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "pinnedToTop" field.
  bool? _pinnedToTop;
  bool get pinnedToTop => _pinnedToTop ?? false;
  bool hasPinnedToTop() => _pinnedToTop != null;

  // "deleted" field.
  bool? _deleted;
  bool get deleted => _deleted ?? false;
  bool hasDeleted() => _deleted != null;

  // "likeCount" field.
  int? _likeCount;
  int get likeCount => _likeCount ?? 0;
  bool hasLikeCount() => _likeCount != null;

  // "tribeCollectionRef" field.
  DocumentReference? _tribeCollectionRef;
  DocumentReference? get tribeCollectionRef => _tribeCollectionRef;
  bool hasTribeCollectionRef() => _tribeCollectionRef != null;

  // "chatEnabled" field.
  bool? _chatEnabled;
  bool get chatEnabled => _chatEnabled ?? false;
  bool hasChatEnabled() => _chatEnabled != null;

  // "featuredGif" field.
  String? _featuredGif;
  String get featuredGif => _featuredGif ?? '';
  bool hasFeaturedGif() => _featuredGif != null;

  // "commentCount" field.
  int? _commentCount;
  int get commentCount => _commentCount ?? 0;
  bool hasCommentCount() => _commentCount != null;

  // "authorName" field.
  String? _authorName;
  String get authorName => _authorName ?? '';
  bool hasAuthorName() => _authorName != null;

  // "authorRole" field.
  String? _authorRole;
  String get authorRole => _authorRole ?? '';
  bool hasAuthorRole() => _authorRole != null;

  // "authorImg" field.
  String? _authorImg;
  String get authorImg => _authorImg ?? '';
  bool hasAuthorImg() => _authorImg != null;

  // "category" field.
  List<String>? _category;
  List<String> get category => _category ?? const [];
  bool hasCategory() => _category != null;

  // "totalViews" field.
  int? _totalViews;
  int get totalViews => _totalViews ?? 0;
  bool hasTotalViews() => _totalViews != null;

  // "likedBy" field.
  List<DocumentReference>? _likedBy;
  List<DocumentReference> get likedBy => _likedBy ?? const [];
  bool hasLikedBy() => _likedBy != null;

  // "watchedBy" field.
  List<DocumentReference>? _watchedBy;
  List<DocumentReference> get watchedBy => _watchedBy ?? const [];
  bool hasWatchedBy() => _watchedBy != null;

  // "adminHasReplied" field.
  bool? _adminHasReplied;
  bool get adminHasReplied => _adminHasReplied ?? false;
  bool hasAdminHasReplied() => _adminHasReplied != null;

  // "adminLastReply" field.
  DateTime? _adminLastReply;
  DateTime? get adminLastReply => _adminLastReply;
  bool hasAdminLastReply() => _adminLastReply != null;

  // "roomData" field.
  RoomDataStruct? _roomData;
  RoomDataStruct get roomData => _roomData ?? RoomDataStruct();
  bool hasRoomData() => _roomData != null;

  void _initializeFields() {
    _isLive = snapshotData['is_live'] as bool?;
    _name = snapshotData['name'] as String?;
    _url = snapshotData['url'] as String?;
    _time = snapshotData['time'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _featuredImage = snapshotData['featuredImage'] as String?;
    _userId = snapshotData['userId'] as DocumentReference?;
    _groupId = castToType<int>(snapshotData['groupId']);
    _contentID = castToType<int>(snapshotData['ContentID']);
    _video = snapshotData['video'] as String?;
    _pinnedToTop = snapshotData['pinnedToTop'] as bool?;
    _deleted = snapshotData['deleted'] as bool?;
    _likeCount = castToType<int>(snapshotData['likeCount']);
    _tribeCollectionRef =
        snapshotData['tribeCollectionRef'] as DocumentReference?;
    _chatEnabled = snapshotData['chatEnabled'] as bool?;
    _featuredGif = snapshotData['featuredGif'] as String?;
    _commentCount = castToType<int>(snapshotData['commentCount']);
    _authorName = snapshotData['authorName'] as String?;
    _authorRole = snapshotData['authorRole'] as String?;
    _authorImg = snapshotData['authorImg'] as String?;
    _category = getDataList(snapshotData['category']);
    _totalViews = castToType<int>(snapshotData['totalViews']);
    _likedBy = getDataList(snapshotData['likedBy']);
    _watchedBy = getDataList(snapshotData['watchedBy']);
    _adminHasReplied = snapshotData['adminHasReplied'] as bool?;
    _adminLastReply = snapshotData['adminLastReply'] as DateTime?;
    _roomData = RoomDataStruct.maybeFromMap(snapshotData['roomData']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('broadcasts');

  static Stream<BroadcastsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BroadcastsRecord.fromSnapshot(s));

  static Future<BroadcastsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BroadcastsRecord.fromSnapshot(s));

  static BroadcastsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BroadcastsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BroadcastsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BroadcastsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BroadcastsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BroadcastsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBroadcastsRecordData({
  bool? isLive,
  String? name,
  String? url,
  DateTime? time,
  String? title,
  String? featuredImage,
  DocumentReference? userId,
  int? groupId,
  int? contentID,
  String? video,
  bool? pinnedToTop,
  bool? deleted,
  int? likeCount,
  DocumentReference? tribeCollectionRef,
  bool? chatEnabled,
  String? featuredGif,
  int? commentCount,
  String? authorName,
  String? authorRole,
  String? authorImg,
  int? totalViews,
  bool? adminHasReplied,
  DateTime? adminLastReply,
  RoomDataStruct? roomData,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'is_live': isLive,
      'name': name,
      'url': url,
      'time': time,
      'title': title,
      'featuredImage': featuredImage,
      'userId': userId,
      'groupId': groupId,
      'ContentID': contentID,
      'video': video,
      'pinnedToTop': pinnedToTop,
      'deleted': deleted,
      'likeCount': likeCount,
      'tribeCollectionRef': tribeCollectionRef,
      'chatEnabled': chatEnabled,
      'featuredGif': featuredGif,
      'commentCount': commentCount,
      'authorName': authorName,
      'authorRole': authorRole,
      'authorImg': authorImg,
      'totalViews': totalViews,
      'adminHasReplied': adminHasReplied,
      'adminLastReply': adminLastReply,
      'roomData': RoomDataStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "roomData" field.
  addRoomDataStructData(firestoreData, roomData, 'roomData');

  return firestoreData;
}

class BroadcastsRecordDocumentEquality implements Equality<BroadcastsRecord> {
  const BroadcastsRecordDocumentEquality();

  @override
  bool equals(BroadcastsRecord? e1, BroadcastsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.isLive == e2?.isLive &&
        e1?.name == e2?.name &&
        e1?.url == e2?.url &&
        e1?.time == e2?.time &&
        e1?.title == e2?.title &&
        e1?.featuredImage == e2?.featuredImage &&
        e1?.userId == e2?.userId &&
        e1?.groupId == e2?.groupId &&
        e1?.contentID == e2?.contentID &&
        e1?.video == e2?.video &&
        e1?.pinnedToTop == e2?.pinnedToTop &&
        e1?.deleted == e2?.deleted &&
        e1?.likeCount == e2?.likeCount &&
        e1?.tribeCollectionRef == e2?.tribeCollectionRef &&
        e1?.chatEnabled == e2?.chatEnabled &&
        e1?.featuredGif == e2?.featuredGif &&
        e1?.commentCount == e2?.commentCount &&
        e1?.authorName == e2?.authorName &&
        e1?.authorRole == e2?.authorRole &&
        e1?.authorImg == e2?.authorImg &&
        listEquality.equals(e1?.category, e2?.category) &&
        e1?.totalViews == e2?.totalViews &&
        listEquality.equals(e1?.likedBy, e2?.likedBy) &&
        listEquality.equals(e1?.watchedBy, e2?.watchedBy) &&
        e1?.adminHasReplied == e2?.adminHasReplied &&
        e1?.adminLastReply == e2?.adminLastReply &&
        e1?.roomData == e2?.roomData;
  }

  @override
  int hash(BroadcastsRecord? e) => const ListEquality().hash([
        e?.isLive,
        e?.name,
        e?.url,
        e?.time,
        e?.title,
        e?.featuredImage,
        e?.userId,
        e?.groupId,
        e?.contentID,
        e?.video,
        e?.pinnedToTop,
        e?.deleted,
        e?.likeCount,
        e?.tribeCollectionRef,
        e?.chatEnabled,
        e?.featuredGif,
        e?.commentCount,
        e?.authorName,
        e?.authorRole,
        e?.authorImg,
        e?.category,
        e?.totalViews,
        e?.likedBy,
        e?.watchedBy,
        e?.adminHasReplied,
        e?.adminLastReply,
        e?.roomData
      ]);

  @override
  bool isValidKey(Object? o) => o is BroadcastsRecord;
}
