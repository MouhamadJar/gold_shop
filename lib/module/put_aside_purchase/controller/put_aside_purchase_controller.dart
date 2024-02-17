import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class PutAsidePurchaseController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    print(subcategoriesADVS.length.toString());
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void getProductDetails({required int productId})async{
    isLoading= true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    print(data['data']['order']);
    model = ProfileProductPurchasesModel.fromJson(json: data['data']);
    isLoading = false;
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    update();
  }
}