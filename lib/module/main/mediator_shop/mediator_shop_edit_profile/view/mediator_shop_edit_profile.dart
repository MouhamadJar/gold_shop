import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/maps.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/main/mediator_shop/mediator_shop_edit_profile/controller/mediator_shop_edit_profile_controller.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/components/components.dart';
import '../../../../edit_profile/components/edit_profile_components.dart';

class MediatorShopEditProfile extends GetView<MediatorShopEditProfileController> {
  const MediatorShopEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MediatorShopEditProfileController());
    return SafeArea(
      child: Directions(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            backgroundColor: CustomColors.white,
            elevation: 1,
            centerTitle: true,
            title: Text(
              AppWord.editProfile,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: GetBuilder<MediatorShopEditProfileController>(
            builder: (_) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator(color: CustomColors.gold,),)
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: controller.pickImage,
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
                              AppWord.uploadProfilePicture,
                              style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                              ),
                            ),
                            SvgPicture.asset(AppImages.upload)
                          ],
                        ),
                      ),
                    ),
                    AppTextField(
                      title: AppWord.mediatorShopName,
                      keyboardType: TextInputType.name,
                      controller: controller.nameController,
                      onChanged:  (value){
                        if(value.isEmpty){
                          controller.nameController.text = controller.mediatorShopProfileModel!.name;
                          controller.update();
                        }else{
                        controller.nameController.text = value;
                        controller.update();}
                      },
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                      title: AppWord.email,
                      keyboardType: TextInputType.emailAddress,
                      controller:controller.emailController,onChanged:  (value){
                      if(value.isEmpty){
                        controller.emailController.text = controller.mediatorShopProfileModel!.email;
                        controller.update();
                      }else{
                        controller.emailController.text = value;
                        controller.update();}
                    },
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextField(
                          title: AppWord.phoneNumber,
                          keyboardType: TextInputType.phone,
                          enabled: false,
                          controller: controller.firstPhoneNumberController,
                          onChanged:  (value){
                          if(value.isEmpty){
                            controller.firstPhoneNumberController.text = controller.mediatorShopProfileModel!.phoneNumber;
                            controller.update();
                          }else{
                            controller.firstPhoneNumberController.text = value;
                            controller.update();}
                        },).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 2)),
                        // controller.phoneNumberCount==2||controller.phoneNumberCount==3
                        //     ?DelayedDisplay(
                        //   child: AppTextField(
                        //     title: '${AppWord.phoneNumber} (2)',
                        //     keyboardType: TextInputType.phone,
                        //     controller: controller.secondPhoneNumberController,
                        //     onChanged: (value){
                        //       controller.secondPhoneNumberController!.text = value;
                        //       controller.update();
                        //     },).paddingSymmetric(
                        //       vertical: ScreenDimensions.heightPercentage(context, 2)),
                        // )
                        //     :const SizedBox.shrink(),
                        // controller.phoneNumberCount == 3
                        //     ?DelayedDisplay(
                        //   child: AppTextField(
                        //     title: '${AppWord.phoneNumber} (3)',
                        //     keyboardType: TextInputType.phone,
                        //     controller: controller.thirdPhoneNumberController,
                        //     onChanged: (value){
                        //       controller.thirdPhoneNumberController!.text = value;
                        //       controller.update();
                        //     },).paddingSymmetric(
                        //       vertical: ScreenDimensions.heightPercentage(context, 2)),
                        // )
                        //     :const SizedBox.shrink(),
                        // Align(
                        //   alignment: AlignmentDirectional.topStart,
                        //   child: Row(
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {
                        //           controller.removePhoneNumber();
                        //         },
                        //         child: Container(
                        //           width: ScreenDimensions.widthPercentage(context, 10),
                        //           height: ScreenDimensions.heightPercentage(context, 5),
                        //           decoration: BoxDecoration(
                        //             boxShadow: [
                        //               BoxShadow(
                        //                   color: CustomColors.shadow,
                        //                   spreadRadius: 0.1,
                        //                   blurStyle: BlurStyle.outer,
                        //                   blurRadius: 3)
                        //             ],
                        //             color: CustomColors.gold,
                        //           ),
                        //           child: Icon(
                        //             Icons.remove,
                        //             size: ScreenDimensions.widthPercentage(context, 7),
                        //             color: CustomColors.white,
                        //           ),
                        //         ),
                        //       ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5)),
                        //       GestureDetector(
                        //         onTap: () {controller.addPhoneNumber();},
                        //         child: Container(
                        //           width: ScreenDimensions.widthPercentage(context, 10),
                        //           height: ScreenDimensions.heightPercentage(context, 5),
                        //           decoration: BoxDecoration(
                        //             boxShadow: [
                        //               BoxShadow(
                        //                   color: CustomColors.shadow,
                        //                   spreadRadius: 0.1,
                        //                   blurStyle: BlurStyle.outer,
                        //                   blurRadius: 3)
                        //             ],
                        //             color: CustomColors.gold,
                        //           ),
                        //           child: Icon(
                        //             Icons.add,
                        //             size: ScreenDimensions.widthPercentage(context, 7),
                        //             color: CustomColors.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ).paddingSymmetric(
                        //   vertical: ScreenDimensions.heightPercentage(context, 2),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppWord.inCaseOfChange,
                              style: TextStyle(
                                  color: CustomColors.grey,
                                  fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppWord.technicalSupport,
                                  style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(context)),
                                )),
                            Text(
                              AppWord.pleaseContactWith,
                              style: TextStyle(
                                  color: CustomColors.grey,
                                  fontSize: AppFonts.smallTitleFont(context)),
                            )
                          ],
                        ),
                      ],
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                      title: AppWord.checkingServiceCommission,
                      keyboardType: TextInputType.number,
                      controller: controller.profitController,
                      onChanged:  (value){
                      if(value.isEmpty){
                        controller.profitController.text = controller.mediatorShopProfileModel!.cost;
                        controller.update();
                      }else{
                        controller.profitController.text = value;
                        controller.update();}
                    },
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                        maxLines: 5,
                      title: AppWord.aboutMediatorShop,
                      keyboardType: TextInputType.text,
                      controller : controller.descriptionController,
                      onChanged:  (value){
                      if(value.isEmpty){
                        controller.descriptionController.text = controller.mediatorShopProfileModel!.description;
                        controller.update();
                      }else{
                        controller.descriptionController.text = value;
                        controller.update();}
                    },
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppWord.fullAddress,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                        AppGoogleMap(
                            markers: {controller.marker},
                            cameraPosition: controller.position,
                          onTap: controller.zoomed?controller.onGoogleMapTapped:(latLng){
                            controller.update();
                            Get.snackbar(AppWord.warning,AppWord.pleaseZoomIn);
                          },
                          onCameraMoved: (cameraPosition){
                            if (cameraPosition.zoom==19.0){
                              controller.zoomed = true;
                              controller.update();
                            }
                            if(cameraPosition.zoom == 18.9){
                              controller.zoomed = false;
                              controller.update();
                            }
                          },
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    EditProfileCard(
                      title: AppWord.area,
                      subtitle: controller.country,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    EditProfileCard(
                      title: AppWord.state,
                      subtitle: controller.state,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    EditProfileCard(
                      title: AppWord.city,
                      subtitle: controller.city,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    EditProfileCard(
                      title: AppWord.neighborhood,
                      subtitle: controller.neighborhood,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    EditProfileCard(
                      title: AppWord.street,
                      subtitle: controller.street,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppButton(
                        text: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppWord.saveChanges,
                                style: TextStyle(
                                  color: CustomColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                ),
                              ),
                              SizedBox(width: ScreenDimensions.widthPercentage(context, 2),),
                              SvgPicture.asset(AppImages.edit)
                            ]),
                        onTap: () {
                          controller.editProfile();
                          },
                        buttonBackground: AppImages.buttonLiteBackground)
                        .paddingSymmetric(
                        horizontal:
                        ScreenDimensions.widthPercentage(context, 5),
                        vertical:
                        ScreenDimensions.heightPercentage(context, 2)),
                  ],
                ).paddingSymmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 2),
                  vertical: ScreenDimensions.heightPercentage(context, 2),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
