import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

bool isGroupHidden(String? groupVisibility) {
  // Custom code added
  bool lock = true;
  if (groupVisibility == "hidden") {
    lock = false;
  }
  return lock;
}

String? returnProgressPercent(
  String? userCompletedItems,
  String? totalItems,
) {
  // Check if any of the parameters are null
  if (userCompletedItems == null || totalItems == null) {
    return null; // or handle as per your use case
  }

  // Convert String to int and handle possible FormatException
  int userCompletedItemsInt;
  int totalItemsInt;
  try {
    userCompletedItemsInt = int.parse(userCompletedItems);
    totalItemsInt = int.parse(totalItems);
  } catch (e) {
    print("Error: Invalid input - $e");
    return null; // or handle as per your use case
  }

  // Check for division by zero
  if (totalItemsInt == 0) {
    return null; // or return an error message or handle as per your use case
  }

  // Calculate the percentage and convert to string with "%" symbol.
  double result = (userCompletedItemsInt / totalItemsInt) * 100;
  return "${result.truncate() == result ? result.toInt() : result.toStringAsFixed(1)}%";
}

bool showVideoIfYoutube(
  String? vid,
  String? content,
) {
  bool show = false;
  if (vid != null && vid.contains("youtu")) {
    show = true;
  } else if (content != null && content.contains("youtu")) {
    show = true;
  }
  return show;
}

String? returnString(String? ret) {
  return ret;
}

bool showLive(
  String? type,
  String? video,
) {
  if (video == null && type == "mux") {
    return true;
  } else {
    return false;
  }
}

int incrementInteger(
  int inputInt,
  int increment,
) {
  return (inputInt + increment);
}

VideoTypeStruct detectVideoType(String link) {
  if (link.contains('youtube') || link.contains('youtu.be')) {
    // Check if link is youtube link
    return VideoTypeStruct(
        url: link.replaceFirst("/live/", "/embed/"), type: "youtube");
  } else if (link.contains('vimeo')) {
    // Check if link is vimeo
    return VideoTypeStruct(url: link, type: "vimeo");
  } else {
    // If not youtube and not vimeo, then it's searchie
    return VideoTypeStruct(url: link, type: "searchie");
  }
}

String returnYoutube(
  String? video,
  String? content,
) {
  String ret = "";

  if (video != null && video != "") {
    ret = video;
  } else if (content != null && content != "") {
    ret = content;
  }

  return ret;
}

bool isVideo(
  String? video,
  String? contentURI,
  String? type,
) {
  bool show = false;

  if (video != null) {
    show = true;
  }

  if (contentURI != null) {
    if (contentURI.contains("youtu")) {
      show = true;
    } else if (contentURI.contains("mux")) {
      show = true;
    } else if (contentURI.contains("vimeo")) {
      show = true;
    } else if (contentURI.contains(".mp4")) {
      show = true;
    }
  }

  if (type != null) {
    if (type == "video embed") {
      show = true;
    } else if (type == "video") {
      show = true;
    } else if (type == "zoom") {
      show = true;
    } else if (type == "mux") {
      show = true;
    } else if (type == "restream") {
      show = true;
    } else if (type == "live streaming") {
      show = true;
    } else if (type == "download") {
      show = false;
    } else if (type == "link") {
      show = false;
    } else if (type == "article") {
      show = false;
    }
  }

  return show;
}

String renderRestream(String? token) {
  String concat = "";

  String start = '<iframe src="https://player.restream.io/?token=';
  String end =
      ' allow="autoplay" allowfullscreen frameborder="0" style="position:absolute;top:0;left:0;width:100%;height:100%;"/></iframe>';

  if (token != null) {
    concat = start + token + end;
  }

  return concat;
}

bool isRestream(String? type) {
  bool display = false;
  if (type != null && type == "restream") {
    display = true;
  }

  return display;
}

String listExtractItem(
  List<String>? list,
  int? index,
) {
  String ret = "";
  if (list != null && index != null) {
    ret = list[index];
  }

  return ret;
}

