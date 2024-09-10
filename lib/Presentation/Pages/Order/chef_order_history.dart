import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../GetX Controller/Order/OrderController.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/cart_icon_widget.dart';
import 'Page/cancel_page.dart';
import 'Page/chef_history_page.dart';
import 'Page/chef_upcoming_page.dart';
import 'Page/history_page.dart';
import 'Page/upcoming_page.dart';


class ChefOrderHistoryPage extends StatefulWidget {
  const ChefOrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<ChefOrderHistoryPage> createState() => _ChefOrderHistoryPageState();
}

class _ChefOrderHistoryPageState extends State<ChefOrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FCFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FCFF),
        automaticallyImplyLeading: false,
        title: Text('Order',),
        actions: [
          // Get.find<OrderController>().status.value=="COMPLETED"?SizedBox():
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            height: 34,
            child: GetBuilder<OrderController>(
              assignId: true,
              builder: (controller) {
                return Obx(() {
                  return
                    controller.status.value=="COMPLETED"?SizedBox():
                    controller.circle.value
                        ? LoadingWidget() :
                    CartIconCount(top: -12,count: controller.list.length,padidng: 4);
                });
              },
            ),
          ),
          SizedBox(width: 24,)
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          height: 1.0.sh,
          width: 1.0.sw,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      //This is for background color
                      color: Colors.white.withOpacity(0.0),
                      //This is for bottom border that is needed
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFF5F5F5), width: 2.sp)),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.all(0),
                      labelColor: kPrimaryColorx,
                      unselectedLabelColor: Color(0xFF5C6360),
                      indicatorColor: kPrimaryColorx,

                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: [
                        Tab(
                          child: Text('Upcoming Order',

                          ),
                        ),
                        Tab(
                          child: Text('Order History',

                          ),
                        ),

                      ],
                    ),
                  )
              ),

              SizedBox(height: 6,),
              Expanded(
                flex: 20,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ChefUpcomingPage(),
                    ChefHistoryPage(),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
