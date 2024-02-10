import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/colors/colors.dart';
import '../controller/edit_profile_controller.dart';
import '../../../core/components/components.dart';
import '../components/edit_profile_components.dart';

class EditProfile extends GetView<EditProfileController> {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    return SafeArea(
      child: Directions(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
          body: SingleChildScrollView(
            child: GetBuilder<EditProfileController>(
              builder: (_) {
                return Column(
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
                        child: controller.image ==null
                        ?Row(
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
                        )
                        :Image.file(controller.image!),
                      ),
                    ),
                    AppTextField(
                      title: AppWord.firstName,
                      controller: controller.firstNameController,
                      keyboardType: TextInputType.name,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                      title: AppWord.lastName,
                      controller: controller.lastNameController,
                      keyboardType: TextInputType.name,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                      title: AppWord.userName,
                      controller: controller.userNameController,
                      keyboardType: TextInputType.name,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    AppTextField(
                      title: AppWord.email,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppWord.phoneNumber,
                          style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: ScreenDimensions.heightPercentage(context, 2),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          width: ScreenDimensions.screenWidth(context),
                          height: ScreenDimensions.heightPercentage(context, 6),
                          padding: EdgeInsetsDirectional.all(
                              ScreenDimensions.radius(context, 1)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenDimensions.radius(context, 0.5)),
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[400]),
                          child: Text(
                            controller.phoneNumberController.text,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppWord.fullAddress,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: ScreenDimensions.screenWidth(context),
                          height: ScreenDimensions.heightPercentage(context, 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenDimensions.radius(context, 1)),
                            border: Border.all(color: CustomColors.grey1),
                          ),
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
                            onTap:controller.editProfile,
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
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
