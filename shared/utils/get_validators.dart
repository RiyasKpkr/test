import 'package:get/get.dart';

validateRequired(String labelText, String? value) =>
    GetUtils.isNullOrBlank(value) == true ? "$labelText is required" : null;

validateEmail(String? email) => GetUtils.isEmail(email??"") ? null : "Email is not valid";
