import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class ReservedSellController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  List <int> subcategoryId = [];

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
}