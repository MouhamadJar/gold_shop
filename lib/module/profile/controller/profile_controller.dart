import 'package:get/get.dart';

import '../../../core/network/dio_helper.dart';

class ProfileController extends GetxController{
  bool isLoading = true;
  Map<String,dynamic> model  ={};

  void getProfile ()async{
    Map<String,dynamic> data = await DioHelper.showProfile();
    model = data['data'];
    print(model.toString());
    isLoading = false;
    update();
  }
}