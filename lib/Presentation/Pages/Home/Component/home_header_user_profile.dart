import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Home/HomeController.dart';
import '../../../../Repository/AuthRepository/AuthRepository.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class userProfileImage extends StatefulWidget {
  const userProfileImage({Key? key}) : super(key: key);

  @override
  State<userProfileImage> createState() => _userProfileImageState();
}

class _userProfileImageState extends State<userProfileImage> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().onInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return
          // controller.shopChircule.value?
          // Container(
          //   width: 34,
          //   height: 34,
          //   decoration: ShapeDecoration(
          //     shape: RoundedRectangleBorder(
          //       side: BorderSide(width: 0.50, color: kPrimaryColorx),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          //   child: LoadingWidget(),
          // ):
          // controller.shopList.value!.chefAdmins==null?SizedBox():
          // controller.shopList.value!.chefAdmins!.isEmpty?
          controller.token.value== ""?
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, LOGIN_PAGE_INTRO);
            },
            child: Container(
              width: 38,
              height: 38,
              padding: const EdgeInsets.all(6),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFF2F3F5)),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 22.80,
                    height: 22.80,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: SvgPicture.asset("assets/icons/user-01.svg"),
                  ),
                ],
              ),
            ),
          ):
          Row(
            children: [
              InkWell(
                onTap: (){
                  controller.chefId.value!=""?
                  Navigator.pushNamed(
                      context, SHEF_PROFILE_PAGE, arguments: {
                    'id': controller.chefId.value,
                    'localuser': false
                  }):
                  Navigator.pushNamed(context, PROFILE_PAGE,arguments: {
                    "name":controller.name.value,
                    "image":controller.userImage.value,
                    "email":controller.email.value,
                  });


                },
                child:controller.userImage.value==""?
                Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFF2F3F5)),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.name.value.substring(0,2).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ):
                CachedNetworkImage(
                  imageUrl:controller.userImage.value==""? "https://via.placeholder.com/34x34": controller.userImage.value,
                  placeholder: (context, url) => SizedBox(
                      height: 34,
                      width: 34,
                      child: LoadingWidget()),
                  imageBuilder: (context, image) =>Container(
                    width: 34,
                    height: 34,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.50, color: kPrimaryColorx),
                        borderRadius: BorderRadius.circular(20),
                      ),

                    ),
                  ),
                ),
              ),
              SizedBox(width: 14,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.chefId.value!=""?Text(
                      "Welcome\n\n\n",
                    style: TextStyle(
                      color: Color(0xFF8D8D8D),
                      fontSize: 12,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                    ),
                  ): Text(
                      "Welcome",
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 20,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w700,

                      ),
                  ),
                  SizedBox(width: 6,),
                  controller.chefId.value!=""?Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 24,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,

                      ),
                  ):Text(
                      controller.name.value,
                      style: TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                  )
                ],
              )
            ],
          );


        });
      },
    );
  }
}
