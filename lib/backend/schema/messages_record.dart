import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "SentTime" field.
  DateTime? _sentTime;
  DateTime? get sentTime => _sentTime;
  bool hasSentTime() => _sentTime != null;

  // "Message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "Images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "Video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "Audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  bool hasAudio() => _audio != null;

  // "MediaType" field.
  MessageMediaType? _mediaType;
  MessageMediaType? get mediaType => _mediaType;
  bool hasMediaType() => _mediaType != null;

  // "SentBy" field.
  DocumentReference? _sentBy;
  DocumentReference? get sentBy => _sentBy;
  bool hasSentBy() => _sentBy != null;

  // "ReplyTo" field.
  DocumentReference? _replyTo;
  DocumentReference? get replyTo => _replyTo;
  bool hasReplyTo() => _replyTo != null;

  // "Read" field.
  bool? _read;
  bool get read => _read ?? false;
  bool hasRead() => _read != null;

  // "ReadTime" field.
  DateTime? _readTime;
  DateTime? get readTime => _readTime;
  bool hasReadTime() => _readTime != null;

  // "EmojiReaction" field.
  MessageReaction? _emojiReaction;
  MessageReaction? get emojiReaction => _emojiReaction;
  bool hasEmojiReaction() => _emojiReaction != null;

  // "File" field.
  String? _file;
  String get file => _file ?? '';
  bool hasFile() => _file != null;

  // "FileType" field.
  DocumentType? _fileType;
  DocumentType? get fileType => _fileType;
  bool hasFileType() => _fileType != null;

  // "FileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  bool hasFileName() => _fileName != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _sentTime = snapshotData['SentTime'] as DateTime?;
    _message = snapshotData['Message'] as String?;
    _images = getDataList(snapshotData['Images']);
    _video = snapshotData['Video'] as String?;
    _audio = snapshotData['Audio'] as String?;
    _mediaType = deserializeEnum<MessageMediaType>(snapshotData['MediaType']);
    _sentBy = snapshotData['SentBy'] as DocumentReference?;
    _replyTo = snapshotData['ReplyTo'] as DocumentReference?;
    _read = snapshotData['Read'] as bool?;
    _readTime = snapshotData['ReadTime'] as DateTime?;
    _emojiReaction =
        deserializeEnum<MessageReaction>(snapshotData['EmojiReaction']);
    _file = snapshotData['File'] as String?;
    _fileType = deserializeEnum<DocumentType>(snapshotData['FileType']);
    _fileName = snapshotData['FileName'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('Messages')
          : FirebaseFirestore.instance.collectionGroup('Messages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('Messages').doc(id);

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  DateTime? sentTime,
  String? message,
  String? video,
  String? audio,
  MessageMediaType? mediaType,
  DocumentReference? sentBy,
  DocumentReference? replyTo,
  bool? read,
  DateTime? readTime,
  MessageReaction? emojiReaction,
  String? file,
  DocumentType? fileType,
  String? fileName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SentTime': sentTime,
      'Message': message,
      'Video': video,
      'Audio': audio,
      'MediaType': mediaType,
      'SentBy': sentBy,
      'ReplyTo': replyTo,
      'Read': read,
      'ReadTime': readTime,
      'EmojiReaction': emojiReaction,
      'File': file,
      'FileType': fileType,
      'FileName': fileName,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sentTime == e2?.sentTime &&
        e1?.message == e2?.message &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.video == e2?.video &&
        e1?.audio == e2?.audio &&
        e1?.mediaType == e2?.mediaType &&
        e1?.sentBy == e2?.sentBy &&
        e1?.replyTo == e2?.replyTo &&
        e1?.read == e2?.read &&
        e1?.readTime == e2?.readTime &&
        e1?.emojiReaction == e2?.emojiReaction &&
        e1?.file == e2?.file &&
        e1?.fileType == e2?.fileType &&
        e1?.fileName == e2?.fileName;
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash([
        e?.sentTime,
        e?.message,
        e?.images,
        e?.video,
        e?.audio,
        e?.mediaType,
        e?.sentBy,
        e?.replyTo,
        e?.read,
        e?.readTime,
        e?.emojiReaction,
        e?.file,
        e?.fileType,
        e?.fileName
      ]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