bool? isPublishDateToday(DateTime? dateTime) {
  // is the dateTime today based on user's timezone
  if (dateTime == null) {
    return null;
  }
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime publishDate =
      DateTime(dateTime.year, dateTime.month, dateTime.day);
  return publishDate == today;
}

int? findEmptyMessage(String? myMessage) {
  // count non-space characters of myMessage and return character count
  if (myMessage != null) {
    int? emptyMessage;
    var count = 0;
    var substrings = myMessage.split('');
    for (var i in substrings) {
      if (i != ' ') {
        count++;
      } else if ((count == 0)) {
        emptyMessage = null;
        break;
      }
    }
    emptyMessage = count;
    return emptyMessage;
  }
  print("null value in: findEmptyMessage method");
  return null;
}

bool isExternalUrl(String? url) {
  bool display = false;

  if (url != null) {
    if (url.contains("https")) {
      display = true;
    }
  }
  return display;
}

List<dynamic>? orderListByOrderField(List<dynamic> jsonList) {
  // sort a json list argument using the order integer field and return an ordered list
  List<dynamic> newList = [];
  jsonList.sort((a, b) => a['order'].compareTo(b['order']));
  for (var i = 0; i < jsonList.length; i++) {
    newList.add(jsonList[i]);
  }
  return newList;
}

int countCurrentCommentAndItsReplies(List<PostCommentStruct>? currentReplies) {
  //

  // Return the count of the replies
  return currentReplies!.length + 1;
}

bool? isSearchie(String? type) {
  return type == "searchie";
}

bool isStatic(String? type) {
  bool display = true;
  if (type != null) {
    if (type == "mux") {
      display = false;
    } else if (type == "video") {
      display = false;
    } else if (type == "zoom") {
      display = false;
    } else if (type == "video embed") {
      display = false;
    } else if (type == "live streaming") {
      display = false;
    } else if (type == "searchie") {
      display = false;
    } else if (type == "restream") {
      display = false;
    }
  }

  return display;
}

List<String>? convertStringList(String? stringList) {
  List<String> list = stringList!.split(',');
  return list;
}

int countMembers(dynamic jsonItem) {
  //var json = jsonDecode(jsonItem.body);
  //var users = json['users'];
  //final length = users.length;
  //return length;\
  return 0;
}

String createUrlFromPlaybackId(String playbackId) {
  return 'https://stream.mux.com/$playbackId.m3u8';
}

String? extractVimeoId(String? vid) {
  String output = "";
  if (vid != null && vid.contains("vimeo")) {
    output = vid.replaceAll("https://vimeo.com/", "");
  }

  return output;
}

String featuredImageReturn(
  String? featuredImage,
  String imgBaseUrl,
) {
  String img = "";

  if (featuredImage != null && featuredImage.contains("mux")) {
    img = featuredImage;
  } else if (featuredImage != null && featuredImage.contains("firebase")) {
    img = featuredImage;
  } else if (featuredImage != null) {
    img = imgBaseUrl + featuredImage;
  }

  return img;
}

DateTime formatDate(String datetime) {
  // Define the input format
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  // Parse the input date
  DateTime parsedDate = inputFormat.parse(datetime, true); // parse in UTC

  // Convert to local time zone
  DateTime localDate = parsedDate.toLocal();

  return localDate;
}

int charCount(String? descriptionPlain) {
  int count = 0;

  if (descriptionPlain != null) {
    // Custom Code Added
    count = descriptionPlain.length;
  }

  //160

  return count;
}

String getPlaybackIdFromUrl(String url) {
  String str1 = url.replaceAll(".m3u8", "");
  return str1.split("/").last;
}

bool hideDiplayNameifNullCopy(String? description) {
  if (description == null) {
    return true;
  } else {
    return false;
  }
}

String imageReturn(
  String? image,
  String? imgBaseURL,
) {
  String imgReturn = "";
  if (image != null && image.contains("firebase")) {
    imgReturn = image;
  } else if (image != null && imgBaseURL != null) {
    imgReturn = imgBaseURL + image;
  }

  return imgReturn;
}

