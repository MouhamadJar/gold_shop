import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/components/components.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../edit_product/view/edit_product_view.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../controller/product_code_controller.dart';

class ProductCode extends GetView<ProductCodeController> {
  const ProductCode({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductCodeController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: CustomColors.white,
        title: Text(
          AppWord.home,
          style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.subTitleFont(context)),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppWord.enterProductCode,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context) - 3,
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 3),
                horizontal: ScreenDimensions.widthPercentage(context, 3)),
          ),
          AppTextField(
                  controller: controller.codeController,
                  keyboardType: TextInputType.text)
              .paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 5),
                  horizontal: ScreenDimensions.widthPercentage(context, 10)),
          const Spacer(),
          GetBuilder<ProductCodeController>(
            builder: (_) {
              return controller.isLoading ? const Center(child: CircularProgressIndicator()).marginSymmetric(  vertical: ScreenDimensions.heightPercentage(context, 2)): AppButton(
                      text: Text(
                        AppWord.done,
                        style: TextStyle(
                            color: CustomColors.white,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: controller.sendCode,
                      buttonBackground: AppImages.buttonLiteBackground)
                  .paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2));
            }
          ),
        ],
      ),
    ));
  }
}
