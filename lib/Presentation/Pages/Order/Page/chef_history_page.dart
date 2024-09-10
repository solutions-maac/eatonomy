import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/chef_order_history_card.dart';
import '../Component/order_history_card.dart';

class ChefHistoryPage extends StatelessWidget {
  const ChefHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      Get.find<OrderController>().status.value="COMPLETED";
      Get.find<OrderController>().orderHistory(isFirstr: true,isChef: true);
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
              controller.list.isEmpty ? EmptyWidget(title: "You Have No Order History",) :
              ListView.builder(
                  controller: controller.controller,
                  itemCount: controller.list.length +
                      (controller.orderPagingCirculer.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.list.length) {
                      return ChefOrderHistoryCard(
                        order: controller.list[index],
                        orderId:controller.list[index].orderId ,
                        createAt:controller.list[index].createdAt ,
                        user: controller.list[index].user,
                        meneName: controller.list[index].menu!.title,
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
