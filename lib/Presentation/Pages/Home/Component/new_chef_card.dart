import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class NewChefCard extends StatelessWidget {
  final String? image, name, address, id,rating,token;
  final bool isFloow;
  final num index;

  const NewChefCard(
      {Key? key, this.image, this.name, this.address, this.id, required this.isFloow, required this.index, this.rating, this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 135,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(6),
        ),

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                'id': id!,
                'localuser': true,
                "directHomePage":false
              });
            },
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                      imageUrl: image!,
                      placeholder: (context, url) =>
                          SizedBox(height: 32, width: 32,
                              child: LoadingWidget()),
                      imageBuilder: (context, image) =>
                          Container(
                            width: 32,
                            height: 32,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: image,
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          )
                  ),
                  const SizedBox(height: 6),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                name!.length>14?name!.substring(0,13)+"..":name!,
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address ?? '',
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RatingBar(
                          initialRating:rating=="null"?0.0: double.parse(rating!),
                          minRating: 0,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 12,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          ratingWidget: RatingWidget(
                            full: SizedBox(
                                height: 8,
                                child: SvgPicture.asset('assets/icons/star.svg',height: 6.23,)),
                            half: SizedBox(
                                height: 8,
                                child: SvgPicture.asset('assets/icons/star.svg')),
                            empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                          ),
                          onRatingUpdate: (ratingx) {

                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          GetBuilder<ChefController>(
            assignId: true,
            builder: (controller) {
              return Obx(() {
                return InkWell(
                  onTap: () {
                    if(token==""){
                      Get.snackbar(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),borderRadius: 6,"Warning", "You are not Login",backgroundColor: Colors.orangeAccent,colorText: Colors.white);
                    }else{
                      if(!isFloow){
                        controller.followChef(id: id!,indexx: index).then((value) {
                          Get.find<MenuControllerx>().getnewChef(true);
                        });
                      }else{
                        controller.deleteFollowChef(id: id!,indexx: index).then((value) {
                          Get.find<MenuControllerx>().getnewChef(true);
                        });
                      }
                    }
                     
                  },
                  child: Container(
                    width: 106,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: ShapeDecoration(
                      color:isFloow ? Color(0XFFEDFCEF): Color(0xFF00934C),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.50, color: isFloow ? kPrimaryColorx : Color(
                            0xFF00934C)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.index.value==index.toString()?
                        controller.circuler.value ?
                        SizedBox(height: 10, child: LoadingWidget()) :
                        Text(
                          isFloow ? 'Following' : 'Follow',
                          style: TextStyle(
                            color:isFloow ?kPrimaryColorx: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ):
                        Text(
                          isFloow ? 'Following' : 'Follow',
                          style: TextStyle(
                            color:isFloow ?kPrimaryColorx:   Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
