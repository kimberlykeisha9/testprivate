import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Mux Group Code

class MuxGroup {
  static String getBaseUrl({
    String? muxToken = '==',
  }) =>
      'https://api.mux.com/video/v1/';
  static Map<String, String> headers = {};
  static GetLiveStreamIdCall getLiveStreamIdCall = GetLiveStreamIdCall();
  static GetPastLiveStreamCall getPastLiveStreamCall = GetPastLiveStreamCall();
}

class GetLiveStreamIdCall {
  Future<ApiCallResponse> call({
    String? playbackId = '',
    String? muxToken = '==',
  }) async {
    final baseUrl = MuxGroup.getBaseUrl(
      muxToken: muxToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getLiveStreamId',
      apiUrl: '${baseUrl}playback-ids/${playbackId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic ${muxToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic streamID(dynamic response) => getJsonField(
        response,
        r'''$.data.object.id''',
      );
}

class GetPastLiveStreamCall {
  Future<ApiCallResponse> call({
    String? streamId = '',
    String? muxToken = '==',
  }) async {
    final baseUrl = MuxGroup.getBaseUrl(
      muxToken: muxToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getPastLiveStream ',
      apiUrl: '${baseUrl}assets?live_stream_id=${streamId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic ${muxToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic playbackID(dynamic response) => getJsonField(
        response,
        r'''$.data[0].playback_ids[0].id''',
      );
}

/// End Mux Group Code

/// Start Mux with Dynamic Token Group Code

class MuxWithDynamicTokenGroup {
  static String getBaseUrl({
    String? muxBase64 =
        'ZmUwNzZiZWYtYjY0Ny00MjRmLWIzNjgtZDEzNTZhNzU3ODA1Omt0TVA3ZSt1YURsQS9CZGNLOG1iVlJRN1VsNzRscGM3ZXhrWHZhK3k1TG1ldDRaT2dqakxQMmtSaFJFUFdYditpcHRxS2JmNGxtaw',
  }) =>
      'https://api.mux.com/video/v1/';
  static Map<String, String> headers = {
    'Authorization': 'Basic [MuxBase64]',
  };
  static GetLiveStreamIdTribeCall getLiveStreamIdTribeCall =
      GetLiveStreamIdTribeCall();
  static GetPastLiveStreamTribeCall getPastLiveStreamTribeCall =
      GetPastLiveStreamTribeCall();
}

class GetLiveStreamIdTribeCall {
  Future<ApiCallResponse> call({
    String? playbackId = '',
    String? muxBase64 =
        'ZmUwNzZiZWYtYjY0Ny00MjRmLWIzNjgtZDEzNTZhNzU3ODA1Omt0TVA3ZSt1YURsQS9CZGNLOG1iVlJRN1VsNzRscGM3ZXhrWHZhK3k1TG1ldDRaT2dqakxQMmtSaFJFUFdYditpcHRxS2JmNGxtaw',
  }) async {
    final baseUrl = MuxWithDynamicTokenGroup.getBaseUrl(
      muxBase64: muxBase64,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getLiveStreamIdTribe',
      apiUrl: '${baseUrl}playback-ids/${playbackId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic ${muxBase64}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? streamID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.object.id''',
      ));
}

class GetPastLiveStreamTribeCall {
  Future<ApiCallResponse> call({
    String? streamId = '',
    String? muxBase64 =
        'ZmUwNzZiZWYtYjY0Ny00MjRmLWIzNjgtZDEzNTZhNzU3ODA1Omt0TVA3ZSt1YURsQS9CZGNLOG1iVlJRN1VsNzRscGM3ZXhrWHZhK3k1TG1ldDRaT2dqakxQMmtSaFJFUFdYditpcHRxS2JmNGxtaw',
  }) async {
    final baseUrl = MuxWithDynamicTokenGroup.getBaseUrl(
      muxBase64: muxBase64,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getPastLiveStreamTribe',
      apiUrl: '${baseUrl}assets?live_stream_id=${streamId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic ${muxBase64}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? playbackID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[0].playback_ids[0].id''',
      ));
}

/// End Mux with Dynamic Token Group Code

/// Start Notion Group Code

class NotionGroup {
  static String getBaseUrl() => 'https://notion-api-proxy.inovo.workers.dev';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static GetDocumentCall getDocumentCall = GetDocumentCall();
  static GetTaskDatabaseCall getTaskDatabaseCall = GetTaskDatabaseCall();
  static GetTaskDatabaseSchemaCall getTaskDatabaseSchemaCall =
      GetTaskDatabaseSchemaCall();
}

class GetDocumentCall {
  Future<ApiCallResponse> call({
    String? page = '069133a539fe40a581bd383e5e72f8f7',
  }) async {
    final baseUrl = NotionGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Document',
      apiUrl: '${baseUrl}/v1/pages/${page}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTaskDatabaseCall {
  Future<ApiCallResponse> call({
    String? notionClientId = 'fc5b8c4ad81d48d7965b4cc442b91d63',
  }) async {
    final baseUrl = NotionGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "filter": {
    "and": [
      {
        "property": "Client",
        "relation": {
          "contains": "${notionClientId}"
        }
      },
      {
        "and": [
          {
            "property": "CS Status",
            "status": {
              "does_not_equal": "Discard"
            }
          },
          {
            "property": "CS Status",
            "status": {
              "does_not_equal": "Done"
            }
          }
        ]
      }
    ]
  },
  "sorts": [
    {
      "property": "CS Status",
      "direction": "ascending"
    }
  ],
  "page_size": 50
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Task Database',
      apiUrl: '${baseUrl}/v1/databases/86217ff48bd445549a11c1628157c3b6/query',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? taskType(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].properties.Type.select.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? taskName(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].properties['Task name'].title[:].plain_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? taskStatus(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].properties.Status.status.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? taskPriority(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].properties.Priority.select.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? taskAssigned(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].properties.Assign.people[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
  List<String>? taskLastEditedTime(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].last_edited_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetTaskDatabaseSchemaCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = NotionGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Task Database Schema',
      apiUrl: '${baseUrl}/v1/databases/86217ff48bd445549a11c1628157c3b6',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Notion Group Code

class SignInCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? baseURL = '',
    int? platformId,
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "password": "${password}",
"PlatformId": "${platformId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SignIn',
      apiUrl: '${baseURL}/auth/signin',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic platformID(dynamic response) => getJsonField(
        response,
        r'''$.PlatformId''',
      );
  static dynamic firebaseUID(dynamic response) => getJsonField(
        response,
        r'''$.firebase_uid''',
      );
  static dynamic customJWT(dynamic response) => getJsonField(
        response,
        r'''$.customJWT''',
      );
  static dynamic photo(dynamic response) => getJsonField(
        response,
        r'''$.photoUrl''',
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  static dynamic email(dynamic response) => getJsonField(
        response,
        r'''$.email''',
      );
  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.name''',
      );
  static dynamic userID(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
  static dynamic userToken(dynamic response) => getJsonField(
        response,
        r'''$.token''',
      );
  static dynamic userRole(dynamic response) => getJsonField(
        response,
        r'''$.role''',
      );
}

class RemoveUserFromGroupCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    int? groupID,
    String? token = '',
    String? userEmail = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${userEmail}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Remove User from Group',
      apiUrl: '${baseURL}/api/group/${groupID}/remove-user',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ForgotPasswordCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? baseURL = '',
    int? platformId,
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "windowLocation": "${baseURL}/",
  "PlatformId": ${platformId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'forgotPassword',
      apiUrl: '${baseURL}/auth/forgot-password',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpsertContentKarolCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? title = '',
    String? description = '',
    int? groupID,
    int? userID,
    int? platformID,
    String? baseURL = '',
    String? type = '',
    bool? chatEnabled = true,
    String? featuredVideo = '',
    String? featuredImage = '',
    String? publishedDate = '',
    String? contentUrl = '',
    int? postID,
  }) async {
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "id": ${postID},
  "description": "${description}",
  "type": "${type}",
  "visibility": "public",
  "GroupIds": [
    ${groupID}
  ],
  "chatEnabled": ${chatEnabled},
  "UserId": ${userID},
  "PlatformId": ${platformID},
  "contentURI": "${contentUrl}",
  "video": "${featuredVideo}",
  "featuredImage": "${featuredImage}",
  "featuredVideo": "${featuredVideo}",
  "publishedDate": "${publishedDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Upsert Content Karol',
      apiUrl: '${baseURL}/api/content',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
      );
}

class GetPlatformCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getPlatform',
      apiUrl: '${baseURL}/api/platform-by-id/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetGroupsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
    int? platformId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroups',
      apiUrl: '${baseURL}/api/group/platform/${platformId}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? slug(dynamic response) => (getJsonField(
        response,
        r'''$[:].slug''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? coverImg(dynamic response) => (getJsonField(
        response,
        r'''$[:].coverImg''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? purchaseLink(dynamic response) => getJsonField(
        response,
        r'''$[:].purchaseLink''',
        true,
      ) as List?;
  static List? nonMemberGroups(dynamic response) => getJsonField(
        response,
        r'''$[?(@.isMember==false)]''',
        true,
      ) as List?;
  static List? description(dynamic response) => getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?;
  static List? visibility(dynamic response) => getJsonField(
        response,
        r'''$[:].visibility''',
        true,
      ) as List?;
  static List? isMember(dynamic response) => getJsonField(
        response,
        r'''$[:].isMember''',
        true,
      ) as List?;
}

class GetMyGroupsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getMyGroups',
      apiUrl: '${baseURL}/api/my-groups',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?;
  static List? name(dynamic response) => getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?;
  static List? slug(dynamic response) => getJsonField(
        response,
        r'''$[:].slug''',
        true,
      ) as List?;
  static List? coverImg(dynamic response) => getJsonField(
        response,
        r'''$[:].coverImg''',
        true,
      ) as List?;
  static List? purchaseLink(dynamic response) => getJsonField(
        response,
        r'''$[:].purchaseLink''',
        true,
      ) as List?;
  static List? users(dynamic response) => getJsonField(
        response,
        r'''$[:].Users''',
        true,
      ) as List?;
  static List? groups(dynamic response) => getJsonField(
        response,
        r'''$.*''',
        true,
      ) as List?;
}

class GetGroupInfoCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? slug = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroupInfo',
      apiUrl: '${baseURL}/api/group/${slug}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
        'slug': '${slug}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetGroupContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? slug = '',
    String? baseURL = '',
    int? currentPage,
    int? itemsPerPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroupContent',
      apiUrl: '${baseURL}/api/group/${slug}/contents',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {
        'currentPage': currentPage,
        'itemsPerPage': itemsPerPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? itemsTitle(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? itemsID(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? itemsDescription(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? itemsDescriptionPlain(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].descriptionPlain''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static dynamic itemsDescriptionHTML(dynamic response) => getJsonField(
        response,
        r'''$.items[:].descriptionHTML''',
      );
  static bool? moreItems(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.hasMore''',
      ));
}

class GetGroupAnnouncementsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? slug = '',
    String? baseURL = '',
    int? currentPage,
    int? itemsPerPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroupAnnouncements',
      apiUrl: '${baseURL}/api/group/${slug}/announcements',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {
        'currentPage': currentPage,
        'itemsPerPage': itemsPerPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? itemsID(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? itemsTitle(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? itemsDescription(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? itemsDescriptionPlain(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].descriptionPlain''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static dynamic itemsDescriptionHTML(dynamic response) => getJsonField(
        response,
        r'''$.items[:].descriptionHTML''',
      );
}

class GetGroupCollectionsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? slug = '',
    String? baseURL = '',
    int? itemsPerPage,
    int? currentPage,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroupCollections',
      apiUrl: '${baseURL}/api/group/${slug}/collections',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {
        'itemsPerPage': itemsPerPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? items(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
  static dynamic totalContentCount(dynamic response) => getJsonField(
        response,
        r'''$.totalContentCount''',
      );
  static dynamic totalCompletedCount(dynamic response) => getJsonField(
        response,
        r'''$.totalCompletedCount''',
      );
  static dynamic totalItems(dynamic response) => getJsonField(
        response,
        r'''$.totalItems''',
      );
  static List? collectionName(dynamic response) => getJsonField(
        response,
        r'''$.items[:].name''',
        true,
      ) as List?;
  static List? contentTitle(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].title''',
        true,
      ) as List?;
  static List? contentId(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].id''',
        true,
      ) as List?;
  static List? contentFeaturedImg(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].featuredImage''',
        true,
      ) as List?;
  static List? contentPublishedDate(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].publishedDate''',
        true,
      ) as List?;
  static List? contentChatEnabled(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].chatEnabled''',
        true,
      ) as List?;
  static List? contentType(dynamic response) => getJsonField(
        response,
        r'''$.items[:].Contents[:].type''',
        true,
      ) as List?;
}

class GetContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getContent',
      apiUrl: '${baseURL}/api/content',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCollectionsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getCollections',
      apiUrl: '${baseURL}/api/collection',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetContentByIDCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getContentByID',
      apiUrl: '${baseURL}/api/content/${id}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? post(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.title''',
      ));
  static String? slug(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.slug''',
      ));
  static String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.featuredImage''',
      ));
  static String? type(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.type''',
      ));
  static int? likeCount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.likeCount''',
      ));
  static int? commentCount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.commentCount''',
      ));
  static bool? hasLiked(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.currentUserHasLiked''',
      ));
  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.User.id''',
      ));
  static String? userName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.User.name''',
      ));
  static String? descriptionPlain(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.descriptionPlain''',
      ));
  static String? descriptionHtml(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.descriptionHtml''',
      ));
  static bool? chatEnabled(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.chatEnabled''',
      ));
  static String? video(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.video''',
      ));
  static dynamic? userPic(dynamic response) => getJsonField(
        response,
        r'''$.User.photoUrl''',
      );
  static String? contentURI(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.contentURI''',
      ));
  static String? featuredImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.featuredImage''',
      ));
}

class DeleteContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteContent',
      apiUrl: '${baseURL}/api/content/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetChatByIDCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getChatByID',
      apiUrl: '${baseURL}/api/chat/${id}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? chatId(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?;
}

class CreateChatCall {
  static Future<ApiCallResponse> call({
    String? message = '',
    int? contentId,
    String? userId = '',
    String? token = '',
    String? baseURL = '',
    int? parentCommentId,
  }) async {
    final ffApiRequestBody = '''
{
  "message": "${message}",
  "ContentId": ${contentId},
  "UserId": "${userId}",
  "parentCommentId": ${parentCommentId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createChat',
      apiUrl: '${baseURL}/api/chat',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LikePostCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
    String? baseURL = '',
  }) async {
    final ffApiRequestBody = '''
''';
    return ApiManager.instance.makeApiCall(
      callName: 'likePost',
      apiUrl: '${baseURL}/api/content/${id}/like',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SignupCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? name = '',
    String? baseURL = '',
    int? platformId,
    String? firebaseUid = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "password": "${password}",
  "role": "free",
  "name": "${name}",
  "PlatformId": ${platformId},
  "firebase_uid": "${firebaseUid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Signup',
      apiUrl: '${baseURL}/api/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic userToken(dynamic response) => getJsonField(
        response,
        r'''$.token''',
      );
  static dynamic platformId(dynamic response) => getJsonField(
        response,
        r'''$.PlatformId''',
      );
  static dynamic userRole(dynamic response) => getJsonField(
        response,
        r'''$.role''',
      );
}

class CreateTextPostCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? description = '',
    int? groupId,
    int? userID,
    int? platformID,
    String? baseURL = '',
    String? publishedDate = '',
  }) async {
    final ffApiRequestBody = '''
{
  "description": "${description}",
  "type": "article",
  "visibility": "public",
  "GroupIds": [
    ${groupId}
  ],
  "chatEnabled": true,
  "UserId": ${userID},
  "PlatformId": ${platformID},
  "publishedDate": "${publishedDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createTextPost',
      apiUrl: '${baseURL}/api/content/',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCollectionInfoCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? slug = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCollectionInfo',
      apiUrl: '${baseURL}/api/collection/36',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
        'slug': '${slug}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTopicByidCall {
  static Future<ApiCallResponse> call({
    int? topicId,
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetTopicByid',
      apiUrl: '${baseURL}/api/topic/${topicId}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCollectionByIDCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCollectionByID',
      apiUrl: '${baseURL}/api/collection-by-id/${id}',
      callType: ApiCallType.GET,
      headers: {
        'id': '${id}',
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? collectionContents(dynamic response) => getJsonField(
        response,
        r'''$.Contents''',
        true,
      ) as List?;
  static String? collectionName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  static String? collectionSlug(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.slug''',
      ));
  static List<String>? contentType(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? contentURI(dynamic response) => getJsonField(
        response,
        r'''$.Contents[:].contentURI''',
        true,
      ) as List?;
  static List<String>? contentVideo(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].video''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? contentChatEnabled(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].chatEnabled''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<String>? contentVisibility(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].visibility''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? contentPublishedDate(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].publishedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? contentFeaturedImage(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].featuredImage''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? contentDescription(dynamic response) => getJsonField(
        response,
        r'''$.Contents[:].description''',
        true,
      ) as List?;
  static List<String>? contentTitle(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? contentDescriptionPlain(dynamic response) =>
      (getJsonField(
        response,
        r'''$.Contents[:].descriptionPlain''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? contentId(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? contentSlug(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].slug''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? contentUserId(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].UserId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? contentCommentCount(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].commentCount''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? contentLikeCount(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].likeCount''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? contentUserName(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].User.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? contentUserPhoto(dynamic response) => (getJsonField(
        response,
        r'''$.Contents[:].User.photoUrl''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? contentDescriptionHtml(dynamic response) =>
      (getJsonField(
        response,
        r'''$.Contents[:].descriptionHtml''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? collectionDescriptionHtml(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.descriptionHtml''',
      ));
  static String? collectionDescriptionPlain(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.descriptionPlain''',
      ));
}

class SearchContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? q = '',
    String? baseURL = '',
    int? platformID,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'searchContent',
      apiUrl: '${baseURL}/api/content/search/${platformID}',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {
        'q': q,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? items(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.items[:].id''',
      ));
  static String? featuredImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.items[:].featuredImage''',
      ));
  static String? author(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].User.name''',
      ));
}

class ValidateUserCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? baseURL = '',
    String? platformId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ValidateUser',
      apiUrl: '${baseURL}/auth/user-validation',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'email': email,
        'PlatformId': platformId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? isPasswordSet(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.isPasswordSet''',
      ));
  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
}

class ResetPasswordCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? baseURL = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": ${userId},
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'resetPassword',
      apiUrl: '${baseURL}/auth/set-password',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ViewPostCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    int? contentID,
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "ContentId": ${contentID}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'viewPost',
      apiUrl: '${baseURL}/api/view-data',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CompleteGroupContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
    int? postId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'completeGroupContent',
      apiUrl: '${baseURL}/api/content/${postId}/complete',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserImageCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? token = '',
    String? baseURL = '',
    String? photoUrl = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id": ${userId},
  "photoUrl": "${photoUrl}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUserImage',
      apiUrl: '${baseURL}/api/user',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteUserCall {
  static Future<ApiCallResponse> call({
    String? baseURL = '',
    int? userId,
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete User',
      apiUrl: '${baseURL}/api/user/${userId}',
      callType: ApiCallType.DELETE,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TestNetworkCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'testNetwork',
      apiUrl: 'https://api.ipify.org/?format=json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SetPasswordCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? baseURL = '',
    String? password = '',
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": ${userId},
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'setPassword',
      apiUrl: '${baseURL}/auth/set-password',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpsertNewContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? title = '',
    String? description = '',
    int? groupId,
    int? userID,
    int? platformID,
    String? baseURL = '',
    String? type = '',
    bool? chatEnabled = true,
    String? video = '',
    String? publishedDate = '',
    String? contentURI = '',
    String? featuredImage = '',
  }) async {
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "description": "${description}",
  "type": "${type}",
  "visibility": "public",
  "GroupIds": [${groupId}],
  "chatEnabled": true,
  "UserId": ${userID},
  "PlatformId": ${platformID},
  "contentURI": "${contentURI}",
  "video": "${video}",
  "publishedDate": "${publishedDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Upsert New Content',
      apiUrl: '${baseURL}/api/content',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
      );
}

class UpsertExistingContentCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? title = '',
    String? description = '',
    int? groupId,
    int? userID,
    int? platformID,
    String? baseURL = '',
    String? type = '',
    bool? chatEnabled = true,
    String? video = '',
    String? publishedDate = '',
    String? contentURI = '',
    String? featuredImage = '',
    int? postID,
  }) async {
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "id": ${postID},
  "description": "${description}",
  "type": "${type}",
  "visibility": "public",
  "GroupIds": [${groupId}],
  "chatEnabled": true,
  "UserId": ${userID},
  "PlatformId": ${platformID},
  "contentURI": "${contentURI}",
  "video": "${video}",
"featuredImage": "${featuredImage}",
  "publishedDate": "${publishedDate}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Upsert Existing Content',
      apiUrl: '${baseURL}/api/content',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetStatusCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? baseURL = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetStatus',
      apiUrl: '${baseURL}/auth/status',
      callType: ApiCallType.GET,
      headers: {
        'token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic tribeFirebaseUID(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.firebase_uid''',
      );
  static dynamic platformId(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.PlatformId''',
      );
  static dynamic uid(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.id''',
      );
  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.name''',
      );
  static dynamic email(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.email''',
      );
  static dynamic token(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.token''',
      );
  static dynamic role(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.role''',
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.currentUser.status''',
      );
}

class UpdateUserCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? token = '',
    String? baseURL = '',
    int? groupIds,
    String? firebaseUid = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id": ${userId},
  "firebase_uid": "${firebaseUid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUser',
      apiUrl: '${baseURL}/api/user',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PushNotificationsCall {
  static Future<ApiCallResponse> call({
    String? baseUrl = '',
    String? title = '',
    String? message = '',
    int? groupId,
    int? platformId,
    String? token = '',
    String? broadcastRef = '',
    String? groupDoc = '',
  }) async {
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "message": "${message}",
  "destinationPage": "discussionPostRedirect",
  "parameterData": "{\\"broadcastRef\\": \\"/broadcasts/${broadcastRef}\\"}",
  "GroupId": ${groupId},
  "PlatformId": ${platformId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PushNotifications',
      apiUrl: '${baseUrl}/api/push-notifications',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ZapierRegistrationCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? fullName = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "fullName": "${fullName}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ZapierRegistration',
      apiUrl: 'https://hooks.zapier.com/hooks/catch/14123329/3kuohbz/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ZapierUpdateUserGroupsCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? token = '',
    String? baseURL = '',
    int? groupIds,
    String? firebaseUid = '',
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "GroupIds": [
    ${groupIds}
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ZapierUpdateUserGroups',
      apiUrl: '${baseURL}/api/zapier/user',
      callType: ApiCallType.POST,
      headers: {
        'token': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
