import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TribeGroupsRecord extends FirestoreRecord {
  TribeGroupsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "tribeGroupID" field.
  int? _tribeGroupID;
  int get tribeGroupID => _tribeGroupID ?? 0;
  bool hasTribeGroupID() => _tribeGroupID != null;

  // "purchaseLink" field.
  String? _purchaseLink;
  String get purchaseLink => _purchaseLink ?? '';
  bool hasPurchaseLink() => _purchaseLink != null;

  // "featuredVideo" field.
  String? _featuredVideo;
  String get featuredVideo => _featuredVideo ?? '';
  bool hasFeaturedVideo() => _featuredVideo != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "headlineText" field.
  String? _headlineText;
  String get headlineText => _headlineText ?? '';
  bool hasHeadlineText() => _headlineText != null;

  // "headlineBtnUrl" field.
  String? _headlineBtnUrl;
  String get headlineBtnUrl => _headlineBtnUrl ?? '';
  bool hasHeadlineBtnUrl() => _headlineBtnUrl != null;

  // "headlineBtnText" field.
  String? _headlineBtnText;
  String get headlineBtnText => _headlineBtnText ?? '';
  bool hasHeadlineBtnText() => _headlineBtnText != null;

  // "featuredImg" field.
  String? _featuredImg;
  String get featuredImg => _featuredImg ?? '';
  bool hasFeaturedImg() => _featuredImg != null;

  // "IsLive" field.
  bool? _isLive;
  bool get isLive => _isLive ?? false;
  bool hasIsLive() => _isLive != null;

  // "sessionHeadlineText" field.
  String? _sessionHeadlineText;
  String get sessionHeadlineText => _sessionHeadlineText ?? '';
  bool hasSessionHeadlineText() => _sessionHeadlineText != null;

  // "nextSteps" field.
  List<NextStepsStruct>? _nextSteps;
  List<NextStepsStruct> get nextSteps => _nextSteps ?? const [];
  bool hasNextSteps() => _nextSteps != null;

  // "TodayTabEnabled" field.
  bool? _todayTabEnabled;
  bool get todayTabEnabled => _todayTabEnabled ?? false;
  bool hasTodayTabEnabled() => _todayTabEnabled != null;

  // "ReplayTabEnabled" field.
  bool? _replayTabEnabled;
  bool get replayTabEnabled => _replayTabEnabled ?? false;
  bool hasReplayTabEnabled() => _replayTabEnabled != null;

  // "CommunityTabEnabled" field.
  bool? _communityTabEnabled;
  bool get communityTabEnabled => _communityTabEnabled ?? false;
  bool hasCommunityTabEnabled() => _communityTabEnabled != null;

  // "TrainingTabEnabled" field.
  bool? _trainingTabEnabled;
  bool get trainingTabEnabled => _trainingTabEnabled ?? false;
  bool hasTrainingTabEnabled() => _trainingTabEnabled != null;

  // "NextStepsTabEnabled" field.
  bool? _nextStepsTabEnabled;
  bool get nextStepsTabEnabled => _nextStepsTabEnabled ?? false;
  bool hasNextStepsTabEnabled() => _nextStepsTabEnabled != null;

  // "FeedEnabled" field.
  bool? _feedEnabled;
  bool get feedEnabled => _feedEnabled ?? false;
  bool hasFeedEnabled() => _feedEnabled != null;

  // "groupSlug" field.
  String? _groupSlug;
  String get groupSlug => _groupSlug ?? '';
  bool hasGroupSlug() => _groupSlug != null;

  // "EventsTabEnabled" field.
  bool? _eventsTabEnabled;
  bool get eventsTabEnabled => _eventsTabEnabled ?? false;
  bool hasEventsTabEnabled() => _eventsTabEnabled != null;

  // "AddEventUrl" field.
  String? _addEventUrl;
  String get addEventUrl => _addEventUrl ?? '';
  bool hasAddEventUrl() => _addEventUrl != null;

  // "CommunityAdminOnlyTabEnabled" field.
  bool? _communityAdminOnlyTabEnabled;
  bool get communityAdminOnlyTabEnabled =>
      _communityAdminOnlyTabEnabled ?? false;
  bool hasCommunityAdminOnlyTabEnabled() =>
      _communityAdminOnlyTabEnabled != null;

  // "Categories" field.
  List<String>? _categories;
  List<String> get categories => _categories ?? const [];
  bool hasCategories() => _categories != null;

  // "visibility" field.
  String? _visibility;
  String get visibility => _visibility ?? '';
  bool hasVisibility() => _visibility != null;

  // "CoursesTabEnabled" field.
  bool? _coursesTabEnabled;
  bool get coursesTabEnabled => _coursesTabEnabled ?? false;
  bool hasCoursesTabEnabled() => _coursesTabEnabled != null;

  // "GroupType" field.
  List<String>? _groupType;
  List<String> get groupType => _groupType ?? const [];
  bool hasGroupType() => _groupType != null;

  // "ChatbotTabEnabled" field.
  bool? _chatbotTabEnabled;
  bool get chatbotTabEnabled => _chatbotTabEnabled ?? false;
  bool hasChatbotTabEnabled() => _chatbotTabEnabled != null;

  // "ChatbotTabLabel" field.
  String? _chatbotTabLabel;
  String get chatbotTabLabel => _chatbotTabLabel ?? '';
  bool hasChatbotTabLabel() => _chatbotTabLabel != null;

  // "ChatbotEmbedUrl" field.
  String? _chatbotEmbedUrl;
  String get chatbotEmbedUrl => _chatbotEmbedUrl ?? '';
  bool hasChatbotEmbedUrl() => _chatbotEmbedUrl != null;

  // "position" field.
  int? _position;
  int get position => _position ?? 0;
  bool hasPosition() => _position != null;

  // "MembersTabEnabled" field.
  bool? _membersTabEnabled;
  bool get membersTabEnabled => _membersTabEnabled ?? false;
  bool hasMembersTabEnabled() => _membersTabEnabled != null;

  // "GroupBadges" field.
  List<UserBadgesStruct>? _groupBadges;
  List<UserBadgesStruct> get groupBadges => _groupBadges ?? const [];
  bool hasGroupBadges() => _groupBadges != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _tribeGroupID = castToType<int>(snapshotData['tribeGroupID']);
    _purchaseLink = snapshotData['purchaseLink'] as String?;
    _featuredVideo = snapshotData['featuredVideo'] as String?;
    _description = snapshotData['description'] as String?;
    _headlineText = snapshotData['headlineText'] as String?;
    _headlineBtnUrl = snapshotData['headlineBtnUrl'] as String?;
    _headlineBtnText = snapshotData['headlineBtnText'] as String?;
    _featuredImg = snapshotData['featuredImg'] as String?;
    _isLive = snapshotData['IsLive'] as bool?;
    _sessionHeadlineText = snapshotData['sessionHeadlineText'] as String?;
    _nextSteps = getStructList(
      snapshotData['nextSteps'],
      NextStepsStruct.fromMap,
    );
    _todayTabEnabled = snapshotData['TodayTabEnabled'] as bool?;
    _replayTabEnabled = snapshotData['ReplayTabEnabled'] as bool?;
    _communityTabEnabled = snapshotData['CommunityTabEnabled'] as bool?;
    _trainingTabEnabled = snapshotData['TrainingTabEnabled'] as bool?;
    _nextStepsTabEnabled = snapshotData['NextStepsTabEnabled'] as bool?;
    _feedEnabled = snapshotData['FeedEnabled'] as bool?;
    _groupSlug = snapshotData['groupSlug'] as String?;
    _eventsTabEnabled = snapshotData['EventsTabEnabled'] as bool?;
    _addEventUrl = snapshotData['AddEventUrl'] as String?;
    _communityAdminOnlyTabEnabled =
        snapshotData['CommunityAdminOnlyTabEnabled'] as bool?;
    _categories = getDataList(snapshotData['Categories']);
    _visibility = snapshotData['visibility'] as String?;
    _coursesTabEnabled = snapshotData['CoursesTabEnabled'] as bool?;
    _groupType = getDataList(snapshotData['GroupType']);
    _chatbotTabEnabled = snapshotData['ChatbotTabEnabled'] as bool?;
    _chatbotTabLabel = snapshotData['ChatbotTabLabel'] as String?;
    _chatbotEmbedUrl = snapshotData['ChatbotEmbedUrl'] as String?;
    _position = castToType<int>(snapshotData['position']);
    _membersTabEnabled = snapshotData['MembersTabEnabled'] as bool?;
    _groupBadges = getStructList(
      snapshotData['GroupBadges'],
      UserBadgesStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TribeGroups');

  static Stream<TribeGroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TribeGroupsRecord.fromSnapshot(s));

  static Future<TribeGroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TribeGroupsRecord.fromSnapshot(s));

  static TribeGroupsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TribeGroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TribeGroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TribeGroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TribeGroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TribeGroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTribeGroupsRecordData({
  String? name,
  int? tribeGroupID,
  String? purchaseLink,
  String? featuredVideo,
  String? description,
  String? headlineText,
  String? headlineBtnUrl,
  String? headlineBtnText,
  String? featuredImg,
  bool? isLive,
  String? sessionHeadlineText,
  bool? todayTabEnabled,
  bool? replayTabEnabled,
  bool? communityTabEnabled,
  bool? trainingTabEnabled,
  bool? nextStepsTabEnabled,
  bool? feedEnabled,
  String? groupSlug,
  bool? eventsTabEnabled,
  String? addEventUrl,
  bool? communityAdminOnlyTabEnabled,
  String? visibility,
  bool? coursesTabEnabled,
  bool? chatbotTabEnabled,
  String? chatbotTabLabel,
  String? chatbotEmbedUrl,
  int? position,
  bool? membersTabEnabled,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'tribeGroupID': tribeGroupID,
      'purchaseLink': purchaseLink,
      'featuredVideo': featuredVideo,
      'description': description,
      'headlineText': headlineText,
      'headlineBtnUrl': headlineBtnUrl,
      'headlineBtnText': headlineBtnText,
      'featuredImg': featuredImg,
      'IsLive': isLive,
      'sessionHeadlineText': sessionHeadlineText,
      'TodayTabEnabled': todayTabEnabled,
      'ReplayTabEnabled': replayTabEnabled,
      'CommunityTabEnabled': communityTabEnabled,
      'TrainingTabEnabled': trainingTabEnabled,
      'NextStepsTabEnabled': nextStepsTabEnabled,
      'FeedEnabled': feedEnabled,
      'groupSlug': groupSlug,
      'EventsTabEnabled': eventsTabEnabled,
      'AddEventUrl': addEventUrl,
      'CommunityAdminOnlyTabEnabled': communityAdminOnlyTabEnabled,
      'visibility': visibility,
      'CoursesTabEnabled': coursesTabEnabled,
      'ChatbotTabEnabled': chatbotTabEnabled,
      'ChatbotTabLabel': chatbotTabLabel,
      'ChatbotEmbedUrl': chatbotEmbedUrl,
      'position': position,
      'MembersTabEnabled': membersTabEnabled,
    }.withoutNulls,
  );

  return firestoreData;
}

