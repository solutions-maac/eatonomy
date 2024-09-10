import 'dart:io';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eatonomy/GetX%20Controller/Home/HomeController.dart';
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
import '../../../Data/Model/Auth/LoginResponse.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../../GetX Controller/Map/MapController.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';


class InfoPage extends StatefulWidget {
  final String? email, mobile, otp;

  InfoPage({Key? key, this.email, this.mobile, this.otp}) : super(key: key);



  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  static final _globalkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController addressTextController = new TextEditingController();

  TextEditingController cityTextController = new TextEditingController();

  TextEditingController zipCodeTextController = new TextEditingController();

  var localBd=getIt<LocalDataGet>();


  @override
  void initState() {
    // TODO: implement initState
    emailController.text=widget.email!;
    mobileController.text=widget.mobile!;
    Get.find<AuthController>().onInit();
    Get.find<MapController>().getLocationName().then((value) {
      Get.find<MapController>().loadLoaction.value=true;
      Get.find<MapController>().locationNameService.getLocationName(value!.latitude, value.longitude).then((valuex) {
        Get.find<MapController>().loadLoaction.value=false;

        addressTextController.text= valuex![0].locality.toString()+", "+
            valuex[0].subLocality.toString();
        cityTextController.text=valuex[0].subAdministrativeArea.toString();
        zipCodeTextController.text=valuex[0].postalCode.toString();
      });
    });
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
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text("About You",),
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:  Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
                ),
                backgroundColor: const Color(0XFFFFFFFF),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: _globalkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Use the name of your business, brand or organization or name that helps explain your profile.",
                                style: TextStyle(
                                  color: Color(0xFF5C6360),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 15,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: nameController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Name",
                                errormsg: "Please enter your name",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),


                              SizedBox(height: 16,),
                              Text(
                                'Contact Info',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 15,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: emailController,
                                readOnly: true,
                                isNumber: false,
                                isemail: true,
                                hintText: "Email",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: mobileController,
                                readOnly: true,
                                isNumber: false,
                                hintText: "Mobile",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),


                              SizedBox(height: 16,),
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 15,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: addressTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Address",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: cityTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "City/Town",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),
                              SizedBox(height: 8,),
                              BackgroundTextfield(
                                height: 65,
                                controller: zipCodeTextController,
                                readOnly: false,
                                isNumber: false,
                                hintText: "Zip Code",
                                bgColor: Color(0XFFEDFCEF),
                                borderColor: Color(0XFFEDFCEF),),


                              SizedBox(height: 16,),
                              Text(
                                'Profile Picture',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 15,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                 controller.filePath.value==""?
                                 Container(
                                    width: 44,
                                    height: 44,
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEDFCEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/camera.svg",color: kPrimaryColor,),
                                  ):
                                 Container(
                                   width: 44,
                                   height: 44,
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
                                  SizedBox(width: 24,),
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
                                                fontFamily: 'Sora',
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
                              SizedBox(height: 20,),

                            ],
                          ),
                        ),

                      controller.circuler.value||controller.tokenReseting.value?LoadingWidget():
                       Container(
                         margin: EdgeInsets.only(bottom: 16),
                         child: CustomButton(
                            height: 52,
                              orderRadius: 40,
                              color: kPrimaryColorx,
                              textColor: Colors.white,
                              title: "Create Profile",
                              onTap: () {

                                  if (_globalkey.currentState!.validate()) {
                                    signUpFun(controller, context);
                                  }


                              }),
                       ),

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

  Future<LoginResponse?> signUpFun(AuthController authController,
      BuildContext context) async {
    var value = authController.SignUp(
        mobile: widget.mobile!,
        email: widget.email!,
        otp: widget.otp!,
        zipcode: zipCodeTextController.text,
        city: cityTextController.text,
        address: addressTextController.text,
        name: nameController.text
    ).then((value) async {
      Logger().w(value?.success);
      if (value!.statusCode==200) {
        Get.find<HomeController>().token.value=value.token!;
        Get.find<HomeController>().update();
        await localBd.storeTokenUserdata(email: value.email,token: value.token,name: value.name,
            mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId).then((valuex) {
          authController.tokenReseting.value=true;
          updateDependency();
          Future.delayed(Duration(seconds: 10),(){
            authController.tokenReseting.value=false;
            Get.find<HomeController>().selectedIndex.value=0;
            Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE,(route) => false,);
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFFF01212),
          content: Container(
            // constraints: BoxConstraints(
            //   maxHeight: 2,
            // minHeight: 24,
            // ),
            padding: EdgeInsets.all(4),
            child: Text(value.message!),
          ),
          duration: Duration(milliseconds: 1500),
        ));
      }
    });

    return value;
  }
}


