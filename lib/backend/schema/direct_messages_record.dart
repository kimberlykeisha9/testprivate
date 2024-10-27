import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DirectMessagesRecord extends FirestoreRecord {
  DirectMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "chat" field.
  DocumentReference? _chat;
  DocumentReference? get chat => _chat;
  bool hasChat() => _chat != null;

  // "attachment_link" field.
  String? _attachmentLink;
  String get attachmentLink => _attachmentLink ?? '';
  bool hasAttachmentLink() => _attachmentLink != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _video = snapshotData['video'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _chat = snapshotData['chat'] as DocumentReference?;
    _attachmentLink = snapshotData['attachment_link'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('direct_messages');

  static Stream<DirectMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DirectMessagesRecord.fromSnapshot(s));

  static Future<DirectMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DirectMessagesRecord.fromSnapshot(s));

  static DirectMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DirectMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DirectMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DirectMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DirectMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DirectMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDirectMessagesRecordData({
  String? text,
  DateTime? timestamp,
  String? image,
  String? video,
  DocumentReference? user,
  DocumentReference? chat,
  String? attachmentLink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'timestamp': timestamp,
      'image': image,
      'video': video,
      'user': user,
      'chat': chat,
      'attachment_link': attachmentLink,
    }.withoutNulls,
  );

  return firestoreData;
}

class DirectMessagesRecordDocumentEquality
    implements Equality<DirectMessagesRecord> {
  const DirectMessagesRecordDocumentEquality();

  @override
  bool equals(DirectMessagesRecord? e1, DirectMessagesRecord? e2) {
    return e1?.text == e2?.text &&
        e1?.timestamp == e2?.timestamp &&
        e1?.image == e2?.image &&
        e1?.video == e2?.video &&
        e1?.user == e2?.user &&
        e1?.chat == e2?.chat &&
        e1?.attachmentLink == e2?.attachmentLink;
  }

  @override
  int hash(DirectMessagesRecord? e) => const ListEquality().hash([
        e?.text,
        e?.timestamp,
        e?.image,
        e?.video,
        e?.user,
        e?.chat,
        e?.attachmentLink
      ]);

  @override
  bool isValidKey(Object? o) => o is DirectMessagesRecord;
}
