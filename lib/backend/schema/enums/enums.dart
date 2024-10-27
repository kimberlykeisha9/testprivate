import 'package:collection/collection.dart';

enum GroupVisibility {
  hidden,
  private,
  public,
}

enum ActiveCourseTab {
  course,
  content,
  none,
  collection,
}

enum MediaType {
  image,
  video,
  youtube,
  vimeo,
  searchie,
}

enum UserRole {
  free,
  basic,
  premium,
  creator,
  admin,
}

enum DocumentType {
  link,
  doc,
  media,
}

enum AnalyticsPeriod {
  daily,
  weekly,
  monthly,
}

enum MessageMediaType {
  Text,
  Image,
  Video,
  Audio,
  File,
}

enum MessageReaction {
  Like,
  Dislike,
  Love,
  Celebrate,
}

enum MessageType {
  Sent,
  Received,
  ReplyTo,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (GroupVisibility):
      return GroupVisibility.values.deserialize(value) as T?;
    case (ActiveCourseTab):
      return ActiveCourseTab.values.deserialize(value) as T?;
    case (MediaType):
      return MediaType.values.deserialize(value) as T?;
    case (UserRole):
      return UserRole.values.deserialize(value) as T?;
    case (DocumentType):
      return DocumentType.values.deserialize(value) as T?;
    case (AnalyticsPeriod):
      return AnalyticsPeriod.values.deserialize(value) as T?;
    case (MessageMediaType):
      return MessageMediaType.values.deserialize(value) as T?;
    case (MessageReaction):
      return MessageReaction.values.deserialize(value) as T?;
    case (MessageType):
      return MessageType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
