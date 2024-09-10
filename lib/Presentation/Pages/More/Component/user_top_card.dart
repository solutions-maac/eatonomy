import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/GetX%20Controller/Chef/ChefController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/User/ChefData.dart';
import '../../../../GetX Controller/Home/HomeController.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class UserMoreTopCard extends StatelessWidget {
  final String?role, image, name, chefId;

  const UserMoreTopCard(
      {Key? key, this.role, this.image, this.name, this.chefId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero, () => Get.find<HomeController>().getShopList());
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Container(
            child: role == "USER" ?
            controller.shopChircule.value ||
                controller.shopList.value!.chefAdmins == null ?
            LoadingWidget() :
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: 72,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.75, color: Color(0xFF00934C)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    constraints: BoxConstraints(
                      maxWidth: 0.80.sw, minWidth: 0.80.sw,),
                    itemBuilder: (BuildContext context) {
                      return controller.shopList.value!.chefAdmins!.asMap()
                          .entries.map((e) =>
                          PopupMenuItem(
                            value: 0,
                            child: Column(
                              children: [
                                SizedBox(height: 12),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.chefId.value = e.value.chefId!;
                                    controller.switchToShop(
                                        e.value.chefId, context);
                                  },
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: e.value.chef!.profilePicture!,
                                        placeholder: (context, url) =>
                                            SizedBox(
                                                height: 34,
                                                width: 34,
                                                child: LoadingWidget()
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              width: 48,
                                              height: 48,
                                              padding: const EdgeInsets.all(2),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1, color: Color(
                                                      0xFFF2F3F5)),
                                                  borderRadius: BorderRadius
                                                      .circular(200),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  name!.substring(0, 2)
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        imageBuilder: (context, image) =>
                                        e.value.chef!.profilePicture == null ?
                                        Container(
                                          width: 34,
                                          height: 34,
                                          padding: const EdgeInsets.all(2),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1, color: Color(
                                                  0xFFF2F3F5)),
                                              borderRadius: BorderRadius
                                                  .circular(200),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              name!.substring(0, 2)
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF8D8D8D),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                            :
                                        Container(
                                          width: 34,
                                          height: 34,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),

                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 6,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(e.value.chef!.name ?? "",
                                            style: mediumText(
                                                16, color: textColor),),
                                          Text(
                                            'Chef Profile',
                                            style: TextStyle(
                                              color: Color(0xFF5C6360),
                                              fontSize: 12,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          )).toList();
                    },
                    child: CachedNetworkImage(
                        imageUrl: image == null || image == ""
                            ? "https://via.placeholder.com/48x48"
                            : image!,
                        placeholder: (context, url) => LoadingWidget(),
                        errorWidget: (context, url, error) =>
                            Container(
                              width: 48,
                              height: 48,
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
                                  name!.substring(0, 2).toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        imageBuilder: (context, imagex) =>
                            badges.Badge(
                              stackFit: StackFit.passthrough,
                              badgeContent: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: controller.shopList.value!.chefAdmins!
                                        .isEmpty ? 1 : 16,)

                              ),
                              position: BadgePosition.custom(
                                  top: 14, start: 38),
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                badgeColor: kPrimaryColorx,
                                padding: EdgeInsets.all(0),
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0),
                                elevation: 0,
                              ),
                              child: image == null || image == "" ?
                              Container(
                                width: 48,
                                height: 48,
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
                                    name!.substring(0, 2).toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF8D8D8D),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                                  :
                              Container(
                                width: 48,
                                height: 48,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: imagex,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                  ),
                                ),
                              ),
                            )
                    ),
                  ),
                  SizedBox(width: 18,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? "",
                        style: TextStyle(
                          color: Color(0xFFFF02190E),
                          fontSize: 18,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'User profile',
                        style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
                :
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              height: 72,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 0.75, color: Color(0xFF00934C)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PopupMenuButton(
                        position: PopupMenuPosition.under,
                        constraints: BoxConstraints(
                          maxWidth: 0.80.sw, minWidth: 0.80.sw,),
                        itemBuilder: (BuildContext context) {
                          return controller.shopList.value!.chefAdmins!.asMap()
                              .entries.map((e) =>
                          e.key == 0 ? PopupMenuItem(
                            value: 0,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.chefId.value = "";
                                    controller.switchToUser(context);
                                  },
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: e.value.chef!.user!
                                            .profilePicture!,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              width: 38,
                                              height: 38,
                                              padding: const EdgeInsets.all(2),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(width: 1,
                                                      color: Color(0xFFF2F3F5)),
                                                  borderRadius: BorderRadius
                                                      .circular(200),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  e.value.chef!
                                                      .user!
                                                      .name!
                                                      .substring(0, 2)
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        placeholder: (context, url) =>
                                            SizedBox(
                                                height: 34,
                                                width: 34,
                                                child: LoadingWidget()
                                            ),
                                        imageBuilder: (context, image) =>
                                        e.value.chef!.user!.profilePicture ==
                                            null ?
                                        Container(
                                          width: 38,
                                          height: 38,
                                          padding: const EdgeInsets.all(2),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1,
                                                  color: Color(0xFFF2F3F5)),
                                              borderRadius: BorderRadius
                                                  .circular(200),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              e.value.chef!.name!.substring(
                                                  0, 2).toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF8D8D8D),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                            :
                                        Container(
                                          width: 34,
                                          height: 34,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),

                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 6,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(e.value.chef!.user!.name ?? "",
                                            style: mediumText(
                                                16, color: textColor),),
                                          Text(
                                            'User Profile',
                                            style: TextStyle(
                                              color: Color(0xFF6D7075),
                                              fontSize: 12,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Divider(color: dividerColor, thickness: 1,)
                              ],
                            ),
                          ) :
                          PopupMenuItem(
                            value: 0,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.chefId.value = e.value.chefId!;
                                    controller.switchToShop(
                                        e.value.chefId, context);
                                  },
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: e.value.chef!.profilePicture!,
                                        placeholder: (context, url) =>
                                            SizedBox(
                                                height: 34,
                                                width: 34,
                                                child: LoadingWidget()
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              width: 38,
                                              height: 38,
                                              padding: const EdgeInsets.all(2),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(width: 1,
                                                      color: Color(0xFFF2F3F5)),
                                                  borderRadius: BorderRadius
                                                      .circular(200),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  e.value.chef!.name!.substring(
                                                      0, 2).toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF8D8D8D),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        imageBuilder: (context, image) =>
                                        e.value.chef!.profilePicture == null ?
                                        Container(
                                          width: 38,
                                          height: 38,
                                          padding: const EdgeInsets.all(2),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1,
                                                  color: Color(0xFFF2F3F5)),
                                              borderRadius: BorderRadius
                                                  .circular(200),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              e.value.chef!.name!.substring(
                                                  0, 2).toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF8D8D8D),
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ) :
                                        Container(
                                          width: 34,
                                          height: 34,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),

                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 6,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(e.value.chef!.name ?? "",
                                            style: mediumText(
                                                16, color: textColor),),
                                          Text(
                                            'Chef Profile',
                                            style: TextStyle(
                                              color: Color(0xFF6D7075),
                                              fontSize: 12,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Divider(color: dividerColor, thickness: 1,)
                              ],
                            ),
                          )).toList();
                        },
                        child: CachedNetworkImage(
                            imageUrl: controller.selectedShopImage.value !=
                                "" ?
                            controller.selectedShopImage.value
                                :
                            controller.userImage.value != ""
                                ? controller.userImage.value
                                : "https://via.placeholder.com/34x34",
                            placeholder: (context, url) => LoadingWidget(),
                            imageBuilder: (context, image) =>
                                badges.Badge(
                                  stackFit: StackFit.passthrough,
                                  badgeContent: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_down, color: Colors
                                          .white,
                                        size: controller.shopList.value!
                                            .chefAdmins!.isEmpty ? 1 : 20,)

                                  ),
                                  position: BadgePosition.custom(
                                      top: 14, start: 38),
                                  badgeStyle: badges.BadgeStyle(
                                    shape: badges.BadgeShape.circle,
                                    badgeColor: kPrimaryColorx,
                                    padding: EdgeInsets.all(0),
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.0),
                                    elevation: 0,
                                  ),
                                  child: controller.userImage.value == "" ?
                                  Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.all(2),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFFF2F3F5)),
                                        borderRadius: BorderRadius.circular(
                                            200),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.name.value.substring(0, 2)
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF8D8D8D),
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                      :
                                  Container(
                                    width: 48,
                                    height: 48,
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
                                )),
                      ),
                      SizedBox(width: 13,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SHEF_PROFILE_PAGE, arguments: {
                            'id': chefId,
                            'localuser': false
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.selectedShop.value != "" ?
                              controller.selectedShop.value :
                              controller.name.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6,),
                            Text(
                              'Chef',
                              style: TextStyle(
                                color: Color(0xFF6D7075),
                                fontSize: 12,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  controller.shopswitchChircule.value ?
                  Container(
                      height: 42,
                      width: 42,
                      padding: EdgeInsets.all(12),
                      child: LoadingWidget()):
                  GetBuilder<ChefController>(
                    assignId: true,
                    builder: (chefController) {
                      return
                        chefController.circuler.value?LoadingWidget():
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
                    },
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
