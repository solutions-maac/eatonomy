import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Config/text_style.dart';
import 'package:badges/badges.dart' as badges;

import '../../../GetX Controller/Order/OrderController.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import 'Component/chef_order_request_card.dart';


class OrderRequestPage extends StatelessWidget {
  const OrderRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   Get.find<OrderController>().status.value = "PROCESSING";
    //   Get.find<OrderController>().orderHistory(isFirstr: true,isChef: true);
    // });
    return Scaffold(
      backgroundColor: Color(0xFFF9FCFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FCFF),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Order Request',),
      ),
      body: DefaultTabController(
        length: 3,
        child: Container(
          color: Color(0xFFF9FCFF),
          height: 1.0.sh,
          width: 1.0.sw,
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
          child: GetBuilder<OrderController>(
            assignId: true,
            builder: (controller) {
              return Obx(() {
                return
                  controller.circle.value
                    ? LoadingWidget() :
                controller.list.isEmpty ? EmptyWidget(title: "You Have No Order Request",) :
                ListView.builder(
                    controller: controller.controller,
                    itemCount: controller.list.length +
                        (controller.orderPagingCirculer.value ? 1 : 0),
                    itemBuilder:(context,index){
                      if (index < controller.list.length) {
                       return ChefOrderRequetsCard(order:controller.list[index] ,);
                      }else{
                        Timer(const Duration(milliseconds: 30), () {
                          controller.controller.jumpTo(
                              controller.controller.position.maxScrollExtent
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
      ),
    );
  }
}
