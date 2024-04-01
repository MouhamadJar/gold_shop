import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

class AppValidator {
  static AppValidator? _instance;

  AppValidator._();

  factory AppValidator() => _instance ??= AppValidator._();

  String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (value.length < 5) return AppWord.atLeast5Characters;
    return null;
  }
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isEmail) return AppWord.emailHasToBeLike;
    if (value.length < 10) return AppWord.invalidEmail;
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isPhoneNumber) return AppWord.only10Characters;
    if (value.length != 10) return AppWord.only10Characters;
    return null;
  }

  String? numberValidator(String? value,) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if (!value.isNum) return AppWord.notNumber;
    return null;
  }

  String? nameValidator(String? value, [int len = 6]) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if ((value.length < len)) return AppWord.atLeast6Characters;
    if ((value.isNum)) return AppWord.notNumbersOnly;
    return null;
  }

  String? passwordValidator(String? value, [int len = 9]) {
    if (value == null || value.isEmpty) return AppWord.empty;
    if ((value.length < len)) return AppWord.atLeast9Characters;

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
