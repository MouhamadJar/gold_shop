import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_shop/core/texts/words.dart';

class StorageHandler {
  StorageHandler._();

  static StorageHandler? _instance;

  factory StorageHandler() => _instance ??= StorageHandler._();

  final _storage = GetStorage('gold-shop');

  static Future<void> init() async {
    await GetStorage.init('gold-shop');
  }

  // Token
  Future<void> setToken(String token) => _storage.write('token', token);

  Future<void> removeToken() => _storage.remove('token');

  String get token => _storage.read('token') ?? 'no token';

  bool get hasToken => _storage.hasData('token');

  // Mediator Token
  Future<void> setMediatorToken(String mediatorToken) => _storage.write('mediator_token', mediatorToken);

  Future<void> removeMediatorToken() => _storage.remove('mediator_token');

  String get mediatorToken => _storage.read('mediator_token') ?? 'no mediator token';

  bool get mediatorHasToken => _storage.hasData('mediator_token');

  // Locale
  Future<void> setLocale(String locale) => _storage.write('locale', locale);

  Locale get locale {
    if (_storage.hasData('locale')) {
      var lang = _storage.read('locale');
      switch (lang) {
        case 'ar':
          return const Locale('ar');
        default:
          return const Locale('en');
      }
    }
    return const Locale('en');
  }

  String get lang {
    if (_storage.hasData('locale')) {
      var lang = _storage.read('locale');
      return lang;
    }
    return 'en';
  }

  bool get isAr => lang == 'ar';

  // User id
  Future<void> setUserId(String id) async => await _storage.write('userId', id);

  Future<void> removeUserId() => _storage.remove('userId');

  String get userId => _storage.read('userId') ?? 'no user id';

  bool get hasUserId => _storage.hasData('userId');

  // Mediator id
  Future<void> setMediatorId(String mediatorId) async => await _storage.write('mediatorId', mediatorId);

  Future<void> removeMediatorId() => _storage.remove('mediatorId');

  String get mediatorId => _storage.read('mediatorId') ?? 'no mediator id';

  bool get hasMediatorId => _storage.hasData('mediatorId');

  // role
  Future<void> setRole(String role) => _storage.write('role', role);

  Future<void> removeRole() => _storage.remove('role');

  String get role => _storage.read('role') ?? 'not authenticated';

  bool get hasRole => _storage.hasData('role');

  // signature
  Future<void> setSignature(bool signature) => _storage.write('signature', signature);

  Future<void> removeSignature() => _storage.remove('signature');

  bool get signature => _storage.read('signature') ?? false;

  bool get hasSignature => _storage.hasData('signature');

  // user profile photo
  Future<void> setProfilePhoto(String photoLink) => _storage.write('profile photo', photoLink);

  Future<void> removePhoto() => _storage.remove('profile photo');

  String get profilePhoto => _storage.read('profile photo') ?? 'No photo';

  bool get hasPhoto => _storage.hasData('profile photo');

  // Mediator profile photo
  Future<void> setMediatorProfilePhoto(String mediatorPhotoLink) => _storage.write('Mediator profile photo', mediatorPhotoLink);

  Future<void> removeMediatorPhoto() => _storage.remove('Mediator profile photo');

  String get mediatorProfilePhoto => _storage.read('Mediator profile photo') ?? 'No Mediator photo';

  bool get hasMediatorPhoto => _storage.hasData('Mediator profile photo');

  // user name
  Future<void> setUserName(String userName) => _storage.write('userName', userName);

  Future<void> removeUserName() => _storage.remove('userName');

  String get userName => _storage.read('userName') ?? 'No account';

  bool get loggedIn => _storage.hasData('userName');

  // Mediator user name
  Future<void> setMediatorName(String mediatorName) => _storage.write('MediatorName', mediatorName);

  Future<void> removeMediatorName() => _storage.remove('MediatorName');

  String get mediatorName => _storage.read('MediatorName') ?? 'No account';

  bool get mediatorLoggedIn => _storage.hasData('MediatorName');

  // user verified
  Future<void> setVerification(String userVerification) => _storage.write('verified', userVerification);

  Future<void> removeVerification() => _storage.remove('verified');

  String get verified => _storage.read('verified') ?? 'No account';

  bool get isVerified => _storage.hasData('verified');

  // Mediator verified
  Future<void> setMediatorVerification(String mediatorVerification) => _storage.write('verifiedMediator', mediatorVerification);

  Future<void> removeMediatorVerification() => _storage.remove('verifiedMediator');

  String get verifiedMediator => _storage.read('verifiedMediator') ?? 'No Mediator account';

  bool get isVerifiedMediator => _storage.hasData('verifiedMediator');
}
