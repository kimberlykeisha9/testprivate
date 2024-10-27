import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageReactionsRecord extends FirestoreRecord {
  MessageReactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Emoji" field.
  String? _emoji;
  String get emoji => _emoji ?? '';
  bool hasEmoji() => _emoji != null;

  // "Order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  void _initializeFields() {
    _emoji = snapshotData['Emoji'] as String?;
    _order = castToType<int>(snapshotData['Order']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('MessageReactions');

  static Stream<MessageReactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessageReactionsRecord.fromSnapshot(s));

  static Future<MessageReactionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => MessageReactionsRecord.fromSnapshot(s));

  static MessageReactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessageReactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessageReactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessageReactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessageReactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessageReactionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessageReactionsRecordData({
  String? emoji,
  int? order,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Emoji': emoji,
      'Order': order,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessageReactionsRecordDocumentEquality
    implements Equality<MessageReactionsRecord> {
  const MessageReactionsRecordDocumentEquality();

  @override
  bool equals(MessageReactionsRecord? e1, MessageReactionsRecord? e2) {
    return e1?.emoji == e2?.emoji && e1?.order == e2?.order;
  }

  @override
  int hash(MessageReactionsRecord? e) =>
      const ListEquality().hash([e?.emoji, e?.order]);

  @override
  bool isValidKey(Object? o) => o is MessageReactionsRecord;
}
