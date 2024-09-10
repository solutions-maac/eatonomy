import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/order_history_card.dart';
import '../Component/order_upcoming_card.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      Get.find<OrderController>().status.value="PROCESSING";
      Get.find<OrderController>().orderHistory(isFirstr: true);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GetBuilder<OrderController>(
        assignId: true,
        builder: (controller) {
          return
            Obx(() {
              return controller.circle.value
                  ? LoadingWidget() :
              controller.list.isEmpty ? EmptyWidget(title: "You Have No Upcoming Order",) :
              ListView.builder(
                  controller: controller.controller,
                  itemCount: controller.list.length +
                      (controller.orderPagingCirculer.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.list.length) {
                      return OrderUpcomingCard(
                        order: controller.list[index],
                        ordertype: controller.list[index].deliveryOption,
                        orderId: controller.list[index].orderId,
                        image:controller.list[index].menu!.images![0] ,
                        menu:controller.list[index].menu! ,
                        title: controller.list[index].menu!.title,
                        chef:controller.list[index].chef!.name ,
                        location:controller.list[index].deliveryAddress,
                      );
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
    );
  }
}
