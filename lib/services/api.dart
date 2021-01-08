import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:retry/retry.dart';

import '../config/global.dart' as CONFIG;

class API {

  SharedPreferences sharedPreferences;
  HttpRequestHandler httpRequestHandler = HttpRequestHandler();

  API() {
    init();
  }

  /// Current Language */

  String locale = CONFIG.COMMON.DEFAULT_LANGUAGE;

  void setLocale(String language) {
    locale = language;
  }

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future getLangs() async {
    final res = await httpRequestHandler.invokeAPI(
        httpMethod: HttpMethod.GET,
        path: 'langGenerator',
        method: '');
    //print("getLangs: $res");
    if (res.versioning != null) {
      //print( res.versioning.langGenerator);
      //locator<LocalStorage>().localLangsVersion = res.versioning.langGenerator;
    }


    return res;
  }

}

enum HttpMethod { GET, POST, PUT, DELETE }

class HttpRequestHandler {
  ValueChanged onError;

  set error(ValueChanged er) {
    onError = er;
  }

  /** Base URL of API */
  String apiPath;

  /** Current Language */
  String locale = CONFIG.COMMON.DEFAULT_LANGUAGE;

  /**
   * List of default headers
   */
  Map<String, String> _defaultHeaderMap = {};
  Map<UniqueKey, Future<Response>> requests = {};

  HttpRequestHandler({this.apiPath = CONFIG.COMMON.API_URL}) {
    setAuth();
  }

  /**
   * Sets language for API processing. API calss does not work if Language is not specified.
   */
  void setLocale(String language) {
    locale = language;
  }

  setAuth() async {
    var prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('AccessToken');
    if (accessToken != null) {
      _defaultHeaderMap['AuthToken'] = accessToken;
    }
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  String requestURI({String path, String method, String queryParams}) {
    return [CONFIG.COMMON.API_URL, locale, path, method, queryParams]
        .where((p) => (p != null && p != ''))
        .join('/');
  }

  Future<ApiResponse> invokeAPI(
      {HttpMethod httpMethod,
        path,
        method,
        body,
        queryParams,
        customUrl = ''}) async {
    String url;
    String contentType = 'application/json';
    Map<String, String> headerParams = {};
    String queryString;

    if (queryParams != null) {
      //queryString = Functions.convertQueryParams(queryParams);
    }


    if (customUrl != '') {
      url = customUrl;
    } else {
      url = requestURI(path: path, method: method, queryParams: queryString);
    }

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;
    Future<Response> request;
    print('invokeAPI $httpMethod $url');
    try {
      final res = await retry(
            () {
          switch (httpMethod) {
            case HttpMethod.POST:
              request = http.post(url, headers: headerParams, body: body);
              break;
            case HttpMethod.PUT:
              request = http.put(url, headers: headerParams, body: body);
              break;
            case HttpMethod.DELETE:
              request = http.delete(url, headers: headerParams);
              break;
            default:
              request = http.get(url, headers: headerParams);
          }
          return request;
        },
        retryIf: (e) {
          // print('retryIf  $e');
          return e is SocketException && onError != null;
        },
        onRetry: (e) {
          this.onError?.call(e);
          print('onRetry  $url');
        },
      );

      print(res.statusCode);
      if (res.statusCode != 200) print(res.body);
      final apiRes = ApiResponse(response: res);

      if (apiRes.versioning != null) {
        //locator<LocalStorage>().remoteApiVersion = apiRes.versioning.appDataGenerator;
        //locator<LocalStorage>().remoteLangsVersion = apiRes.versioning.langGenerator;
      }
      onError?.call(null);
      return apiRes;
    } catch (e) {
      print('invokeAPI $e');
      if (e is ApiException) throw e;
      throw ApiException('$e Request URL : $url',
          stackTrace: StackTrace.current);
    }
  }
}

class ApiException {
  int statusCode;
  String message;
  String title;
  final exception;
  final UniqueKey requestId;
  bool fixed;
  StackTrace stackTrace;

  ApiException(this.exception,
      {this.requestId, this.fixed, this.statusCode, this.stackTrace}) {
    message = '$exception' ?? 'Message';
    if (stackTrace == null) stackTrace = StackTrace.current;
  }

  @override
  String toString() {
    return 'ApiException { statusCode: $statusCode, message: $message, title: $title, stackTrace: $stackTrace }';
  }
}


class ApiVersioning {
  ApiVersioning({
    this.appDataGenerator = '1.0.0',
    this.langGenerator = '1.0.0',
    this.androidVersion = '1.0.0',
    this.iosVersion = '1.0.0',
  });

  String appDataGenerator;
  String langGenerator;
  final String androidVersion;
  final String iosVersion;

  factory ApiVersioning.fromJson(Map<String, dynamic> json) => json == null
      ? ApiVersioning()
      : ApiVersioning(
    appDataGenerator: json['endPoints']['appDataGenerator'],
    langGenerator: json['endPoints']['langGenerator'],
    androidVersion: json['androidVersion'],
    iosVersion: json['iosVersion'],
  );

  Map<String, dynamic> toJson() => {
    'appDataGenerator': appDataGenerator,
    'langGenerator': langGenerator,
    'androidVersion': androidVersion,
    'iosVersion': iosVersion,
  };
}

class ApiResponse {
  http.Response response;
  var body;
  ApiVersioning versioning;
  bool strictMode;
  String statusMessage;
  int statusCode;
  int networkStatusCode;
  bool requestSuccessful = false;

  // Map<String, dynamic> data;
  var data;

  ApiResponse(
      {this.response,
        this.body,
        this.strictMode = CONFIG.COMMON.REQUEST_STRICT_MODE}) {
//    print(jsonDecode(response.body));
    if (body == null) {
      body = json.decode(this.response.body);
      if (body['versioning'] != null && ['endPoints'] != null)
        versioning = ApiVersioning.fromJson(body['versioning']);
    }
    _parseResponse();
  }

  void _setResponseData() {
    if (!ok) return;
    data = body['data'];
  }

  void _setRequestStatus() {
    statusCode = body['statusCode'] ?? 1;
    networkStatusCode = response.statusCode;
    statusMessage = body['statusMessage'] ?? 'Success';
    requestSuccessful = networkStatusCode == 200;
  }

  void _handleStatus() {
    if (!strictMode || ok) return;
    throw ApiException(
      Exception(
        'Request Error. Request Status : $statusMessage\n'
            'Request URL : ${response.request.url}',
      ),
      statusCode: networkStatusCode,
    );
  }

  void _handleUpdateToken() async {
    if (body['updateToken'] != null) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('AccessToken', body['updateToken']);
      prefs.setString('AuthToken', body['updateToken']);
    }
  }

  void _parseResponse() {
    _setRequestStatus();
    _setResponseData();
    _handleStatus();
    _handleUpdateToken();
  }

  bool get ok => requestSuccessful;

  bool get err => !requestSuccessful;

  @override
  String toString() {
    return 'ApiResponse{response: $response, body: $body, strictMode: $strictMode, statusMessage: $statusMessage, statusCode: $statusCode, networkStatusCode: $networkStatusCode, requestSuccessful: $requestSuccessful, data: $data}';
  }
}