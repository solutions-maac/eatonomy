import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../GetX Controller/Menu/MenuController.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import 'Component/wish_card.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<MenuControllerx>().getWishList(isFirst: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FCFF),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text("Wish List"),
      ),
      body: Container(
        color: Color(0xFFF9FCFF),
        height: 1.0.sh,
        width: 1.0.sw,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
        child: GetBuilder<MenuControllerx>(
          assignId: true,
          builder: (controller) {
            return Obx(() {
              return controller.wishcirculer.value
                  ?
              LoadingWidget() :
              controller.wishList.isEmpty ?
              EmptyWidget(title: "You Have No Wish List",) :
                ListView.builder(
                    controller: controller.wishController,
                    itemCount: controller.wishList.length +
                        (controller.wishPagingCirculer.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.wishList.length) {
                      return controller.wishList[index].menu==null?SizedBox():
                      WishCard(
                        controller: controller,
                        menu: controller.wishList[index].menu,
                        craeteat: controller.wishList[index].createdAt,
                      );
                    }else{
                      Timer(const Duration(milliseconds: 30), () {
                        controller.wishController.jumpTo(
                            controller.wishController.position.maxScrollExtent
                        );
                      });
                      return const Center(
                        child: CircularProgressIndicator(),);
                    }
                  }
              );
            });
          },
        ),
      ),
    );
  }
}
