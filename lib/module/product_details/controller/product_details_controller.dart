import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/product_details/model/product_details_model.dart';

import '../../../core/images/images.dart';

class ProductDetailsController extends GetxController{
  bool isChecked = false;
  String buttonBackground = AppImages.buttonDarkBackground;
  ProductDetailsModel? model;
  bool isLoading = true;
  Map<String,dynamic> productDetails = {};
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
}