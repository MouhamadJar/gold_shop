
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/components/maps.dart';
import '../../../../core/validator/app_validator.dart';
import '../../../privacy/view/privacy_view.dart';
import '../../controller/mediator_shop/register_controller.dart';
import '../../../../core/components/components.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../edit_profile/components/edit_profile_components.dart';

class MediatorSignupScreen extends GetView<RegisterMediatorShopController> {
   const MediatorSignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterMediatorShopController());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<RegisterMediatorShopController>(
          builder: (_) {
            return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
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
                              vertical: ScreenDimensions.heightPercentage(context, 3)),
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
                                Align(
                                  child: Text(
                                    AppWord.createMediatorAccountRequest,
                                    style: TextStyle(
                                      fontSize:
                                      AppFonts.subTitleFont(context),
                                    ),
                                  ).marginSymmetric(
                                      vertical: ScreenDimensions.heightPercentage(
                                          context, 3)),
                                ),
                                AppTextField(
                                  controller: controller.nameController,
                                  title: AppWord.mediatorName,
                                  hintText: AppWord.atLeast6Characters,
                                  suffix:  Icon(Icons.person,color: controller.nameController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.name,
                                  validator: (value) => AppValidator().nameValidator(value),
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.emailController,
                                  title: AppWord.email,
                                  hintText: '___@gmail.com',
                                  suffix:  Icon(Icons.email,color: controller.emailController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => AppValidator().emailValidator(value),
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.phoneController,
                                  title: AppWord.phoneNumber,
                                  hintText: '05********',
                                  keyboardType: TextInputType.number,
                                  suffix:  Icon(Icons.call,color: controller.phoneController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  validator: (value)
                                  {
                                    if(value==null||value.toString().isEmpty){
                                      return AppValidator().phoneValidator(value);
                                    }
                                    if (value!=null||value.toString().isNotEmpty){
                                      controller.phoneNumber = value.toString().characters.toList();
                                    if (controller.phoneNumber[0] != '0' ||
                                        controller.phoneNumber[1] != '5') {
                                      return AppWord.mustStartWith05;
                                    }else{
                                      return AppValidator().phoneValidator(value);
                                    }
                                  }
                                    return '';
                                    },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.descriptionController,
                                  title: AppWord.mediatorDescription,
                                  hintText: AppWord.atLeast9Characters,
                                  suffix:  Icon(Icons.description,color: controller.descriptionController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value== null || value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyDescription);
                                      return AppWord.emptyDescription;
                                    }
                                    if(value.toString().isNum){
                                      ControllerSnackBar(errorMessage: AppWord.descriptionShouldNotBeOnlyNumbers);
                                      return AppWord.descriptionShouldNotBeOnlyNumbers;
                                    }
                                    if(value.toString().length < 9){
                                      ControllerSnackBar(errorMessage: AppWord.descriptionMustBeAtLeast9);
                                      return AppWord.descriptionMustBeAtLeast9;
                                    }
                                    return null;
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.nationalNumberController,
                                  title: AppWord.identifierNumber,
                                  hintText: '1*********',
                                  suffix:  Icon(Icons.person,color: controller.nationalNumberController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    controller.numbers = value.toString().characters.toList();
                                    if (value== null || value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyIdentifierNumber);
                                      return AppWord.emptyIdentifierNumber;
                                    }
                                    if(!value.toString().isNum){
                                      return AppWord.onlyNumbers;
                                    }
                                    if(value.toString().length != 10){
                                      return AppWord.identifierMustBe10;
                                    }
                                    if (controller.numbers.first != '1'){
                                      controller.numbers.clear();
                                      controller.nationalNumberController.text = '';
                                      controller.update();
                                      ControllerSnackBar(errorMessage: AppWord.identifierMustStartWith1);
                                      return AppWord.identifierMustStartWith1;
                                    }
                                    return null;
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.commercialRegisterController,
                                  title: AppWord.commercialRegisterNumber,
                                  hintText:AppWord.only10Characters,
                                  suffix:  Icon(Icons.app_registration,color: controller.commercialRegisterController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value== null || value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyCommercialRegister);
                                      return AppWord.emptyCommercialRegister;
                                    }
                                    if(!value.toString().isNum){
                                      return AppWord.onlyNumbers;
                                    }
                                    if(!(value.toString().length == 10)){
                                      ControllerSnackBar(errorMessage: AppWord.commercialRegisterMustBe10);
                                      return AppWord.commercialRegisterMustBe10;
                                    }
                                    return null;
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.licenseController,
                                  title: AppWord.license,
                                  hintText:AppWord.only10Characters,
                                  suffix:  Icon(Icons.done,color: controller.licenseController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value== null || value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyLicense);
                                      return AppWord.emptyLicense;
                                    }
                                    if(!value.toString().isNum){
                                      return AppWord.onlyNumbers;
                                    }
                                    if(!(value.toString().length ==10) ){
                                      ControllerSnackBar(errorMessage: AppWord.licenseMustBe10);
                                      return AppWord.licenseMustBe10;
                                    }
                                    return null;
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.pickCommercialRegisterImage,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: ScreenDimensions.widthPercentage(context, 30),
                                            height: ScreenDimensions.heightPercentage(context, 15),
                                            padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 2)),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 10  ,blurStyle:BlurStyle.outer ,color: CustomColors.shadow
                                                ),],
                                            ),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.cloud_upload_outlined,size: ScreenDimensions.widthPercentage(context, 8)),
                                                Text(
                                                  AppWord.uploadCommercialRegisterPicture,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                      fontSize: AppFonts.smallTitleFont(context)),),
                                              ],
                                            ),),
                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 2000),
                                          width: ScreenDimensions.widthPercentage(context, 10),
                                          height: ScreenDimensions.heightPercentage(context, 5),
                                          decoration: BoxDecoration(
                                              color: controller.isCommercialUploaded?CustomColors.gold:CustomColors.white,
                                              shape: BoxShape.circle,
                                            border: Border.all(color: controller.isCommercialUploaded?CustomColors.gold:CustomColors.black)
                                          ),
                                          child: Icon(controller.isCommercialUploaded?Icons.done_all:Icons.remove_done,color: controller.isCommercialUploaded?CustomColors.white:CustomColors.black,),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.pickLicenseImage,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: ScreenDimensions.widthPercentage(context, 30),
                                            height: ScreenDimensions.heightPercentage(context, 15),
                                            padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 2)),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 10  ,blurStyle:BlurStyle.outer ,color: CustomColors.shadow
                                                ),],
                                            ),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.cloud_upload_outlined,size: ScreenDimensions.widthPercentage(context, 8)),
                                                Text(
                                                  AppWord.uploadLicensePicture,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: AppFonts.smallTitleFont(context)),),
                                              ],
                                            ),),
                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 2000),
                                          width: ScreenDimensions.widthPercentage(context, 10),
                                          height: ScreenDimensions.heightPercentage(context, 5),
                                          decoration: BoxDecoration(
                                              color: controller.isLicenseUploaded?CustomColors.gold:CustomColors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: controller.isLicenseUploaded?CustomColors.gold:CustomColors.black)
                                          ),
                                          child: Icon(controller.isLicenseUploaded?Icons.done_all:Icons.remove_done,color: controller.isLicenseUploaded?CustomColors.white:CustomColors.black,),
                                        ),
                                      ],
                                    ),
                                  ],)
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5),vertical: ScreenDimensions.heightPercentage(context, 2))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppTextField(
                                  controller: controller.taxCertificateController,
                                  title: AppWord.taxNumber,
                                  suffix:  Icon(Icons.monetization_on_outlined,color: controller.licenseController.text.isEmpty?Colors.black:CustomColors.gold,),
                                  hintText: AppWord.only15Characters,
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyTaxNumber);
                                      return AppWord.emptyTaxNumber;
                                    }
                                    if(!value.toString().isNum){
                                      return AppWord.onlyNumbers;
                                    }
                                    if(!(value.toString().length ==15) ){
                                      ControllerSnackBar(errorMessage: AppWord.taxNumberMustBe15);
                                      return AppWord.taxNumberMustBe15;
                                    }
                                    return null;
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.pickTaxCertificate,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: ScreenDimensions.widthPercentage(context, 30),
                                            height: ScreenDimensions.heightPercentage(context, 15),
                                            padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 2)),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 10  ,blurStyle:BlurStyle.outer ,color: CustomColors.shadow
                                                ),],
                                            ),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.cloud_upload_outlined,size: ScreenDimensions.widthPercentage(context, 8)),
                                                Text(
                                                  AppWord.taxAssignmentCertificate,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: AppFonts.smallTitleFont(context)),),
                                              ],
                                            ),),
                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 2000),
                                          width: ScreenDimensions.widthPercentage(context, 10),
                                          height: ScreenDimensions.heightPercentage(context, 5),
                                          decoration: BoxDecoration(
                                              color: controller.isTaxCertificateUploaded?CustomColors.gold:CustomColors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: controller.isTaxCertificateUploaded?CustomColors.gold:CustomColors.black)
                                          ),
                                          child: Icon(controller.isTaxCertificateUploaded?Icons.done_all:Icons.remove_done,color: controller.isCommercialUploaded?CustomColors.white:CustomColors.black,),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.pickShopImage,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: ScreenDimensions.widthPercentage(context, 30),
                                            height: ScreenDimensions.heightPercentage(context, 15),
                                            padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 2)),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 10  ,blurStyle:BlurStyle.outer ,color: CustomColors.shadow
                                                ),],
                                            ),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.cloud_upload_outlined,size: ScreenDimensions.widthPercentage(context, 8)),
                                                Text(
                                                  AppWord.uploadShopImage,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: AppFonts.smallTitleFont(context)),),
                                              ],
                                            ),),
                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 2000),
                                          width: ScreenDimensions.widthPercentage(context, 10),
                                          height: ScreenDimensions.heightPercentage(context, 5),
                                          decoration: BoxDecoration(
                                              color: controller.isShopImageUploaded?CustomColors.gold:CustomColors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: controller.isShopImageUploaded?CustomColors.gold:CustomColors.black)
                                          ),
                                          child: Icon(controller.isShopImageUploaded?Icons.done_all:Icons.remove_done,color: controller.isShopImageUploaded?CustomColors.white:CustomColors.black,),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5),vertical: ScreenDimensions.heightPercentage(context, 2))
                                .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                AppGoogleMap(
                                  markers: controller.markers,
                                  cameraPosition: controller.position,
                                  onTap: controller.zoomed ? controller.onGoogleMapTapped:(latLng){
                                    controller.update();
                                    ControllerSnackBar(errorMessage: AppWord.pleaseZoomIn,errorTitle: AppWord.warning);
                                    },
                                  onCameraMoved: (cameraPosition){
                                    if (cameraPosition.zoom>=17.0&&cameraPosition.zoom<17.5){
                                     controller.zoomed = true;
                                     controller.update();
                                    }if(cameraPosition.zoom<=16.9&&cameraPosition.zoom>16.5){
                                     controller.zoomed = false;
                                     controller.update();
                                    }
                                  },
                                )
                                    .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Directions(
                                  child: EditProfileCard(
                                    title: AppWord.area,
                                    subtitle: controller.country,
                                  ),
                                )
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Directions(
                                  child: EditProfileCard(
                                    title: AppWord.state,
                                    subtitle: controller.state,
                                  ),
                                )
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Directions(
                                  child: EditProfileCard(
                                    title: AppWord.city,
                                    subtitle: controller.city,
                                  ),
                                )
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Directions(
                                  child: EditProfileCard(
                                    title: AppWord.neighborhood,
                                    subtitle: controller.neighborhood,
                                  ),
                                )
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Directions(
                                  child: EditProfileCard(
                                    title: AppWord.street,
                                    subtitle: controller.street,
                                  ),
                                )
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 5)),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.isChecked,
                                      onChanged: (value) {
                                        controller.isChecked = value!;
                                        controller.update();
                                      },
                                      fillColor: controller.isChecked?MaterialStatePropertyAll(CustomColors.gold):MaterialStatePropertyAll(CustomColors.silver),
                                      activeColor: CustomColors.gold,).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                                    Text( AppWord.acceptTerms,
                                      style: TextStyle(
                                        fontSize: AppFonts
                                            .smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.black,
                                      ),),
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(const Privacy(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                                      },
                                      child: SizedBox(
                                        child: Text(' ${AppWord.terms}',
                                          style: TextStyle(
                                            fontSize: AppFonts.smallTitleFont(context),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ).marginOnly(
                                    bottom: ScreenDimensions.heightPercentage(context, 5)),
                                !controller.isChecked
                                    ? AppButton(
                                    text: Text(
                                      AppWord.sendRequest,
                                      style: TextStyle(
                                        fontSize: AppFonts.smallTitleFont(
                                            context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.white,
                                      ),
                                    ), onTap: (){}, buttonBackground: AppImages.buttonDarkBackground).marginSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 20))
                                    : AppButton(
                                  text: Text(
                                    AppWord.sendRequest,
                                    style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(
                                          context),
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.white,
                                    ),
                                  ),
                                  onTap: (){
                                    if(!(controller.formKey.currentState!.validate())){
                                      return;
                                    }
                                    Get.dialog(WillPopScope(child: Center(child: CircularProgressIndicator(color: CustomColors.gold,),), onWillPop: ()async{
                                      return false;
                                    }),barrierDismissible: false);
                                    controller.register();
                                  },
                                  buttonBackground: AppImages.buttonLiteBackground,).marginSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 20)),
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
                                            fontSize: AppFonts.smallTitleFont(
                                                context),
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: AppWord.loginAsMediatorShop,
                                          style: TextStyle(
                                            fontSize: AppFonts.smallTitleFont(
                                                context),
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.gold,
                                            decoration:
                                            TextDecoration.underline,
                                            decorationColor:
                                            CustomColors.gold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      .marginSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Directions(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: BackArrow(color: CustomColors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
