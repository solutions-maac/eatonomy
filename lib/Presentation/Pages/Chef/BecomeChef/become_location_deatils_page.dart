import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../../GetX Controller/Map/MapController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';
import '../../Map/location_picker.dart';

class ChefLocationDetailsPage extends StatefulWidget {
  ChefLocationDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChefLocationDetailsPage> createState() => _ChefLocationDetailsPageState();
}

class _ChefLocationDetailsPageState extends State<ChefLocationDetailsPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController addressTextController = new TextEditingController();

  TextEditingController cityTextController = new TextEditingController();

  TextEditingController zipCodeTextController = new TextEditingController();

   final controller =Get.find<ChefController>();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,(){
      controller.locatioCirculer.value = true;
      Get.find<MapController>().getLocationName().then((value) {
        Logger().e( value);
        Future.delayed(Duration.zero,(){
          Get.find<MapController>().locationNameService.getLocationName(value!.latitude, value.longitude).then((valuex) {
            controller.locatioCirculer.value = false;
            addressTextController.text = valuex![0].locality.toString() + ", " + valuex[0].subLocality.toString();
            controller.address.value = valuex[0].locality.toString() + ", " + valuex[0].subLocality.toString();
            controller.city.value = valuex[0].subAdministrativeArea.toString();
            controller.zipCode.value = valuex[0].postalCode.toString();
            controller.location.value = value;
            cityTextController.text = valuex[0].subAdministrativeArea.toString();
            zipCodeTextController.text = valuex[0].postalCode.toString();
            controller.update();
          });
        });
      });
    });
    super.initState();
  }

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
        title: Text('Location Details',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<ChefController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 18),
              height: 1.0.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  controller.locatioCirculer.value?LoadingWidget():
                  ListView(
                    shrinkWrap: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Use your location details with zip code, that helps to find you.',
                        style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 13,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,

                        ),
                      ),


                      SizedBox(height: 16,),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 15,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: addressTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.address.value = "";
                          } else {
                            controller.address.value = text;
                          }
                        },
                        hintText: "Address",
                        bgColor: textFieldBackground,
                        errormsg: "Please enter  Address",
                        borderColor: textFieldBackground,),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: cityTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.city.value = "";
                          } else {
                            controller.city.value = text;
                          }
                        },
                        hintText: "City/Town",
                        bgColor: textFieldBackground,
                        errormsg: "Please enter City/Town",
                        borderColor: textFieldBackground,),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: zipCodeTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.zipCode.value = "";
                          } else {
                            controller.zipCode.value = text;
                          }
                        },
                        hintText: "Zip Code",
                        bgColor: textFieldBackground,
                        errormsg: "Please enter Zip Code",
                        borderColor: textFieldBackground,),
                      SizedBox(height: 12,),
                      CustomButton(
                          height: 52,
                          orderRadius: 8,
                          color: kPrimaryColorx,
                          boder: false,
                          textColor: Colors.white,
                          title: "Pick Location",
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MapLocationPicker(
                                          addressTextController: addressTextController,
                                          cityTextController: cityTextController,
                                          zipCodeTextController: zipCodeTextController,)
                                )
                            );
                          }),


                    ],
                  ),
                  SizedBox(height: 40,),
                  CustomButton(
                      height: 52,
                      orderRadius: 40,
                      color:
                          controller.zipCode.value == "" ||
                          controller.address.value == "" ||
                          controller.city.value == ""
                          ? Color(0xFFBCC3C0)
                          : kPrimaryColorx,
                      boder: false,
                      textColor: Colors.white,
                      title: "Next",
                      onTap: () {
                        if(
                            controller.zipCode.value == "" ||
                            controller.address.value == "" ||
                            controller.city.value == ""){

                        }else{
                          Navigator.pushNamed(
                              context, BEACOME_PAYMENT_DETAILS_PAGE);
                        }

                      }),

                ],
              ),
            );
          });
        },
      ),
    );
  }
}

