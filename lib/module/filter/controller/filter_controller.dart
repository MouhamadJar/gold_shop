import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/category_products/model/category_products_model.dart';
import '';
import '../../../core/texts/words.dart';
import '../../category_products/controller/category_products_controller.dart';

class FilterController extends GetxController {
  bool isLoading = true;
  String title = AppWord.productCalibre;
  int? value = 0;
  List<ProductsModel> filteredProducts = [];
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  TextEditingController fromWeightController = TextEditingController();
  TextEditingController toWeightController = TextEditingController();
  SubcategoryProductsController subcategoryProductsController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool priceCheck = false;
  bool weightCheck = false;
  List<String> productTypes = [AppWord.news,AppWord.used,AppWord.likeNew];
  List<String> carats = [];
  String selectedProductType = AppWord.productType;
  String? carat;
  int? productType;
  int? byPrice;
  int? byWeight;
  double? fromWeight;
  double? toWeight;
  double? fromPrice;
  double? toPrice;


  // void checkValue() {
  //  checked =true;
  //   update();
  // }
  // void uncheckValue() {
  //  checked =false;
  //   update();
  // }

  void filterProducts()async{
     DioHelper.filterProducts(
        carat: carat!,
        byPrice: byPrice!,
        byWeight: byWeight!,
        productType: productType!,
        fromWeight:double.parse('${fromWeightController.text}.0'),
        toWeight:double.parse('${toWeightController.text}.0'),
        fromPrice:double.parse('${fromPriceController.text}.0'),
        toPrice:double.parse('${toPriceController.text}.0'),).then((value) {
          print(value);
          if(value['data']['data']==[]){
            Get.back();
            ControllerSnackBar(errorMessage: AppWord.noDataForThisFilter);
            subcategoryProductsController.update();
          }
          else{
          value['data']['data'].forEach((element) {
           filteredProducts.add(ProductsModel.fromJson(json: element));
           update();});
          Get.back();
          subcategoryProductsController.product = filteredProducts;
          subcategoryProductsController.update();}
     });
     update();
  }

  // void weightFilter() async {
  //   Map<String, dynamic> data = await DioHelper.weightFilter(
  //       carat: carat!,
  //       fromWeight: double.tryParse(fromWeightController.text)!,
  //       toWeight: double.tryParse(toWeightController.text)!);
  //   print(data.toString());
  //   if(data['data'].isEmpty){
  //     Get.snackbar(AppWord.warning, AppWord.noDataForThisFilter);
  //   }
  //

  //   });
  //   subcategoryProductsController.product = filteredProducts;
  //   subcategoryProductsController.update();
  //   Get.back();
  // }
  //
  // void priceFilter() async {
  //   Map<String, dynamic> data = await DioHelper.priceFilter(
  //       carat: carat!,
  //       fromPrice: double.tryParse(fromPriceController.text)!,
  //       toPrice: double.tryParse(toPriceController.text)!);
  //   if(data['data'].isEmpty||data['data']==null){
  //     Get.snackbar(AppWord.warning, AppWord.noDataForThisFilter);
  //     return;
  //   }
  //   data['data']['data'].forEach((element) {
  //     filteredProducts.add(ProductsModel.fromJson(json: element));
  //     update();
  //   });
  //   Get.back();
  // }

  void getAllCarats()async{
    await DioHelper.getAllCarats().then((value) {
      value['data'].forEach((element){
        carats.add(element);
      });
    } );
    isLoading = false;
    update();
  }
  @override
  void onInit() {
    getAllCarats();
    super.onInit();
  }
}
