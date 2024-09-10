import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/chef_list_card.dart';

class ChefListView extends StatelessWidget {
  const ChefListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChefController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: controller.circle.value ? LoadingWidget() :
            controller.list.isEmpty ? EmptyWidget() :
            ListView.builder(
              controller: controller.controller,
              itemCount: controller.list.length + (controller.chefPagingCirculer.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < controller.list.length) {
                  return InkWell(
                      onTap: (){
                        if(controller.token.value==""){

                        }else{
                          Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                            'id': controller.list[index].id,
                            'localuser': true
                          });
                        }

                      },
                    child: ChefListCard(
                      id:  controller.list[index].id,
                      items: controller.list[index].numberOfItem,
                      controller: controller,
                      locationModel: controller.list[index].location,
                      isHotDeal: controller.list[index].isHotDeal,
                      rating: controller.list[index].rating,
                      address: controller.list[index].address,
                      image: controller.list[index].profilePicture,name: controller.list[index].name,));
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    controller.controller
                        .jumpTo(controller.controller.position
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
