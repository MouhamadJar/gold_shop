
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

import '../../../core/texts/words.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  List<CategoriesModel> categories=[];
  bool isLoading =true;
  bool isBannerLoading =true;
  bool isCategoryEmpty =true;
  List<String> cities = [];
  List<HomeADVSModel> ads = [];
  String? selectedCity;
  bool isCityEmpty =true;
  bool isBannerEmpty = false;

  void getCategories() async {
    isLoading = true;
    update();
    Map<String, dynamic> data = await DioHelper.getAllCategories();
    categories.clear();
    data ['data']['data'].forEach((element){categories.add(CategoriesModel.frmJson(json: element));});
    isLoading =false;
    update();
  }

  // void getCity() async {
  //   Map<String, dynamic> data = await DioHelper.getCity();
  //   data['data'].forEach((element) {
  //     cities.add(element);
  //     selectedCity = AppWord.chooseCity;
  //   });
  //   isCityEmpty = false;
  //   update();
  // }

  void homeADVS() async {
    isBannerLoading = true;
    update();
    Map<String, dynamic> data = await DioHelper.homeADVS();
    data['data'].forEach((element) {ads.add(HomeADVSModel.fromJson(json: element));
    });
    ads.isEmpty ? isBannerEmpty = true : isBannerEmpty = false;
    isBannerLoading = false;
    update();
  }
  @override
  void onInit() {
    getCategories();
    homeADVS();
    super.onInit();
  }
}
