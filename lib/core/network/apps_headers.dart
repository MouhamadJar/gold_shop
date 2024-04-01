import '../storage_handler/storage_handler.dart';

class AppHeadersUser {
  static Map<String, dynamic> get header => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (StorageHandler().hasToken)
          'Authorization': 'Bearer ${StorageHandler().token}',
      };
}
class AppHeadersMediator {
  static Map<String, dynamic> get header => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (StorageHandler().mediatorHasToken)
          'Authorization': 'Bearer ${StorageHandler().mediatorToken}',
      };
}
