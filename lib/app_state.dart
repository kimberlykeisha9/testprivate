import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _userID = await secureStorage.getInt('ff_userID') ?? _userID;
    });
    await _safeInitAsync(() async {
      _empty = await secureStorage.getString('ff_empty') ?? _empty;
    });
    await _safeInitAsync(() async {
      _s3AccessKey =
          await secureStorage.getString('ff_s3AccessKey') ?? _s3AccessKey;
    });
    await _safeInitAsync(() async {
      _s3SecretKey =
          await secureStorage.getString('ff_s3SecretKey') ?? _s3SecretKey;
    });
    await _safeInitAsync(() async {
      _s3BucketName =
          await secureStorage.getString('ff_s3BucketName') ?? _s3BucketName;
    });
    await _safeInitAsync(() async {
      _currentUserImg =
          await secureStorage.getString('ff_currentUserImg') ?? _currentUserImg;
    });
    await _safeInitAsync(() async {
      _s3EndpointURL =
          await secureStorage.getString('ff_s3EndpointURL') ?? _s3EndpointURL;
    });
    await _safeInitAsync(() async {
      _currentUserGroupList =
          (await secureStorage.getStringList('ff_currentUserGroupList'))
                  ?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _currentUserGroupList;
    });
    await _safeInitAsync(() async {
      _discussionList =
          (await secureStorage.getStringList('ff_discussionList'))?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _discussionList;
    });
    await _safeInitAsync(() async {
      _ActiveGroupTab =
          await secureStorage.getString('ff_ActiveGroupTab') ?? _ActiveGroupTab;
    });
    await _safeInitAsync(() async {
      _trainingContent =
          (await secureStorage.getStringList('ff_trainingContent'))?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trainingContent;
    });
    await _safeInitAsync(() async {
      _currentGroup = (await secureStorage.getString('ff_currentGroup'))?.ref ??
          _currentGroup;
    });
    await _safeInitAsync(() async {
      _isCacheOverride =
          await secureStorage.getBool('ff_isCacheOverride') ?? _isCacheOverride;
    });
    await _safeInitAsync(() async {
      _userGroupsID = (await secureStorage.getStringList('ff_userGroupsID'))
              ?.map(int.parse)
              .toList() ??
          _userGroupsID;
    });
    await _safeInitAsync(() async {
      _notificationCount = await secureStorage.getInt('ff_notificationCount') ??
          _notificationCount;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  int _userID = 0;
  int get userID => _userID;
  set userID(int value) {
    _userID = value;
    secureStorage.setInt('ff_userID', value);
  }

  void deleteUserID() {
    secureStorage.delete(key: 'ff_userID');
  }

  bool _minimise = true;
  bool get minimise => _minimise;
  set minimise(bool value) {
    _minimise = value;
  }

  bool _hasLiked = false;
  bool get hasLiked => _hasLiked;
  set hasLiked(bool value) {
    _hasLiked = value;
  }

  int _currentPage = 1;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
  }

  String _empty = 'null';
  String get empty => _empty;
  set empty(String value) {
    _empty = value;
    secureStorage.setString('ff_empty', value);
  }

  void deleteEmpty() {
    secureStorage.delete(key: 'ff_empty');
  }

  bool _replyDisplay = false;
  bool get replyDisplay => _replyDisplay;
  set replyDisplay(bool value) {
    _replyDisplay = value;
  }

  bool _enabled = false;
  bool get enabled => _enabled;
  set enabled(bool value) {
    _enabled = value;
  }

  bool _isFree = false;
  bool get isFree => _isFree;
  set isFree(bool value) {
    _isFree = value;
  }

  int _itemsPerPage = 15;
  int get itemsPerPage => _itemsPerPage;
  set itemsPerPage(int value) {
    _itemsPerPage = value;
  }

  String _s3AccessKey = 'jx6ae5cgzlnvbt5k2o4phflj3uda';
  String get s3AccessKey => _s3AccessKey;
  set s3AccessKey(String value) {
    _s3AccessKey = value;
    secureStorage.setString('ff_s3AccessKey', value);
  }

  void deleteS3AccessKey() {
    secureStorage.delete(key: 'ff_s3AccessKey');
  }

  String _s3SecretKey = 'j2enook37pf33ixawmhqjomxaw3hwyymjdp7diepqkqlpfajckkdi';
  String get s3SecretKey => _s3SecretKey;
  set s3SecretKey(String value) {
    _s3SecretKey = value;
    secureStorage.setString('ff_s3SecretKey', value);
  }

  void deleteS3SecretKey() {
    secureStorage.delete(key: 'ff_s3SecretKey');
  }

  String _s3BucketName = 'wisdomly-app';
  String get s3BucketName => _s3BucketName;
  set s3BucketName(String value) {
    _s3BucketName = value;
    secureStorage.setString('ff_s3BucketName', value);
  }

  void deleteS3BucketName() {
    secureStorage.delete(key: 'ff_s3BucketName');
  }

  String _currentUserImg = 'anon.png';
  String get currentUserImg => _currentUserImg;
  set currentUserImg(String value) {
    _currentUserImg = value;
    secureStorage.setString('ff_currentUserImg', value);
  }

  void deleteCurrentUserImg() {
    secureStorage.delete(key: 'ff_currentUserImg');
  }

  String _uploaded = '';
  String get uploaded => _uploaded;
  set uploaded(String value) {
    _uploaded = value;
  }

  String _s3EndpointURL = 'https://gateway.storjshare.io';
  String get s3EndpointURL => _s3EndpointURL;
  set s3EndpointURL(String value) {
    _s3EndpointURL = value;
    secureStorage.setString('ff_s3EndpointURL', value);
  }

  void deleteS3EndpointURL() {
    secureStorage.delete(key: 'ff_s3EndpointURL');
  }

  bool _accept = true;
  bool get accept => _accept;
  set accept(bool value) {
    _accept = value;
  }

  bool _showDescription = false;
  bool get showDescription => _showDescription;
  set showDescription(bool value) {
    _showDescription = value;
  }

  List<dynamic> _currentUserGroupList = [];
  List<dynamic> get currentUserGroupList => _currentUserGroupList;
  set currentUserGroupList(List<dynamic> value) {
    _currentUserGroupList = value;
    secureStorage.setStringList(
        'ff_currentUserGroupList', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteCurrentUserGroupList() {
    secureStorage.delete(key: 'ff_currentUserGroupList');
  }

  void addToCurrentUserGroupList(dynamic value) {
    currentUserGroupList.add(value);
    secureStorage.setStringList('ff_currentUserGroupList',
        _currentUserGroupList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromCurrentUserGroupList(dynamic value) {
    currentUserGroupList.remove(value);
    secureStorage.setStringList('ff_currentUserGroupList',
        _currentUserGroupList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromCurrentUserGroupList(int index) {
    currentUserGroupList.removeAt(index);
    secureStorage.setStringList('ff_currentUserGroupList',
        _currentUserGroupList.map((x) => jsonEncode(x)).toList());
  }

  void updateCurrentUserGroupListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    currentUserGroupList[index] = updateFn(_currentUserGroupList[index]);
    secureStorage.setStringList('ff_currentUserGroupList',
        _currentUserGroupList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInCurrentUserGroupList(int index, dynamic value) {
    currentUserGroupList.insert(index, value);
    secureStorage.setStringList('ff_currentUserGroupList',
        _currentUserGroupList.map((x) => jsonEncode(x)).toList());
  }

  int _likeCount = 0;
  int get likeCount => _likeCount;
  set likeCount(int value) {
    _likeCount = value;
  }

  List<dynamic> _announcementList = [];
  List<dynamic> get announcementList => _announcementList;
  set announcementList(List<dynamic> value) {
    _announcementList = value;
  }

  void addToAnnouncementList(dynamic value) {
    announcementList.add(value);
  }

  void removeFromAnnouncementList(dynamic value) {
    announcementList.remove(value);
  }

  void removeAtIndexFromAnnouncementList(int index) {
    announcementList.removeAt(index);
  }

  void updateAnnouncementListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    announcementList[index] = updateFn(_announcementList[index]);
  }

  void insertAtIndexInAnnouncementList(int index, dynamic value) {
    announcementList.insert(index, value);
  }

  bool _showLoadMore = true;
  bool get showLoadMore => _showLoadMore;
  set showLoadMore(bool value) {
    _showLoadMore = value;
  }

  List<dynamic> _discussionList = [];
  List<dynamic> get discussionList => _discussionList;
  set discussionList(List<dynamic> value) {
    _discussionList = value;
    secureStorage.setStringList(
        'ff_discussionList', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteDiscussionList() {
    secureStorage.delete(key: 'ff_discussionList');
  }

  void addToDiscussionList(dynamic value) {
    discussionList.add(value);
    secureStorage.setStringList('ff_discussionList',
        _discussionList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromDiscussionList(dynamic value) {
    discussionList.remove(value);
    secureStorage.setStringList('ff_discussionList',
        _discussionList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromDiscussionList(int index) {
    discussionList.removeAt(index);
    secureStorage.setStringList('ff_discussionList',
        _discussionList.map((x) => jsonEncode(x)).toList());
  }

  void updateDiscussionListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    discussionList[index] = updateFn(_discussionList[index]);
    secureStorage.setStringList('ff_discussionList',
        _discussionList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInDiscussionList(int index, dynamic value) {
    discussionList.insert(index, value);
    secureStorage.setStringList('ff_discussionList',
        _discussionList.map((x) => jsonEncode(x)).toList());
  }

  String _postPhoto = '';
  String get postPhoto => _postPhoto;
  set postPhoto(String value) {
    _postPhoto = value;
  }

  bool _complete = false;
  bool get complete => _complete;
  set complete(bool value) {
    _complete = value;
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool value) {
    _processing = value;
  }

  bool _permission = false;
  bool get permission => _permission;
  set permission(bool value) {
    _permission = value;
  }

  String _AppVersion = '2.1.2';
  String get AppVersion => _AppVersion;
  set AppVersion(String value) {
    _AppVersion = value;
  }

  String _ActiveGroupTab = '';
  String get ActiveGroupTab => _ActiveGroupTab;
  set ActiveGroupTab(String value) {
    _ActiveGroupTab = value;
    secureStorage.setString('ff_ActiveGroupTab', value);
  }

  void deleteActiveGroupTab() {
    secureStorage.delete(key: 'ff_ActiveGroupTab');
  }

  bool _profileEdit = false;
  bool get profileEdit => _profileEdit;
  set profileEdit(bool value) {
    _profileEdit = value;
  }

  List<dynamic> _trainingContent = [];
  List<dynamic> get trainingContent => _trainingContent;
  set trainingContent(List<dynamic> value) {
    _trainingContent = value;
    secureStorage.setStringList(
        'ff_trainingContent', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteTrainingContent() {
    secureStorage.delete(key: 'ff_trainingContent');
  }

  void addToTrainingContent(dynamic value) {
    trainingContent.add(value);
    secureStorage.setStringList('ff_trainingContent',
        _trainingContent.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrainingContent(dynamic value) {
    trainingContent.remove(value);
    secureStorage.setStringList('ff_trainingContent',
        _trainingContent.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrainingContent(int index) {
    trainingContent.removeAt(index);
    secureStorage.setStringList('ff_trainingContent',
        _trainingContent.map((x) => jsonEncode(x)).toList());
  }

  void updateTrainingContentAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    trainingContent[index] = updateFn(_trainingContent[index]);
    secureStorage.setStringList('ff_trainingContent',
        _trainingContent.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrainingContent(int index, dynamic value) {
    trainingContent.insert(index, value);
    secureStorage.setStringList('ff_trainingContent',
        _trainingContent.map((x) => jsonEncode(x)).toList());
  }

  DocumentReference? _currentGroup;
  DocumentReference? get currentGroup => _currentGroup;
  set currentGroup(DocumentReference? value) {
    _currentGroup = value;
    value != null
        ? secureStorage.setString('ff_currentGroup', value.path)
        : secureStorage.remove('ff_currentGroup');
  }

  void deleteCurrentGroup() {
    secureStorage.delete(key: 'ff_currentGroup');
  }

  DateTime? _lastCacheTime;
  DateTime? get lastCacheTime => _lastCacheTime;
  set lastCacheTime(DateTime? value) {
    _lastCacheTime = value;
  }

  bool _isCacheOverride = true;
  bool get isCacheOverride => _isCacheOverride;
  set isCacheOverride(bool value) {
    _isCacheOverride = value;
    secureStorage.setBool('ff_isCacheOverride', value);
  }

  void deleteIsCacheOverride() {
    secureStorage.delete(key: 'ff_isCacheOverride');
  }

  bool _UniqueKey = false;
  bool get UniqueKey => _UniqueKey;
  set UniqueKey(bool value) {
    _UniqueKey = value;
  }

  List<int> _myGroupIds = [];
  List<int> get myGroupIds => _myGroupIds;
  set myGroupIds(List<int> value) {
    _myGroupIds = value;
  }

  void addToMyGroupIds(int value) {
    myGroupIds.add(value);
  }

  void removeFromMyGroupIds(int value) {
    myGroupIds.remove(value);
  }

  void removeAtIndexFromMyGroupIds(int index) {
    myGroupIds.removeAt(index);
  }

  void updateMyGroupIdsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    myGroupIds[index] = updateFn(_myGroupIds[index]);
  }

  void insertAtIndexInMyGroupIds(int index, int value) {
    myGroupIds.insert(index, value);
  }

  String _trainingUserCompleted = '';
  String get trainingUserCompleted => _trainingUserCompleted;
  set trainingUserCompleted(String value) {
    _trainingUserCompleted = value;
  }

  String _trainingTotalItems = '';
  String get trainingTotalItems => _trainingTotalItems;
  set trainingTotalItems(String value) {
    _trainingTotalItems = value;
  }

  List<String> _menuItems = ['Feed', 'Groups', 'Support', 'My Profile'];
  List<String> get menuItems => _menuItems;
  set menuItems(List<String> value) {
    _menuItems = value;
  }

  void addToMenuItems(String value) {
    menuItems.add(value);
  }

  void removeFromMenuItems(String value) {
    menuItems.remove(value);
  }

  void removeAtIndexFromMenuItems(int index) {
    menuItems.removeAt(index);
  }

  void updateMenuItemsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    menuItems[index] = updateFn(_menuItems[index]);
  }

  void insertAtIndexInMenuItems(int index, String value) {
    menuItems.insert(index, value);
  }

  String _menuActiveItem = 'Groups';
  String get menuActiveItem => _menuActiveItem;
  set menuActiveItem(String value) {
    _menuActiveItem = value;
  }

  bool _ClearCacheGroupTraining = false;
  bool get ClearCacheGroupTraining => _ClearCacheGroupTraining;
  set ClearCacheGroupTraining(bool value) {
    _ClearCacheGroupTraining = value;
  }

  bool _refreshTraining = false;
  bool get refreshTraining => _refreshTraining;
  set refreshTraining(bool value) {
    _refreshTraining = value;
  }

  String _uploadedVideoAssetId = '';
  String get uploadedVideoAssetId => _uploadedVideoAssetId;
  set uploadedVideoAssetId(String value) {
    _uploadedVideoAssetId = value;
  }

  String _currentSidebarPage = 'My Groups';
  String get currentSidebarPage => _currentSidebarPage;
  set currentSidebarPage(String value) {
    _currentSidebarPage = value;
  }

  List<DocumentReference> _userMentionTextInputUserRefs = [];
  List<DocumentReference> get userMentionTextInputUserRefs =>
      _userMentionTextInputUserRefs;
  set userMentionTextInputUserRefs(List<DocumentReference> value) {
    _userMentionTextInputUserRefs = value;
  }

  void addToUserMentionTextInputUserRefs(DocumentReference value) {
    userMentionTextInputUserRefs.add(value);
  }

  void removeFromUserMentionTextInputUserRefs(DocumentReference value) {
    userMentionTextInputUserRefs.remove(value);
  }

  void removeAtIndexFromUserMentionTextInputUserRefs(int index) {
    userMentionTextInputUserRefs.removeAt(index);
  }

  void updateUserMentionTextInputUserRefsAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    userMentionTextInputUserRefs[index] =
        updateFn(_userMentionTextInputUserRefs[index]);
  }

  void insertAtIndexInUserMentionTextInputUserRefs(
      int index, DocumentReference value) {
    userMentionTextInputUserRefs.insert(index, value);
  }

  String _userMentionTextInputText = '';
  String get userMentionTextInputText => _userMentionTextInputText;
  set userMentionTextInputText(String value) {
    _userMentionTextInputText = value;
  }

  bool _userMentionTextInputClearState = false;
  bool get userMentionTextInputClearState => _userMentionTextInputClearState;
  set userMentionTextInputClearState(bool value) {
    _userMentionTextInputClearState = value;
  }

  List<int> _userGroupsID = [];
  List<int> get userGroupsID => _userGroupsID;
  set userGroupsID(List<int> value) {
    _userGroupsID = value;
    secureStorage.setStringList(
        'ff_userGroupsID', value.map((x) => x.toString()).toList());
  }

  void deleteUserGroupsID() {
    secureStorage.delete(key: 'ff_userGroupsID');
  }

  void addToUserGroupsID(int value) {
    userGroupsID.add(value);
    secureStorage.setStringList(
        'ff_userGroupsID', _userGroupsID.map((x) => x.toString()).toList());
  }

  void removeFromUserGroupsID(int value) {
    userGroupsID.remove(value);
    secureStorage.setStringList(
        'ff_userGroupsID', _userGroupsID.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromUserGroupsID(int index) {
    userGroupsID.removeAt(index);
    secureStorage.setStringList(
        'ff_userGroupsID', _userGroupsID.map((x) => x.toString()).toList());
  }

  void updateUserGroupsIDAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    userGroupsID[index] = updateFn(_userGroupsID[index]);
    secureStorage.setStringList(
        'ff_userGroupsID', _userGroupsID.map((x) => x.toString()).toList());
  }

  void insertAtIndexInUserGroupsID(int index, int value) {
    userGroupsID.insert(index, value);
    secureStorage.setStringList(
        'ff_userGroupsID', _userGroupsID.map((x) => x.toString()).toList());
  }

  DocumentReference? _postViewActiveContentRef;
  DocumentReference? get postViewActiveContentRef => _postViewActiveContentRef;
  set postViewActiveContentRef(DocumentReference? value) {
    _postViewActiveContentRef = value;
  }

  int _notificationCount = 0;
  int get notificationCount => _notificationCount;
  set notificationCount(int value) {
    _notificationCount = value;
    secureStorage.setInt('ff_notificationCount', value);
  }

  void deleteNotificationCount() {
    secureStorage.delete(key: 'ff_notificationCount');
  }

  final _userDocQueryManager = FutureRequestManager<UserRecord>();
  Future<UserRecord> userDocQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UserRecord> Function() requestFn,
  }) =>
      _userDocQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserDocQueryCache() => _userDocQueryManager.clear();
  void clearUserDocQueryCacheKey(String? uniqueKey) =>
      _userDocQueryManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
