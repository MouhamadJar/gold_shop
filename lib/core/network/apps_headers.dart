import '../storage_handler/storage_handler.dart';

class AppHeaders {
  static Map<String, dynamic> get header => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (StorageHandler().hasToken)
          'Authorization': 'Bearer ${StorageHandler().token}',
      };
}
