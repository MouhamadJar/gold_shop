// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/edit_profile/view/edit_profile_view.dart';
import 'package:gold_shop/module/my_ads/view/my_ads_view.dart';
import 'package:gold_shop/module/profile/controller/profile_controller.dart';
import 'package:gold_shop/module/purchased_product/view/purchased_product_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/network/dio_helper.dart';
import '../../my_purchases_home/view/my_purchases_home_view.dart';
import '../../my_sells_home/view/my_sells_home_view.dart';
import '../components/profile_components.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: GetBuilder<ProfileController>(initState: (state) {
          controller.getProfile();
          controller.getPurchases();
          controller.getSells();
          controller.getMyProducts();
        }, builder: (_) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.gold,
                  ),
                )
              : SizedBox(
                  width: ScreenDimensions.screenWidth(context),
                  height: ScreenDimensions.screenHeight(context),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          width: ScreenDimensions.screenWidth(context),
                          height:
                              ScreenDimensions.heightPercentage(context, 60),
                          child: Stack(
                            children: [
                              Positioned(
                                top: ScreenDimensions.heightPercentage(
                                    context, 20),
                                left: -ScreenDimensions.widthPercentage(
                                    context, 30),
                                right: -ScreenDimensions.widthPercentage(
                                    context, 30),
                                child: Transform.rotate(
                                  angle: -120,
                                  child: Container(
                                    width:
                                        ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(
                                        context, 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          CustomColors.black,
                                          CustomColors.gold,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(
                                      context, 6),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white,
                                    radius:
                                        ScreenDimensions.radius(context, 10),
                                  )),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(
                                      context, 7),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white1,
                                    radius: ScreenDimensions.radius(context, 9),
                                    child: controller.model['photo'] != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.dialog(BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 10, sigmaX: 10),
                                                child: InteractiveViewer(
                                                  child: AppNetworkImage(
                                                    baseUrlImages +
                                                        controller
                                                            .model['photo'],
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ));
                                            },
                                            child: AppNetworkImage(
                                              baseUrlImages +
                                                  controller.model['photo'],
                                              shape: BoxShape.circle,
                                              fit: BoxFit.contain,
                                              width: ScreenDimensions
                                                  .widthPercentage(context, 40),
                                              height: ScreenDimensions
                                                  .heightPercentage(
                                                      context, 30),
                                            ),
                                          )
                                        : DelayedDisplay(
                                            child: Icon(
                                              Icons.person_2_outlined,
                                              size: ScreenDimensions
                                                  .heightPercentage(
                                                      context, 10),
                                            ),
                                          ),
                                  )),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: ScreenDimensions.heightPercentage(
                                    context, 26),
                                child: Column(
                                  children: [
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 300),
                                      slidingBeginOffset: const Offset(5, 0),
                                      child: Text(
                                        '${controller.model['first_name']} ${controller.model['last_name']}',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize:
                                              AppFonts.subTitleFont(context),
                                        ),
                                      ),
                                    ),
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 600),
                                      slidingBeginOffset: const Offset(-5, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.model['is_verified'] == 0
                                                ? AppWord.notActivatedAccount
                                                : AppWord.activatedAccount,
                                            style: TextStyle(
                                              color: CustomColors.white,
                                              fontSize: AppFonts.subTitleFont(
                                                  context),
                                            ),
                                          ).paddingSymmetric(
                                              horizontal: ScreenDimensions
                                                  .widthPercentage(context, 3)),
                                          controller.model['is_verified'] == 0
                                              ? const SizedBox.shrink()
                                              : Icon(Icons.verified,
                                                  color: CustomColors.white,
                                                  size: ScreenDimensions
                                                      .widthPercentage(
                                                          context, 6)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Directions(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('${controller.model['country']}, ${controller.model['state']} , ${controller.model['city']} , ${controller.model['neighborhood']} , ${controller.model['street']}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      AppFonts.smallTitleFont(
                                                          context),
                                                  fontWeight: FontWeight.bold))
                                          .paddingSymmetric(
                                              horizontal: ScreenDimensions
                                                  .widthPercentage(context, 1)),
                                      SvgPicture.asset(
                                        AppImages.location,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                                  width: ScreenDimensions.screenWidth(context),
                                  height: ScreenDimensions.heightPercentage(
                                      context, 25),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: GoogleMap(
                                      onMapCreated: (mapController) {
                                        controller.mapController =
                                            mapController;
                                      },
                                      gestureRecognizers: {
                                        Factory(
                                          () => EagerGestureRecognizer(
                                              allowedButtonsFilter: (buttons) =>
                                                  true,
                                              supportedDevices: {
                                                PointerDeviceKind.touch
                                              }),
                                        ),
                                      },
                                      initialCameraPosition:
                                          controller.position!,
                                      markers: {controller.marker!}),
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 2)),
                            childCount: 1,
                            addSemanticIndexes: true),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Directions(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.model['phone_number'],
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ).paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 2)),
                              SvgPicture.asset(AppImages.phone)
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 5),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        Directions(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.model['email'],
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ).paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 2)),
                              SvgPicture.asset(AppImages.email)
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 5),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        Text(
                          AppWord.myPurchasesAndPutAside,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: controller.isLoadingPurchases
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: CustomColors.gold,
                                    ),
                                  )
                                : controller.myPurchases.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppWord.nothingToShow,
                                          style: TextStyle(
                                              fontSize: AppFonts.subTitleFont(
                                                  context)),
                                        ),
                                      )
                                    : ProfileLists(
                                        product: controller.myPurchases,
                                        image: controller.myPurchases,
                                      )),
                        TextButton(
                                onPressed: () {
                                  Get.to(const MyPurchasesHome(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                child: Text(
                                  AppWord.viewAll,
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontSize:
                                          AppFonts.smallTitleFont(context)),
                                ))
                            .paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(
                                    context, 2)),
                        Text(
                          AppWord.mySellsAndPutAside,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: controller.isLoadingSells
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: CustomColors.gold,
                                    ),
                                  )
                                : controller.mySells.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppWord.nothingToShow,
                                          style: TextStyle(
                                              fontSize: AppFonts.subTitleFont(
                                                  context)),
                                        ),
                                      )
                                    : ProfileLists(toSold: true,
                                        product: controller.mySells,
                                        image: controller.mySells,
                                      )),
                        TextButton(
                            onPressed: () {
                              Get.to(const MySellsHome(),
                                  transition: Transition.zoom,
                                  duration: const Duration(milliseconds: 500));
                            },
                            child: Text(
                              AppWord.viewAll,
                              style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: AppFonts.smallTitleFont(context)),
                            )).paddingSymmetric(
                          horizontal:
                              ScreenDimensions.widthPercentage(context, 2),
                        ),
                        Text(
                          AppWord.myAds,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: controller.isLoadingMyProducts
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: CustomColors.gold,
                                    ),
                                  )
                                : controller.myProducts.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppWord.nothingToShow,
                                          style: TextStyle(
                                              fontSize: AppFonts.subTitleFont(
                                                  context)),
                                        ),
                                      )
                                    : ProfileLists(toMyProducts: true,
                                        product: controller.myProducts,
                                        image: controller.myProducts,
                                      )),
                        TextButton(
                                onPressed: () {
                                  Get.to(const MyAds(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                child: Text(
                                  AppWord.viewAll,
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontSize:
                                          AppFonts.smallTitleFont(context)),
                                ))
                            .paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(
                                    context, 2)),
                        Directions(
                          child: Center(
                            child: AppButton(
                                text: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppWord.editProfile,
                                      style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: ScreenDimensions.widthPercentage(
                                          context, 1),
                                    ),
                                    SvgPicture.asset(AppImages.edit,
                                        color: CustomColors.white),
                                  ],
                                ),
                                onTap: () {
                                  Get.to(const EditProfile(),
                                      transition: Transition.fade,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                buttonBackground:
                                    AppImages.buttonLiteBackground),
                          ),
                        )
                      ]))
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
