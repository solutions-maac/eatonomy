import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Presentation/Widgets/EmptyCard/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Dependenci Injection/injection.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../../GetX Controller/Home/HomeController.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../../Service/LocalDataBase/localdata.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/text_field_reamarks.dart';
import '../../Home/Component/menu_card.dart';
import '../Component/compliment_card.dart';
import '../Component/cuisine_card.dart';
import '../Component/review.dart';

class ChefProfilePage extends StatefulWidget {
  final String?id;
  final bool?localUser;
  final bool?directHomePage,isButton;

  const ChefProfilePage({Key? key, this.id, this.localUser = false, this.directHomePage=true, this.isButton=true})
      : super(key: key);

  @override
  State<ChefProfilePage> createState() => _ChefProfilePageState();
}

class _ChefProfilePageState extends State<ChefProfilePage> {

  String? role;
  String? token;

  void getToken() async {
    var tokenx = await getIt<LocalDataGet>().getData();
    if (tokenx.get('token') != null) {
      setState(() {
        role = tokenx.get('role');
        token = tokenx.get('token');
      });
      // Logger().e(tokenx.get('name'));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Logger().e(widget.id!);
    getToken();
    Future.delayed(
        Duration.zero, () {
      Get.find<ChefController>().onInit();
      Get.find<ChefController>().getChefDetails(widget.id!);
      Get.find<MenuControllerx>().selectCuisine.value="";
      Get.find<MenuControllerx>().menuSelect.value = "menu";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChefController>(
      assignId: true,
      builder: (chefController) {
        return Obx(() {
          return Scaffold(

            appBar: AppBar(
              leading:widget.isButton!? InkWell(
                  onTap: () {
                    widget.directHomePage==null||widget.directHomePage!?
                    Navigator.pushNamedAndRemoveUntil(
                        context, MAIN_PAGE, (route) => false):Navigator.pop(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        "assets/icons/arrow-left.svg", height: 20,
                        width: 20,))):null,
              title: Text('Profile',),
              actions: [
                chefController.chefId.value == "" ? SizedBox() :
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GetBuilder<HomeController>(
                        assignId: true,
                        builder: (controller) {
                          return Obx(() {
                            return controller.shopswitchChircule.value ?
                            Container(
                                height: 42,
                                width: 42,
                                padding: EdgeInsets.all(12),
                                child: LoadingWidget()) :
                            InkWell(
                              onTap: () {
                                controller.chefId.value = "";
                                controller.switchToUser(context);
                              },
                              child:
                              CachedNetworkImage(
                                  imageUrl: chefController.chefDetailsResponse.value!.chef!.user!.profilePicture!,
                                  placeholder: (context, url) => LoadingWidget(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          height: 42,
                                          width: 42,
                                          padding: EdgeInsets.all(12),
                                          decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/icons/refresh.png")
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(44)
                                              )

                                          ),
                                          child: Container(
                                            width: 28,
                                            height: 28,
                                            padding: const EdgeInsets.all(2),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1, color: Color(0xFFF2F3F5)),
                                                borderRadius: BorderRadius.circular(200),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                chefController.chefDetailsResponse.value!.chef!.user!.name!.substring(0, 2)
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF8D8D8D),
                                                  fontSize: 11,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                  imageBuilder: (context, image) =>
                                      Container(
                                        height: 42,
                                        width: 42,
                                        padding: EdgeInsets.all(12),
                                        decoration: ShapeDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/icons/refresh.png")
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(44)
                                            )

                                        ),
                                        child:
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  44),
                                            ),
                                          ),
                                        ),
                                      )
                              ),
                            );


                            // InkWell(
                            //   onTap: () {
                            //     controller.chefId.value = "";
                            //     controller.switchToUser(context);
                            //   },
                            //   child: CachedNetworkImage(
                            //       imageUrl: controller.selectedShopImage.value !=
                            //           "" ?
                            //       controller.selectedShopImage.value
                            //           :
                            //       controller.userImage.value != ""
                            //           ? controller.userImage.value
                            //           : "https://via.placeholder.com/34x34",
                            //       placeholder: (context, url) => LoadingWidget(),
                            //       imageBuilder: (context, image) =>
                            //           Container(
                            //             height: 42,
                            //             width: 42,
                            //             padding: EdgeInsets.all(12),
                            //             decoration: ShapeDecoration(
                            //                 image: DecorationImage(
                            //                     image: AssetImage(
                            //                         "assets/icons/refresh.png")
                            //                 ),
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius: BorderRadius.circular(44)
                            //                 )
                            //
                            //             ),
                            //             child: Container(
                            //               width: 28,
                            //               height: 28,
                            //               decoration: ShapeDecoration(
                            //                 image: DecorationImage(
                            //                   image: image,
                            //                   fit: BoxFit.fill,
                            //                 ),
                            //                 shape: RoundedRectangleBorder(
                            //                   borderRadius: BorderRadius.circular(
                            //                       44),
                            //                 ),
                            //               ),
                            //             ),
                            //           )
                            //   ),
                            // );
                          });
                        },
                      ),
                      SizedBox(width: 2,),
                      Container(
                        height: 16,
                        width: 1,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Color(0XFFFFE5E5EB),
                            )
                        ),

                      ),
                      ),
                      SizedBox(width: 12,),

