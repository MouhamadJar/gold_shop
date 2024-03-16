import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StorageHandler {
  StorageHandler._();

  static StorageHandler? _instance;

  factory StorageHandler() => _instance ??= StorageHandler._();

  final _storage = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  // Token
  Future<void> setToken(String token) => _storage.write('token', token);

  Future<void> removeToken() => _storage.remove('token');

  String get token => _storage.read('token') ?? 'no token';

  bool get hasToken => _storage.hasData('token');

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
  Future<void> setUserId(String id) => _storage.write('userId', id);

  Future<void> removeUserId() => _storage.remove('userId');

  String get userId => _storage.read('userId') ?? 'no user id';

  bool get hasUserId => _storage.hasData('userId');

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
}