String imgReplace(
  String? imageFile,
  String? altImage,
) {
  String imagePath;

  if (imageFile == "null") {
    imagePath = "https://ik.imagekit.io/vngwebikzm/brilliant/" +
        altImage! +
        "?tr=w-50,h-50";
  } else {
    imagePath = "https://ik.imagekit.io/vngwebikzm/brilliant/" +
        imageFile! +
        "?tr=w-50,h-50";
  }

  return imagePath;
}

int intListExtract(
  String? intList,
  int? index,
) {
  List<String> list = intList!.split(',');
  List<int> numbers = list.map(int.parse).toList();
  int retInt = numbers[index!];
  return retInt;
}

bool isDownload(String? type) {
  bool display = false;

  if (type != null) {
    if (type == "download") {
      display = true;
    }
  }
  return display;
}

bool isFree(String? userRole) {
  bool lock = false;
  if (userRole == "free") {
    lock = true;
  }
  return lock;
}

bool isLiked(
  List<int>? jsonLikes,
  int? userId,
) {
  bool isLiked;

  if (jsonLikes!.contains(userId)) {
    isLiked = true;
  } else {
    isLiked = false;
  }

  return isLiked;
}

bool isLink(String? type) {
  bool display = false;

  if (type != null) {
    if (type == "link") {
      display = true;
    }
  }
  return display;
}

bool isPending(String? userRole) {
  bool pending = false;
  if (userRole == "pending") {
    pending = true;
  }
  return pending;
}

bool isZoom(String? type) {
  bool display = false;
  if (type != null && type == "zoom") {
    display = true;
  }

  return display;
}

String pfpNullImage(
  String? imageFile,
  String imgBaseUrl,
) {
  String imagePath;

  if (imageFile == null || imageFile == "null") {
    imagePath = "assets/error_image.jpg";
  } else if (imageFile.contains("http")) {
    imagePath = imageFile;
  } else {
    try {
      imagePath = imgBaseUrl + imageFile + "?tr=w-70,h-70,q-80";
      // Optionally you can add a function to verify if the constructed URL is valid
      // bool isValidUrl = await isValidImageUrl(imagePath);
      // if (!isValidUrl) throw Error();
    } catch (e) {
      imagePath = "assets/error_image.jpg";
    }
  }
  return imagePath;
}

String retVidPath(String? video) {
  if (video != null) {
    return video;
  } else {
    return "";
  }
}

bool showVimeo(String? vid) {
  bool show = false;
  if (vid != null) {
    if (vid.contains("vimeo")) {
      show = true;
    }
  }
  return show;
}

bool showMux(String? type) {
  bool show = false;
  if (type == "mux") {
    show = true;
  }
  return show;
}

String strListExtract(
  String? stringList,
  int? index,
) {
  List<String> list = stringList!.split(',');
  String retString = list[index!];

  return retString;
}

bool showNormalVid(
  String? vid,
  String? type,
) {
  bool show = false;
  if (vid != null) {
    show = true;
    if (vid.contains("youtu")) {
      show = false;
    } else if (vid.contains("mux")) {
      show = false;
    } else if (vid.contains("vimeo")) {
      show = false;
    } else if (type == "download") {
      show = false;
    } else if (type == "article") {
      show = false;
    } else if (type == "video embed") {
      show = false;
    } else if (type == "restream") {
      show = false;
    }
  }
  if (vid == null) {
    show = false;
  }
  return show;
}

String twoValuesOneReturn(
  String? value1,
  String? value2,
) {
  if (value1 == null && value2 != null) {
    return value2;
  } else if (value1 != null) {
    return value1;
  }

  return " ";
}

String vidPathToString(String url) {
  return url;
}

