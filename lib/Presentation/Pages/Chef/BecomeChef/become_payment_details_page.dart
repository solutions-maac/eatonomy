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

class BusinessPaymentDetails extends StatelessWidget {
  const BusinessPaymentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Payment Details',),
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
              return Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please add your email address where you want to get your payment.',
                        style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 13,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,

                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: null,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        hintText: "Payment Instruction",
                        bgColor: textFieldBackground,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.paymentEmail.value = "";
                          } else {
                            controller.paymentEmail.value = text;
                          }
                        },
                        errormsg: "Please enter email",
                        borderColor: textFieldBackground,),
                    ],
                  ),


                  CustomButton(height: 52,
                      orderRadius: 40,
                      color:controller.paymentEmail.value==""?Color(0xFFBCC3C0): kPrimaryColorx,
                      boder: false,
                      textColor: Colors.white,
                      title: "Next",
                      onTap: () {
                        if(controller.paymentEmail.value!=""){
                          Logger().w( controller.name.value);
                          Navigator.pushNamed(context, BEACOME_SHEF_OTHER_DETAILS_PAGE);

                        }

                      }),

                ],
              );
            }),
          );
        },
      ),
    );
  }
}

