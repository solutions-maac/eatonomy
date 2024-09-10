
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_follow_list_view.dart';
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_list_map.dart';
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import 'Component/houre_chip.dart';
import 'Component/rating_chip.dart';

class FollowChefPage extends StatelessWidget {
  const FollowChefPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<ChefController>().onInit();
    Get.find<ChefController>().getFollowChefs(true);
    return Scaffold(
      backgroundColor:  Color(0xFFF9FCFF),
      appBar: AppBar(

        backgroundColor: Color(0xFFF9FCFF),
        title: Text('Followed Chef List',),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
      ),
      body:  Container(
        color:Color(0xFFF9FCFF),
        height: 1.0.sh,
        width: 1.0.sw,
        child: ChefFollowListView(),
      ),
    );
  }


}

