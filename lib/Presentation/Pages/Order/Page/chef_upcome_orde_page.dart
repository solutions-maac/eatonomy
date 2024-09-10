import 'package:eatonomy/Data/Model/Order/Order.dart';
import 'package:eatonomy/Presentation/Widgets/EmptyCard/empty_widget.dart';
import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Order/OrderMenu.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../Component/chef_menu_order_list_card.dart';


class ChefOrderUpComePage extends StatelessWidget {
  final OrderMenu? orderMenu;

  const ChefOrderUpComePage({super.key, this.orderMenu});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<OrderController>().orderMenuFullHistory(
          menuId: orderMenu!.menuId);
    });
    return Scaffold(
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
        title: Text('Orders',),
      ),
      body: Container(
        height: 1.0.sh,
        width: 1.0.sw,
        child: ListView(
          children: [
            Container(
                width: 1.0.sw,
                padding: EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Color(0xff00934c), Color(0xff070b37)],)),

              child: Row(
                children: [
                  SizedBox(width: 24,),
                  Container(
                    width: 132,
                    height: 128.04,
                    // margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            orderMenu!.menu!.images![0]),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          orderMenu!.menu!.title ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Wrap(
                          spacing: 8, // space between items
                          children: orderMenu!.menu!.menus!
                              .map((e) =>
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFED000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        23),
                                  ),
                                ),
                                child: InkWell(
                                    onTap: () {},
                                    child: Text(e, style: TextStyle(
                                      color: Color(0xFF02190E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ))),
                              ))
                              .toList(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            GetBuilder<OrderController>(
              assignId: true,
              builder: (controller) {
                return Obx(() {
                  return Container(
                    margin: EdgeInsets.only(top: 12, bottom: 12),
                    child: controller.orderMenuHistoryCirculer.value||controller.orderMenuFullHistoryResponse.value==null
                        ? LoadingWidget()
                        :
                    controller.orderMenuFullHistoryResponse.value!.orders!
                        .isEmpty ? EmptyWidget(title: "You Have No Upcoming Order",) :
                    GroupedListView<Order, String>(
                      shrinkWrap: true,
                      reverse: true,
                      elements: controller.orderMenuFullHistoryResponse.value!.orders!,
                      groupBy: (element) => element.createdAt!.split("T")[0],
                      groupSeparatorBuilder: (String groupByValue) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(groupByValue,
                              style: TextStyle(
                                color: Color(0xFF8D8D8D),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),),
                          ],
                        ),
                      ),
                      itemBuilder: (context, Order element) => ChefMenuUnderOrderCard(
                          order: element),
                      // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                      useStickyGroupSeparators: false, // optional
                      floatingHeader: true, // optional
                      order: GroupedListOrder.ASC, // optional
                    )
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
