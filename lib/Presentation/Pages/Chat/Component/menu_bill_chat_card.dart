import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Dependenci Injection/injection.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';
import '../../../../service/location_service.dart';

class MenuBillChatCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;
  const MenuBillChatCard({Key? key, this.sender, this.controler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Your menu bill ',
                style: TextStyle(
                  color: sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w400,

                ),
              ),
              TextSpan(
                text: '\$120\n',
                style: TextStyle(
                  color: sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,

                ),
              ),
              TextSpan(
                text: 'Delivery charge ',
                style: TextStyle(
                  color: sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w400,

                ),
              ),
              TextSpan(
                text: '\$12\n',
                style: TextStyle(
                  color: sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,

                ),
              ),
              TextSpan(
                text: 'Total ',
                style: TextStyle(
                  color: sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: '\$132',
                style: TextStyle(
                  color:sender!? Colors.white:textColor,
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Text(
          'Please make payment in this address.',
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
        InkWell(
          onTap: (){

          },
          child: Container(
            height: 30,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color:sender!? Colors.white:kPrimaryColorx),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Make payment',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color:sender!? Colors.white:kPrimaryColorx,
                    fontSize: 12,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }


}
