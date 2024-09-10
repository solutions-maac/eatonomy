import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Data/Model/Location/LocationModel.dart';
import '../../../Data/Model/User/Chef.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/text_field_reamarks.dart';
import '../Map/location_picker.dart';



class ChefProfileUpdate extends StatefulWidget {
  final Chef? chef;
  ChefProfileUpdate({Key? key, this.chef}) : super(key: key);

  @override
  State<ChefProfileUpdate> createState() => _ChefProfileUpdateState();
}

class _ChefProfileUpdateState extends State<ChefProfileUpdate> {
  TextEditingController paymentInsController = TextEditingController();

  TextEditingController businessController = TextEditingController();

  TextEditingController aboutController = TextEditingController();

  TextEditingController addressTextController = new TextEditingController();

  TextEditingController cityTextController = new TextEditingController();

  TextEditingController zipCodeTextController = new TextEditingController();

  var chefController=Get.find<ChefController>();

  @override
  void initState() {
    // TODO: implement initState
    chefController.circleUpdateChef.value=false;
    chefController.location.value=widget.chef!.location!;
    chefController.name.value=widget.chef!.name??"";
    chefController.about.value=widget.chef!.about??"";
    chefController.paymentEmail.value=widget.chef!.paymentInstruction??"";
    chefController.address.value=widget.chef!.address??"";
    chefController.city.value=widget.chef!.city??"";
    chefController.zipCode.value=widget.chef!.zipCode??"";
    chefController.ppImageUrl.value=widget.chef!.profilePicture??"";
    chefController.imageUrl.value=widget.chef!.banner??"";
    chefController.ppFile=null;
    chefController.file=null;

    Logger().w(chefController.imageUrl.value);

    businessController.text=widget.chef!.name??"";
    aboutController.text=widget.chef!.about??"";
    paymentInsController.text=widget.chef!.paymentInstruction??"";
    addressTextController.text=widget.chef!.address??"";
    cityTextController.text=widget.chef!.city??"";
    zipCodeTextController.text=widget.chef!.zipCode??"";
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
            child: Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Chef Profile Edit',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<ChefController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.all(24),
              height: 1.0.sh,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Picture',
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 15,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        height: 180,
                        child: Stack(
                          children: [

                            controller.imageUrl.value!=""?
                            controller.file!=null?
                            Container(
                              height: 127,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                    image:FileImage(controller.file!=null?controller.file!:File(""),),
                                    fit: BoxFit.cover
                                ),
                                color: Color(0xFF0FFE6EAE6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ):
                            Container(
                              height: 127,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(controller.imageUrl.value),
                                    fit: BoxFit.cover
                                ),
                                color: Color(0xFF0FFE6EAE6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                                :
                            Container(
                              height: 127,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.chef!.banner!,),
                                    fit: BoxFit.cover
                                ),
                                color: Color(0xFFF1EDFC),
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 100,
                              left: 0.35.sw,
                              child:controller.ppImageUrl.value!=""?
                              controller.ppFile!=null?
                              Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(controller.ppFile!=null?controller.ppFile!:File("path"),),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              ):
                              Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(controller.ppImageUrl.value),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              )
                                  :
                              Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.chef!.profilePicture!),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 80,
                                left: 0.75.sw,
                                child: InkWell(
                                  onTap: () {
                                    controller.filepic(true);
                                  },
                                  child:controller.ppCirculer.value||controller.coverCirculer.value?
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: LoadingWidget(),
                                  )
                                      :
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEDFCEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/camera.svg",color: kPrimaryColorx,),
                                  ),
                                )
                            ),
                            Positioned(
                                top: 150,
                                left: 0.49.sw,
                                child:controller.ppCirculer.value||controller.coverCirculer.value?
                                Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: LoadingWidget(),
                                )
                                    :
                                InkWell(
                                  onTap: (){
                                    controller.filePPpic();
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(4),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEDFCEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/camera.svg",color: kPrimaryColorx,),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 8,),
                      Text(
                        'Business Name',
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 15,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: businessController,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        hintText: "Business name",
                        bgColor: textFieldBackground,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.name.value = "";
                          } else {
                            controller.name.value = text;
                          }
                        },
                        errormsg: "Please enter business name",
                        borderColor: textFieldBackground,),

                      SizedBox(height: 8,),
                      Text(
                        'Payment Instruction',
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 15,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12,),
                      BackgroundTextfield(
                        controller: paymentInsController,
                        readOnly: false,
                        isNumber: false,
                        isemail: false,
                        height: 46,
                        isValueChnged: true,
                        tap: (text) {
                          if (text.isEmpty) {
                            controller.paymentEmail.value = "";
                          } else {
                            controller.paymentEmail.value = text;
                          }
                        },
                        hintText: "Address",
                        bgColor: textFieldBackground,
                        errormsg: "Please enter  payment instruction",
                        borderColor: textFieldBackground,),

                      SizedBox(height: 8,),
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
                          height: 44,
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

                      SizedBox(height: 8,),
                      Text(
                        'About',
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 15,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12,),
                      SalesCreateRemarkTextfield(
                        readOnly: false,
                        isNumber: false,
                        hintText: "About",
                        lable: "",
                        controller: aboutController,
                        isValueChnged: true,
                        tap: (text){
                          if(text.isNotEmpty){
                            controller.about.value=text;
                          }else{
                            controller.about.value="";
                          }
                        },
                        maxLine: 4,
                      ),
                      SizedBox(height: 12,),


                    ],
                  ),
                  controller.circleUpdateChef.value?
                  LoadingWidget():
                  CustomButton(
                      height: 52,
                      orderRadius: 40,
                      color: kPrimaryColorx,
                      boder: false,
                      textColor: Colors.white,
                      title: "Update",
                      onTap: () {
                         controller.updateChef(widget.chef!.id!,context);
                        }
                      ),

                ],
              ),
            );
          });
        },
      ),
    );
  }
}