import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/TextField/bg_textfield.dart';

class BusinessOtherDetails extends StatefulWidget {
  BusinessOtherDetails({Key? key}) : super(key: key);

  @override
  State<BusinessOtherDetails> createState() => _BusinessOtherDetailsState();
}

class _BusinessOtherDetailsState extends State<BusinessOtherDetails> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Other Details',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<ChefController>(
        assignId: true,
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 18),
            width: 1.0.sw,
            height: 1.0.sh,
            child: Obx(() {
              return Form(
                key: formKey,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share your overall cooking experience that help to get more order from customer',
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 16,),
                        Text(
                            "Year Of Experience",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        SizedBox(height: 12,),
                        BackgroundTextfield(
                          controller: null,
                          readOnly: false,
                          isNumber: true,
                          isemail: false,
                          height: 46,
                          hintText: "Year Of Experience",
                          bgColor: textFieldBackground,
                          isValueChnged: true,
                          tap: (text) {
                            if (text.isEmpty) {
                              controller.experince.value = "";
                            } else {
                              controller.experince.value = text;
                            }
                          },
                          errormsg: "Please enter experience",
                          borderColor: textFieldBackground,
                        ),
                        SizedBox(height: 32,),
                        Text(
                            "What’s your cuisine choice?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        SizedBox(height: 16,),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 12/2
                          ),
                          itemCount: controller.cuisineList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                if(controller.selectCuisine.value.contains(controller.cuisineList[index])){
                                  controller.selectCuisine.value.removeWhere((element) => element==controller.cuisineList[index]);
                                  controller.update();
                                }else{
                                  controller.selectCuisine.value.add(controller.cuisineList[index]);
                                  controller.update();
                                }
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height:24,
                                      width:24,
                                      child: Checkbox(
                                          side: BorderSide(color: Color(0xFF0FFD9D9D9)),
                                        activeColor: kPrimaryColorx,
                                          value: controller.selectCuisine.value.contains(controller.cuisineList[index]),
                                          onChanged: (cc){
                                            if(controller.selectCuisine.value.contains(controller.cuisineList[index])){
                                              controller.selectCuisine.value.removeWhere((element) => element==controller.cuisineList[index]);
                                              controller.update();
                                            }else{
                                              controller.selectCuisine.value.add(controller.cuisineList[index]);
                                              controller.update();
                                            }
                                          }
                                        ),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                        controller.cuisineList[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        )
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )

                      ],

                    ),


                    CustomButton(height: 52,
                        orderRadius: 40,
                        color:controller.experince.value==""||controller.selectCuisine.value.isEmpty?Color(0xFFBCC3C0): kPrimaryColorx,
                        boder: false,
                        textColor: Colors.white,
                        title: "Next",
                        onTap: () {
                          if(controller.experince.value!=""&&controller.selectCuisine.value.isNotEmpty){
                            Logger().w( controller.name.value);
                            if (formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, BEACOME_SHEF_PROFILE_PAGE);
                            }
                          }

                        }),

                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

