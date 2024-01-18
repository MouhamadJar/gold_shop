
import 'package:get/get.dart';

import '../../../core/network/dio_helper.dart';
import '../model/categories_model.dart';

class CategoriesController extends GetxController{
bool isLoading = true;
List <dynamic> categories = [];
  void getCategories() async {
    Map<String, dynamic> data = await DioHelper.getAllCategories();
    categories.clear();
    data ['data']['data'].forEach((element){categories.add(CategoriesModel.frmJson(json: element));});
    isLoading =false;
    update();
  }
}