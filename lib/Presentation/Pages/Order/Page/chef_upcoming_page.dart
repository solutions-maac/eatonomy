import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/chef_order_upcoming_card.dart';
import '../Component/order_history_card.dart';
import '../Component/order_upcoming_card.dart';

class ChefUpcomingPage extends StatelessWidget {
  const ChefUpcomingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChefOrderUpcomingCard()
    Future.delayed(Duration.zero,(){
      Get.find<OrderController>().status.value="PROCESSING";
      Get.find<OrderController>().orderHistory(isFirstr: true,isChef: true);
      Get.find<OrderController>().orderMenuHistory();
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GetBuilder<OrderController>(
        assignId: true,
        builder: (controller) {
          return
            Obx(() {
              return controller.orderMenuHistoryCirculer.value
                  ? LoadingWidget() :
              controller.orderMenuResponse.value!.orderStat!.isEmpty ? EmptyWidget(title: "You Have No Upcoming Order",) :
              ListView.builder(
                  itemCount: controller.orderMenuResponse.value!.orderStat!.length,
                  itemBuilder: (context, index) {
                      return ChefOrderUpcomingCard(
                        menu:controller.orderMenuResponse.value!.orderStat![index] ,
                      );
                  }
              );
            });
        },
      ),
    );
  }
}
