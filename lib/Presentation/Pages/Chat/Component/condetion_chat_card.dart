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

class CondetionChatCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;
  const CondetionChatCard({Key? key, this.sender, this.controler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'This order will be picked up not delivered. Have you agreed ?',
          style: TextStyle(
            color:sender!? Colors.white:textColor,
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
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 30,

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
                        'Disagreed',
                        textAlign: TextAlign.right,
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
            ),
            SizedBox(width: 10,),
            Expanded(
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 30,

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
                        'Agreed',
                        textAlign: TextAlign.right,
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
            ),
          ],
        )

      ],
    );
  }


}
