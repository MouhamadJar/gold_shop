import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/product_payment_method/view/product_payment_method_view.dart';

import '../../../core/colors/colors.dart';
import '../../../core/components/components.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';
import '../controller/add_product_controller.dart';

class AddProduct extends GetView<AddProductController> {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    return GetBuilder<AddProductController>(
        builder: (_) {
      return controller.isLoading
          ?Center(child: CircularProgressIndicator(color: CustomColors.gold,),)
          :Directions(
          child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.selectMultipleImage,
              child: Container(
                alignment: AlignmentDirectional.center,
                height: ScreenDimensions.heightPercentage(context, 8),
                width: ScreenDimensions.widthPercentage(context, 80),
                decoration: BoxDecoration(
                    color: CustomColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: CustomColors.gold,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          offset: const Offset(0, 3),
                          spreadRadius: 0.1),
                    ],
                    borderRadius: BorderRadius.circular(
                        ScreenDimensions.radius(context, 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppWord.uploadProductPictures,
                      style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                      ),
                    ),
                    SvgPicture.asset(AppImages.upload),
                  ],
                ),
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 3)),
            ),
            AppTextField(
                    maxLines: 4,
                    controller: controller.descriptionController,
                    title: AppWord.productDescription,
                    keyboardType: TextInputType.text).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(hintText: '__ years',
                    controller: controller.ageController,
                    title: AppWord.productAge,
                    keyboardType: TextInputType.text).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              controller: controller.weightController,
                    title: AppWord.productWeight,
                    keyboardType: TextInputType.number).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppPopUpMenu(
                  title: controller.categoriesTitle,
                  items: controller.categoriesModel.map((e) => PopupMenuItem(value: e,
                    child: Text(
                      e.name,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context)),),)).toList(),
                  onSelected: (value) {
                    controller.categoriesTitle = value.name;
                    controller.getSubcategories(categoryId: value.id);
                    controller.update();
                  },
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: ScreenDimensions.widthPercentage(context, 30),
                  child: Text(
                    AppWord.productCategory,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppPopUpMenu(
                  title: controller.subcategoriesTitle,
                  items: controller.subcategoriesModel.map((e) => PopupMenuItem(value: e.name,
                    child: Text(
                      e.name,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context)),),)).toList(),
                  onSelected: (value) {
                    controller.subcategoriesTitle = value;
                    controller.update();
                  },
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: ScreenDimensions.widthPercentage(context, 30),
                  child: Text(
                    AppWord.productClassification,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppPopUpMenu(
                  title: controller.calibers,
                  items: [
                    PopupMenuItem(value: '6k',child: Text('6k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '8k',child: Text('8k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '9k',child: Text('9k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '10k',child: Text('10k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '12k',child: Text('12k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '14k',child: Text('14k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '16k',child: Text('16k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '18k',child: Text('18k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '21k',child: Text('21k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '21.6k',child: Text('21.6k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '22k',child: Text('22k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                    PopupMenuItem(value: '24k',child: Text('24k',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),)),
                  ],
                  onSelected: (value) {
                    controller.calibers = value;
                    controller.getAllCaratPrices();
                    controller.update();
                  },
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: ScreenDimensions.widthPercentage(context, 30),
                  child: Text(
                    AppWord.productCalibre,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              enabled: false,
              controller: controller.caliberPriceValueController,
              title: AppWord.theNetPrice,
              keyboardType: TextInputType.number,
              label: Row(
                children: [
                  Text(' ${AppWord.sad} ',style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),),
                  Text(controller.caliberPrice.toString(),style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),),
                ],
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              controller: controller.profitController,
              title: AppWord.theAddedCommission,
              keyboardType: TextInputType.number,
              label: Text(AppWord.sad),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              enabled: false,
              title: AppWord.platformCommission,
              keyboardType: TextInputType.number,
              label: Text(AppWord.sad),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
                    title: AppWord.anotherAddsPrice,
                    keyboardType: TextInputType.number).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              title: AppWord.anotherAddsDescription,
              keyboardType: TextInputType.text,
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              title: AppWord.totalGramPrice,
              keyboardType: TextInputType.number,
              label: Text(AppWord.sad),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              title: AppWord.totalProductPrice,
              keyboardType: TextInputType.number,
              label: Text(AppWord.sad),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
                    title: AppWord.manufacturer,
                    keyboardType: TextInputType.name).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeColor();
                      },
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1),
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 6)),
                        decoration: BoxDecoration(
                            color: controller.cardColor,
                            border: Border.all(
                                color: CustomColors.white2,
                                width: ScreenDimensions.widthPercentage(
                                    context, 0.3)),
                            borderRadius: BorderRadius.circular(
                                ScreenDimensions.radius(context, 1))),
                        child: Text(
                            AppWord.international,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: controller.fontColor,
                                fontSize: AppFonts.smallTitleFont(context)-3,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.changeColor2();
                      },
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1),
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 6)),
                        decoration: BoxDecoration(
                            color: controller.cardColor2,
                            border: Border.all(
                                color: CustomColors.white2,
                                width: ScreenDimensions.widthPercentage(
                                    context, 0.3)),
                            borderRadius: BorderRadius.circular(
                                ScreenDimensions.radius(context, 1))),
                        child: Text(
                            AppWord.local,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: controller.fontColor2,
                                fontSize: AppFonts.smallTitleFont(context)-3,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: ' : '),
                    TextSpan(text: AppWord.industry),
                  ]),
                  style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppWord.productOffer,
                      style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GetBuilder<AddProductController>(builder: (_) {
                      return Checkbox(
                          value: controller.isChecked,
                          onChanged: (value) {
                            controller.checked();
                            controller.isChecked = value!;
                          },
                          activeColor: CustomColors.gold);
                    }),
                  ],
                ),
                AppTextField(
                  enabled: controller.isChecked,
                  title: AppWord.offerDescription,
                  keyboardType: TextInputType.text,
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 50),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    cursorColor: CustomColors.gold,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.gold)),
                        border: const OutlineInputBorder()),
                  ),
                ),
                Text(
                  AppWord.discountValue,
                  style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 80),
                    child: Text(
                      AppWord.pinPrice,
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                          fontWeight: FontWeight.bold),
                    )),
                GetBuilder<AddProductController>(builder: (_) {
                  return Checkbox(
                    value: controller.isPinned,
                    onChanged: (value) {
                      controller.pinned();
                      controller.isPinned = value!;
                    },
                    activeColor: CustomColors.gold,
                  );
                }),
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 2)),
            AppButton(
                text: Text(
                  AppWord.next,
                  style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                      fontWeight: FontWeight.bold,
                      color: CustomColors.white),
                ),
                onTap: () {Get.to(const ProductPaymentMethod(),transition: Transition.fade,duration: const Duration(milliseconds: 500));},
                buttonBackground: AppImages.buttonLiteBackground).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 3)),
          ],
        ).paddingSymmetric(
          horizontal: ScreenDimensions.widthPercentage(context, 5),
        ),
      ));
    });
  }
}
