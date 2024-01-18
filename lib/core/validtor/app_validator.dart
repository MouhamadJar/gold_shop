import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

class AppValidator {
  static AppValidator? _instance;

  AppValidator._();

  factory AppValidator() => _instance ??= AppValidator._();

  String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (value.length < 4) return AppWord.invalidUserName;
    return null;
  }
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isEmail) return AppWord.invalidEmail;
    if (value.length < 4) return AppWord.invalidUserName;
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isPhoneNumber) return AppWord.invalidPhoneNumber;
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isNum) return AppWord.notNumber;
    return null;
  }

  String? nameValidator(String? value, [int len = 6]) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if ((value.length < len)) return AppWord.invalidLength;
    return null;
  }

  String? passwordValidator(String? value, [int len = 8]) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if ((value.length < len)) return AppWord.invalidLength;

    return null;
  }

  String? otpValidator(String? value, [int len = 6]) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if ((value.length < len)) return AppWord.invalidLength;
    return null;
  }

  String? matchPassword(String? value1, String value2) => value1 == value2
      ? value1!.isEmpty
          ? AppWord.empty
          : null
      : AppWord.passwordIsNotMatch;
}
