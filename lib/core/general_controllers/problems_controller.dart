import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';

class ProblemsController extends GetxController {
  List<Map<String, dynamic>> problems = [];
  TextEditingController descriptionController = TextEditingController();
  Map<String, dynamic> selectedProblemType = {'name': 'select type'};
bool isLoading = false;
  void getProblemsTypes() async {
    await DioHelper.getProblemTypes().then((value) {
      value['data'].forEach((type) {
        problems.add(type);
      });
    });
  }

  void sendProblem({
    required int productId,
  }) async {
    isLoading = true;
    update();
    await DioHelper.problemStore(
      description: descriptionController.text,
      type: selectedProblemType['id'].toString(),
      productId: productId,
    ).then((value) {
      if (value) {
        Get.back();
        descriptionController.clear();
        selectedProblemType = {'name': 'select type'};
        isLoading = false;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
      } else {
        isLoading = false;
        update();
        ControllerSnackBar(errorMessage: AppWord.checkInternet,errorTitle: AppWord.warning);
      }
    });
  }

  @override
  void onInit() {
    getProblemsTypes();
    super.onInit();
  }
}

