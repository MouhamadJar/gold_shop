import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/components/components.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../edit_profile/components/edit_profile_components.dart';
import 'verify_account_screen.dart';

class MediatorSignupScreen extends StatelessWidget {
  const MediatorSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: ScreenDimensions.screenHeight(context),
            width: ScreenDimensions.screenWidth(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: const [0, 0.5],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    //CustomColors().grey,
                    CustomColors.grey1,
                    CustomColors.black
                  ]),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -ScreenDimensions.heightPercentage(context, 80),
                  left: -ScreenDimensions.widthPercentage(context, 55),
                  right: -ScreenDimensions.widthPercentage(context, 50),
                  bottom: -ScreenDimensions.heightPercentage(context, 60),
                  child: SvgPicture.asset(
                    AppImages.splashScreen,
                    //fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: ScreenDimensions.heightPercentage(context, 5),
                  child: DelayedDisplay(
                    slidingBeginOffset: const Offset(0, 10),
                    delay: const Duration(milliseconds: 150),
                    child: CircleAvatar(
                      radius: ScreenDimensions.widthPercentage(context, 18),
                      backgroundColor: CustomColors.white,
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                            color: CustomColors.gold,
                            fontSize: AppFonts.titleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: ScreenDimensions.heightPercentage(context, 70),
                    width: ScreenDimensions.screenWidth(context),
                    padding: EdgeInsets.symmetric(
                        vertical:
                            ScreenDimensions.heightPercentage(context, 3)),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          ScreenDimensions.radius(context, 5),
                        ),
                        topLeft: Radius.circular(
                          ScreenDimensions.radius(context, 5),
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                          ),
                          Text(
                            AppWord.createAccount,
                            style: TextStyle(
                              fontSize: AppFonts.subTitleFont(context),
                            ),
                          ).marginSymmetric(
                              vertical: ScreenDimensions.heightPercentage(
                                  context, 3)),
                          AppTextField(
                            title: AppWord.mediatorFirstName,
                            keyboardType: TextInputType.name,
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          AppTextField(
                            title: AppWord.email,
                            keyboardType: TextInputType.emailAddress,
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          AppTextField(
                            title: AppWord.phoneNumber,
                            keyboardType: TextInputType.phone,
                            suffix: const Icon(Icons.call),
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          AppTextField(
                            title: AppWord.backupPhoneNumber,
                            keyboardType: TextInputType.phone,
                            suffix: const Icon(Icons.call),
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_box,
                                color: CustomColors.gold,
                                size: ScreenDimensions.widthPercentage(
                                    context, 8),
                              ),
                            ),
                          ).marginSymmetric(
                              horizontal:
                                  ScreenDimensions.widthPercentage(context, 3)),
                          AppTextField(
                            title: AppWord.password,
                            keyboardType: TextInputType.name,
                            suffix: const Icon(Icons.lock),
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          AppTextField(
                            title: AppWord.serviceValue,
                            keyboardType: TextInputType.name,
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 2)),
                          AppTextField(
                            title: AppWord.address,
                            keyboardType: TextInputType.phone,
                            maxLines: 5,
                          )
                              .paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5))
                              .marginOnly(
                                  bottom: ScreenDimensions.heightPercentage(
                                      context, 5)),
                          Directions(
                            child: EditProfileCard(
                              title: AppWord.area,
                              subtitle: AppWord.area,
                            ),
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          Directions(
                            child: EditProfileCard(
                              title: AppWord.state,
                              subtitle: AppWord.state,
                            ),
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          Directions(
                            child: EditProfileCard(
                              title: AppWord.city,
                              subtitle: AppWord.city,
                            ),
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          Directions(
                            child: EditProfileCard(
                              title: AppWord.neighborhood,
                              subtitle: AppWord.neighborhood,
                            ),
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          Directions(
                            child: EditProfileCard(
                              title: AppWord.street,
                              subtitle: AppWord.street,
                            ),
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (_) {},
                                activeColor: CustomColors.gold,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppWord.acceptTerms,
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${AppWord.terms}',
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).marginOnly(
                              bottom: ScreenDimensions.heightPercentage(
                                  context, 5)),
                          AppButton(
                              text: Text(
                                AppWord.createAccount,
                                style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.white,
                                ),
                              ),
                              onTap: () {
                                Get.to(
                                  const VerifyMediatorAccount(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              buttonBackground: AppImages.buttonLiteBackground),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppWord.alreadyHaveAccount,
                                    style: TextStyle(
                                      fontSize:
                                          AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppWord.login,
                                    style: TextStyle(
                                      fontSize:
                                          AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.gold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: CustomColors.gold,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginSymmetric(
                                vertical: ScreenDimensions.heightPercentage(
                                    context, 2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
