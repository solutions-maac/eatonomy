
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/text_style.dart';
import '../../Constants/Colors/app_colors.dart';
import '../../Constants/Strings/app_strings.dart';
import '../../GetX Controller/AuthController/AuthController.dart';

class CartIconCount extends StatelessWidget {
  final double? padidng;
  final double? top;
  final double? start;
  final int? count;
  final String? icon;

  const CartIconCount(
      {Key? key, this.padidng = 7, this.top = -2, this.start = 15, this.icon="assets/icons/order.svg", this.count=0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 34,
        height: 34,
        padding: EdgeInsets.all(7),
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: ShapeDecoration(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(44),
            side: BorderSide(width: 1.50, color: Color(0xFFF2F3F5)),
          ),
        ),
        child:
        badges.Badge(
          stackFit: StackFit.passthrough,
          badgeContent: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(count.toString(),
              style: regularText(8, color: Colors.white),),
          ),
          position: BadgePosition.custom(top: top, start: start),
          badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: Color(0xFFB3261E),
            padding: EdgeInsets.all(padidng!),
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.white, width: 2.5),

            // badgeGradient: badges.BadgeGradient.linear(
            //   colors: [Colors.blue, Colors.yellow],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            elevation: 0,
          ),
          child: SizedBox(
            height: 20,
              width: 20,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ORDER_REQUEST_PAGE);
              },
              child: SvgPicture.asset(
                "assets/icons/order.svg", height: 20,),
            ),
          ),
        )
    );
  }
}
