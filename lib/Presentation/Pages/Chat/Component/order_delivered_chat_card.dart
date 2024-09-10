import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Dependenci Injection/injection.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';
import '../../../../service/location_service.dart';

class OrderDeliveredChatCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;
  const OrderDeliveredChatCard({Key? key, this.sender, this.controler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Order is delivered. Did you get your parcel?',
          style: TextStyle(
            color: sender!? Colors.white:textColor,
            fontSize: 12,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: 1.0.sw,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.38,
                color:sender!?  Colors.white.withOpacity(0.20000000298023224):Colors.black.withOpacity(0.20000000298023224),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color:sender!? Colors.white:kPrimaryColorx),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      child: SvgPicture.asset("assets/icons/call.svg",color:sender!? Colors.white:kPrimaryColorx),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Call',
                      style: TextStyle(
                        color:sender!? Colors.white:kPrimaryColorx,
                        fontSize: 10,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                height: 30,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color:sender!? Colors.white:kPrimaryColorx),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Yes',
                      style: TextStyle(
                        color:sender!? Colors.white:kPrimaryColorx,
                        fontSize: 10,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

      ],
    );
  }


}
