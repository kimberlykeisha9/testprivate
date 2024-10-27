import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DirectMessagesChatRecord extends FirestoreRecord {
  DirectMessagesChatRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "group_chat_id" field.
  int? _groupChatId;
  int get groupChatId => _groupChatId ?? 0;
  bool hasGroupChatId() => _groupChatId != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "last_message_sent_by" field.
  DocumentReference? _lastMessageSentBy;
  DocumentReference? get lastMessageSentBy => _lastMessageSentBy;
  bool hasLastMessageSentBy() => _lastMessageSentBy != null;

  // "last_message_seen_by" field.
  List<DocumentReference>? _lastMessageSeenBy;
  List<DocumentReference> get lastMessageSeenBy =>
      _lastMessageSeenBy ?? const [];
  bool hasLastMessageSeenBy() => _lastMessageSeenBy != null;

  void _initializeFields() {
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _groupChatId = castToType<int>(snapshotData['group_chat_id']);
    _users = getDataList(snapshotData['users']);
    _lastMessageSentBy =
        snapshotData['last_message_sent_by'] as DocumentReference?;
    _lastMessageSeenBy = getDataList(snapshotData['last_message_seen_by']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('direct_messages_chat');

  static Stream<DirectMessagesChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DirectMessagesChatRecord.fromSnapshot(s));

  static Future<DirectMessagesChatRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => DirectMessagesChatRecord.fromSnapshot(s));

  static DirectMessagesChatRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DirectMessagesChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DirectMessagesChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DirectMessagesChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DirectMessagesChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DirectMessagesChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDirectMessagesChatRecordData({
  String? lastMessage,
  DateTime? lastMessageTime,
  int? groupChatId,
  DocumentReference? lastMessageSentBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'group_chat_id': groupChatId,
      'last_message_sent_by': lastMessageSentBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class DirectMessagesChatRecordDocumentEquality
    implements Equality<DirectMessagesChatRecord> {
  const DirectMessagesChatRecordDocumentEquality();

  @override
  bool equals(DirectMessagesChatRecord? e1, DirectMessagesChatRecord? e2) {
    const listEquality = ListEquality();
    return e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.groupChatId == e2?.groupChatId &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        listEquality.equals(e1?.lastMessageSeenBy, e2?.lastMessageSeenBy);
  }

  @override
  int hash(DirectMessagesChatRecord? e) => const ListEquality().hash([
        e?.lastMessage,
        e?.lastMessageTime,
        e?.groupChatId,
        e?.users,
        e?.lastMessageSentBy,
        e?.lastMessageSeenBy
      ]);

  @override
  bool isValidKey(Object? o) => o is DirectMessagesChatRecord;
}
