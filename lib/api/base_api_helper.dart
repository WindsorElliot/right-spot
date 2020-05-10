import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:right_spot/api/app_exception.dart';

class BaseApiHelper {
  final String _baseUrl = "localhost:8888";

  Future<dynamic> get({ String target, Map<String, String> header, Map<String, String> params }) async {
    var responseJson;
    try {
      final Uri request = Uri.http(_baseUrl, target, params);
      final response = await http.get(request, headers: header);
      responseJson = this._returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJSon = json.decode(response.body);
        return responseJSon;
        break;

      case 400:
        throw BadRequestException(response.body);
        break;

      case 401:
      case 403:
        throw UnauthorisedException(response.body);
        break;
        
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  static Map<String, String> params({ 
    bool includeUser = false, 
    bool includeSpot = false,
    bool includeGeoloc = false,
    bool includeComments = false,
    bool includeImage = false,
    bool includeCarpooling = false,
    bool includeTraveler = false
  }) {
    return {
      "includeUser": (includeUser) ? "1" : "0",
      "includeSpot": (includeSpot) ? "1" : "0",
      "includeGeoloc": (includeGeoloc) ? "1" : "0",
      "includeComments": (includeComments) ? "1" : "0",
      "includeImage": (includeImage) ? "1" : "0",
      "includeCarpooling": (includeCarpooling) ? "1" : "0",
      "includeTraveler": (includeTraveler) ? "1" : "0"
    };
  }

  static Map<String, String> headers({ @required String token }) {
    return {
      "Authorization": "Bearer $token",
      "Content-Type": "Application/json"
    };
  }
}