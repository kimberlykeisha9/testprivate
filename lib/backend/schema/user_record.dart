import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "terms_accepted" field.
  bool? _termsAccepted;
  bool get termsAccepted => _termsAccepted ?? false;
  bool hasTermsAccepted() => _termsAccepted != null;

  // "banned" field.
  bool? _banned;
  bool get banned => _banned ?? false;
  bool hasBanned() => _banned != null;

  // "AppVersion" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  bool hasAppVersion() => _appVersion != null;

  // "userRole" field.
  String? _userRole;
  String get userRole => _userRole ?? '';
  bool hasUserRole() => _userRole != null;

  // "TribeToken" field.
  String? _tribeToken;
  String get tribeToken => _tribeToken ?? '';
  bool hasTribeToken() => _tribeToken != null;

  // "likePosts" field.
  List<DocumentReference>? _likePosts;
  List<DocumentReference> get likePosts => _likePosts ?? const [];
  bool hasLikePosts() => _likePosts != null;

  // "tribeUserId" field.
  int? _tribeUserId;
  int get tribeUserId => _tribeUserId ?? 0;
  bool hasTribeUserId() => _tribeUserId != null;

  // "TribeGroups" field.
  List<TribeGroupsStruct>? _tribeGroups;
  List<TribeGroupsStruct> get tribeGroups => _tribeGroups ?? const [];
  bool hasTribeGroups() => _tribeGroups != null;

  // "last_notification_read_time" field.
  DateTime? _lastNotificationReadTime;
  DateTime? get lastNotificationReadTime => _lastNotificationReadTime;
  bool hasLastNotificationReadTime() => _lastNotificationReadTime != null;

  // "contentCompletedIDs" field.
  List<int>? _contentCompletedIDs;
  List<int> get contentCompletedIDs => _contentCompletedIDs ?? const [];
  bool hasContentCompletedIDs() => _contentCompletedIDs != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "blockedUsers" field.
  List<DocumentReference>? _blockedUsers;
  List<DocumentReference> get blockedUsers => _blockedUsers ?? const [];
  bool hasBlockedUsers() => _blockedUsers != null;

  // "userChats" field.
  List<ChatDetailsStruct>? _userChats;
  List<ChatDetailsStruct> get userChats => _userChats ?? const [];
  bool hasUserChats() => _userChats != null;

  // "last_login_time" field.
  DateTime? _lastLoginTime;
  DateTime? get lastLoginTime => _lastLoginTime;
  bool hasLastLoginTime() => _lastLoginTime != null;

  // "privateCourses" field.
  List<DocumentReference>? _privateCourses;
  List<DocumentReference> get privateCourses => _privateCourses ?? const [];
  bool hasPrivateCourses() => _privateCourses != null;

  // "userBadges" field.
  List<UserBadgesStruct>? _userBadges;
  List<UserBadgesStruct> get userBadges => _userBadges ?? const [];
  bool hasUserBadges() => _userBadges != null;

  // "ArchivedConversations" field.
  List<DocumentReference>? _archivedConversations;
  List<DocumentReference> get archivedConversations =>
      _archivedConversations ?? const [];
  bool hasArchivedConversations() => _archivedConversations != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _termsAccepted = snapshotData['terms_accepted'] as bool?;
    _banned = snapshotData['banned'] as bool?;
    _appVersion = snapshotData['AppVersion'] as String?;
    _userRole = snapshotData['userRole'] as String?;
    _tribeToken = snapshotData['TribeToken'] as String?;
    _likePosts = getDataList(snapshotData['likePosts']);
    _tribeUserId = castToType<int>(snapshotData['tribeUserId']);
    _tribeGroups = getStructList(
      snapshotData['TribeGroups'],
      TribeGroupsStruct.fromMap,
    );
    _lastNotificationReadTime =
        snapshotData['last_notification_read_time'] as DateTime?;
    _contentCompletedIDs = getDataList(snapshotData['contentCompletedIDs']);
    _bio = snapshotData['bio'] as String?;
    _blockedUsers = getDataList(snapshotData['blockedUsers']);
    _userChats = getStructList(
      snapshotData['userChats'],
      ChatDetailsStruct.fromMap,
    );
    _lastLoginTime = snapshotData['last_login_time'] as DateTime?;
    _privateCourses = getDataList(snapshotData['privateCourses']);
    _userBadges = getStructList(
      snapshotData['userBadges'],
      UserBadgesStruct.fromMap,
    );
    _archivedConversations = getDataList(snapshotData['ArchivedConversations']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? termsAccepted,
  bool? banned,
  String? appVersion,
  String? userRole,
  String? tribeToken,
  int? tribeUserId,
  DateTime? lastNotificationReadTime,
  String? bio,
  DateTime? lastLoginTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'terms_accepted': termsAccepted,
      'banned': banned,
      'AppVersion': appVersion,
      'userRole': userRole,
      'TribeToken': tribeToken,
      'tribeUserId': tribeUserId,
      'last_notification_read_time': lastNotificationReadTime,
      'bio': bio,
      'last_login_time': lastLoginTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.termsAccepted == e2?.termsAccepted &&
        e1?.banned == e2?.banned &&
        e1?.appVersion == e2?.appVersion &&
        e1?.userRole == e2?.userRole &&
        e1?.tribeToken == e2?.tribeToken &&
        listEquality.equals(e1?.likePosts, e2?.likePosts) &&
        e1?.tribeUserId == e2?.tribeUserId &&
        listEquality.equals(e1?.tribeGroups, e2?.tribeGroups) &&
        e1?.lastNotificationReadTime == e2?.lastNotificationReadTime &&
        listEquality.equals(e1?.contentCompletedIDs, e2?.contentCompletedIDs) &&
        e1?.bio == e2?.bio &&
        listEquality.equals(e1?.blockedUsers, e2?.blockedUsers) &&
        listEquality.equals(e1?.userChats, e2?.userChats) &&
        e1?.lastLoginTime == e2?.lastLoginTime &&
        listEquality.equals(e1?.privateCourses, e2?.privateCourses) &&
        listEquality.equals(e1?.userBadges, e2?.userBadges) &&
        listEquality.equals(
            e1?.archivedConversations, e2?.archivedConversations);
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.termsAccepted,
        e?.banned,
        e?.appVersion,
        e?.userRole,
        e?.tribeToken,
        e?.likePosts,
        e?.tribeUserId,
        e?.tribeGroups,
        e?.lastNotificationReadTime,
        e?.contentCompletedIDs,
        e?.bio,
        e?.blockedUsers,
        e?.userChats,
        e?.lastLoginTime,
        e?.privateCourses,
        e?.userBadges,
        e?.archivedConversations
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}
