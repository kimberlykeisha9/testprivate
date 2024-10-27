// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NextStepsStruct extends FFFirebaseStruct {
  NextStepsStruct({
    String? featuredImage,
    String? title,
    String? description,
    String? ctaText,
    String? ctaLink,
    int? order,
    bool? featureOnToday,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _featuredImage = featuredImage,
        _title = title,
        _description = description,
        _ctaText = ctaText,
        _ctaLink = ctaLink,
        _order = order,
        _featureOnToday = featureOnToday,
        super(firestoreUtilData);

  // "featuredImage" field.
  String? _featuredImage;
  String get featuredImage => _featuredImage ?? '';
  set featuredImage(String? val) => _featuredImage = val;

  bool hasFeaturedImage() => _featuredImage != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "cta_text" field.
  String? _ctaText;
  String get ctaText => _ctaText ?? '';
  set ctaText(String? val) => _ctaText = val;

  bool hasCtaText() => _ctaText != null;

  // "cta_link" field.
  String? _ctaLink;
  String get ctaLink => _ctaLink ?? '';
  set ctaLink(String? val) => _ctaLink = val;

  bool hasCtaLink() => _ctaLink != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  set order(int? val) => _order = val;

  void incrementOrder(int amount) => order = order + amount;

  bool hasOrder() => _order != null;

  // "FeatureOnToday" field.
  bool? _featureOnToday;
  bool get featureOnToday => _featureOnToday ?? false;
  set featureOnToday(bool? val) => _featureOnToday = val;

  bool hasFeatureOnToday() => _featureOnToday != null;

  static NextStepsStruct fromMap(Map<String, dynamic> data) => NextStepsStruct(
        featuredImage: data['featuredImage'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        ctaText: data['cta_text'] as String?,
        ctaLink: data['cta_link'] as String?,
        order: castToType<int>(data['order']),
        featureOnToday: data['FeatureOnToday'] as bool?,
      );

  static NextStepsStruct? maybeFromMap(dynamic data) => data is Map
      ? NextStepsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'featuredImage': _featuredImage,
        'title': _title,
        'description': _description,
        'cta_text': _ctaText,
        'cta_link': _ctaLink,
        'order': _order,
        'FeatureOnToday': _featureOnToday,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'featuredImage': serializeParam(
          _featuredImage,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'cta_text': serializeParam(
          _ctaText,
          ParamType.String,
        ),
        'cta_link': serializeParam(
          _ctaLink,
          ParamType.String,
        ),
        'order': serializeParam(
          _order,
          ParamType.int,
        ),
        'FeatureOnToday': serializeParam(
          _featureOnToday,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NextStepsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NextStepsStruct(
        featuredImage: deserializeParam(
          data['featuredImage'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        ctaText: deserializeParam(
          data['cta_text'],
          ParamType.String,
          false,
        ),
        ctaLink: deserializeParam(
          data['cta_link'],
          ParamType.String,
          false,
        ),
        order: deserializeParam(
          data['order'],
          ParamType.int,
          false,
        ),
        featureOnToday: deserializeParam(
          data['FeatureOnToday'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'NextStepsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NextStepsStruct &&
        featuredImage == other.featuredImage &&
        title == other.title &&
        description == other.description &&
        ctaText == other.ctaText &&
        ctaLink == other.ctaLink &&
        order == other.order &&
        featureOnToday == other.featureOnToday;
  }

  @override
  int get hashCode => const ListEquality().hash([
        featuredImage,
        title,
        description,
        ctaText,
        ctaLink,
        order,
        featureOnToday
      ]);
}

NextStepsStruct createNextStepsStruct({
  String? featuredImage,
  String? title,
  String? description,
  String? ctaText,
  String? ctaLink,
  int? order,
  bool? featureOnToday,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NextStepsStruct(
      featuredImage: featuredImage,
      title: title,
      description: description,
      ctaText: ctaText,
      ctaLink: ctaLink,
      order: order,
      featureOnToday: featureOnToday,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NextStepsStruct? updateNextStepsStruct(
  NextStepsStruct? nextSteps, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nextSteps
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNextStepsStructData(
  Map<String, dynamic> firestoreData,
  NextStepsStruct? nextSteps,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nextSteps == null) {
    return;
  }
  if (nextSteps.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nextSteps.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nextStepsData = getNextStepsFirestoreData(nextSteps, forFieldValue);
  final nestedData = nextStepsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nextSteps.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNextStepsFirestoreData(
  NextStepsStruct? nextSteps, [
  bool forFieldValue = false,
]) {
  if (nextSteps == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nextSteps.toMap());

  // Add any Firestore field values
  nextSteps.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNextStepsListFirestoreData(
  List<NextStepsStruct>? nextStepss,
) =>
    nextStepss?.map((e) => getNextStepsFirestoreData(e, true)).toList() ?? [];