double? returnProgressMath(
  String? userCompletedItems,
  String? totalItems,
) {
  // Check if any of the parameters are null
  if (userCompletedItems == null || totalItems == null) {
    return null; // or handle as per your use case
  }

  // Convert String to int and handle possible FormatException
  int userCompletedItemsInt;
  int totalItemsInt;
  try {
    userCompletedItemsInt = int.parse(userCompletedItems);
    totalItemsInt = int.parse(totalItems);
  } catch (e) {
    print("Error: Invalid input - $e");
    return null; // or handle as per your use case
  }

  // Check for division by zero
  if (totalItemsInt == 0) {
    return null; // or return an error message or handle as per your use case
  }

  double result = userCompletedItemsInt / totalItemsInt;
  return result;
}

String? generateVimeoIframe(String vimeoUrl) {
  final RegExp regex = RegExp(r'vimeo\.com/(\d+)');
  final Match? match = regex.firstMatch(vimeoUrl);

  if (match != null && match.groupCount >= 1) {
    final videoId = match.group(1);
    return '<iframe src="https://player.vimeo.com/video/$videoId" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>';
  } else {
    throw ArgumentError('Invalid Vimeo URL');
  }
}

String? getLivepeerPlayerUrl(String originalUrl) {
// Check if the originalUrl is not null (for null-safety)
  if (originalUrl.isEmpty) {
    return '';
  }

  // Define the regular expression pattern to extract the video ID
  RegExp pattern = RegExp(r'\/(\w+)\/index\.m3u8$');
  // Apply the pattern to the original URL
  Match? match = pattern.firstMatch(originalUrl);

  // If there's a match, group(1) will be the video ID
  if (match != null && match.groupCount >= 1) {
    // Ensure that the matched group is not null
    String? videoId = match.group(1);
    if (videoId != null) {
      // Construct the new URL with the extracted video ID
      return 'https://lvpr.tv/?v=$videoId';
    }
  }
  // If the pattern doesn't match or the video ID is null, return an empty string or handle as appropriate
  return '';
}

String? extractEmails(List<UserRecord> userDocs) {
  // Filter out null or empty email addresses and then extract them
  var emails = userDocs
      .where((doc) => doc.email?.isNotEmpty ?? false)
      .map((doc) => doc.email!)
      .toList();

  // Join all emails with a comma
  return emails.join(', ');
}

String imgPathToString(String imgPath) {
  // Convert imgPath argument from imagePath type to String type
  return imgPath.toString();
}

List<String> convertJsonToListString(String input) {
  // convert input json string to list of strings
  List<dynamic> jsonList = jsonDecode(input);
  List<String> stringList = jsonList.map((item) => item.toString()).toList();
  return stringList;
}

int returnCompletedContentNumber(
  List<int> contentList,
  List<int> userCompletedList,
) {
  // Return number of items that are both in userCompletedList and contentList
  int count = 0;
  for (int i = 0; i < contentList.length; i++) {
    if (userCompletedList.contains(contentList[i])) {
      count++;
    }
  }
  return count;
}

String checkLinkType(String link) {
  // Check if link is youtube link
  if (link.contains('youtube') || link.contains('youtu.be')) {
    return 'youtube';
  } else if (link.contains('vimeo')) {
    return 'vimeo';
  } else if (link.contains('searchie')) {
    return 'searchie';
  } else {
    return 'download';
  }
}

String? removeDashes(String? input) {
  // Check if input is null, return empty string if true, otherwise remove dashes
  return input?.replaceAll('-', '') ?? '';
}

List<DocumentReference> addTwoUserRefLists(
  List<DocumentReference> list1,
  List<DocumentReference> list2,
) {
  // Add list1 and list2 together
  return [...list1, ...list2];
}

String? stringToImgPath(String? imageUrl) {
  return imageUrl;
}

Color? getHexColorFromNotion(String? notionColor) {
  // Define a map of Notion color names to Tailwind CSS style hex codes
  const Map<String, String> notionToTailwindHexColors = {
    'default': '#6B7280', // Tailwind white
    'gray': '#6B7280', // Tailwind gray-500
    'brown': '#9D7350', // Tailwind amber-700
    'orange': '#F59E0B', // Tailwind yellow-500
    'yellow': '#FBBF24', // Tailwind yellow-400
    'green': '#10B981', // Tailwind green-500
    'blue': '#3B82F6', // Tailwind blue-500
    'purple': '#8B5CF6', // Tailwind purple-500
    'pink': '#EC4899', // Tailwind pink-500
    'red': '#EF4444', // Tailwind red-500
  };

  // Get the hex color code from the map
  String hexColor = notionToTailwindHexColors[notionColor] ??
      '#000000'; // Default to black if color not found

  // Convert hex color code to Color object
  return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
}

