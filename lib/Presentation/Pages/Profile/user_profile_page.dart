import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../../GetX Controller/Map/MapController.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';


class UserProfilePage extends StatefulWidget {

  final String? name,email,mobile,image,address,city,zipcode;

  UserProfilePage({Key? key, this.name, this.email, this.mobile, this.image, this.address, this.city, this.zipcode,}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _globalkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController addressTextController = new TextEditingController();

  TextEditingController cityTextController = new TextEditingController();

  TextEditingController zipCodeTextController = new TextEditingController();

  var localBd=getIt<LocalDataGet>();

  var authController= Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    authController.onInit();
    nameController.text=widget.name??"";
    mobileController.text=widget.mobile??"";
    emailController.text=widget.email??"";
    authController.imageUrl.value=widget.image??"";
    addressTextController.text= widget.address??"";
    cityTextController.text=widget.city??"";
    zipCodeTextController.text=widget.zipcode??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text("Profile Edit",),
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
                ),
                backgroundColor: const Color(0XFFFFFFFF),
                body: SingleChildScrollView(
                  child: Container(

                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: _globalkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16,),
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
                              Row(
                                children: [
                                  controller.filePath.value==""?
                                  Container(
                                    width: 55,
                                    height: 55,
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      color: textFieldBorder,
                                      image: DecorationImage(
                                          image: NetworkImage(widget.image??""),
                                          fit: BoxFit.cover
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                    ),

                                  ):
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: FileImage(File(controller.filePath.value)),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: 16.w,),
                                  InkWell(
                                    onTap: (){
                                      controller.filepic();
                                    },
                                    child: Container(
                                      width: 111,
                                      height: 26,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFEDFCEF),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Opacity(
                                            opacity: 0.90,
                                            child: Text(
                                              'Image Upload Here',
                                              style: TextStyle(
                                                color: Color(0xFF00934C),
                                                fontSize: 10,
                                                fontFamily: 'Satoshi',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12,),
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Color(0xFF01180D),
                                  fontSize: 15,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 12,),
                              BackgroundTextfield(
                                height: 65,
                                controller: nameController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Name",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),


                              SizedBox(height: 16,),
                              Text(
                                'Contact Info',
                                style: TextStyle(
                                  color: Color(0xFF01180D),
                                  fontSize: 15,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 12,),
                              BackgroundTextfield(
                                height: 65,
                                controller: emailController,
                                readOnly: true,
                                isNumber: false,
                                isemail: true,
                                hintText: "Email",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),
                              SizedBox(height: 12,),
                              BackgroundTextfield(
                                height: 65,
                                controller: mobileController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Mobile",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),


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
                                height: 65,
                                controller: addressTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Address",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),
                              SizedBox(height: 12,),
                              BackgroundTextfield(
                                height: 65,
                                controller: cityTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "City/Town",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),
                              SizedBox(height: 12,),
                              BackgroundTextfield(
                                height: 65,
                                controller: zipCodeTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Zip Code",
                                bgColor: textFieldBorder,
                                borderColor: textFieldBorder,),




                              SizedBox(height: 20,),

                            ],
                          ),
                        ),

                      controller.circuler.value||controller.tokenReseting.value?LoadingWidget():
                      CustomButton(height: 52,
                            orderRadius: 40,
                            color: kPrimaryColorx,
                            textColor: Colors.white,
                            title: "Update Profile",
                            onTap: () {
                              if (_globalkey.currentState!.validate()) {
                                controller.updateUser(
                                    mobile:mobileController.text,
                                    email: widget.email!,
                                    zipcode: zipCodeTextController.text,
                                    city: cityTextController.text,
                                    address: addressTextController.text,
                                    name: nameController.text,
                                    context: context,
                                );
                              }
                            }),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}