                      chefController.circuler.value?LoadingWidget():
                      chefController.chefId.value ==
                          chefController.chefDetailsResponse.value!.chef!.id ?
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CHEF_PROFILE_EDIT_PAGE, arguments:
                          {
                            'chef': chefController.chefDetailsResponse.value!.chef!
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 16,
                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                width: 16,
                                height: 16,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/edit-2.svg", height: 16,)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ) : SizedBox()
                    ],
                  ),
                ),

              ],
            ),
            backgroundColor: Color(0xFFF9FCFF),
            body: Obx(() {
              return chefController.circuler.value ?
              Center(child: LoadingWidget(),) :
              Container(

                height: 1.0.sh,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24, top: 12),
                      child: Column(
                        children: [
                          Container(
                            height: 190,
                            child: Stack(
                              children: [
                                Container(
                                  height: 127,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF1EDFC),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            chefController.chefDetailsResponse
                                                .value!.chef!.banner!
                                        ),
                                        fit: BoxFit.cover
                                    ),
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
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF1EDFC),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            chefController.chefDetailsResponse
                                                .value!
                                                .chef!.profilePicture!),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            44),
                                        side: BorderSide(
                                            width: 1.50, color: Colors.white),

                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Text(
                            chefController.chefDetailsResponse.value!.chef!
                                .name!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF01180D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24,),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 77,
                                    padding: const EdgeInsets.all(18),
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.98, 0.19),
                                        end:Alignment(0.98, -0.19),
                                        colors: [
                                          Color(0xFF0B5933),
                                          Color(0xFF1DD667)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              6)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x143E2489),
                                          blurRadius: 24,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  "assets/icons/weekly.svg"),
                                            ),
                                            const SizedBox(width: 16),
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    chefController
                                                        .chefDetailsResponse
                                                        .value!.totalWeeklyOrder
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight
                                                          .w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Weekly order',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(width: 16,),
                              Expanded(
                                  child: Container(
                                    height: 77,
                                    padding: const EdgeInsets.all(18),
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.98, 0.19),
                                        end:Alignment(0.98, -0.19),
                                        colors: [
                                          Color(0xFFEA5101),
                                          Color(0xFFFCB116)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              6)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x143E2489),
                                          blurRadius: 24,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  "assets/icons/experince.svg"),
                                            ),
                                            const SizedBox(width: 16),
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    chefController
                                                        .chefDetailsResponse
                                                        .value!.chef!.experience
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight
                                                          .w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Experience',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),

                              // Expanded(
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           chefController.chefDetailsResponse
                              //               .value!.totalWeeklyOrder
                              //               .toString(),
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color(0xFF01180D),
                              //             fontSize: 18,
                              //             fontFamily: 'Satoshi',
                              //             fontWeight: FontWeight.w900,
                              //           ),
                              //         ),
                              //         Opacity(
                              //           opacity: 0.90,
                              //           child: Text(
                              //             'Weekly order completed',
                              //             style: TextStyle(
                              //               color: Color(0xFF01180D),
                              //               fontSize: 12,
                              //               fontFamily: 'Satoshi',
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     )
                              // ),
                              // Expanded(
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           chefController.chefDetailsResponse
                              //               .value!.totalPartyOrder
                              //               .toString(),
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color(0xFF01180D),
                              //             fontSize: 18,
                              //             fontFamily: 'Satoshi',
                              //             fontWeight: FontWeight.w900,
                              //           ),
                              //         ),
                              //         Opacity(
                              //           opacity: 0.90,
                              //           child: Text(
                              //             'Party order completed',
                              //             style: TextStyle(
                              //               color: Color(0xFF01180D),
                              //               fontSize: 12,
                              //               fontFamily: 'Satoshi',
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         ),
                              //
                              //       ],
                              //     )
                              // ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 77,
                                    padding: const EdgeInsets.all(18),
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin:Alignment(-0.98, 0.19),
                                        end: Alignment(0.98, -0.19),
                                        colors: [
                                          Color(0xFF531A9C),
                                          Color(0xFFAE28C4)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              6)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x143E2489),
                                          blurRadius: 24,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  "assets/icons/party.svg"),
                                            ),
                                            const SizedBox(width: 16),
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    chefController
                                                        .chefDetailsResponse
                                                        .value!.totalPartyOrder
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight
                                                          .w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Party order',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(width: 16,),
                              Expanded(
                                  child: Container(
                                    height: 77,
                                    padding: const EdgeInsets.all(18),
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin:  Alignment(-0.98, 0.19),
                                        end:Alignment(0.98, -0.19),
                                        colors: [
                                          Color(0xFF6D193E),
                                          Color(0xFFFF679E)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              6)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x143E2489),
                                          blurRadius: 24,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  "assets/icons/overall.svg"),
                                            ),
                                            const SizedBox(width: 16),
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    chefController
                                                        .chefDetailsResponse
                                                        .value!.chef!.rating ==
                                                        null ? "0.0" :
                                                    chefController
                                                        .chefDetailsResponse
                                                        .value!.chef!.rating!.toDouble().toStringAsFixed(1)
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Sora',
                                                      fontWeight: FontWeight
                                                          .w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Overall rating',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontFamily: 'Sora',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),


                              // Expanded(
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           chefController.chefDetailsResponse
                              //               .value!.totalWeeklyOrder
                              //               .toString(),
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color(0xFF01180D),
                              //             fontSize: 18,
                              //             fontFamily: 'Satoshi',
                              //             fontWeight: FontWeight.w900,
                              //           ),
                              //         ),
                              //         Opacity(
                              //           opacity: 0.90,
                              //           child: Text(
                              //             'Weekly order completed',
                              //             style: TextStyle(
                              //               color: Color(0xFF01180D),
                              //               fontSize: 12,
                              //               fontFamily: 'Satoshi',
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     )
                              // ),
                              // Expanded(
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           chefController.chefDetailsResponse
                              //               .value!.totalPartyOrder
                              //               .toString(),
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color(0xFF01180D),
                              //             fontSize: 18,
                              //             fontFamily: 'Satoshi',
                              //             fontWeight: FontWeight.w900,
                              //           ),
                              //         ),
                              //         Opacity(
                              //           opacity: 0.90,
                              //           child: Text(
                              //             'Party order completed',
                              //             style: TextStyle(
                              //               color: Color(0xFF01180D),
                              //               fontSize: 12,
                              //               fontFamily: 'Satoshi',
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         ),
                              //
                              //       ],
                              //     )
                              // ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          widget.localUser! ?
                          token==null?SizedBox():
                          chefController.chefDetailsResponse.value!.chef!
                              .isFollowed! ?
                          role == "CHEF" ? SizedBox() :
                          InkWell(
                            onTap: (){
                              chefController.deleteFollowChef(id: widget.id!);
                            },
                            child: Container(
                              width: 10.sw,
                              height: 48,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                color: Color(0XFFEDFCEF),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.50, color:  kPrimaryColorx ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                     'Following',
                                    style: TextStyle(
                                      color:kPrimaryColorx,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                         :
                          role == "CHEF" ? SizedBox() :
                          CustomButton(
                              height: 52,
                              orderRadius: 24,
                              color: kPrimaryColorx,
                              boder: false,
                              textColor: Colors.white,
                              title: "Follow Chef",
                              onTap: () {
                                chefController.followChef(id: widget.id!);
                              }
                          ) :
                          CustomButton(
                              height: 52,
                              orderRadius: 48,
                              color: kPrimaryColorx,
                              boder: false,
                              textColor: Colors.white,
                              title: "Create Menu",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CREATE_MENU_PAGE, arguments: {
                                  'id': widget.id!
                                });
                              }
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 16,),
                    Container(
                      width: 1.0.sw,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.38,
                            color: Color(0xB2D9D9D9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    GetBuilder<MenuControllerx>(
                      assignId: true,
                      builder: (controller) {
                        return Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.menuSelect.value = "menu";
                                    },
                                    child: Container(
                                      width: 68,
                                      height: 32,
                                      margin: EdgeInsets.only(
                                          right: 8, left: 24),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: ShapeDecoration(
                                        color: controller.menuSelect == "menu"
                                            ? Color(0x2600934C)
                                            : Color(0x269EA0A2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Menu',
                                          style: TextStyle(
                                            color: controller.menuSelect ==
                                                "menu"
                                                ? Color(0xFF00934C)
                                                : Color(0xFF9E9FA1),
                                            fontSize: 12,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.menuSelect.value = "about";
                                    },
                                    child: Container(
                                      width: 68,
                                      height: 32,
                                      margin: EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: ShapeDecoration(
                                        color: controller.menuSelect ==
                                            "about"
                                            ? Color(0x2600934C)
                                            : Color(0x269EA0A2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'About',
                                          style: TextStyle(
                                            color: controller.menuSelect ==
                                                "about"
                                                ? Color(0xFF00934C)
                                                : Color(0xFF9E9FA1),
                                            fontSize: 12,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.menuSelect.value = "rating";
                                    },
                                    child: Container(
                                      width: 68,
                                      height: 32,
                                      margin: EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: ShapeDecoration(
                                        color: controller.menuSelect ==
                                            "rating"
                                            ? Color(0x2600934C)
                                            : Color(0x269EA0A2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Rating',
                                          style: TextStyle(
                                            color: controller.menuSelect ==
                                                "rating"
                                                ? Color(0xFF00934C)
                                                : Color(0xFF9E9FA1),
                                            fontSize: 12,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12,),
                              Container(
                                width: 1.0.sw,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.38,
                                      color: Color(0xB2D9D9D9),
                                    ),
                                  ),
                                ),
                              ),

                              controller.menuSelect == "about" ?
                              chefController.chefDetailsResponse.value!
                                  .chef!.about == null ? Center(
                                  child: EmptyWidget()) :
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,vertical: 16),
                                child: Text(
                                    chefController.chefDetailsResponse.value!
                                        .chef!.about ?? "There Has No About",
                                  style: TextStyle(
                                    color: Color(0xFF5C6360),
                                    fontSize: 14,
                                    height: 1.30
                                  ),
                                ),

                              ) :
                              controller.menuSelect == "rating" ?

                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    width: 1.0.sw,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD6EEE2),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10)
                                            ),
                                            height: 97.h,
                                            width: 107.w,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                  chefController
                                                      .chefDetailsResponse
                                                      .value!.chef!.rating ==
                                                      null ? "0.0" :
                                                  chefController
                                                      .chefDetailsResponse
                                                      .value!.chef!.rating!.toDouble().toStringAsFixed(1)
                                                      .toString(),
                                                  style: extraBoldText(36.sp,
                                                      color: kPrimaryColor),),
                                                SizedBox(height: 4,),
                                                Text(
                                                  "out of 5",
                                                  style: mediumText(14.sp,
                                                      color: kPrimaryColor),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                            flex: 7,
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                              ],
                                                            ),

                                                          )
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                      Expanded(
                                                          flex: 9,
                                                          child: FAProgressBar(
                                                            size: 6.h,
                                                            backgroundColor: Color(
                                                                0xFFD6EEE2),
                                                            progressColor: kPrimaryColor,
                                                            currentValue: chefController
                                                                .chefDetailsResponse
                                                                .value!
                                                                .reviewStats![4]
                                                                .percentage!
                                                                .toDouble(),
                                                          )
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                              ],
                                                            ),

                                                          )
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                      Expanded(
                                                          flex: 9,
                                                          child: FAProgressBar(
                                                            size: 6.h,
                                                            backgroundColor: Color(
                                                                0xFFD6EEE2),
                                                            progressColor: kPrimaryColor,
                                                            currentValue: chefController
                                                                .chefDetailsResponse
                                                                .value!
                                                                .reviewStats![3]
                                                                .percentage!
                                                                .toDouble(),

                                                          )
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                    "assets/icons/star.svg",
                                                                    color: Color(
                                                                        0xFFD6EEE2),
                                                                    height: 12),

                                                              ],
                                                            ),

                                                          )
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                      Expanded(
                                                          flex: 9,
                                                          child: FAProgressBar(
                                                            size: 6.h,
                                                            backgroundColor: Color(
                                                                0xFFD6EEE2),
                                                            progressColor: kPrimaryColor,
                                                            currentValue: chefController
                                                                .chefDetailsResponse
                                                                .value!
                                                                .reviewStats![2]
                                                                .percentage!
                                                                .toDouble(),

                                                          )
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/icons/star.svg",
                                                                  color: Color(
                                                                      0xFFD6EEE2),
                                                                  height: 12,),
                                                                SizedBox(
                                                                  width: 3,),
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/icons/star.svg",
                                                                  color: Color(
                                                                      0xFFD6EEE2),
                                                                  height: 12,),

                                                              ],
                                                            ),

                                                          )
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                      Expanded(
                                                          flex: 9,
                                                          child: FAProgressBar(
                                                            size: 6.h,
                                                            backgroundColor: Color(
                                                                0xFFD6EEE2),
                                                            progressColor: kPrimaryColor,
                                                            currentValue: chefController
                                                                .chefDetailsResponse
                                                                .value!
                                                                .reviewStats![1]
                                                                .percentage!
                                                                .toDouble(),

                                                          )
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Expanded(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/icons/star.svg",
                                                                  color: Color(
                                                                      0xFFD6EEE2),
                                                                  height: 12,),
                                                              ],
                                                            ),

                                                          )
                                                      ),
                                                      SizedBox(width: 12.w,),
                                                      Expanded(
                                                          flex: 9,
                                                          child: FAProgressBar(
                                                            size: 6.h,
                                                            backgroundColor: Color(
                                                                0xFFD6EEE2),
                                                            progressColor: kPrimaryColor,
                                                            currentValue: chefController
                                                                .chefDetailsResponse
                                                                .value!
                                                                .reviewStats![0]
                                                                .percentage!
                                                                .toDouble(),

                                                          )
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  chefController.chefDetailsResponse.value!.
                                  compliments!.isEmpty?SizedBox(): Container(
                                    margin: const EdgeInsets.only(left: 24.0),
                                    child: Text(
                                      "Compliments",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                  ),
                                  chefController.chefDetailsResponse.value!.
                                  compliments!.isEmpty?SizedBox():SizedBox(height: 20,),
                                  chefController.chefDetailsResponse.value!.
                                  compliments!.isEmpty?SizedBox():
                                  Container(
                                      height: 100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child:
                                      ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: chefController
                                            .chefDetailsResponse.value!
                                            .compliments!.length,
                                        itemBuilder: (context, index) {
                                          return
                                            chefController.chefDetailsResponse
                                                .value!.compliments![index]
                                                .text ==
                                                "Please rate their timeliness."
                                                ? Compliment(
                                              image: "assets/icons/time.svg",
                                              name: "Timeliness",
                                              number: chefController
                                                  .chefDetailsResponse.value!
                                                  .compliments![index].count
                                                  .toString(),
                                            ) :
                                            chefController.chefDetailsResponse
                                                .value!.compliments![index]
                                                .text ==
                                                "Please rate their service intensity."
                                                ?
                                            Compliment(
                                              image: "assets/icons/service.svg",
                                              name: "Service intensity",
                                              number: chefController
                                                  .chefDetailsResponse.value!
                                                  .compliments![index].count
                                                  .toString(),
                                            ) :
                                            chefController.chefDetailsResponse
                                                .value!.compliments![index]
                                                .text ==
                                                "Please rate their service?"
                                                ?
                                            Compliment(
                                              image: "assets/icons/startservice.svg",
                                              name: "5 star service",
                                              number: chefController
                                                  .chefDetailsResponse.value!
                                                  .compliments![index].count
                                                  .toString(),
                                            ) :
                                            chefController.chefDetailsResponse
                                                .value!.compliments![index]
                                                .text ==
                                                "Please rate their food hygiene."
                                                ?
                                            Compliment(
                                              image: "assets/icons/haygine.svg",
                                              name: "Hygiene",
                                              number: chefController
                                                  .chefDetailsResponse.value!
                                                  .compliments![index].count
                                                  .toString(),
                                            )
                                                : SizedBox();
                                        },

                                      )


                                    // ListView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   children: [
                                    //
                                    //
                                    //   ],
                                    // ),
                                  ),
                                  SizedBox(height: 12,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 24.0),
                                    child: Text(
                                      "Reviews",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                  ),
                                  SizedBox(height: 16,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 24.0),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFECE8E8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  chefController.chefDetailsResponse
                                      .value!.reviews!.isEmpty ? Center(
                                      child: Container(
                                          child: EmptyWidget(title: "There Has No Review",),
                                        margin: EdgeInsets.only(bottom: 24),

                                      )) :
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: chefController
                                        .chefDetailsResponse
                                        .value!.reviews!.length,
                                    itemBuilder: (context, index) {
                                      return ReviewCrad(
                                        review: chefController
                                            .chefDetailsResponse
                                            .value!.reviews![index],);
                                    },
                                  ),

                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )

                                  :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12,),
                                  Container(
                                    child: Text(
                                      'Select Cuisine',
                                      style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 12,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(left: 24),
                                  ),
                                  SizedBox(height: 16,),
                                  Container(
                                    height: 77,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CuisineCrad(
                                          name: controller.cuisineList[index],
                                          controller: controller,
                                          chefController: chefController,
                                        );
                                      },
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.cuisineList.length,
                                    ),
                                    margin: EdgeInsets.only(left: 24),
                                  ),
                                  SizedBox(height: 16,),
                                  chefController.menusCopy.isEmpty ? Center(
                                      child: EmptyWidget()) :
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: chefController.menusCopy.length,
                                    itemBuilder: (context, index) {
                                      return MenuCard(
                                        isFeed: false,
                                        isLogin: token!=null,
                                        wishListed: chefController.menusCopy[index].alreadyInWishList,
                                        menu: chefController.menusCopy[index],
                                        type: chefController.menusCopy[index]
                                            .type,
                                        createAt: chefController
                                            .menusCopy[index].createdAt,
                                        image: chefController.menusCopy[index]
                                            .images!,
                                        iteams: chefController.menusCopy[index]
                                            .menus!,
                                        title: chefController.menusCopy[index]
                                            .title,
                                        price: chefController.menusCopy[index]
                                            .price.toString(),
                                        chefName: chefController
                                            .menusCopy[index].chef!.name,
                                        chefPP: chefController.menusCopy[index]
                                            .chef!
                                            .profilePicture,
                                        deliveryInst: chefController
                                            .menusCopy[index]
                                            .deliveryInstruction,
                                        orderInst: chefController
                                            .menusCopy[index]
                                            .orderTakingInstruction,
                                        isDeliver: chefController
                                            .menusCopy[index]
                                            .isDeliveryAvailable,
                                        isPickUp: chefController
                                            .menusCopy[index].isPickUpAvailable,
                                      );
                                    },
                                  ),
                                ],
                              )

                            ],
                          );
                        });
                      },
                    )


                  ],
                ),
              );
            }),
          );
        });
      },
    );
  }
}

