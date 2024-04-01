import 'package:delayed_display/delayed_display.dart';
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
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
                    child: Column(
            children: [
              controller.listImagePath!.isNotEmpty
                  ?const SizedBox.shrink()
                  :DelayedDisplay(
                child: GestureDetector(
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
              ),
              controller.listImagePath!.isEmpty
                  ?const SizedBox.shrink()
                  :SizedBox(
                width: ScreenDimensions.screenWidth(context),
                height: ScreenDimensions.heightPercentage(context, 20),
                child: ListView.builder(
                  itemCount: controller.listImagePath!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return DelayedDisplay(
                      delay: Duration(milliseconds: (index+1)*100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.dialog(
                                barrierDismissible: true,
                                  Container(
                                    width: ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(context, 30),
                                    margin: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 20)),
                                    child: InteractiveViewer(
                                        child: Image.file(controller.listImagePath![index],),),
                                  ),);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenDimensions.widthPercentage(context, 20),
                              height: ScreenDimensions.heightPercentage(context, 10),
                              margin: EdgeInsets.symmetric(horizontal:ScreenDimensions.widthPercentage(context, 2),vertical: ScreenDimensions.heightPercentage(context, 0.5)),
                              decoration: BoxDecoration(
                                boxShadow: [
                                BoxShadow(blurStyle: BlurStyle.outer,color: CustomColors.shadow,spreadRadius: 1,blurRadius: 5),],
                                borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1))
                              ),
                              child: Image.file(controller.listImagePath![index],fit: BoxFit.contain,),

                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              controller.listImagePath!.removeAt(index);
                              controller.update();
                            },
                            child: Container(
                                width: ScreenDimensions.widthPercentage(context, 10),
                                height: ScreenDimensions.heightPercentage(context, 5),
                                decoration: BoxDecoration(border: Border.all(color: CustomColors.red),shape: BoxShape.circle),
                                child: Icon(Icons.delete,color: CustomColors.red,size: ScreenDimensions.widthPercentage(context, 6),)),
                          ),
                        ],
                      ),
                    );
                },),
              ),
              AppTextField(
                  onChanged: (value){
                    controller.descriptionController.text = value;
                    controller.update();
                  },
                      maxLines: 4,
                      controller: controller.descriptionController,
                      title: AppWord.productDescription,
                      validator: (value){
                    if (value.toString().isEmpty|| value == null){
                      return AppWord.empty;
                    } if(value.toString().length<9){
                      return AppWord.atLeast9Characters;
                    } if (value.toString().isNum){
                      return AppWord.notNumbersOnly;
                    }
                    return null;
                      },
                      keyboardType: TextInputType.text).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                  onChanged: (value){
                    controller.ageController.text = value;
                    controller.update();
                  },
                  hintText: '__ ${AppWord.years}',
                      controller: controller.ageController,
                      title: AppWord.productAge,
                      validator:(value){
                    if (value.toString().isEmpty||value==null){
                      return AppWord.empty;
                    }if(value.toString().isAlphabetOnly){
                      return AppWord.notOnlyAlphabetic;
                    }
                    return null;
                      } ,
                      keyboardType: TextInputType.text).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                onChanged: (value){
                  if (value.isEmpty){
                    controller.weight = 0;
                  }else{
                  controller.weightController.text = value;
                  controller.weight = double.parse(controller.weightController.text);
                  }
                  controller.update();
                },
                controller: controller.weightController,
                title: AppWord.productWeight,
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value.toString().isEmpty||value==null){
                    return AppWord.empty;
                  }if(!value.toString().isNum){
                    return AppWord.onlyNumbers;
                  } if (double.parse(value)<=0){
                    return AppWord.invalidValue;
                  }
                  return null;
                },
              ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppPopUpMenu(
                    title: controller.categoriesTitle,
                    items: controller.categoriesModel.map((e) => PopupMenuItem(
                      onTap: (){
                        controller.getSubcategories(categoryId: e.id);
                        controller.categoriesTitle = e.name;
                        controller.checkSubId = true;
                        controller.update();
                      },
                      value: e,
                      child: Text(
                        e.name,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context)),),),).toList(),

                    // onSelected: (value) {
                    //   controller.categoriesTitle = value.name;
                    //   controller.update();
                    //   controller.getSubcategories(categoryId: value.id);
                    //   controller.update();
                    // },
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
              controller.checkSubId?DelayedDisplay(
                slidingBeginOffset: const Offset(1,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppPopUpMenu(
                      title: controller.subcategoriesTitle,
                      items: controller.subcategoriesModel.map((e) => PopupMenuItem(value: e.name,
                        onTap: () {
                        controller.subcategoryId = e.id;
                        controller.subcategoriesTitle = e.name;
                        controller.update();
                        },
                        child: Text(
                          e.name,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context)),),)).toList(),
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
              ):const SizedBox.shrink(),
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
                controller: controller.caliberPriceValueController=TextEditingController(text: controller.caliberPrice.toString()),
                title: AppWord.theNetPrice,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  if (value.isEmpty){
                    controller.caliberPrice = 0;
                  }else {
                    controller.currentGoldPriceController.text = value;
                    controller.caliberPrice = int.parse(controller.currentGoldPriceController.text);
                  }
                  controller.update();
                },
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                onChanged: (value){
                  if (value.isEmpty){
                    controller.profit = 0;
                  }else{
                  controller.profitController.text = value;
                  controller.profit = double.parse(controller.profitController.text);
                  }
                  controller.update();
                },
                controller: controller.profitController,
                title: AppWord.theAddedCommission,
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value.toString().isEmpty|| value == null){
                    return AppWord.empty;
                  }if(!value.toString().isNum){
                    return AppWord.onlyNumbers;
                  } if (double.parse(value)<=0){
                    return AppWord.invalidValue;
                  }
                  return null;
                },
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                enabled: false,
                controller: controller.appCommissionController = TextEditingController(text: controller.appCommission.toString()),
                title: AppWord.platformCommission,
                keyboardType: TextInputType.number,
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(AppWord.additions,style: TextStyle(fontSize: AppFonts.smallTitleFont(context),fontWeight: FontWeight.bold),),
                Checkbox(
                    value: controller.additionCheck,
                    activeColor: CustomColors.gold,
                    onChanged: (value){
                  controller.additionCheck =value!;
                  if(controller.additionCheck==false){
                    controller.additionController.clear();
                    controller.additionDescriptionController.clear();
                  }
                  controller.update();
                }),
              ]).paddingSymmetric(
              vertical:  ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                onChanged: (value){
                  if (value.isEmpty){
                    controller.addition = 0;
                  }else{
                  controller.additionController.text = value;
                  controller.addition = double.parse(controller.additionController.text);
                  }
                  controller.update();
                },
                enabled: controller.additionCheck,
                controller: controller.additionController,
                      title: AppWord.anotherAddsPrice,
                      keyboardType: TextInputType.number,
                validator: (value){
                  if (controller.additionController.text.isNotEmpty){
                          if (!value.toString().isNum) {
                            return AppWord.onlyNumbers;
                          }
                          if (double.parse(value) <= 0) {
                            return AppWord.invalidValue;
                          }
                        }
                        return null;
                },
              ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                onChanged: (value){
                  controller.additionDescriptionController.text = value;
                  controller.update();
                },
                enabled: controller.additionCheck,
                maxLines: 3,
                controller: controller.additionDescriptionController,
                title: AppWord.anotherAddsDescription,
                keyboardType: TextInputType.text,
                validator: (value){
                  if (controller.additionDescriptionController.text.isNotEmpty){
                    if (value.toString().isNum) {
                      return AppWord.notNumbersOnly;
                    }
                  }
                  return null;
                },
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                controller: controller.totalGramPriceController = TextEditingController(
                    text:(controller.caliberPrice
                        + controller.appCommission
                        + controller.profit
                        +controller.addition
                    ).toInt().toString() ),
                enabled: false,
                title: AppWord.totalGramPrice,
                keyboardType: TextInputType.number,
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                controller: controller.totalProductPriceController = TextEditingController(text:(controller.weight * double.parse(controller.totalGramPriceController.text)).toInt().toString()),
                enabled: false,
                title: AppWord.totalProductPrice,
                keyboardType: TextInputType.number,
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              AppTextField(
                controller: controller.manufacturerController,
                      onChanged: (value){
                  controller.manufacturerController.text = value;
                  controller.update();
                      },
                      title: AppWord.manufacturer,
                      keyboardType: TextInputType.name,
              validator: (value){
                  if (value.toString().isEmpty|| value==null){
                    return AppWord.empty;
                  }
                    if (!value.toString().isNum) {
                      return AppWord.notNumbersOnly;
                    }
                    if (value.toString().length<5){
                      return AppWord.atLeast5Characters;
                    }
                  return null;

              },
              ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.changeColor();
                          controller.manufacturerType = 'international';
                          controller.update();
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
                          controller.manufacturerType = 'local';
                          controller.update();
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
                              if (value == false){
                                controller.discountToggle = 0;
                                controller.offerDescriptionController =TextEditingController(text: 'No offer');
                                controller.discountValueController = TextEditingController(text: '0');
                              }else{controller.discountToggle = 1;}
                              controller.checked();
                              controller.isChecked = value!;
                            },
                            activeColor: CustomColors.gold);
                      }),
                    ],
                  ),
                  AppTextField(
                    onChanged: (value){
                      controller.offerDescriptionController.text = value;
                      controller.update();
                    },
                    controller: controller.offerDescriptionController,
                    enabled: controller.isChecked,
                    title: AppWord.offerDescription,
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(controller.isChecked){
                      if (value.toString().isEmpty||value==null){
                          return AppWord.empty;
                        }
                      if(value.toString().isNum){
                        return AppWord.notNumbersOnly;
                      }
                      if (value.toString().length<5){
                        return AppWord.atLeast5Characters;
                      }
                      }
                      return null ;
                    },
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
                      enabled: controller.isChecked,
                      controller : controller.discountValueController,
                      onChanged: (value){
                        if (value.isEmpty){
                          controller.discountValue = 0;
                        }else{
                        controller.discountValueController.text = value;
                        controller.discountValue = double.parse(controller.discountValueController.text);
                        }
                        controller.update();
                      },
                      textAlign: TextAlign.right,
                      cursorColor: CustomColors.gold,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: CustomColors.gold)),
                          border: const OutlineInputBorder()),
                      validator: (value){
                        if(controller.isChecked){
                                if (value.toString().isEmpty || value == null) {
                                  return AppWord.empty;
                                }
                                if (!value.toString().isNum) {
                                  return AppWord.onlyNumbers;
                                }
                                if (double.parse(value) <= 0) {
                                  return AppWord.invalidValue;
                                }
                              }
                        return null;
                            },
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
                        if (value == false){
                          controller.toggle = 0;
                          controller.update();
                        }else{
                          controller.toggle = 1;
                        controller.update();
                        }
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
                  onTap: () {
                    if (!controller.formKey.currentState!.validate()){
                      return;
                    }
                    if(
                    controller.listImagePath!.isEmpty || controller.descriptionController.text.isEmpty
                    || controller.ageController.text.isEmpty || controller.weightController.text.isEmpty
                    || controller.subcategoryId == null || controller.caliberPriceValueController.text.isEmpty
                    || controller.profitController.text.isEmpty || controller.manufacturerController.text.isEmpty
                    ){
                      Get.snackbar(AppWord.warning, AppWord.checkAllRequiredFields);
                      return;
                    }else{
                      controller.currentGoldPriceController.text = controller.appCommission.toString();
                      Get.to(ProductPaymentMethod(
                        images: controller.listImagePath!,
                        descriptionController: controller.descriptionController,
                        ageController: controller.ageController,
                        weightController: controller.weightController,
                        subcategoryId: controller.subcategoryId!,
                        caliber: controller.calibers,
                        profitController: controller.profitController,
                        caliberPriceValue: double.parse(controller.caliberPriceValueController.text),
                        additionController: controller.additionController,
                        additionDescriptionController: controller.additionDescriptionController.text.isEmpty?controller.additionDescriptionController=TextEditingController(text: 'no additions'):controller.additionDescriptionController,
                        manufacturerController: controller.manufacturerController,
                        manufacturerType: controller.manufacturerType,
                        discountToggle: controller.isChecked,
                        discountDescriptionController: controller.offerDescriptionController.text.isEmpty?controller.offerDescriptionController=TextEditingController(text: 'no offers'):controller.additionDescriptionController,
                        discountValueController: controller.discountValueController.text.isEmpty?controller.discountValueController = TextEditingController(text: controller.discountValue.toString()):controller.discountValueController,
                        toggle: controller.toggle,
                      ),transition: Transition.fade,duration: const Duration(milliseconds: 500));}
                    },
                  buttonBackground: AppImages.buttonLiteBackground).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 3)),
            ],).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5),),),
          ));
    });
  }
}
