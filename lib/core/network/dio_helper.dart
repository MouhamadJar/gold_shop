import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:gold_shop/core/network/apps_headers.dart';
import 'package:gold_shop/core/network/end_points.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';

String baseUrl = 'https://mayadeen-md.com/goldStore/public';
String baseUrlImages = 'https://mayadeen-md.com/goldStore/public/storage/';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 20000),
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  // visitor

  static Future<Map<String, dynamic>> getAllCategories() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.getAllCategories,
          options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getAllSubCategories(
      {required int categoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.getAllSubCategories}$categoryId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> aboutUs() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.aboutUs,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> privacy() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.privacy,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> homeADVS() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.homeADVS,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> categoryADVS(
      {required int categoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.categoryADVS}$categoryId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> subcategoryADVS(
      {required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.subCategoryADVS}$subcategoryId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getCaratPrices() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.getCaratPrices,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getAllCaratPrices() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.getAllCaratPrices,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> getOneCaratPrices() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.oneCaratPrice,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> allProducts(
      {required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.allProducts}$subcategoryId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> productsByCity(
      {required String city, required int subcategoryId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.productByCity}$subcategoryId',options: Options(
        headers: AppHeadersUser.header,
      ),
          queryParameters: {'city': city});
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sort(
      {int? carat, int? price, int? weight}) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sorts(carat: carat, price: price, weight: weight),options: Options(
        headers: AppHeadersUser.header,
      )
      );
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
        EndPoints.filter,options: Options(
        headers: AppHeadersUser.header,
      ),
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
        EndPoints.filter,options: Options(
        headers: AppHeadersUser.header,
      ),
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

  static Future<Map<String, dynamic>> getCity() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.getCity,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
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
        options: Options(headers: AppHeadersUser.header),
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

  static Future<Map<String, dynamic>> loginMediatorShop({
    required String userName,
    required String password,
  }) async {
    late Response response;
    try {
      response = await _dio.post(
        EndPoints.loginMediatorShop,options: Options(
        headers: AppHeadersUser.header,
      ),
        data: {
          'user_name': userName,
          'password': password,
        },
      );
      log('success login shop data :\n${response.data}');
      return response.data;
    } on DioException catch (error) {
      log('error login shop data :\n${error.response!.data}');
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
        options: Options(headers: AppHeadersUser.header),
        data: FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          //'photo': MultipartFile.fromFile('filePath'),
          'phone_number': phoneNumber,
          'password': password,
          'latitude': latitude,
          'longitude': longitude,
          'country': country,
          'state': state,
          'city': city,
          'neighborhood': neighborhood,
          'street': street,
        }),
      );
      return response.data;
    } on DioException catch (error) {
      log('error : ${error.response!.data}');
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> registerStore({
    required String name,
    required String email,
    required String phoneNumber,
    required double latitude,
    required double longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
    required String cost,
    required String description,
    required String nationalNumber,
    required String commercialRegister,
    required String commercialRegisterImage,
    required String license,
    required String licenseImage,
  }) async {
    late Response response;
    try {
      log('---REQUESTING SIGNUP---');
      FormData body = FormData.fromMap({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'cost': cost,
        'description': description,
        'national_number': nationalNumber,
        'commercial_register': commercialRegister,
        'commercial_register_image': await MultipartFile.fromFile(commercialRegisterImage),
        'license': license,
        'license_image': await MultipartFile.fromFile(licenseImage),
      });
      response = await _dio.post(
        EndPoints.registerStore,
        options: Options(
        headers: AppHeadersMediator.header,
      ),
        data: body,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.logout,options: Options(
        headers: AppHeadersUser.header,
      ),);
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
      response = await _dio.post(EndPoints.discountStore,options: Options(
        headers: AppHeadersUser.header,
      ), data: {
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
      response = await _dio.post(EndPoints.discountUpdate,options: Options(
        headers: AppHeadersUser.header,
      ), data: {
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
        EndPoints.discountDelete,options: Options(
        headers: AppHeadersUser.header,
      ),
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
        EndPoints.storesIndex,options: Options(
        headers: AppHeadersUser.header,
      ),
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
        EndPoints.storeIndexCity,options: Options(
        headers: AppHeadersUser.header,
      ),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> store({
    required List<File> images,
    required String description,
    required String age,
    required double weight,
    required String carat,
    required int subcategoryId,
    required double currentGoldPrice,
    required double profit,
    double? addition,
    String? details,
    required String manufacturer,
    required String manufacturerType,
    required int toggle,
    required int deliveryType,
    required List<String> phoneNumber,
    required List<dynamic> stores,
    int? discountToggle,
    String? offerDescription,
    double? discountValue,
  }) async {
    late Response response;
    try {
      print('images : ${images}');
      print('description : ${description}');
      print('age : ${age}');
      print('weight : ${weight}');
      print('carat : ${carat}');
      print('subcategory id : ${subcategoryId}');
      print('current gold price : ${currentGoldPrice}');
      print('profit : ${profit}');
      print('addition : ${addition}');
      print('details : ${details}');
      print('manufacturer : ${manufacturer}');
      print('manufaturer type : ${manufacturerType}');
      print('toggle : ${toggle}');
      print('delivery type : ${deliveryType}');
      print('phone numbers : ${phoneNumber}');
      print('stores : ${stores}');
      print('discount toggle : ${discountToggle}');
      print('offer description : ${offerDescription}');
      print('discount value : ${discountValue}');
      List tmp = [];
      List sto = [];
      Map<String, dynamic> data = {
        'images[]': tmp,
        'description': description,
        'age': age,
        'wight': weight,
        'carat': carat,
        'subcategory_id': subcategoryId,
        'current_gold_price': currentGoldPrice,
        'profit': profit,
        'addition': addition ?? 0.0,
        'detail': details ?? 'no offer',
        'manufacture': manufacturer,
        'manufacture_type': manufacturerType,
        'toggle': toggle,
        'delivery_type': deliveryType,
        'phone_number[]': phoneNumber,
        'stores[]': stores,
        'discount_toggle': discountToggle,
        'offer_description': offerDescription ?? 'no offer',
        'discount_value': discountValue ?? 0.0,
      };
      for (int i = 0; i < images.length; i++) {
        tmp.add(await MultipartFile.fromFile(images[i].path));
      }
      for (int i = 0; i < stores.length; i++) {
        sto.add(phoneNumber);
      }
      response = await _dio.post(EndPoints.store, data: FormData.fromMap(data),options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> restoreOrResale({
    required int orderId,
  }) async {
    late Response response;
    try {
      response = await _dio.post(
        '${EndPoints.restoreOrResell}$orderId',
          options: Options(
        headers: AppHeadersUser.header,
      )
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
        '${EndPoints.show}$productId',options: Options(
        headers: AppHeadersUser.header,
      ),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> update({
    required int productId,
    required List<File> images,
    required String description,
    required String age,
    required double weight,
    required String carat,
    required int subcategoryId,
    required double currentGoldPrice,
    required double profit,
    required double addition,
    required String details,
    required String manufacturer,
    required String manufacturerType,
    required int toggle,
    required int deliveryType,
    required List<String> phoneNumber,
    required List<dynamic> stores,
    required int discountToggle,
    String? offerDescription,
    double? discountValue,
  }) async {
    late Response response;
    try {
      List tmp = [];
      Map<String, dynamic> data = {
        'images[]': tmp,
        'description': description,
        'age': age,
        'wight': weight,
        'carat': carat,
        'subcategory_id': subcategoryId,
        'current_gold_price': currentGoldPrice,
        'profit': profit,
        'addition': addition,
        'detail': details,
        'manufacture': manufacturer,
        'manufacture_type': manufacturerType,
        'toggle': toggle,
        'delivery_type': deliveryType,
        'phone_number': [phoneNumber],
        'stores': [stores],
        'discount_toggle': discountToggle,
        'offer_description': offerDescription,
        'discount_value': discountValue,
      };
      for (int i = 0; i < images.length; i++) {
        tmp.add(await MultipartFile.fromFile(images[i].path));
      }
      response = await _dio.post('${EndPoints.update}$productId',
          data: FormData.fromMap(data));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> delete({required int productId}) async {
    late Response response;
    try {
      response = await _dio.delete(
        '${EndPoints.delete}$productId',options: Options(
        headers: AppHeadersUser.header,
      ),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> appCommission() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.appCommission,options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app problems
  static Future<bool> problemStore(
      {required String description,
      required String type,
      required int productId}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.problemStore,options: Options(
        headers: AppHeadersUser.header,
      ), data: {
        'description': description,
        'problem_type_id': type,
        'product_id': productId,
      });
      return true;
    } on DioException catch (error) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getProblemTypes() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.problemTypes,options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app profile
  static Future<Map<String, dynamic>> updateProfile(
      {required String firstName,
      required String lastName,
      required String? email,
      required File? photo,
      required double longitude,
      required double latitude,
      required String country,
      required String state,
      required String city,
      required String neighborhood,
      required String street}) async {
    late Response response;
    try {
      FormData body = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        if (email != null) 'email': email,
        if (photo != null) 'photo': await MultipartFile.fromFile(photo.path),
        'longitude': longitude,
        'latitude': latitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
      });
      response = await _dio
          .post(EndPoints.updateProfile(StorageHandler().userId), data: body,options: Options(
        headers: AppHeadersUser.header,
      ));

      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> showProfile() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.showProfile(StorageHandler().userId),
          options: Options(
            headers: AppHeadersUser.header,
          ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> deleteAccount() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.deleteAccount,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app contact us
  static Future<bool> contactUsStore({
    required String description,
  }) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.contactUsStore, options: Options(
        headers: AppHeadersUser.header,
      ),data: {
        'description': description,
        'type': 'problem',
      });
      return true;
    } on DioException catch (error) {
      return false;
    }
  }

//app orders
  static Future<Map<String, dynamic>> ordersOnHold(
      {required int productId}) async {
    late Response response;
    try {
      response = await _dio.post('${EndPoints.onHold}$productId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> orderSale(
      {required String code, required int productId}) async {
    late Response response;
    try {
      FormData body = FormData.fromMap({'code': code});
      response = await _dio.post('${EndPoints.sale}$productId', data: body,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> paymentInfo() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.paymentInfo,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> bankInfo() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.bankInfo,options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> notificationImage(
      {required int orderId, required String image}) async {
    late Response response;
    try {
      FormData body = FormData.fromMap({
        'image': await MultipartFile.fromFile(image),
      });
      response =
          await _dio.post('${EndPoints.notificationImage}$orderId', data: body,options: Options(
            headers: AppHeadersUser.header,
          ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//reports

  static Future<Map<String, dynamic>> invoice({required int orderId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.invoice}$orderId',options: Options(
        headers: AppHeadersUser.header,
      ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> buyOrder({required int orderId}) async {
    late Response response;
    try {
      response = await _dio.get('${EndPoints.buyOrder}$orderId',options: Options(
        headers: AppHeadersUser.header,
      ));
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
        EndPoints.profileListsSalesOnHold,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsPurchasesOnHold,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsMyProducts,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsSalesReservations,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsReservedPurchases,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsSales,options: Options(
        headers: AppHeadersUser.header,
      )
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
        EndPoints.profileListsPurchases,options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileListsShowProduct(
      {required int productId}) async {
    late Response response;
    try {
      response = await _dio.get(
        '${EndPoints.profileListsShowProduct}$productId',options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileSalesList() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileSalesList,options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profilePurchasesList() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profilePurchasesList,
          options: Options(
            headers: AppHeadersUser.header,
          )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> profileMyProductsList() async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.profileMyProductsList,options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter my product
  static Future<Map<String, dynamic>> sortMyProductByPrice({
    required bool fromUpToDownPrice,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMyProductByPrice(fromUpToDownPrice ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sortMyProductByDate({
    required bool fromUpToDownDate,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMyProductByDate(fromUpToDownDate ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMyProductByPrice({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMyProductByPrice(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMyProductByDate({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMyProductByDate(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter purchases
  static Future<Map<String, dynamic>> sortMyPurchasesByPrice({
    required bool fromUpToDownPrice,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMyPurchasesByPrice(fromUpToDownPrice ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sortMyPurchasesByDate({
    required bool fromUpToDownDate,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMyPurchasesByDate(fromUpToDownDate ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMyPurchasesByDate({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMyPurchasesByDate(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMyPurchasesByPrice({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMyPurchaseByPrice(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app sort & filter sales
  static Future<Map<String, dynamic>> sortMySalesByPrice({
    required bool fromUpToDownPrice,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMySellsByPrice(fromUpToDownPrice ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> sortMySalesByDate({
    required bool fromUpToDownDate,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.sortMySellsByDate(fromUpToDownDate ? 1 : 0),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMySalesByDate({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMySellsByDate(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> filterMySalesByPrice({
    required String from,
    required String to,
    required String subcategoryId,
    required String categoryId,
  }) async {
    late Response response;
    try {
      response = await _dio.get(
        EndPoints.filterMySellsByPrice(subcategoryId, categoryId, from, to),options: Options(
        headers: AppHeadersUser.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app rate
  static Future<Map<String, dynamic>> rateByBuyer({
    required int sellerRating,
    required String sellerMessage,
    required int productRating,
    required String productMessage,
    required int serviceRating,
    required String serviceMessage,
    required int productId,
  }) async {
    late Response response;
    try {
      response = await _dio.post('${EndPoints.rateByBuyer}$productId', data: {
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

  static Future<Map<String, dynamic>> rateBySeller({
    required int buyerRating,
    required String buyerMessage,
    required int serviceRating,
    required String serviceMessage,
    required int productId,
  }) async {
    late Response response;
    try {
      response = await _dio.post('${EndPoints.rateBySeller}$productId',options: Options(
        headers: AppHeadersUser.header,
      ), data: {
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
      response = await _dio.post(EndPoints.storeLogin, options: Options(
        headers: AppHeadersMediator.header,
      ),data: {
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
      response = await _dio.post(EndPoints.storeSignup, options: Options(
        headers: AppHeadersMediator.header,
      ),data: {
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
      response = await _dio.post(EndPoints.storeLogout,options: Options(headers: AppHeadersMediator.header));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

//app store profile
  static Future<Map<String, dynamic>> updateStoreProfile({
    required String name,
    required String email,
    required File photo,
    required double latitude,
    required double longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
    required List<String> numbers,
    required List<int> numbersId,
    required String description,
    required dynamic cost,
  }) async {
    late Response response;
    try {
      // print('name : $name');
      // print('email : $email');
      // print('photo : $photo');
      // print('latitude : $latitude');
      // print('longitude : $longitude');
      // print('country : $country');
      // print('state : $state');
      // print('city : $city');
      // print('neighborhood : $neighborhood');
      // print('street : $street');
      // print('numbers : $numbers');
      // print('numbersId : $numbersId');
      // print('cost : $cost');
      // print('description : $description');
      photo.path.isEmpty ? photo.path != 'no Image' : photo = photo;
      FormData body = FormData.fromMap({
        'name': name,
        'email': email,
        'photo': await MultipartFile.fromFile(photo.path),
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'numbers[number]': numbers,
        'numbers[id]': numbersId,
        'cost': cost,
        'description': description,
      });
      response = await _dio.post(
          EndPoints.updateStoreProfile(StorageHandler().mediatorId),options: Options(
        headers: AppHeadersMediator.header,
      ),
          data: body);
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> showStoreProfile() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.showStoreProfile(StorageHandler().mediatorId),
      options:  Options(headers: AppHeadersMediator.header));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> deleteStoreAccount() async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.deleteStoreAccount,options: Options(
        headers: AppHeadersMediator.header,
      ),);
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
      response = await _dio.post(EndPoints.storeContactUs, options: Options(
        headers: AppHeadersMediator.header,
      ),data: {
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
        EndPoints.hisServiceShowProduct,options: Options(
        headers: AppHeadersMediator.header,
      )
      );
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> hisServiceCheck({
    required String note,
    required String carat,
    required dynamic weight,
    required String manufacturer,
    required int productId,
  }) async {
    late Response response;
    try {
      FormData body = FormData.fromMap({
        'note': note,
        'carat': carat,
        'wight': weight,
        'manufacture': manufacturer,
      });
      response = await _dio.post(EndPoints.hisServiceCheck(productId),
          data: body, options: Options(headers: AppHeadersMediator.header));
      print('iuasdid : ${response.toString()}');
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> hisServiceUpdate({
    required String note,
    required String carat,
    required dynamic weight,
    required String manufacturer,
    required int productId,
  }) async {
    late Response response;
    try {
      FormData body = FormData.fromMap({
        'note': note,
        'carat': carat,
        'wight': weight,
        'manufacture': manufacturer,
      });
      response = await _dio.post(EndPoints.hisServiceUpdateProduct(productId),
          data: body, options: Options(headers: AppHeadersMediator.header));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  // app signature
  static Future<Map<String, dynamic>> uploadSignature(
      {required File signatureImage}) async {
    late Response response;
    try {
      response = await _dio.post(EndPoints.uploadSignature,options: Options(
        headers: AppHeadersMediator.header,
      ),
          data: FormData.fromMap(
              {'image': await MultipartFile.fromFile(signatureImage.path)}));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  static Future<Map<String, dynamic>> checkSignature() async {
    late Response response;
    try {
      response =
          await _dio.get(EndPoints.checkSignature(StorageHandler().mediatorId),options: Options(
            headers: AppHeadersMediator.header,
          ));
      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    }
  }

  // product code
  static Future<Map<String, dynamic>> sendCode({required String code}) async {
    late Response response;
    try {
      response = await _dio.get(EndPoints.sendCode(code),
          options: Options(headers: AppHeadersMediator.header));
      return response.data;
    } on DioException catch (error) {
      return {'status': false};
    }
  }
}
