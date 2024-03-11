import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class AdsProductController extends GetxController {
  bool isLoading = true;
  bool isBannersEmpty = true;
  bool isSubcategoryLoading = true;
  ProfileMyProductsModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS = [];
  dynamic appCommission;

  void subcategoryADVS({required int subcategoryId}) async {
    isSubcategoryLoading = true;
    update();
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    isSubcategoryLoading = false;
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void getProductDetails({required int productId}) async {
    isLoading = true;
    update();
    getAppCommission();
    Map<String, dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileMyProductsModel.fromJson(json: data['data']);
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    isLoading = false;
    update();
  }

  String getProductState(String state) {
    switch (state) {
      case '0':
        return AppWord.available;
      case '1':
        return AppWord.putAside;
      case '2':
        return AppWord.reserved;
      case '3':
        return AppWord.sold;
      default:
        return AppWord.sold;
    }
  }

  void deleteProduct({required int productId}) async {
    await DioHelper.delete(productId: productId).then((value) {
       if(value == null){
         Get.snackbar(AppWord.warning, AppWord.checkInternet);
         return {};
       } else{
         Get.snackbar(AppWord.note, AppWord.deleted,
             snackStyle: SnackStyle.GROUNDED,
             duration: const Duration(milliseconds: 2500));
         Get.offAll(const MainScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 700));
         return {};
       }
    } );
    update();
  }


  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }

}
