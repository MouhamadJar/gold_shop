import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import '../components/my_sells_filter_components.dart';

class MySellsFilter extends StatelessWidget {
  const MySellsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController1 = TextEditingController();
    TextEditingController priceController2 = TextEditingController();
    TextEditingController dateController1 = TextEditingController();
    TextEditingController dateController2 = TextEditingController();
    return SafeArea(
        child: Directions(
          child: Scaffold(
            backgroundColor: CustomColors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: CustomColors.white,
              title: Text(
                AppWord.mySellsFilter,
                style: TextStyle(
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.screenHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MySellsDropDownMenu(
                            title: '', items: const [], onSelected: (value) {}),
                        SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 10),
                        ),
                        Text(
                          AppWord.productCategory,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MySellsDropDownMenu(
                            title: '', items: const [], onSelected: (value) {}),
                        SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 10),
                        ),
                        Text(
                          AppWord.productClassification,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 40),
                                  height:
                                  ScreenDimensions.heightPercentage(context, 3),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Directions(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (int.parse(value) >
                                            int.parse(priceController2.text)) {
                                          priceController1.text =
                                              priceController2.text;
                                        }
                                      },
                                      controller: priceController1,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 2),
                                ),
                                Text(
                                  AppWord.from,
                                  style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: ScreenDimensions.heightPercentage(context, 2),
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 40),
                                  height:
                                  ScreenDimensions.heightPercentage(context, 3),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (int.parse(value) <
                                          int.parse(priceController1.text)) {
                                        priceController2.text =
                                            priceController1.text;
                                      }
                                    },
                                    controller: priceController2,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 2),
                                ),
                                Text(
                                  AppWord.to,
                                  style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppWord.price,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 40),
                                  height:
                                  ScreenDimensions.heightPercentage(context, 3),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Directions(
                                    child: TextFormField(
                                      onChanged: (value) {},
                                      controller: dateController1,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.datetime,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 2),
                                ),
                                Text(
                                  AppWord.from,
                                  style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: ScreenDimensions.heightPercentage(context, 2),
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 40),
                                  height:
                                  ScreenDimensions.heightPercentage(context, 3),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: TextFormField(
                                    onChanged: (value) {},
                                    controller: dateController2,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  ScreenDimensions.widthPercentage(context, 2),
                                ),
                                Text(
                                  AppWord.to,
                                  style: TextStyle(
                                      fontSize: AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppWord.sellDate,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MySellsDropDownMenu(
                            title: '', items: const [], onSelected: (value) {}),
                        SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 10),
                        ),
                        Text(
                          AppWord.productState,
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                  const Spacer(),
                  Center(
                      child: AppButton(
                          text: Text(
                            AppWord.search,
                            style: TextStyle(
                              color: CustomColors.white,
                              fontSize: AppFonts.smallTitleFont(context),
                            ),
                          ),
                          onTap: () {},
                          buttonBackground: AppImages.buttonLiteBackground))
                ],
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 3),
                  horizontal: ScreenDimensions.widthPercentage(context, 3)),
            ),
          ),
        ));
  }
}
