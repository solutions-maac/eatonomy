import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import 'bar_chart_chef.dart';
import 'graph_chart_chef.dart';
import 'graph_chart_chef2.dart';
import 'linear_chart_chef.dart';

class ChefDashboardPage extends StatefulWidget {
  final String?id;
  final bool?localUser;

  const ChefDashboardPage({Key? key, this.id, this.localUser = false})
      : super(key: key);

  @override
  State<ChefDashboardPage> createState() => _ChefDashboardPageState();
}

class _ChefDashboardPageState extends State<ChefDashboardPage> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Get.find<ChefController>().getChefOrderPerformance();
      Get.find<ChefController>().getChefTotalIncome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<ChefController>().getChefOrderPerformance();
      Get.find<ChefController>().getChefTotalIncome();
    });

    return GetBuilder<ChefController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Container(
            height: 1.0.sh,
            width: 1.0.sw,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: ListView(
              children: [
                controller.circleOrderPerfomance.value?
                LoadingWidget()
                    :
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 96,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50, color: Color(0x7FCCCBD6)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x19000026),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Order',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                 Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.orderPerfomanceResponse.value!.totalOrder==null?"0.0":controller.orderPerfomanceResponse.value!.totalOrder!.toDouble().toStringAsFixed(1).toString(),
                                      style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 20,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              // color: Colors.green
                                            ),
                                            child: controller.orderPerfomanceResponse.value!.orderIncrease!.toInt()<0?
                                            SvgPicture.asset(
                                                "assets/icons/arrow-down.svg")
                                                :
                                            SvgPicture.asset(
                                                "assets/icons/arrow-up.svg") ,
                                          ),
                                          const SizedBox(width: 2),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${controller.orderPerfomanceResponse.value!.orderIncrease!}% ',
                                                  style: TextStyle(
                                                    color: Color(0xFF027947),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'vs last month',
                                                  style: TextStyle(
                                                    color: Color(0xFF7E8795),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: TextStyle(
                                                    color: Color(0xFF027947),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 39,
                                  height: 18,
                                  child: controller.orderPerfomanceResponse.value!.orderIncrease!.toInt()<0?
                                  SvgPicture.asset(
                                      "assets/icons/chart_dowon.svg")
                                      :
                                  SvgPicture.asset(
                                    "assets/icons/chart_up.svg"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: Container(
                        height: 96,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50, color: Color(0x7FCCCBD6)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x19000026),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Income',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                   controller.orderPerfomanceResponse.value!.totalIncome==null?"0.0": controller.orderPerfomanceResponse.value!.totalIncome!.toDouble().toStringAsFixed(1).toString(),
                                      style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 20,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              // color: Colors.green
                                            ),
                                            child:controller.orderPerfomanceResponse.value!.incomeIncrease!.toInt()<0?
                                            SvgPicture.asset(
                                                "assets/icons/arrow-down.svg")
                                                :
                                            SvgPicture.asset(
                                                "assets/icons/arrow-up.svg") ,
                                          ),
                                          const SizedBox(width: 2),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${controller.orderPerfomanceResponse.value!.incomeIncrease!.toDouble().toStringAsFixed(1).toString()}% ',
                                                  style: TextStyle(
                                                    color: Color(0xFF027947),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'vs last month',
                                                  style: TextStyle(
                                                    color: Color(0xFF7E8795),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: TextStyle(
                                                    color: Color(0xFF027947),
                                                    fontSize: 8,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 39,
                                  height: 18,
                                  child:controller.orderPerfomanceResponse.value!.incomeIncrease!.toInt()<0?
                                  SvgPicture.asset(
                                      "assets/icons/chart_dowon.svg")
                                  :
                                  SvgPicture.asset(
                                  "assets/icons/chart_up.svg"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),



                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 108,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPrimaryColorx,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          padding: EdgeInsets.all(12),
                          dropdownColor: kPrimaryColorx,
                          icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 16,),
                          value: controller.orderPerfomanceFilter.value,
                          // borderRadius: BorderRadius.circular(12),
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                          onChanged: (newValue) {
                            controller.orderPerfomanceFilter.value=newValue!;
                            controller.getChefOrderPerformance();
                            controller.orderTotalIncomeFilter.value=newValue;
                            controller.getChefTotalIncome();

                          },
                          items: ["Month","Daily"]
                              .map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value, style: TextStyle(fontSize: 12),),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16,),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF3FFF9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14101828),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: controller.circleOrderPerfomance.value?LoadingWidget():Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Order Performance',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 20,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Expanded(
                          //   flex: 1,
                          //   child: ,
                          // ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      BarChartChef(controller: controller,sales: controller.orderPerfomanceResponse.value!.sales!,)
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF3FFF9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14101828),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child:controller.circleOrderPerfomance.value?LoadingWidget(): Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Unique & Total User',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 20,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     height: 38,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8),
                          //       color: kPrimaryColorx,
                          //     ),
                          //     child: DropdownButtonHideUnderline(
                          //       child: DropdownButton<String>(
                          //         padding: EdgeInsets.all(12),
                          //         dropdownColor: kPrimaryColorx,
                          //         icon: Icon(Icons.keyboard_arrow_down,
                          //           color: Colors.white, size: 16,),
                          //         value: "Month",
                          //         // borderRadius: BorderRadius.circular(12),
                          //         style: TextStyle(
                          //             color: Colors.white, fontSize: 12),
                          //         onChanged: (newValue) {
                          //
                          //         },
                          //         items: ["Month"]
                          //             .map<DropdownMenuItem<String>>((
                          //             String value) {
                          //           return DropdownMenuItem<String>(
                          //             value: value,
                          //             child: Text(
                          //               value, style: TextStyle(fontSize: 12),),
                          //           );
                          //         }).toList(),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      LinearChartChef(controller: controller,sales: controller.orderPerfomanceResponse.value!.sales, uniqueUser: controller.orderPerfomanceResponse.value!.uniqueOrders,)
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF3FFF9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14101828),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child:controller.circleOrderTotalIncome.value?LoadingWidget(): Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Total Income',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 20,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     height: 38,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8),
                          //       color: kPrimaryColorx,
                          //     ),
                          //     child: DropdownButtonHideUnderline(
                          //       child: DropdownButton<String>(
                          //         padding: EdgeInsets.all(12),
                          //         dropdownColor: kPrimaryColorx,
                          //         icon: Icon(Icons.keyboard_arrow_down,
                          //           color: Colors.white, size: 16,),
                          //         value: controller.orderTotalIncomeFilter.value,
                          //         // borderRadius: BorderRadius.circular(12),
                          //         style: TextStyle(
                          //             color: Colors.white, fontSize: 12),
                          //         onChanged: (newValue) {
                          //           controller.orderTotalIncomeFilter.value=newValue!;
                          //           controller.getChefTotalIncome();
                          //         },
                          //         items: ["Month","Daily"]
                          //             .map<DropdownMenuItem<String>>((
                          //             String value) {
                          //           return DropdownMenuItem<String>(
                          //             value: value,
                          //             child: Text(
                          //               value, style: TextStyle(fontSize: 12),),
                          //           );
                          //         }).toList(),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      GraphChartChef2(controller: controller,sales: controller.orderTotalIncomeResponse.value!.sales,)
                    ],
                  ),
                ),

              ],
            ),
          );
        });
      },
    );
  }
}

