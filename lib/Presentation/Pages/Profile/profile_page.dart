import 'dart:async';
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
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../../GetX Controller/Map/MapController.dart';
import '../../../GetX Controller/Menu/MenuController.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';
import '../wish List/Component/wish_card.dart';


class ProfilePage extends StatefulWidget {

  final String? name,email,image;

  ProfilePage({Key? key, this.name, this.email, this.image,}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var authController= Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    authController.onInit();
    authController.imageUrl.value=widget.image!;
    Get.find<ChefController>().getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChefController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: const Color(0XFFF9FCFF),
                  title: Text("Profile",),
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),

                  actions: [
                    controller.circuler.value?LoadingWidget():
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(
                            context, USER_PROFILE_PAGE, arguments: {
                          "name": controller.chefDetailsResponse.value!.user!.name??"",
                          "mobile": controller.chefDetailsResponse.value!.user!.mobileNumber??"",
                          "email": controller.chefDetailsResponse.value!.user!.email??"",
                          "image": controller.chefDetailsResponse.value!.user!.profilePicture??"",
                          "address": controller.chefDetailsResponse.value!.user!.address??"",
                          "city": controller.chefDetailsResponse.value!.user!.city??"",
                          "zipcode": controller.chefDetailsResponse.value!.user!.zipCode??"",
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 24),
                        child:Row(
                          children: [
                            SvgPicture.asset("assets/icons/useredit.svg"),
                            SizedBox(width: 4,),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Color(0xFF00934C),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],

                ),
                backgroundColor: const Color(0XFFF9FCFF),
                body: SingleChildScrollView(
                  child: Container(
                    width: 1.0.sw,
                    height: 1.0.sh,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                    child:controller.circuler.value?LoadingWidget():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 1.0.sw,
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [

                                  Container(
                                    width: 60,
                                    height: 60,
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      color: textFieldBorder,
                                      image: DecorationImage(
                                          image: NetworkImage(controller.chefDetailsResponse.value!.user!.profilePicture??""),
                                          fit: BoxFit.cover
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                    ),

                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                      controller.chefDetailsResponse.value!.user!.name??"",
                                      style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            Container(
                              width: 1.0.sw,
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 52,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Mobile Number',
                                                      style: TextStyle(
                                                        color: Color(0xFF5C6360),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    controller.chefDetailsResponse.value!.user!.mobileNumber??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF02190E),
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight.w600,

                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Container(
                                            width: double.infinity,
                                            height: 52,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Email ',
                                                      style: TextStyle(
                                                        color: Color(0xFF5C6360),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    controller.chefDetailsResponse.value!.user!.email??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF02190E),
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),

                            Container(
                              width: 1.0.sw,
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 52,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Address',
                                                      style: TextStyle(
                                                        color: Color(0xFF5C6360),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    controller.chefDetailsResponse.value!.user!.address??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF02190E),
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Container(
                                            width: double.infinity,
                                            height: 52,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'City',
                                                      style: TextStyle(
                                                        color: Color(0xFF5C6360),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    controller.chefDetailsResponse.value!.user!.city??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF02190E),
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight.w600,

                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Container(
                                            width: double.infinity,
                                            height: 52,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Zip Code',
                                                      style: TextStyle(
                                                        color: Color(0xFF5C6360),
                                                        fontSize: 14,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                      controller.chefDetailsResponse.value!.user!.zipCode??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF02190E),
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
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
}


