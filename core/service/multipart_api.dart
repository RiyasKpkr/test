import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../shared/dialog/app_snackbar.dart';
import '../config.dart';
import '../screen_utils.dart';
import 'api.dart';
import 'api_response.dart';
import 'urls.dart';

class MultipartApi {
  static Future<ApiResponse> call({
    required String endPoint,
    required List<String?> filePaths,
    String? textValue,
    //  Map<String, String>? body,
    Method method = Method.post,
    bool isShowMessage = false,
  }) async {
    try {
      showLoader();

      var request = http.MultipartRequest(
          method == Method.post ? 'POST' : 'PATCH',
          Uri.parse('$baseUrl/$endPoint'));
      request.headers['Authorization'] = "Bearer $userToken";

      for (var path in filePaths) {
        if (path != null) {
          var file = await http.MultipartFile.fromPath("files", path);
          request.files.add(file);
        }
      }
      if (textValue != null) {
        request.fields['previousFiles'] = textValue;
      }

      debugPrint(jsonEncode(request.fields));

      var response = await request.send();
      var responseDecoded = await http.Response.fromStream(response);

      Screen.closeDialog();

      return ApiResponse.fromJson(
          '$baseUrl/$endPoint', method, responseDecoded.body, responseDecoded);
    } on SocketException {
      Screen.closeDialog();
      Get.snackbar("Error", "Network seems to be offline");
      return ApiResponse(
          success: false, message: "Network seems to be offline", data: null);
    } catch (e) {
      // Screen.closeDialog();
      // Get.snackbar("Error", e.toString());
      showToast("The selected file is too large, can not be uploaded.");
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
