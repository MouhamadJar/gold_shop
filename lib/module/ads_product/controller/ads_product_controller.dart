import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class AdsProductController extends GetxController{
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  String deleteMessage = '';

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void getProductDetails({required int productId})async{
    isLoading= true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileProductPurchasesModel.fromJson(json: data['data']);
    isLoading = false;
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    update();
  }

  String getProductState(String state){
    switch (state){
      case '0' :
        return AppWord.available;
      case '1' :
        return AppWord.putAside;
      case '2' :
        return AppWord.reserved;
      case '3' :
        return AppWord.sold;
      default :
        return AppWord.sold;
    }
  }

  void deleteProduct ({required int productId})async{
    Map<String,dynamic> data = await DioHelper.delete(productId: productId);
    deleteMessage  = data ['message'];
    Get.snackbar(
        AppWord.done,
        AppWord
            .deleteRequestHasBeenSent,
        snackStyle: SnackStyle
            .GROUNDED,
        duration:
        const Duration(
            milliseconds:
            2500));
    update();
  }
}