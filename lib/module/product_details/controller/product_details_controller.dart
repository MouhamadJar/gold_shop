import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/product_details/model/product_details_model.dart';

import '../../../core/images/images.dart';
import '../../category_products/model/category_products_model.dart';

class ProductDetailsController extends GetxController{
  bool isChecked = false;
  String buttonBackground = AppImages.buttonDarkBackground;
  ProductDetailsModel? model;
  bool isLoading = true;
  Map<String,dynamic> productDetails = {};
  List<dynamic> subcategoriesADVS = [];
  bool isBannersEmpty = true;
  void checked (){
    if(isChecked){
      buttonBackground =AppImages.buttonDarkBackground;
      isChecked = !isChecked;
    }else{
      buttonBackground =AppImages.buttonLiteBackground;
      isChecked = !isChecked ;
    }
    update();
  }

void getProductDetails({required int productId})async{
    Map<String,dynamic> data = await DioHelper.show(productId: productId);
    productDetails = data['data'];
    model = ProductDetailsModel.fromJson(json: data['data']);
    isLoading = false;
    update();
}
  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data =
    await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {
      subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));
    });
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }
}