class TribeGroupsRecordDocumentEquality implements Equality<TribeGroupsRecord> {
  const TribeGroupsRecordDocumentEquality();

  @override
  bool equals(TribeGroupsRecord? e1, TribeGroupsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.tribeGroupID == e2?.tribeGroupID &&
        e1?.purchaseLink == e2?.purchaseLink &&
        e1?.featuredVideo == e2?.featuredVideo &&
        e1?.description == e2?.description &&
        e1?.headlineText == e2?.headlineText &&
        e1?.headlineBtnUrl == e2?.headlineBtnUrl &&
        e1?.headlineBtnText == e2?.headlineBtnText &&
        e1?.featuredImg == e2?.featuredImg &&
        e1?.isLive == e2?.isLive &&
        e1?.sessionHeadlineText == e2?.sessionHeadlineText &&
        listEquality.equals(e1?.nextSteps, e2?.nextSteps) &&
        e1?.todayTabEnabled == e2?.todayTabEnabled &&
        e1?.replayTabEnabled == e2?.replayTabEnabled &&
        e1?.communityTabEnabled == e2?.communityTabEnabled &&
        e1?.trainingTabEnabled == e2?.trainingTabEnabled &&
        e1?.nextStepsTabEnabled == e2?.nextStepsTabEnabled &&
        e1?.feedEnabled == e2?.feedEnabled &&
        e1?.groupSlug == e2?.groupSlug &&
        e1?.eventsTabEnabled == e2?.eventsTabEnabled &&
        e1?.addEventUrl == e2?.addEventUrl &&
        e1?.communityAdminOnlyTabEnabled == e2?.communityAdminOnlyTabEnabled &&
        listEquality.equals(e1?.categories, e2?.categories) &&
        e1?.visibility == e2?.visibility &&
        e1?.coursesTabEnabled == e2?.coursesTabEnabled &&
        listEquality.equals(e1?.groupType, e2?.groupType) &&
        e1?.chatbotTabEnabled == e2?.chatbotTabEnabled &&
        e1?.chatbotTabLabel == e2?.chatbotTabLabel &&
        e1?.chatbotEmbedUrl == e2?.chatbotEmbedUrl &&
        e1?.position == e2?.position &&
        e1?.membersTabEnabled == e2?.membersTabEnabled &&
        listEquality.equals(e1?.groupBadges, e2?.groupBadges);
  }

  @override
  int hash(TribeGroupsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.tribeGroupID,
        e?.purchaseLink,
        e?.featuredVideo,
        e?.description,
        e?.headlineText,
        e?.headlineBtnUrl,
        e?.headlineBtnText,
        e?.featuredImg,
        e?.isLive,
        e?.sessionHeadlineText,
        e?.nextSteps,
        e?.todayTabEnabled,
        e?.replayTabEnabled,
        e?.communityTabEnabled,
        e?.trainingTabEnabled,
        e?.nextStepsTabEnabled,
        e?.feedEnabled,
        e?.groupSlug,
        e?.eventsTabEnabled,
        e?.addEventUrl,
        e?.communityAdminOnlyTabEnabled,
        e?.categories,
        e?.visibility,
        e?.coursesTabEnabled,
        e?.groupType,
        e?.chatbotTabEnabled,
        e?.chatbotTabLabel,
        e?.chatbotEmbedUrl,
        e?.position,
        e?.membersTabEnabled,
        e?.groupBadges
      ]);

  @override
  bool isValidKey(Object? o) => o is TribeGroupsRecord;
}
