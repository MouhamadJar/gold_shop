import 'package:get/get.dart';

import '../../../core/network/dio_helper.dart';

class ProfileController extends GetxController{
  bool isLoading = true;
  Map<String,dynamic> model  ={};
  List<Map<String,dynamic>> myPurchases = [];

  void getProfile ()async{
    Map<String,dynamic> data = await DioHelper.showProfile();
    model = data['data'];
    isLoading = false;
    update();
  }
  void getPurchases()async{
    Map <String ,dynamic> data = await DioHelper.profileListsPurchases();
   data ['data']['data'].forEach((element){myPurchases.add(element);});
   print(myPurchases.toString());
  }
}