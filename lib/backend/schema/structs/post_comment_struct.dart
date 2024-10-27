// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostCommentStruct extends FFFirebaseStruct {
  PostCommentStruct({
    DocumentReference? userref,
    String? comment,
    DateTime? postDate,
    bool? deleted,
    String? authorImg,
    String? authorName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userref = userref,
        _comment = comment,
        _postDate = postDate,
        _deleted = deleted,
        _authorImg = authorImg,
        _authorName = authorName,
        super(firestoreUtilData);

  // "userref" field.
  DocumentReference? _userref;
  DocumentReference? get userref => _userref;
  set userref(DocumentReference? val) => _userref = val;

  bool hasUserref() => _userref != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "postDate" field.
  DateTime? _postDate;
  DateTime? get postDate => _postDate;
  set postDate(DateTime? val) => _postDate = val;

  bool hasPostDate() => _postDate != null;

  // "deleted" field.
  bool? _deleted;
  bool get deleted => _deleted ?? false;
  set deleted(bool? val) => _deleted = val;

  bool hasDeleted() => _deleted != null;

  // "AuthorImg" field.
  String? _authorImg;
  String get authorImg => _authorImg ?? '';
  set authorImg(String? val) => _authorImg = val;

  bool hasAuthorImg() => _authorImg != null;

  // "AuthorName" field.
  String? _authorName;
  String get authorName => _authorName ?? '';
  set authorName(String? val) => _authorName = val;

  bool hasAuthorName() => _authorName != null;

  static PostCommentStruct fromMap(Map<String, dynamic> data) =>
      PostCommentStruct(
        userref: data['userref'] as DocumentReference?,
        comment: data['comment'] as String?,
        postDate: data['postDate'] as DateTime?,
        deleted: data['deleted'] as bool?,
        authorImg: data['AuthorImg'] as String?,
        authorName: data['AuthorName'] as String?,
      );

  static PostCommentStruct? maybeFromMap(dynamic data) => data is Map
      ? PostCommentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userref': _userref,
        'comment': _comment,
        'postDate': _postDate,
        'deleted': _deleted,
        'AuthorImg': _authorImg,
        'AuthorName': _authorName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userref': serializeParam(
          _userref,
          ParamType.DocumentReference,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'postDate': serializeParam(
          _postDate,
          ParamType.DateTime,
        ),
        'deleted': serializeParam(
          _deleted,
          ParamType.bool,
        ),
        'AuthorImg': serializeParam(
          _authorImg,
          ParamType.String,
        ),
        'AuthorName': serializeParam(
          _authorName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PostCommentStruct fromSerializableMap(Map<String, dynamic> data) =>
      PostCommentStruct(
        userref: deserializeParam(
          data['userref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['user'],
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        postDate: deserializeParam(
          data['postDate'],
          ParamType.DateTime,
          false,
        ),
        deleted: deserializeParam(
          data['deleted'],
          ParamType.bool,
          false,
        ),
        authorImg: deserializeParam(
          data['AuthorImg'],
          ParamType.String,
          false,
        ),
        authorName: deserializeParam(
          data['AuthorName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PostCommentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PostCommentStruct &&
        userref == other.userref &&
        comment == other.comment &&
        postDate == other.postDate &&
        deleted == other.deleted &&
        authorImg == other.authorImg &&
        authorName == other.authorName;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userref, comment, postDate, deleted, authorImg, authorName]);
}

PostCommentStruct createPostCommentStruct({
  DocumentReference? userref,
  String? comment,
  DateTime? postDate,
  bool? deleted,
  String? authorImg,
  String? authorName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PostCommentStruct(
      userref: userref,
      comment: comment,
      postDate: postDate,
      deleted: deleted,
      authorImg: authorImg,
      authorName: authorName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PostCommentStruct? updatePostCommentStruct(
  PostCommentStruct? postComment, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    postComment
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPostCommentStructData(
  Map<String, dynamic> firestoreData,
  PostCommentStruct? postComment,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (postComment == null) {
    return;
  }
  if (postComment.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && postComment.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final postCommentData =
      getPostCommentFirestoreData(postComment, forFieldValue);
  final nestedData =
      postCommentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = postComment.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPostCommentFirestoreData(
  PostCommentStruct? postComment, [
  bool forFieldValue = false,
]) {
  if (postComment == null) {
    return {};
  }
  final firestoreData = mapToFirestore(postComment.toMap());

  // Add any Firestore field values
  postComment.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPostCommentListFirestoreData(
  List<PostCommentStruct>? postComments,
) =>
    postComments?.map((e) => getPostCommentFirestoreData(e, true)).toList() ??
    [];
