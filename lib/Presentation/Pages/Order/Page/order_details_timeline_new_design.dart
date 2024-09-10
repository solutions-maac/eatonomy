import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Constants/Strings/app_strings.dart';
import 'package:eatonomy/Presentation/Widgets/Button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';
import '../../Home/Component/header_user_name_msg.dart';
import '../Component/order_timeline_delivered_log_card.dart';
import '../Component/order_timeline_log_card.dart';
import '../Component/order_timeline_payment_log_card.dart';
import '../Component/user_history_card.dart';


class OrderTimelineDetailsPageNewDesign extends StatefulWidget {
  final String? ordrId;

  const OrderTimelineDetailsPageNewDesign({Key? key, this.ordrId})
      : super(key: key);

  @override
  State<OrderTimelineDetailsPageNewDesign> createState() =>
      _OrderTimelineDetailsPageNewDesignState();
}

class _OrderTimelineDetailsPageNewDesignState
    extends State<OrderTimelineDetailsPageNewDesign> {

  // final globalkey = GlobalKey<FormState>();
  List<String> fromNumberList = [];
  List<String> toNumberList = [];
  TextEditingController paymentTextController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Get.find<OrderController>().onInit();
      Get.find<OrderController>().orderDetails(widget.ordrId);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero,() {
    //   Get.find<OrderController>().showRateNowAlertDialog(context: context,orderid: widget.ordrId);
    // });
    return GetBuilder<OrderController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        "assets/icons/arrow-left.svg", height: 20,
                        width: 20,))),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Text("Order Progress"),
              actions: [
                Container(
                    margin: EdgeInsets.only(right: 24),
                    child:controller.orderDetailsResponse.value == null ?
                    LoadingWidget() : InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CHAT_PAGE, arguments: {
                            "order": controller
                                .orderDetailsResponse.value!
                                .order!
                          });
                        },
                        child: SvgPicture.asset("assets/icons/message.svg")
                    )
                )
              ],

            ),
            body: RefreshIndicator(
                onRefresh: () => refreshList(context),
                child: controller.orderDetailsResponse.value == null ?
                LoadingWidget() :
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        // color: kPrimaryColorx,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(1, 0.05),
                            end: Alignment(-1.00, -0.05),
                            colors: [
                              Color(0xFF00934C),
                              Color(0xFF070B37)
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CachedNetworkImage(
                                        imageUrl: controller
                                            .orderDetailsResponse.value!
                                            .order!.menu!.images![0],
                                        placeholder: (context, url) =>
                                            LoadingWidget(),
                                        imageBuilder: (context,
                                            image) =>
                                            Container(
                                              width: 121,
                                              height: 104,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        12)),
                                              ),
                                            )),
                                  ),
                                  SizedBox(width: 16,),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "Order Id: " + controller
                                              .orderDetailsResponse
                                              .value!
                                              .order!.orderId
                                              .toString() +
                                              "\n" +
                                              controller
                                                  .orderDetailsResponse
                                                  .value!.order!.menu!
                                                  .title!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Wrap(
                                          spacing: 8,
                                          // space between items
                                          children: controller
                                              .orderDetailsResponse
                                              .value!
                                              .order!.menu!.menus!.map((
                                              e) =>
                                              Container(
                                                height: 26,
                                                margin: EdgeInsets.only(
                                                    bottom: 10),
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: ShapeDecoration(
                                                  color: Color(
                                                      0xFFFED000),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(23),
                                                  ),
                                                ),
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                        color: Color(
                                                            0xFF02190E),
                                                        fontSize: 12,
                                                        fontFamily: 'Satoshi',
                                                        fontWeight: FontWeight
                                                            .w400,
                                                      ),
                                                    )),
                                              ))
                                              .toList(),
                                        ),
                                        SizedBox(height: 2,),
                                        Row(
                                          children: [
                                            SizedBox(),
                                            Expanded(
                                                flex: 5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                      width: 1.0.sw,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 0.38,
                                                            color: Colors
                                                                .white
                                                                .withOpacity(
                                                                0.15000000596046448),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .orderDetailsResponse
                                                              .value!
                                                              .order!
                                                              .deliveryOption! +
                                                              ' Time ',
                                                          textAlign: TextAlign
                                                              .right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),
                                                        Text(

                                                          convertTo12HourFormat(
                                                              controller.orderDetailsResponse.value!.order!.deliveryFrom.toString()) +
                                                              " - " +
                                                              convertTo12HourFormat(controller.orderDetailsResponse.value!.order!.deliveryTo.toString()),
                                                          textAlign: TextAlign
                                                              .right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Container(
                                                      width: 1.0.sw,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 0.38,
                                                            color: Colors
                                                                .white
                                                                .withOpacity(
                                                                0.15000000596046448),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Menu Quantity ',
                                                          textAlign: TextAlign
                                                              .right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .orderDetailsResponse
                                                              .value!
                                                              .order!
                                                              .quantity
                                                              .toString(),
                                                          textAlign: TextAlign
                                                              .right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Container(
                                                      width: 1.0.sw,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 0.38,
                                                            color: Colors
                                                                .white
                                                                .withOpacity(
                                                                0.15000000596046448),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,),

                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children:
                                                        [
                                                          Text(
                                                            'Menu Price \$',
                                                            textAlign: TextAlign
                                                                .right,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .isHotDeal !=
                                                                null &&
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .isHotDeal!
                                                                ?
                                                            (controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price! -
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .discountedPrice!)
                                                                .toStringAsFixed(2)
                                                                :
                                                            controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price!
                                                                .toStringAsFixed(2),
                                                            textAlign: TextAlign
                                                                .right,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                        ]
                                                    ),

                                                    SizedBox(
                                                      height: 8,),
                                                    Container(
                                                      width: 1.0.sw,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 0.38,
                                                            color: Colors
                                                                .white
                                                                .withOpacity(
                                                                0.15000000596046448),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children:
                                                        [
                                                          Text(
                                                            'Delivery Fee \$',
                                                            textAlign: TextAlign
                                                                .right,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            (controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .deliveryCharge !=
                                                                null
                                                                ? controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .deliveryCharge!.toDouble()
                                                                .toStringAsFixed(2)
                                                                : ""),
                                                            textAlign: TextAlign
                                                                .right,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Container(
                                                      width: 1.0.sw,
                                                      decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 0.38,
                                                            color: Colors
                                                                .white
                                                                .withOpacity(
                                                                0.15000000596046448),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Total Amount \$',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                            ),
                                                          ),
                                                          Text(
                                                            (controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .deliveryCharge !=
                                                                null
                                                                ?
                                                            ((controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .isHotDeal !=
                                                                null &&
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .isHotDeal!
                                                                ?
                                                            (controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price! -
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .discountedPrice!)
                                                                :
                                                            controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price! *
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .quantity!) +
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .deliveryCharge!)
                                                                .toStringAsFixed(2)
                                                                :

                                                            ((controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .isHotDeal !=
                                                                null &&
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .isHotDeal!
                                                                ?
                                                            (controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price! -
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .menu!
                                                                    .discountedPrice!)
                                                                :
                                                            controller
                                                                .orderDetailsResponse
                                                                .value!
                                                                .order!
                                                                .menu!
                                                                .price!) *
                                                                controller
                                                                    .orderDetailsResponse
                                                                    .value!
                                                                    .order!
                                                                    .quantity!)
                                                                .toStringAsFixed(2)),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                            ),
                                                          ),
                                                        ]
                                                    ),

                                                    SizedBox(
                                                      height: 22,),


                                                  ],
                                                )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                            ),

                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8),
                          child:
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(height: 16,),
                              Text(
                                "You need to discuss the following to accept this user's order",
                                style: TextStyle(
                                  color: Color(0xFF5C6360),
                                  fontSize: 13,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 16,),

                              ///order Placed
                              TimelineTile(
                                hasIndicator: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 28,
                                  indicatorXY: 0.0,
                                  color: controller.orderDetailsResponse
                                      .value!.order!.customerStatus ==
                                      "REJECTED"||controller.orderDetailsResponse
                                      .value!.order!.customerStatus ==
                                      "DateTime_Reject" ? Color(
                                      0xFFF32828) :
                                  kPrimaryColorx,
                                  padding: const EdgeInsets.all(3),
                                  drawGap: true,
                                  height: 28,
                                  indicator: Container(
                                      width: 24,
                                      height: 24,
                                      padding: EdgeInsets.all(6),
                                      decoration: ShapeDecoration(
                                        color: controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "REJECTED"||controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "DateTime_Reject" ?
                                        Color(0xFFF32828)
                                            :
                                        Color(0xFF00934C),
                                        shape: OvalBorder(),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/calender.svg",
                                        height: 12,
                                        color: Colors.white,)
                                  ),
                                ),
                                beforeLineStyle: LineStyle(thickness: 4,
                                    color: controller
                                        .orderDetailsResponse
                                        .value!.order!.customerStatus ==
                                        "REJECTED" || controller
                                        .orderDetailsResponse
                                        .value!.order!.customerStatus ==
                                        "DateTime_Reject" ? Color(
                                        0xFFF32828) :
                                    kPrimaryColorx),
                                alignment: TimelineAlign.start,
                                endChild: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 12, top: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Date & Time',
                                        style: TextStyle(
                                          color: Color(0xFF02190E),
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      Column(
                                        children: controller
                                            .orderDetailsResponse.value!
                                            .order!.dateAndTimeLogs!
                                            .asMap().entries.map((e) {
                                          return OrderLogCard(
                                              index: e.key,
                                              controller: controller,
                                              orderLog: e.value,
                                              order: controller
                                                  .orderDetailsResponse
                                                  .value!.order!);
                                        }).toList(),
                                      ),


                                      SizedBox(height: 18,),

                                    ],
                                  ),
                                ),
                                // startChild: Container(
                                //   color: Colors.amberAccent,
                                // ),
                              ),


                              ///payment
                              TimelineTile(
                                hasIndicator: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 28,
                                  indicatorXY: 0.0,
                                  color: Color(0xFFDBEEE5),
                                  padding: const EdgeInsets.all(3),
                                  drawGap: true,
                                  height: 28,
                                  indicator: Container(
                                      width: 24,
                                      height: 24,
                                      padding: EdgeInsets.all(6),
                                      decoration: ShapeDecoration(
                                        color: controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "PAYMENT" || controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "ORDER_DELIVERY" ||
                                            controller
                                                .orderDetailsResponse
                                                .value!
                                                .order!
                                                .customerStatus ==
                                                "DELIVERED" ?
                                        kPrimaryColorx
                                            :
                                        Color(0xFFDBEEE5),
                                        shape: OvalBorder(),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/payment.svg",
                                        height: 12,
                                        color: controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "PAYMENT" || controller
                                            .orderDetailsResponse.value!
                                            .order!.customerStatus ==
                                            "ORDER_DELIVERY" ||
                                            controller
                                                .orderDetailsResponse
                                                .value!
                                                .order!
                                                .customerStatus ==
                                                "DELIVERED" ?
                                        Colors.white
                                            : kPrimaryColorx,)
                                  ),
                                  // iconStyle: IconStyle(
                                  //   color: Colors.white,
                                  //   iconData: Icons.done,
                                  // ),
                                ),
                                beforeLineStyle: LineStyle(thickness: 4,
                                    color: controller
                                        .orderDetailsResponse
                                        .value!.order!.customerStatus ==
                                        "PAYMENT" ||
                                        controller.orderDetailsResponse
                                            .value!.order!
                                            .customerStatus ==
                                            "ORDER_DELIVERY" ||
                                        controller.orderDetailsResponse
                                            .value!.order!
                                            .customerStatus ==
                                            "DELIVERED"
                                        ?
                                    kPrimaryColorx
                                        : Color(0xFFDBEEE5)),
                                alignment: TimelineAlign.start,
                                endChild: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 12, top: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Make Payment',
                                        style: TextStyle(
                                          color: Color(0xFF02190E),
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      controller.orderDetailsResponse
                                          .value!.order!.paymentLogs !=
                                          null ?
                                      Column(
                                          children: controller
                                              .orderDetailsResponse
                                              .value!
                                              .order!.paymentLogs!
                                              .asMap()
                                              .entries.map((e) {
                                            return OrderPaymentLogCard(
                                                index: e.key,
                                                controller: controller,
                                                orderLog: e.value,
                                                order: controller
                                                    .orderDetailsResponse
                                                    .value!.order!);
                                          }).toList())
                                          :

                                      controller
                                          .orderPaymentRequestcirculer
                                          .value ? LoadingWidget() :

                                      controller.orderDetailsResponse
                                          .value!.order!
                                          .customerStatus ==
                                          "PAYMENT" &&
                                          controller
                                              .orderDetailsResponse
                                              .value!.order!
                                              .paymentLogs == null &&
                                          controller.role != "CHEF" ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Pay \$${(controller.orderDetailsResponse.value!.order!.deliveryCharge != null ?
                                                  ((controller.orderDetailsResponse.value!.order!.menu!.isHotDeal != null && controller.orderDetailsResponse.value!.order!.menu!.isHotDeal! ? (double.parse((controller.orderDetailsResponse.value!.order!.menu!.price!.toStringAsFixed(2))) - double.parse(controller.orderDetailsResponse.value!.order!.menu!.discountedPrice!.toStringAsFixed(2)))
                                                      : 
                                                  double.parse(controller.orderDetailsResponse.value!.order!.menu!.price!.toStringAsFixed(2)) * controller.orderDetailsResponse.value!.order!.quantity!) + controller.orderDetailsResponse.value!.order!.deliveryCharge!).toString() : ((controller.orderDetailsResponse.value!.order!.menu!.isHotDeal != null && controller.orderDetailsResponse.value!.order!.menu!.isHotDeal! ? (double.parse(controller.orderDetailsResponse.value!.order!.menu!.price!.toStringAsFixed(2)) - double.parse(controller.orderDetailsResponse.value!.order!.menu!.discountedPrice!.toStringAsFixed(2))) : double.parse(controller.orderDetailsResponse.value!.order!.menu!.price!.toStringAsFixed(2))) * controller.orderDetailsResponse.value!.order!.quantity!).toStringAsFixed(2))} to confirm order by sending payment to the specified instruction: \n',
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF5C6360),
                                                    fontSize: 12,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight
                                                        .w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller
                                                      .orderDetailsResponse
                                                      .value!.order!
                                                      .chef!
                                                      .paymentInstruction ??
                                                      "",
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF00934C),
                                                    fontSize: 12,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight
                                                        .w400,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 6,),
                                          controller.filePath.value !=
                                              ""
                                              ?
                                          Container(
                                            width: 312,
                                            height: 180,
                                            margin: EdgeInsets.only(
                                                bottom: 10),
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: FileImage(File(
                                                    controller.filePath
                                                        .value)),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                            ),
                                          )
                                              :
                                          SizedBox(),
                                          controller.imageCirculer.value
                                              ? LoadingWidget()
                                              :


                                          TextFormField(
                                            validator: (value) {
                                              if (value == null || value
                                                  .isEmpty) {
                                                return 'Enter your note';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType
                                                .text,
                                            controller: paymentTextController,
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                controller
                                                    .orderPaymentNote
                                                    .value = text;
                                              } else {
                                                controller
                                                    .orderPaymentNote
                                                    .value = "";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Send Your Payment Details",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey),
                                              suffixIcon: IconButton(
                                                icon: SvgPicture.asset(
                                                  "assets/icons/gallery-export.svg",
                                                  height: 20,
                                                  color: kPrimaryColorx,),
                                                onPressed: () {
                                                  controller.filepic();
                                                },
                                              ),
                                              fillColor: textFieldBackground,
                                              filled: true,
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  vertical: 18.h,
                                                  horizontal: 12.0),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        10.0)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(
                                                    color: textFieldBackground,
                                                    width: 1.0),
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        10.0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(
                                                    color: textFieldBackground,
                                                    width: 2.0),
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        10.0)),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              CustomButton(
                                                height: 28,
                                                width: 65,
                                                color: kPrimaryColorx,
                                                onTap: () {
                                                  controller.oderpaymenrResquest(widget.ordrId);
                                                  controller.update();
                                                },
                                                textColor: Colors.white,
                                                title: "Send",
                                                textSize: 10,
                                                boder: false,
                                                orderRadius: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ) : SizedBox(),

                                      // SizedBox(height: 10,),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       width: 14,
                                      //       height: 14,
                                      //       decoration: ShapeDecoration(
                                      //         image: DecorationImage(
                                      //           image: NetworkImage("https://via.placeholder.com/14x14"),
                                      //           fit: BoxFit.fill,
                                      //         ),
                                      //         shape: OvalBorder(),
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: 4,),
                                      //     Text(
                                      //       'You',
                                      //       style: TextStyle(
                                      //         color: Color(0xFF02190E),
                                      //         fontSize: 12,
                                      //         fontFamily: 'Sora',
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   'Order Id #369486',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF5C6360),
                                      //     fontSize: 12,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Container(
                                      //   width: 115,
                                      //   height: 60,
                                      //   padding: EdgeInsets.all(16),
                                      //   decoration: ShapeDecoration(
                                      //     color: Color(0xFF5C6360),
                                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      //   ),
                                      //   child: SvgPicture.asset("assets/icons/image_show.svg",height: 24,width: 24,),
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   '8:30 PM',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF00934C),
                                      //     fontSize: 8,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),


                                      // SizedBox(height: 10,),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       width: 14,
                                      //       height: 14,
                                      //       decoration: ShapeDecoration(
                                      //         image: DecorationImage(
                                      //           image: NetworkImage("https://via.placeholder.com/14x14"),
                                      //           fit: BoxFit.fill,
                                      //         ),
                                      //         shape: OvalBorder(),
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: 4,),
                                      //     Text(
                                      //       'You',
                                      //       style: TextStyle(
                                      //         color: Color(0xFF02190E),
                                      //         fontSize: 12,
                                      //         fontFamily: 'Sora',
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   'Capacity issue',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF5C6360),
                                      //     fontSize: 12,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Row(
                                      //   children: [
                                      //     Icon(Icons.done_all,size: 14,color: kPrimaryColorx,),
                                      //     SizedBox(width: 4,),
                                      //     Text(
                                      //       'Accepted',
                                      //       style: TextStyle(
                                      //         color: Color(0xFF00934C),
                                      //         fontSize: 12,
                                      //         fontFamily: 'Sora',
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   '8:30 PM',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF00934C),
                                      //     fontSize: 8,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                // startChild: Container(
                                //   color: Colors.amberAccent,
                                // ),
                              ),


                              ///Order delivery
                              TimelineTile(
                                isLast: true,
                                hasIndicator: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 28,
                                  indicatorXY: 0.0,
                                  color: Color(0xFFDBEEE5),
                                  padding: const EdgeInsets.all(3),
                                  drawGap: true,
                                  height: 28,
                                  indicator: Container(
                                      width: 24,
                                      height: 24,
                                      padding: EdgeInsets.all(6),
                                      decoration: ShapeDecoration(
                                        color: controller.orderDetailsResponse.value!.order!.customerStatus == "ORDER_DELIVERY" ||
                                            controller.orderDetailsResponse.value!.order!.customerStatus ==
                                                "DELIVERED" ?
                                        kPrimaryColorx
                                            : Color(0xFFDBEEE5),
                                        shape: OvalBorder(),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/box.svg",
                                        height: 12,
                                        color: controller.orderDetailsResponse.value!.order!.customerStatus ==
                                            "ORDER_DELIVERY" ||
                                            controller.orderDetailsResponse.value!.order!.customerStatus ==
                                                "DELIVERED" ?
                                        Colors.white : kPrimaryColorx,)
                                  ),
                                  // iconStyle: IconStyle(
                                  //   color: Colors.white,
                                  //   iconData: Icons.done,
                                  // ),
                                ),
                                beforeLineStyle: LineStyle(thickness: 4,
                                    color: controller.orderDetailsResponse.value!.order!.customerStatus == "ORDER_DELIVERY" ||
                                        controller.orderDetailsResponse.value!.order!
                                            .customerStatus ==
                                            "DELIVERED"
                                        ?
                                    kPrimaryColorx
                                        : Color(0xFFDBEEE5)),
                                alignment: TimelineAlign.start,
                                endChild: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 12, top: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Order Delivery',
                                        style: TextStyle(
                                          color: Color(0xFF02190E),
                                          fontSize: 16,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 12,),


                                      controller.orderDetailsResponse .value!.order!.deliveryLogs != null &&
                                          controller.orderDetailsResponse.value!.order!.deliveryLogs!.isNotEmpty
                                          ?
                                      Column(
                                          children: controller.orderDetailsResponse.value!.order!.deliveryLogs!.asMap().entries.map((e) {
                                            return OrderDelivredLogCard(
                                                contextx: context,
                                                index: e.key,
                                                controller: controller,
                                                orderLog: e.value,
                                                order: controller
                                                    .orderDetailsResponse
                                                    .value!.order!);}).toList())
                                          :
                                      controller.role == "CHEF" && controller.orderDetailsResponse.value!.order!.customerStatus ==
                                              "ORDER_DELIVERY" ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text.rich(
                                            textAlign: TextAlign.start,
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: controller
                                                      .orderDetailsResponse
                                                      .value!.order!.deliveryOption=="Delivery"? 'Order have to deliver at\n':"Order have to pick up at  \n",
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF5C6360),
                                                    fontSize: 12,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight
                                                        .w400,
                                                  ),

                                                ),
                                                TextSpan(
                                                  text: controller
                                                      .orderDetailsResponse
                                                      .value!.order!
                                                      .deliveryDay! +
                                                      " " +
                                                      convertTo12HourFormat(
                                                          controller
                                                              .orderDetailsResponse
                                                              .value!
                                                              .order!
                                                              .deliveryFrom) +
                                                      "-" +
                                                      convertTo12HourFormat(
                                                          controller
                                                              .orderDetailsResponse
                                                              .value!
                                                              .order!
                                                              .deliveryTo),
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xFF00934C),
                                                    fontSize: 12,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight
                                                        .w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          controller.orderCompletecirculer.value ||controller.orderReadyForcirculer.value? LoadingWidget() :
                                          CustomButton(
                                            height: 28,
                                            width:controller
                                                .orderDetailsResponse
                                                .value!.order!.deliveryOption=="Delivery"? 68:120,
                                            color: kPrimaryColorx,
                                            onTap: () {
                                              // controller.oderReadyFor(widget.ordrId);
                                              controller
                                                  .orderDetailsResponse
                                                  .value!.order!.deliveryOption=="Delivery"?
                                              controller.oderComplete(widget.ordrId, context):
                                              controller.oderReadyFor(widget.ordrId);
                                            },
                                            textColor: Colors.white,
                                            title: controller
                                                .orderDetailsResponse
                                                .value!.order!.deliveryOption=="Delivery"? "Deliver":"Ready for Pick up",
                                            textSize: 10,
                                            boder: false,
                                            orderRadius: 5,
                                          ),
                                        ],
                                      ) : SizedBox(),


                                      // SizedBox(height: 12,),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       width: 14,
                                      //       height: 14,
                                      //       decoration: ShapeDecoration(
                                      //         image: DecorationImage(
                                      //           image: NetworkImage("https://via.placeholder.com/14x14"),
                                      //           fit: BoxFit.fill,
                                      //         ),
                                      //         shape: OvalBorder(),
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: 4,),
                                      //     Text(
                                      //       'You',
                                      //       style: TextStyle(
                                      //         color: Color(0xFF02190E),
                                      //         fontSize: 12,
                                      //         fontFamily: 'Sora',
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   'Your order is delivered ',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF5C6360),
                                      //     fontSize: 12,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 6,),
                                      // Text(
                                      //   '8:30 PM',
                                      //   style: TextStyle(
                                      //     color: Color(0xFF00934C),
                                      //     fontSize: 8,
                                      //     fontFamily: 'Sora',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 10,),
                                      // Row(
                                      //   children: [
                                      //     CustomButton(
                                      //       height: 28,
                                      //       width: 83,
                                      //       color: Color(0xFFF32727),
                                      //       onTap: (){
                                      //
                                      //       },
                                      //       title: "Support",
                                      //       textSize: 10,
                                      //       boder: true,
                                      //       orderRadius: 5,
                                      //     ),
                                      //     SizedBox(width: 8,),
                                      //     CustomButton(
                                      //       height: 28,
                                      //       width: 105,
                                      //       color: kPrimaryColorx,
                                      //       onTap: (){
                                      //
                                      //       },
                                      //       textColor: Colors.white,
                                      //       title: "Yay! got it",
                                      //       textSize: 10,
                                      //       boder: false,
                                      //       isIcon: true,
                                      //       icon: Icons.done,
                                      //       orderRadius: 5,
                                      //     ),
                                      //   ],
                                      // ),


                                      SizedBox(height: 22,),
                                    ],
                                  ),
                                ),
                                // startChild: Container(
                                //   color: Colors.amberAccent,
                                // ),
                              ),


                            ],
                          ),
                        )
                    ),
                  ],
                )
            ),
          );
        });
      },
    );
  }


  String convertTo12HourFormat(String time24Hour) {

    int hour = int.parse(time24Hour);
    int minute = int.parse('0');
    String period;
    period = (hour > 12) ? 'PM' : 'AM';

    if(hour==24){
      period='AM';
    }if(hour==12){
      period='PM';
    }
    if (hour > 12) {
      hour -= 12;
    }

    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');

    return '$hourString:$minuteString $period';
  }

  Future<void> refreshList(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    Future.delayed(Duration.zero, () {
      Get.find<OrderController>().onInit();
      Get.find<OrderController>().orderDetails(widget.ordrId);
    });
  }
}






