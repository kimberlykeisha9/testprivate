import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessagesRecord extends FirestoreRecord {
  ChatMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "contentID" field.
  int? _contentID;
  int get contentID => _contentID ?? 0;
  bool hasContentID() => _contentID != null;

  // "deleted" field.
  bool? _deleted;
  bool get deleted => _deleted ?? false;
  bool hasDeleted() => _deleted != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "broadcastRef" field.
  DocumentReference? _broadcastRef;
  DocumentReference? get broadcastRef => _broadcastRef;
  bool hasBroadcastRef() => _broadcastRef != null;

  // "tribeContentRef" field.
  DocumentReference? _tribeContentRef;
  DocumentReference? get tribeContentRef => _tribeContentRef;
  bool hasTribeContentRef() => _tribeContentRef != null;

  // "replies" field.
  List<PostCommentStruct>? _replies;
  List<PostCommentStruct> get replies => _replies ?? const [];
  bool hasReplies() => _replies != null;

  // "TribeCollectionRef" field.
  DocumentReference? _tribeCollectionRef;
  DocumentReference? get tribeCollectionRef => _tribeCollectionRef;
  bool hasTribeCollectionRef() => _tribeCollectionRef != null;

  // "AuthorName" field.
  String? _authorName;
  String get authorName => _authorName ?? '';
  bool hasAuthorName() => _authorName != null;

  // "AuthorImg" field.
  String? _authorImg;
  String get authorImg => _authorImg ?? '';
  bool hasAuthorImg() => _authorImg != null;

  // "AuthorRole" field.
  String? _authorRole;
  String get authorRole => _authorRole ?? '';
  bool hasAuthorRole() => _authorRole != null;

  void _initializeFields() {
    _contentID = castToType<int>(snapshotData['contentID']);
    _deleted = snapshotData['deleted'] as bool?;
    _message = snapshotData['message'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
    _broadcastRef = snapshotData['broadcastRef'] as DocumentReference?;
    _tribeContentRef = snapshotData['tribeContentRef'] as DocumentReference?;
    _replies = getStructList(
      snapshotData['replies'],
      PostCommentStruct.fromMap,
    );
    _tribeCollectionRef =
        snapshotData['TribeCollectionRef'] as DocumentReference?;
    _authorName = snapshotData['AuthorName'] as String?;
    _authorImg = snapshotData['AuthorImg'] as String?;
    _authorRole = snapshotData['AuthorRole'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatMessages');

  static Stream<ChatMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessagesRecord.fromSnapshot(s));

  static Future<ChatMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessagesRecord.fromSnapshot(s));

  static ChatMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatMessagesRecordData({
  int? contentID,
  bool? deleted,
  String? message,
  DateTime? date,
  DocumentReference? user,
  DocumentReference? broadcastRef,
  DocumentReference? tribeContentRef,
  DocumentReference? tribeCollectionRef,
  String? authorName,
  String? authorImg,
  String? authorRole,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'contentID': contentID,
      'deleted': deleted,
      'message': message,
      'date': date,
      'user': user,
      'broadcastRef': broadcastRef,
      'tribeContentRef': tribeContentRef,
      'TribeCollectionRef': tribeCollectionRef,
      'AuthorName': authorName,
      'AuthorImg': authorImg,
      'AuthorRole': authorRole,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatMessagesRecordDocumentEquality
    implements Equality<ChatMessagesRecord> {
  const ChatMessagesRecordDocumentEquality();

  @override
  bool equals(ChatMessagesRecord? e1, ChatMessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.contentID == e2?.contentID &&
        e1?.deleted == e2?.deleted &&
        e1?.message == e2?.message &&
        e1?.date == e2?.date &&
        e1?.user == e2?.user &&
        e1?.broadcastRef == e2?.broadcastRef &&
        e1?.tribeContentRef == e2?.tribeContentRef &&
        listEquality.equals(e1?.replies, e2?.replies) &&
        e1?.tribeCollectionRef == e2?.tribeCollectionRef &&
        e1?.authorName == e2?.authorName &&
        e1?.authorImg == e2?.authorImg &&
        e1?.authorRole == e2?.authorRole;
  }

  @override
  int hash(ChatMessagesRecord? e) => const ListEquality().hash([
        e?.contentID,
        e?.deleted,
        e?.message,
        e?.date,
        e?.user,
        e?.broadcastRef,
        e?.tribeContentRef,
        e?.replies,
        e?.tribeCollectionRef,
        e?.authorName,
        e?.authorImg,
        e?.authorRole
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatMessagesRecord;
}
