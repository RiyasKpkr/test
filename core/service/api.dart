import 'dart:convert';
import 'dart:io';

import 'package:cpsales/core/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/dialog/app_snackbar.dart';
import '../screen_utils.dart';
import '../shared_pref.dart';
import 'api_response.dart';
import 'urls.dart';

enum Method { get, post, put, patch, delete }

class Api {
  static Future<ApiResponse> call(
      {required String endPoint,
      Method method = Method.get,
      Object? body,
      bool isShowLoader = false}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $userToken",
        "platform": "app"
      };

      if (isShowLoader) {
        isShowingLoader = true;
        showLoader();
      }

      final http.Response response;
      Uri url = Uri.parse("$baseUrl/$endPoint");
      debugPrint('$headers');

      //REST API METHOD
      switch (method) {
        case Method.get:
          response = await http.get(url, headers: headers);
          break;
        case Method.post:
          response =
              await http.post(url, body: json.encode(body), headers: headers);
          break;

        case Method.patch:
          response =
              await http.patch(url, body: json.encode(body), headers: headers);
          break;
        case Method.put:
          response =
              await http.put(url, body: json.encode(body), headers: headers);
          break;

        case Method.delete:
          response = await http.delete(url,
              body: body != null ? json.encode(body) : null, headers: headers);
          break;

        default:
          throw ("Invalid request type");
      }

      if (isShowLoader) hideLoader();
      if (response.statusCode == 401 && userToken != null) {
        SharedPref().logout();
        return ApiResponse(success: false, message: "", data: null);
      }

      return ApiResponse.fromJson(url, method, body, response);
    } on SocketException {
      if (isShowLoader) hideLoader();
      showToast("Network seems to be offline");

      return ApiResponse(
          success: false, message: "Network seems to be offline", data: null);
    } catch (e) {
      debugPrint(e.toString());

      if (isShowLoader) hideLoader();
      showToast(e.toString());

      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
