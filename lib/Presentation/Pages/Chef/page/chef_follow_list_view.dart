import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/chef_list_card.dart';

class ChefFollowListView extends StatelessWidget {
  const ChefFollowListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChefController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: controller.circleFollow.value ? LoadingWidget() :
            controller.listFollow.isEmpty ? EmptyWidget(title: "There Is No Followed Chef",) :
            ListView.builder(
              controller: controller.controllerFollow,
              itemCount: controller.listFollow.length +
                  (controller.followChefPagingCirculer.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < controller.listFollow.length) {
                  return controller.listFollow[index].chef!=null?
                  ChefListCard(
                    directHomePage: false,
                    id: controller.listFollow[index].chefId,
                    controller: controller,
                    locationModel: controller.listFollow[index].chef!.location,
                    items: controller.listFollow[index].chef!.numberOfItem??0,
                    isHotDeal: controller.listFollow[index].chef!.isHotDeal,
                    rating:controller.listFollow[index].chef!.rating,
                    address: controller.listFollow[index].chef!.address,
                    shop: controller.listFollow[index].chef!.address! ,
                    image: controller.listFollow[index].chef!.profilePicture,
                    name: controller.listFollow[index].chef!.name,)
                      :SizedBox();
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    controller.controllerFollow
                        .jumpTo(controller.controllerFollow.position
                        .maxScrollExtent);
                  });
                  return const Center(
                    child: CircularProgressIndicator(),);
                }
              },
            ),
          );
        });
      },
    );
  }
}
