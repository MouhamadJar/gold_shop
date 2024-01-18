import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:gold_shop/core/network/apps_headers.dart';
import 'package:gold_shop/core/network/end_points.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';

String baseUrl = 'https://mayadeen-md.com/goldStore/public';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      headers: AppHeaders.header,
    ),
  );

  // visitor

  static Future<Map<String, dynamic>> getAllCategories() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.getAllCategories);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getAllSubCategories(
      {required int categoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.getAllSubCategories}$categoryId');
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> aboutUs() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.aboutUs);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> privacy() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.privacy);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> categoryADVS(
      {required int categoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.categoryADVS}$categoryId');
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> subcategoryADVS(
      {required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.subCategoryADVS}$subcategoryId');
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> allProducts(
      {required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.allProducts}$subcategoryId');
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> productsByCity(
      {required String city,required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.productByCity}$subcategoryId', queryParameters: {'city': 'South%20Susana'});
      print(response.data.toString());
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sort(
      {required bool carat, required bool price, required bool weight}) async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.sort, data: {
        'carat': carat,
        'price': price,
        'wight': weight,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> weightFilter(
      {required int carat,
      required double fromWeight,
      required double toWeight}) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filter,
        queryParameters: {
          'carat': carat,
          'wight': 1,
          'from_wight': fromWeight,
          'to_wight': toWeight,
        },
      );
      print(response.data.toString());
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }


  static Future<Map<String, dynamic>> priceFilter(
      {required int carat,
        required double fromPrice,
        required double toPrice}) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filter,
        queryParameters: {
          'carat': carat,
          'price': 1,
          'from_price': fromPrice,
          'to_price': toPrice,
        },
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String,dynamic>> getCity()async{
    late Response response;
    try{
      response = await _dio.get(EndPoints.getCity);
   return response.data;
    }on DioException catch (error){
return error.response!.data;
    }
  }

  //------------------------------------------------------------------------------------------------------
  //app user

  //app auth
  static Future<Map<String, dynamic>> login({
    required String phoneNumber,
    required String password,
  }) async {
    late Response response;
    try {
      response = await _dio.post(
        EndPoints.login,
        data: {
          'phone_number': phoneNumber,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required double latitude,
    required double longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
  }) async {
    late Response response;
    try {
      response = await _dio.post(
        EndPoints.register,
        data: FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          //'photo': MultipartFile.fromFile('filePath'),
          'phone_number': phoneNumber,
          'password': password,
          'latitude': 10,
          'longitude': 10,
          'country': 'syria',
          'state': 'dmascuse',
          'city': 'mazeh',
          'neighborhood': 'vellat',
          'street': '98',
        }),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.logout);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  //app products

//app products discounts
  static Future<Map<String, dynamic>> discountStore(
      {required String description, required int value}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.discountStore, data: {
        'description': description,
        'value': value,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> discountUpdate(
      {required String description, required int value}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.discountUpdate, data: {
        'description': description,
        'value': value,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> discountDelete() async {
    late Response response;
    try {
      response = await _dio.delete(
        EndPoints.discountDelete,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//stores
  static Future<Map<String, dynamic>> storeIndex() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.storesIndex,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> storeIndexCity() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.storeIndexCity,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> store(
      {required String details,
      required String manufacturer,
      required String manufacturerType,
      required bool toggle,
      required String deliveryType,
      required String phoneNumber,
      required List<String> stores}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.store, data: {
        'detail': details,
        'manufacture': manufacturer,
        'manufacture_type': manufacturerType,
        'toggle': toggle,
        'delivery_type': deliveryType,
        'phone_number': phoneNumber,
        'stores': stores,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> restoreOrResell() async {
    late Response response;
    try {
      response = await _dio.post(
        EndPoints.restoreOrResell,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> show({required int productId}) async {
    late Response response;
    try {
      response = await _dio.get(
        '${EndPoints.show}$productId',
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> update({
    required List<String> image,
    required String description,
    required int age,
    required int weight,
    required int carat,
    required int subCategoryId,
    required int currentGoldPrice,
    required int profit,
    required int addition,
    required String details,
    required String manufacturer,
    required String manufacturerType,
    required bool toggle,
    required int deliveryType,
    required String phoneNumber,
    required List<String> stores,
  }) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.show, data: {
        'images': image,
        'description': description,
        'age': age,
        'wight': weight,
        'carat': carat,
        'subcategory_id': subCategoryId,
        'current_gold_price': currentGoldPrice,
        'profit': profit,
        'addition': addition,
        'detail': details,
        'manufacture': manufacturer,
        'manufacture_type': manufacturerType,
        'toggle': toggle,
        'delivery_type': deliveryType,
        'phone_number': phoneNumber,
        'stores': stores,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> delete() async {
    late Response response;
    try {
      response = await _dio.delete(
        EndPoints.delete,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app problems
  static Future<Map<String, dynamic>> problemStore(
      {required String description,
      required String type,
      required int productId}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.problemStore, data: {
        'description': description,
        'type': type,
        'product_id': productId,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app profile
  static Future<Map<String, dynamic>> updateProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String photo,
      required double longitude,
      required double latitude,
      required String country,
      required String state,
      required String city,
      required String neighborhood,
      required String street}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.updateProfile, data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'photo': photo,
        'longitude': longitude,
        'latitude': latitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> showProfile() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.showProfile);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> deleteAccount() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.deleteAccount);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app contact us
  static Future<Map<String, dynamic>> contactUsStore({
    required String description,
    required String type,
  }) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.contactUsStore, data: {
        'description': description,
        'type': type,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app orders
  static Future<Map<String, dynamic>> ordersOnHold() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.onHold);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> orderSale({required String code}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.sale, data: {'code': code});
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app profile lists
  static Future<Map<String, dynamic>> profileListsSalesOnHold() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsSalesOnHold,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsPurchasesOnHold() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsPurchasesOnHold,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsMyProducts() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsMyProducts,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsSalesReservations() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsSalesReservations,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsReservedPurchases() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsReservedPurchases,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsSales() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsSales,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsPurchases() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsPurchases,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsShowProduct() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileListsShowProduct,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter my product
  static Future<Map<String, dynamic>> sortMyProduct() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMyProduct,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMyProduct() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMyProduct,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter purchases
  static Future<Map<String, dynamic>> sortPurchases() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortPurchases,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterPurchases() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterPurchases,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter sales
  static Future<Map<String, dynamic>> sortSales() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortSales,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterSales() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterSales,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app rate
  static Future<Map<String, dynamic>> rateByBuyer(
      {required int sellerRating,
      required String sellerMessage,
      required int productRating,
      required String productMessage,
      required int serviceRating,
      required String serviceMessage}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.rateByBuyer, data: {
        'seller_number_of_stars': sellerRating,
        'seller_message': sellerMessage,
        'product_number_of_stars': productRating,
        'product_message': productMessage,
        'service_number_of_stars': serviceRating,
        'service_message': serviceMessage,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> rateBySeller(
      {required int buyerRating,
      required String buyerMessage,
      required int serviceRating,
      required String serviceMessage}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.rateBySeller, data: {
        'buyer_number_of_stars': buyerRating,
        'buyer_message': buyerMessage,
        'service_number_of_stars': serviceRating,
        'service_message': serviceMessage,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//-------------------------------------------------------------------------------------------------------
//app store

//app Store auth
  static Future<Map<String, dynamic>> storeLogin(
      {required String phoneNumber, required String password}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.storeLogin, data: {
        'phone_number': phoneNumber,
        'password': password,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> storeSignup({
    required String name,
    required String email,
    required String photo,
    required String phoneNumber,
    required String password,
    required double latitude,
    required double longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
    required List<String> numbers,
    required int cost,
    required String description,
  }) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.storeSignup, data: {
        'name': name,
        'email': email,
        'photo': photo,
        'phone_number': phoneNumber,
        'password': password,
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'numbers': numbers,
        'cost': cost,
        'description': description,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> storeLogout() async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.logout);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app store profile
  static Future<Map<String, dynamic>> updateStoreProfile({
    required String name,
    required String email,
    required String photo,
    required String latitude,
    required String longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
    required List<String> numbers,
    required String description,
    required int cost,
  }) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.updateStoreProfile, data: {
        'name': name,
        'email': email,
        'photo': photo,
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'numbers': numbers,
        'cost': cost,
        'description': description,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> showStoreProfile() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.showStoreProfile);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> deleteStoreAccount() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.deleteStoreAccount);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app store contact us
  static Future<Map<String, dynamic>> storeContactUs(
      {required String description, required String problemType}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.storeContactUs, data: {
        'description': description,
        'type': problemType,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app store his service
  static Future<Map<String, dynamic>> hisServiceShowProduct() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.hisServiceShowProduct,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> hisServiceCheck(
      {required String note,
      required int carat,
      required int weight,
      required String manufacturer}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.hisServiceCheck, data: {
        'note': note,
        'carat': carat,
        'wight': weight,
        'manufacture': manufacturer,
      });
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }
}