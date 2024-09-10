import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:logger/logger.dart';
import '../../../../Config/text_style.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import 'package:badges/badges.dart' as badges;
class ChefOrderRequetsCard extends StatelessWidget {
  final Order? order;
  const ChefOrderRequetsCard({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    // Logger().i(order!.deliveryOption!);
    return Container(
      height: 72,
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.75, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // "https://via.placeholder.com/48x48"
              badges.Badge(
                stackFit: StackFit.passthrough,
                badgeContent: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SvgPicture.asset(order!.deliveryOption=="Delivery"?"assets/icons/cycle.svg":"assets/icons/handbox.svg",color: Colors.white,height: 12,),
                ),
                position: BadgePosition.custom(top: 26, end: -10),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: kPrimaryColor,
                  padding: EdgeInsets.all(6),
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 2.5),
                ),
                child:CachedNetworkImage(
                    imageUrl: order!.user!.profilePicture??"",
                    placeholder: (context, url) => LoadingWidget(),
                    errorWidget: (context, url, error) => Container(
                      width: 48,
                      height: 48,
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
                          order!.user!.name!.substring(0,2).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8D8D8D),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ) ,
                    imageBuilder: (context, image) =>
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image:image,
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(44),
                            ),
                          ),
                        )
                ),
              ),


              SizedBox(width: 13,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    order!.user!.name??"",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        child: SvgPicture.asset(
                            "assets/icons/location.svg"),
                      ),
                      SizedBox(width: 4,),
                      Text(
                        order!.deliveryAddress==""?"This is a pickup order":
                        order!.deliveryAddress??"This is a pickup order",
                        style: TextStyle(
                          color: Color(0xFF525573),
                          fontSize: 10,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
              width: 33.96,
              height: 34,
              padding: EdgeInsets.all(7),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 0.75, color: Color(0xFFF2F3F5)),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: badges.Badge(
                stackFit: StackFit.passthrough,
                badgeContent: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('',
                    style: boldText(11, color: Colors.white),),
                ),
                position: BadgePosition.custom(
                    top: -8, start: 13),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Color(0xFFB3261E),
                  padding: EdgeInsets.all(2),
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.5),

                  // badgeGradient: badges.BadgeGradient.linear(
                  //   colors: [Colors.blue, Colors.yellow],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                  elevation: 0,
                ),
                child:
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                      'orderId':order!.orderId
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/message.svg", height: 20,),
                ),

              )


          )
        ],
      ),
    );
  }
}
