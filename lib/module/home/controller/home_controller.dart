import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

import '../../../core/texts/words.dart';
import '../model/home_model.dart';

class HomeController extends GetxController with StateMixin {
  List<dynamic> categories=[];
  bool isLoading =true;
  bool isCategoryEmpty =true;
  List<String> cities = [];
  List<Map<String ,dynamic>> ads = [];
  String? selectedCity;
  bool isCityEmpty =true;

  void getCategories() async {
    Map<String, dynamic> data = await DioHelper.getAllCategories();
    categories.clear();
    Get.log('REQUESTING');

    data ['data']['data'].forEach((element){categories.add(CategoriesModel.frmJson(json: element));});
    isLoading =false;
    update();
  }

  void getCity() async {
    Map<String, dynamic> data = await DioHelper.getCity();
    data['data'].forEach((element) {
      cities.add(element);
      selectedCity = AppWord.chooseCity;
    });
    isCityEmpty = false;
    update();
  }

  void homeADVS()async{
    Map<String ,dynamic> data = await DioHelper.homeADVS();
    data['data'].forEach((element){ads.add(element);});
    print(ads.toString());
    update();
  }
}
