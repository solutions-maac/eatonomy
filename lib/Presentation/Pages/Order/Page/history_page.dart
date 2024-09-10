import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/order_history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}


class _HistoryPageState extends State<HistoryPage> {


  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,(){
      Get.find<OrderController>().status.value="COMPLETED";
      Get.find<OrderController>().orderHistory(isFirstr: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GetBuilder<OrderController>(
        assignId: true,
        builder: (controller) {
          return
            Obx(() {
              return controller.circle.value
                  ? LoadingWidget() :
              controller.list.isEmpty ? EmptyWidget(title: "You Have No History",) :
              ListView.builder(
                  controller: controller.controller,
                  itemCount: controller.list.length +
                      (controller.orderPagingCirculer.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.list.length) {
                      return  OrderHistoryCard(
                        controller: controller,
                        order:controller.list[index] ,
                        orderId:controller.list[index].orderId ,
                        menu: controller.list[index].menu,
                        createdAt: controller.list[index].createdAt,
                        updatedAt:controller.list[index].updatedAt ,
                      );
                    }else{
                      Timer(const Duration(milliseconds: 30), () {
                        controller.controller.jumpTo(
                            controller.controller.position.maxScrollExtent
                        );
                      });
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  }
              );
            });
        },
      ),
    );
  }
}
