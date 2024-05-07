import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/buy_order/model/buy_order_model.dart';

class BuyOrderController extends GetxController {
  bool isLoading = true;
  BuyOrderModel? buyOrderModel;


  void getBuyOrder({required int orderId}) async {
    Map<String, dynamic> data = await DioHelper.buyOrder(orderId: orderId);
    buyOrderModel = BuyOrderModel.fromJson(json: data['data']);
    isLoading = false;
    update();
  }
}
