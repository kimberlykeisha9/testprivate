import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConversationsRecord extends FirestoreRecord {
  ConversationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "CreatedTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "ConversationStarted" field.
  bool? _conversationStarted;
  bool get conversationStarted => _conversationStarted ?? false;
  bool hasConversationStarted() => _conversationStarted != null;

  // "Users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "Messages" field.
  List<DocumentReference>? _messages;
  List<DocumentReference> get messages => _messages ?? const [];
  bool hasMessages() => _messages != null;

  // "LastMessage" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "LastMessageSentBy" field.
  DocumentReference? _lastMessageSentBy;
  DocumentReference? get lastMessageSentBy => _lastMessageSentBy;
  bool hasLastMessageSentBy() => _lastMessageSentBy != null;

  // "LastMessageTime" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "AllMessagesRead" field.
  bool? _allMessagesRead;
  bool get allMessagesRead => _allMessagesRead ?? false;
  bool hasAllMessagesRead() => _allMessagesRead != null;

  // "Archived" field.
  bool? _archived;
  bool get archived => _archived ?? false;
  bool hasArchived() => _archived != null;

  // "Typing" field.
  bool? _typing;
  bool get typing => _typing ?? false;
  bool hasTyping() => _typing != null;

  // "UserTyping" field.
  List<DocumentReference>? _userTyping;
  List<DocumentReference> get userTyping => _userTyping ?? const [];
  bool hasUserTyping() => _userTyping != null;

  void _initializeFields() {
    _createdTime = snapshotData['CreatedTime'] as DateTime?;
    _conversationStarted = snapshotData['ConversationStarted'] as bool?;
    _users = getDataList(snapshotData['Users']);
    _messages = getDataList(snapshotData['Messages']);
    _lastMessage = snapshotData['LastMessage'] as String?;
    _lastMessageSentBy =
        snapshotData['LastMessageSentBy'] as DocumentReference?;
    _lastMessageTime = snapshotData['LastMessageTime'] as DateTime?;
    _allMessagesRead = snapshotData['AllMessagesRead'] as bool?;
    _archived = snapshotData['Archived'] as bool?;
    _typing = snapshotData['Typing'] as bool?;
    _userTyping = getDataList(snapshotData['UserTyping']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Conversations');

  static Stream<ConversationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConversationsRecord.fromSnapshot(s));

  static Future<ConversationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ConversationsRecord.fromSnapshot(s));

  static ConversationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConversationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConversationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConversationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConversationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConversationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createConversationsRecordData({
  DateTime? createdTime,
  bool? conversationStarted,
  String? lastMessage,
  DocumentReference? lastMessageSentBy,
  DateTime? lastMessageTime,
  bool? allMessagesRead,
  bool? archived,
  bool? typing,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'CreatedTime': createdTime,
      'ConversationStarted': conversationStarted,
      'LastMessage': lastMessage,
      'LastMessageSentBy': lastMessageSentBy,
      'LastMessageTime': lastMessageTime,
      'AllMessagesRead': allMessagesRead,
      'Archived': archived,
      'Typing': typing,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConversationsRecordDocumentEquality
    implements Equality<ConversationsRecord> {
  const ConversationsRecordDocumentEquality();

  @override
  bool equals(ConversationsRecord? e1, ConversationsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdTime == e2?.createdTime &&
        e1?.conversationStarted == e2?.conversationStarted &&
        listEquality.equals(e1?.users, e2?.users) &&
        listEquality.equals(e1?.messages, e2?.messages) &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.allMessagesRead == e2?.allMessagesRead &&
        e1?.archived == e2?.archived &&
        e1?.typing == e2?.typing &&
        listEquality.equals(e1?.userTyping, e2?.userTyping);
  }

  @override
  int hash(ConversationsRecord? e) => const ListEquality().hash([
        e?.createdTime,
        e?.conversationStarted,
        e?.users,
        e?.messages,
        e?.lastMessage,
        e?.lastMessageSentBy,
        e?.lastMessageTime,
        e?.allMessagesRead,
        e?.archived,
        e?.typing,
        e?.userTyping
      ]);

  @override
  bool isValidKey(Object? o) => o is ConversationsRecord;
}
