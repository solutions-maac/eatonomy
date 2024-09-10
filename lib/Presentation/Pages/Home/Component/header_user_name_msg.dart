import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../GetX Controller/Home/HomeController.dart';


class HeaderUserMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final int currentHour = currentTime.hour;

    String greeting;

    if (currentHour < 12) {
      greeting = 'Good Morning';
    } else if (currentHour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return GetBuilder<HomeController>(
      assignId: true,
      builder: (logic) {
        return Obx(() {
          return Text((greeting +" "+ logic.name.value).length>25?(greeting +" "+ logic.name.value).substring(0,24)+"...":greeting +" "+ logic.name.value,
            style: TextStyle(
              color: Color(0xFF0B0D0F),
              fontSize: 20.sp,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.48,
            ),);
        });
      },
    );
  }
}



