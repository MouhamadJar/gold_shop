import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_shop/module/main/mediator_shop/edit_product/view/edit_product_view.dart';
import 'package:gold_shop/module/privacy/view/privacy_view.dart';
import '../../../../../core/components/components.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../../../../authentication/view/login_screen.dart';
import '../../../../authentication/view/mediator_shop/verify_account_screen.dart';
import '../../../user/components/components.dart';
import '../../mediator_shop_profile/view/mediator_shop_profile.dart';
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
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.all(
                ScreenDimensions.widthPercentage(context, 2)),
            child: SvgPicture.asset(
              AppImages.saudiArabia,
              height: ScreenDimensions.heightPercentage(context, 5),
            ),
          ),
        ],
         title: Text(
          AppWord.home,
          style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.subTitleFont(context)),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(
              AppImages.moreIcon,
              fit: BoxFit.scaleDown,
            ),
          );
        }),
      ),
          drawer: Directions(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Drawer(
                width: ScreenDimensions.widthPercentage(context, 65),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [CustomColors.gold, CustomColors.black],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        stops: const [0.5, 1]),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                                height: ScreenDimensions.heightPercentage(
                                    context, 20),
                                width:
                                ScreenDimensions.widthPercentage(context, 40),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                        color: CustomColors.shadow,
                                      )
                                    ])),
                            Container(
                              height:
                              ScreenDimensions.heightPercentage(context, 18),
                              width:
                              ScreenDimensions.widthPercentage(context, 36),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.person_2_outlined,
                                  size: ScreenDimensions.heightPercentage(
                                      context, 15)),
                            ),
                          ],
                        ),
                        Text(
                          AppWord.userName,
                          style: TextStyle(
                              fontSize: AppFonts.subTitleFont(context),
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppWord.activatedAccount,
                              style: TextStyle(
                                  fontSize: AppFonts.subTitleFont(context),
                                  color: CustomColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Icon(
                              Icons.verified,
                              color: CustomColors.white,
                              size: ScreenDimensions.radius(context, 3),
                            ),
                          ],
                        ),
                        DrawerListTiles(
                          title: AppWord.logout,
                          imagePath: AppImages.login,
                          onTap: () {
                            controller.logout();
                            controller.loader
                                ?Get.dialog(Center(child: CircularProgressIndicator(color: CustomColors.gold,),),barrierDismissible: false)
                                :Get.snackbar(AppWord.note,AppWord.loggedOut);
                            controller.update();
                          },
                        ),
                        DrawerListTiles(
                            onTap: () {
                              Get.to(const VerifyMediatorAccount(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 700));
                            },
                            title: AppWord.activateAccount,
                            imagePath: AppImages.verified),
                        DrawerListTiles(
                            onTap: () {
                              Get.to(const MediatorShopProfile(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 700));
                            },
                            title: AppWord.profile,
                            imagePath: AppImages.user),
                        DrawerListTiles(
                          title: AppWord.language,
                          imagePath: AppImages.language,
                          onTap: () {
                            Get.log(Get.locale!.languageCode);
                            if (Get.locale!.languageCode == 'ar') {
                              Get.updateLocale(const Locale('en'));
                            } else {
                              Get.updateLocale(const Locale('ar'));
                            }
                          },
                        ),
                        DrawerListTiles(
                            title: AppWord.notifications,
                            imagePath: AppImages.notification),
                        DrawerListTiles(
                            title: AppWord.deal, imagePath: AppImages.contract),
                        DrawerListTiles(
                            title: AppWord.info, imagePath: AppImages.info,onTap: (){
                              Get.back();
                              Get.to(const Privacy(),transition: Transition.size,duration: const Duration(milliseconds: 700));}),
                        DrawerListTiles(
                            title: AppWord.contactUs,
                            imagePath: AppImages.contactUs2),
                      ],
                    ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2),
                    ),
                  ),
                ),
              ),
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
                  keyboardType: TextInputType.text).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 5),
                  horizontal: ScreenDimensions.widthPercentage(context, 10)),
          const Spacer(),
          GetBuilder<ProductCodeController>(builder: (_) {
            return  AppButton(
                        text: Text(
                          AppWord.done,
                          style: TextStyle(
                              color: CustomColors.white,
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          Get.to(EditProduct(productCodeController: controller.codeController.text),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                        },
                        buttonBackground: AppImages.buttonLiteBackground)
                    .paddingSymmetric(
                        vertical:
                            ScreenDimensions.heightPercentage(context, 2));
          }),
        ],
      ),
    ));
  }
}
