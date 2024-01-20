import 'package:get/get.dart';

import '../../../core/network/dio_helper.dart';

class ProfileController extends GetxController{
  bool isLoading = true;
  bool isLoadingPurchases = true;
  bool isLoadingSells = true;
  bool isLoadingMyProducts = true;
  Map<String,dynamic> model  ={};
  List<Map<String,dynamic>> myPurchases = [];
  List<Map<String,dynamic>> mySells = [];
  List<Map<String,dynamic>> myProducts = [];

  void getProfile ()async{
    Map<String,dynamic> data = await DioHelper.showProfile();
    model = data['data'];
    isLoading = false;
    update();
  }
  void getPurchases()async{
    Map <String ,dynamic> data = await DioHelper.profileListsPurchases();
   data ['data']['data'].forEach((element){myPurchases.add(element);});
  isLoadingPurchases = false;
   update();
  }
  void getSells()async{
    Map <String ,dynamic> data = await DioHelper.profileListsSales();
   data ['data']['data'].forEach((element){mySells.add(element);});
    isLoadingSells = false;
   update();
  }
  void getMyProducts()async{
    Map <String ,dynamic> data = await DioHelper.profileListsMyProducts();
   data ['data']['data'].forEach((element){myProducts.add(element);});
    isLoadingMyProducts = false;
   update();
  }
}