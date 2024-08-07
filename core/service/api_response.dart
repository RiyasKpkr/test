import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class ApiResponse<T> {
  bool success;
  String message;
  dynamic data;

  ApiResponse(
      {required this.success, required this.message, required this.data});

  factory ApiResponse.fromJson(
      url, Method method, Object? body, http.Response? response,
      {String? fetchKeyName = "data"}) {
    debugPrint("$url ($method)");

    if (body != null) debugPrint(jsonEncode(body));

    if (response == null) {
      return ApiResponse(success: false, message: "", data: null);
    }

    var message = "";
    dynamic data;

    try {
      final isSuccess =
          response.statusCode == 200 || response.statusCode == 201;
      message = response.body;

      final map = json.decode(response.body);

      debugPrint("${response.statusCode} : $map");

      if (map['status'] == false || !isSuccess) {
        message = map["message"];
        throw message;
      }

      data = map[fetchKeyName] ?? map;

      return ApiResponse(
        data: data,
        success: isSuccess,
        message: message,
      );
    } catch (e) {
      throw message;
    }
  }
}
