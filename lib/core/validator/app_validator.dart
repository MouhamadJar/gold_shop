import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../components/components.dart';

class AppValidator {
  static AppValidator? _instance;

  AppValidator._();

  factory AppValidator() => _instance ??= AppValidator._();

  dynamic userNameValidator(String? value,BuildContext context) {
    if (value == null || value.isEmpty) {
      ControllerSnackBar(errorMessage: AppWord.emptyUserName,);
      return AppWord.emptyUserName;
    }
    if (value.length < 5) {
      ControllerSnackBar(errorMessage: AppWord.userNameMustBeAtLeast5,);
      return AppWord.userNameMustBeAtLeast5;
    }
    return null;
  }
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      ControllerSnackBar(errorMessage: AppWord.emptyEmail,);
      return AppWord.emptyEmail;
    }
    if (!value.isEmail) {
      ControllerSnackBar(errorMessage: AppWord.emailHasToBeLike,);
      return AppWord.emailHasToBeLike;
    }
    if (value.length < 10) {
      ControllerSnackBar(errorMessage: AppWord.emailShouldBeAtLeast10,);
      return AppWord.emailShouldBeAtLeast10;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      ControllerSnackBar(errorMessage: AppWord.emptyPhone,);
      return AppWord.emptyPhone;
    }
    if (!value.isPhoneNumber) {
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.phoneMustBeAtOnly10,);
      return AppWord.phoneMustBeAtOnly10;
    }
    if (value.length != 10) return AppWord.phoneMustBeAtOnly10;
    return null;
  }

  // String? numberValidator(String? value,) {
  //   if (value == null || value.isEmpty) return AppWord.empty;
  //   if (!value.isNum) return AppWord.notNumber;
  //   return null;
  // }

  String? nameValidator(String? value, [int len = 3]) {
    if (value == null || value.isEmpty) {
      ControllerSnackBar(errorMessage: AppWord.emptyName,);
      return AppWord.emptyName;
    }
    if ((value.length < len)) {
      ControllerSnackBar(errorMessage: AppWord.nameShouldBeAtLeast3,);
      return AppWord.nameShouldBeAtLeast3;
    }
    if ((value.isNum)) {
      ControllerSnackBar(errorMessage: AppWord.nameShouldNotBeOnlyNumbers,);
      return AppWord.nameShouldNotBeOnlyNumbers;
    }
    return null;
  }

  String? passwordValidator(String? value, [int len = 9]) {
    if (value == null || value.isEmpty) {
      ControllerSnackBar(errorMessage: AppWord.emptyPassword,);
      return AppWord.emptyPassword;
    }
    if ((value.length < len)) {
      ControllerSnackBar(errorMessage: AppWord.passwordShouldBeAtLeast9);
      return AppWord.passwordShouldBeAtLeast9;
    }

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