bool? shouldDisplayContent(
  String? publishDateString,
  String? expireDateString,
) {
  final DateTime now = DateTime.now();

  DateTime? publishDate;
  DateTime? endDate;

  // Parse publishDate in ISO 8601 format
  if (publishDateString != null) {
    try {
      publishDate = DateTime.parse(publishDateString);
    } catch (e) {
      // Handle parsing error if necessary
      print('Error parsing publishDate: $e');
    }
  }

  // Parse expireDate in ISO 8601 format or the custom format
  if (expireDateString != null) {
    try {
      endDate = DateTime.parse(expireDateString);
    } catch (e) {
      // If the first parse fails, try a different format
      try {
        endDate =
            DateFormat('EEE MMM dd yyyy HH:mm:ss').parse(expireDateString);
      } catch (e) {
        print('Error parsing expireDate: $e');
      }
    }
  }

  bool isPublishDateValid = publishDate == null ||
      now.isAfter(publishDate) ||
      now.isAtSameMomentAs(publishDate);
  bool isEndDateValid = endDate == null || now.isBefore(endDate);

  return isPublishDateValid && isEndDateValid;
}

List<String>? convertArrayToList(String? arrayList) {
  if (arrayList == null || arrayList.isEmpty) {
    return null;
  }

  // Regular expression to match strings inside quotes
  final regex = RegExp(r'"(.*?)"');

  // Find all matches in the input string
  final matches = regex.allMatches(arrayList);

  // Extract and return the list of strings
  return matches.map((match) => match.group(1) ?? '').toList();
}

String getYoutubeEmbedURL(String input) {
  final RegExp idExp = RegExp(r'(?<=v=|\/)([a-zA-Z0-9_-]{11})(?=\?|&|$)');
  final RegExp shortLinkExp = RegExp(r'youtu\.be\/([a-zA-Z0-9_-]{11})');

  String? videoId;

  if (idExp.hasMatch(input)) {
    videoId = idExp.firstMatch(input)?.group(0);
  } else if (shortLinkExp.hasMatch(input)) {
    videoId = shortLinkExp.firstMatch(input)?.group(1);
  } else {
    videoId = input; // Assuming input is directly the ID
  }

  return 'https://www.youtube.com/embed/$videoId';
}

DocumentType returnFileType(String url) {
  Uri uri = Uri.parse(url);
  String extension = uri.path.split('.').last.toLowerCase();

  if (extension == 'pdf' ||
      extension == 'doc' ||
      extension == 'docx' ||
      extension == 'xls' ||
      extension == 'xlsx' ||
      extension == 'ppt' ||
      extension == 'pptx' ||
      extension == 'txt') {
    return DocumentType.doc;
  } else if (extension == 'jpg' ||
      extension == 'jpeg' ||
      extension == 'png' ||
      extension == 'gif') {
    return DocumentType.media;
  } else if (uri.isAbsolute) {
    return DocumentType.link;
  } else {
    return DocumentType.doc; // Default to document for unknown types
  }
}

String convertToVideoPath(String text) {
  return text;
}

List<TribeContentRecord> filterContentIDs(
  List<int> completedIDs,
  List<TribeContentRecord> contentList,
) {
  List<TribeContentRecord> newList = [];

  for (TribeContentRecord content in contentList) {
    if (completedIDs.contains(content.tribeContentID)) {
      newList.add(content);
    }
  }
  return newList;
}

