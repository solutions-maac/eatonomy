import 'package:eatonomy/Data/Model/User/Chef.dart';
import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../GetX Controller/Chef/ChefController.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../Home/Component/menu_card.dart';


class HotMenuPage extends StatelessWidget {
  final String? id;

  const HotMenuPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero, () {
      Get.find<ChefController>().onInit();
      Get.find<ChefController>().getChefDetails(id!);
    });
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset(
                  "assets/icons/arrow-left.svg", height: 20, width: 20,))),
        title: Text('Hot Deals Menu',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<ChefController>(
        assignId: true,
        builder: (chefController) {
          return Obx(() {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child:
                chefController.circuler.value?LoadingWidget():
                chefController.menusCopy.where((element) => element.isHotDeal!).toList().isEmpty ? Center(
                    child: EmptyWidget()) :
                ListView.builder(
                  itemCount: chefController.menusCopy.where((element) => element.isHotDeal!).toList().length,
                  itemBuilder: (context, index) {
                    return MenuCard(
                      isLogin: chefController.token!="",
                      isHeart: false,
                      menu: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index],
                      type: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .type,
                      createAt: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index].createdAt,
                      image:chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .images!,
                      iteams: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .menus!,
                      title:chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .title,
                      price: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .price.toString(),
                      chefName: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index].chef!.name,
                      chefPP: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .chef!
                          .profilePicture,
                      deliveryInst: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .deliveryInstruction,
                      orderInst: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .orderTakingInstruction,
                      isDeliver: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index]
                          .isDeliveryAvailable,
                      isPickUp: chefController.menusCopy.where((element) => element.isHotDeal!).toList()[index].isPickUpAvailable,
                    );
                  },
                ),
            );
          });
        },
      ),
    );
  }
}