String? weekLabel(DateTime? dateStartTime) {
  if (dateStartTime == null) return null;

  // Calculate days to subtract to get to Sunday
  int daysToSubtract = dateStartTime.weekday % 7;
  DateTime sunday = dateStartTime.subtract(Duration(days: daysToSubtract));

  // List of month abbreviations
  List<String> monthAbbreviations = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Format the date
  String monthAbbr = monthAbbreviations[sunday.month];
  String formattedDate = '$monthAbbr ${sunday.day}';

  // Return the final string
  return 'Week of $formattedDate';
}

String returnFileName(String fileURL) {
  // Decode the URL to replace encoded characters
  String decodedURL = Uri.decodeComponent(fileURL);

  // Remove any query parameters starting with '?'
  final String cleanURL = decodedURL.split('?').first;

  // Split the URL by '/' and return the last part which is the file name
  final List<String> parts = cleanURL.split('/');
  return parts.last;
}

bool isUserOnline(DateTime? lastLoginTime) {
  return DateTime.now()
      .isBefore((lastLoginTime ?? DateTime(2000)).add(Duration(hours: 1)));
}

String checkAttachmentType(String url) {
  String extension =
      url.split('/').last.split('?').first.split('.').last.toLowerCase();

  // Define file types based on common extensions
  if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'tiff'].contains(extension)) {
    return 'image';
  } else if (['mp4', 'mov', 'avi', 'mkv', 'webm', 'flv'].contains(extension)) {
    return 'video';
  } else {
    return 'file';
  }
}

String extractAttachmentFileName(String url) {
  // Use the last occurrence of '/' to get the file name
  return url.split('/').last.split('?').first;
}

String relativeTime(DateTime time) {
  // Get the current time
  final now = DateTime.now();

  // Calculate the difference between the current time and the provided time
  final difference = now.difference(time);

  // If the difference is less than 1 minute, return "just now"
  if (difference.inMinutes < 1) {
    return 'just now';
  }
  // If the difference is less than 60 minutes, return the number of minutes ago
  else if (difference.inMinutes < 60) {
    return difference.inMinutes == 1
        ? '1 min ago'
        : '${difference.inMinutes} mins ago';
  }
  // If the difference is less than 24 hours, return the number of hours ago
  else if (difference.inHours < 24) {
    return difference.inHours == 1
        ? '1 hr ago'
        : '${difference.inHours} hrs ago';
  }
  // If the difference is more than 24 hours and less than 48 hours, return "Yesterday"
  else if (difference.inHours < 48 && difference.inDays == 1) {
    return 'Yesterday';
  }
  // If the difference is less than 7 days, return the day of the week (e.g., "Sunday")
  else if (difference.inDays < 7) {
    return DateFormat('EEEE').format(time); // Returns the day of the week
  }
  // If the difference is 7 days or more, return the exact date in "d MMM" format (e.g., "31 Dec")
  else {
    return DateFormat('d MMM').format(time); // e.g., "31 Dec"
  }
}

bool within1MinuteOfNext(
  MessagesRecord message,
  List<MessagesRecord> messagesList,
) {
  // Check if the 'messagesList' is null or empty
  if (messagesList == null || messagesList.isEmpty) {
    return false; // Show the timestamp if no messages
  }

  // Find the index of the current message
  final currentIndex = messagesList.indexOf(message);

  // If the current message is the last in the list, we show the timestamp
  if (currentIndex == messagesList.length - 1) {
    return false; // No next message, so show the timestamp
  }

  // Get the next message in the list
  final nextMessage = messagesList[currentIndex + 1];

  // Check if 'sentTime' exists in both the current and next message
  if (nextMessage.sentTime == null || message.sentTime == null) {
    return false; // Show the timestamp if there's no sent time data
  }

  // Calculate the time difference between the current message and the next message
  final difference = nextMessage.sentTime!.difference(message.sentTime!);

  // Return true if the difference is less than 1 minute (hide the timestamp), otherwise return false (show the timestamp)
  return difference.inMinutes < 1;
}

String appendNameAndUserId(
  String name,
  String userId,
) {
  return '?name=${Uri.encodeQueryComponent(name)}&userId=${Uri.encodeQueryComponent(userId)}';
}
