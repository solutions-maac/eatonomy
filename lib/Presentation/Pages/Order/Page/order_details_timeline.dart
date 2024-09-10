import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Constants/Strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';
import '../../Home/Component/header_user_name_msg.dart';
import '../Component/user_history_card.dart';


class OrderTimelineDetailsPage extends StatefulWidget {
  final String? ordrId;

  const OrderTimelineDetailsPage({Key? key, this.ordrId}) : super(key: key);

  @override
  State<OrderTimelineDetailsPage> createState() => _OrderTimelineDetailsPageState();
}

class _OrderTimelineDetailsPageState extends State<OrderTimelineDetailsPage> {

  final globalkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,(){
        Get.find<OrderController>().onInit();
        Get.find<OrderController>().orderDetails(widget.ordrId);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Order Progress"),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 24),
              child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, CHAT_PAGE,arguments: {
                      "order":widget.ordrId
                    });
                  },
                  child: SvgPicture.asset("assets/icons/message.svg")
              )
          )
        ],

      ),
      body: GetBuilder<OrderController>(
        assignId: true,
        builder: (controller) {
          return Container(
            color: Colors.white,
            height: 1.0.sh,
            width: 1.0.sw,
            child: Obx(() {
              return RefreshIndicator(
                  onRefresh: () => refreshList(context),
                  child: controller.orderDetailsResponse.value==null ?
                  LoadingWidget() :
                  CustomScrollView(
                    slivers: [
                      // SliverAppBar(
                      //   automaticallyImplyLeading: false,
                      //   flexibleSpace: FlexibleSpaceBar(
                      //     background:Container(
                      //       margin: EdgeInsets.only(top: 24),
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 24.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Expanded(
                      //             flex: 2,
                      //             child:CachedNetworkImage(
                      //                 imageUrl: controller.orderDetailsResponse.value!.order!.menu!.images![0],
                      //                 placeholder: (context, url) => LoadingWidget(),
                      //                 imageBuilder: (context, image) =>Container(
                      //                   width: 100,
                      //                   height: 97,
                      //                   decoration: ShapeDecoration(
                      //                     image: DecorationImage(
                      //                       image: image,
                      //                       fit: BoxFit.fill,
                      //                     ),
                      //                     shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(
                      //                             4)),
                      //                   ),
                      //                 )),
                      //           ),
                      //           SizedBox(width: 18,),
                      //           Expanded(
                      //             flex: 4,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment
                      //                   .start,
                      //               children: [
                      //                 Text(
                      //                   controller.orderDetailsResponse.value!.order!.menu!.title??"",
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 16,
                      //                     fontFamily: 'Satoshi',
                      //                     fontWeight: FontWeight.w700,
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 8,),
                      //                 Wrap(
                      //                   spacing: 8, // space between items
                      //                   children: controller.orderDetailsResponse.value!.order!.menu!.menus!.map((e) =>
                      //                       Container(
                      //                         margin: EdgeInsets.only(
                      //                             bottom: 10),
                      //                         padding: const EdgeInsets
                      //                             .symmetric(horizontal: 10,
                      //                             vertical: 6),
                      //                         decoration: ShapeDecoration(
                      //                           color: Colors.white
                      //                               .withOpacity(
                      //                               0.20000000298023224),
                      //                           shape: RoundedRectangleBorder(
                      //                             borderRadius: BorderRadius
                      //                                 .circular(23),
                      //                           ),
                      //                         ),
                      //                         child: InkWell(
                      //                             onTap: () {},
                      //                             child: Text(
                      //                               e,
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight
                      //                                     .w400,
                      //                               ),
                      //                             )),
                      //                       ))
                      //                       .toList(),
                      //                 ),
                      //               ],
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //
                      //     ) ,
                      //   ),
                      //   backgroundColor: kPrimaryColorx,
                      //
                      //   expandedHeight: 260,
                      //   collapsedHeight: 150,
                      //   bottom: PreferredSize(
                      //       preferredSize: Size.fromHeight(5),
                      //       child:  Container(
                      //           width: 1.0.sw,
                      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      //           child:Row(
                      //             children: [
                      //               Expanded(
                      //                   flex: 3,
                      //                   child: SizedBox()
                      //               ),
                      //               Expanded(
                      //                   flex: 5,
                      //                   child: Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Container(
                      //                         width: 1.0.sw,
                      //                         decoration: ShapeDecoration(
                      //                           shape: RoundedRectangleBorder(
                      //                             side: BorderSide(
                      //                               width: 0.38,
                      //                               color: Color(0xB2D9D9D9),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //                       Row(
                      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             'Menu Quantity ',
                      //                             textAlign: TextAlign.right,
                      //                             style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontSize: 12,
                      //                               fontFamily: 'Satoshi',
                      //                               fontWeight: FontWeight.w400,
                      //                             ),
                      //                           ),
                      //                           Text(
                      //                             controller.orderDetailsResponse.value!.order!.quantity.toString(),
                      //                             textAlign: TextAlign.right,
                      //                             style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontSize: 12,
                      //                               fontFamily: 'Satoshi',
                      //                               fontWeight: FontWeight.w400,
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //                       Container(
                      //                         width: 1.0.sw,
                      //                         decoration: ShapeDecoration(
                      //                           shape: RoundedRectangleBorder(
                      //                             side: BorderSide(
                      //                               width: 0.38,
                      //                               color: Color(0xB2D9D9D9),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //
                      //                       Row(
                      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                           children:
                      //                           [
                      //                             Text(
                      //                               'Menu Price \$',
                      //                               textAlign: TextAlign.right,
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w400,
                      //                               ),
                      //                             ),
                      //                             Text(
                      //                               controller.orderDetailsResponse.value!.order!.menu!.price.toString(),
                      //                               textAlign: TextAlign.right,
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w400,
                      //                               ),
                      //                             ),
                      //                           ]
                      //                       ),
                      //
                      //                       SizedBox(height: 8,),
                      //                       Container(
                      //                         width: 1.0.sw,
                      //                         decoration: ShapeDecoration(
                      //                           shape: RoundedRectangleBorder(
                      //                             side: BorderSide(
                      //                               width: 0.38,
                      //                               color: Color(0xB2D9D9D9),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //                       Row(
                      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                           children:
                      //                           [
                      //                             Text(
                      //                               'Delivery fee \$',
                      //                               textAlign: TextAlign.right,
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w400,
                      //                               ),
                      //                             ),
                      //                             Text(
                      //                               (controller.orderDetailsResponse.value!.order!.deliveryCharge!=null?controller.orderDetailsResponse.value!.order!.deliveryCharge.toString():""),
                      //                               textAlign: TextAlign.right,
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w400,
                      //                               ),
                      //                             ),
                      //                           ]
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //                       Container(
                      //                         width: 1.0.sw,
                      //                         decoration: ShapeDecoration(
                      //                           shape: RoundedRectangleBorder(
                      //                             side: BorderSide(
                      //                               width: 0.38,
                      //                               color: Color(0xB2D9D9D9),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 8,),
                      //                       Row(
                      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text(
                      //                               'Total amount \$',
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w700,
                      //                               ),
                      //                             ),
                      //                             Text(
                      //                               (controller.orderDetailsResponse.value!.order!.deliveryCharge!=null?
                      //                               ((controller.orderDetailsResponse.value!.order!.menu!.price!*controller.orderDetailsResponse.value!.order!.quantity!)+controller.orderDetailsResponse.value!.order!.deliveryCharge!).toString():
                      //                               (controller.orderDetailsResponse.value!.order!.menu!.price!*controller.orderDetailsResponse.value!.order!.quantity!).toString()),
                      //                               style: TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 12,
                      //                                 fontFamily: 'Satoshi',
                      //                                 fontWeight: FontWeight.w700,
                      //                               ),
                      //                             ),
                      //                           ]
                      //                       ),
                      //
                      //                       SizedBox(height: 8,),
                      //
                      //
                      //                     ],
                      //                   )
                      //               )
                      //             ],
                      //           )
                      //       )
                      //   ),
                      // ),

                      SliverToBoxAdapter(
                          child: Container(
                            // color: kPrimaryColorx,
                            decoration:BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1, 0.05),
                                end: Alignment(-1.00, -0.05),
                                colors: [Color(0xFF00934C), Color(0xFF070B37)],
                              ),
                            ) ,
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
                                        child:CachedNetworkImage(
                                            imageUrl: controller.orderDetailsResponse.value!.order!.menu!.images![0],
                                            placeholder: (context, url) => LoadingWidget(),
                                            imageBuilder: (context, image) =>Container(
                                              width: 121,
                                              height: 104,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
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
                                              "Order Id: "+controller.orderDetailsResponse.value!.order!.orderId.toString()+"\n"+
                                              controller.orderDetailsResponse.value!.order!.menu!.title!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Satoshi',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 8,),
                                            Wrap(
                                              spacing: 8, // space between items
                                              children: controller.orderDetailsResponse.value!.order!.menu!.menus!.map((e) =>
                                                  Container(
                                                    height: 26,
                                                    margin: EdgeInsets.only(bottom: 10),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFFED000),
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
                                                            color: Color(0xFF02190E),
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 1.0.sw,
                                                          decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 0.38,
                                                                color: Colors.white.withOpacity(0.15000000596046448),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              controller.orderDetailsResponse.value!.order!.deliveryOption!+' Time ',
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily: 'Satoshi',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller.orderDetailsResponse.value!.order!.deliveryTime==null?"":
                                                              convertTo12HourFormat(controller.orderDetailsResponse.value!.order!.deliveryFrom.toString())+" - "+convertTo12HourFormat(controller.orderDetailsResponse.value!.order!.deliveryTo.toString()),
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily: 'Satoshi',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Container(
                                                          width: 1.0.sw,
                                                          decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 0.38,
                                                                color: Colors.white.withOpacity(0.15000000596046448),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Menu Quantity ',
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily: 'Satoshi',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller.orderDetailsResponse.value!.order!.quantity.toString(),
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily: 'Satoshi',
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Container(
                                                          width: 1.0.sw,
                                                          decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 0.38,
                                                                color: Colors.white.withOpacity(0.15000000596046448),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8,),

                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children:
                                                            [
                                                              Text(
                                                                'Menu Price \$',
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              Text(
                                                                controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!=null &&
                                                                    controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!?
                                                                (controller.orderDetailsResponse.value!.order!.menu!.price!-controller.orderDetailsResponse.value!.order!.menu!.discountedPrice!).toString()
                                                                    :
                                                                controller.orderDetailsResponse.value!.order!.menu!.price.toString(),
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ]
                                                        ),

                                                        SizedBox(height: 8,),
                                                        Container(
                                                          width: 1.0.sw,
                                                          decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 0.38,
                                                                color: Colors.white.withOpacity(0.15000000596046448),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children:
                                                            [
                                                              Text(
                                                                'Delivery Fee \$',
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              Text(
                                                                (controller.orderDetailsResponse.value!.order!.deliveryCharge!=null?controller.orderDetailsResponse.value!.order!.deliveryCharge.toString():""),
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Container(
                                                          width: 1.0.sw,
                                                          decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 0.38,
                                                                color: Colors.white.withOpacity(0.15000000596046448),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8,),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total Amount \$',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w700,
                                                                ),
                                                              ),
                                                              Text(
                                                                (controller.orderDetailsResponse.value!.order!.deliveryCharge!=null?
                                                                ((controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!=null &&
                                                                    controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!?
                                                                (controller.orderDetailsResponse.value!.order!.menu!.price!-controller.orderDetailsResponse.value!.order!.menu!.discountedPrice!)
                                                                    :
                                                                    controller.orderDetailsResponse.value!.order!.menu!.price!*controller.orderDetailsResponse.value!.order!.quantity!)+controller.orderDetailsResponse.value!.order!.deliveryCharge!).toString():

                                                                ((controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!=null &&
                                                                    controller.orderDetailsResponse.value!.order!.menu!.isHotDeal!?
                                                                (controller.orderDetailsResponse.value!.order!.menu!.price!-controller.orderDetailsResponse.value!.order!.menu!.discountedPrice!)
                                                                    :
                                                                    controller.orderDetailsResponse.value!.order!.menu!.price!)*controller.orderDetailsResponse.value!.order!.quantity!).toString()),
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w700,
                                                                ),
                                                              ),
                                                            ]
                                                        ),

                                                        SizedBox(height: 22,),


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
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8),
                            child:controller.orderDetailsResponse.value!.order!.status=="CANCELLED"?
                            Column(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/cooking.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  'This Order Was Canceled',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF02190E),
                                    fontSize: 20,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),

                                ),
                                SizedBox(height: 12,),
                                Text(
                                  'Should you be inclined to express interest, I would recommend placing a renewed order.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF5C6360),
                                    fontSize: 13,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 34,),
                              ],
                            ):
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
                                    color: kPrimaryColorx,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color: Colors.white,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(thickness: 6,color: kPrimaryColorx),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order Placed',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // startChild: Container(
                                  //   color: Colors.amberAccent,
                                  // ),
                                ),

                                ///order accepted by chef
                                TimelineTile(
                                  hasIndicator: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 28,
                                    indicatorXY: 0.0,
                                    color:controller.orderDetailsResponse.value!.order!.isAcceptedByChef!?kPrimaryColorx: Colors.grey.shade400,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color:controller.orderDetailsResponse.value!.order!.isAcceptedByChef!?Colors.white: Colors.grey.shade400,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(
                                      thickness: 6, color: controller.orderDetailsResponse.value!.order!.isAcceptedByChef!?kPrimaryColorx:Colors.grey.shade400),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Order Accepted By Chef',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        controller.orderDetailsResponse.value!.order!.isAcceptedByChef!?
                                        SizedBox():
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            controller.role=="CHEF"?
                                            controller.orderDetailsResponse.value!.order!.deliveryOption=="PickUp"?
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    controller.oderCancel(widget.ordrId);
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    decoration: ShapeDecoration(
                                                      color: Colors.redAccent,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    ),
                                                    child: controller.orderAceptedcirculer.value?
                                                    SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                InkWell(
                                                  onTap: (){
                                                    controller.oderAccepted(widget.ordrId);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFF00934C),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    ),
                                                    child: controller.orderAceptedcirculer.value?
                                                    SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Yes, I get it',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ):
                                            Form(
                                              key:globalkey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 8,),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'This order will be deliver on :\n',
                                                          style: TextStyle(
                                                            color: Color(0xFF6D7075),
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: controller.orderDetailsResponse.value!.order!.deliveryAddress??"",
                                                          style: TextStyle(
                                                            color: Color(0xFF00934C),
                                                            fontSize: 12,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Opacity(
                                                    opacity: 0.90,
                                                    child: Text(
                                                      'Delivery Charge',
                                                      style: TextStyle(
                                                        color: Color(0xFF01180D),
                                                        fontSize: 13,
                                                        fontFamily: 'Satoshi',
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  BackgroundTextfield(
                                                    controller: null,
                                                    readOnly: false,
                                                    isNumber: true,
                                                    isemail: false,
                                                    hintText: "Delivery Charge",
                                                    height: 55,
                                                    isValueChnged: true,
                                                    tap: (text) {
                                                      if (text.isNotEmpty) {
                                                        controller.orderDeliveryCharge.value = double.parse(text);
                                                      } else {
                                                        controller.orderDeliveryCharge.value = 0;
                                                      }
                                                    },
                                                    bgColor: textFieldBackground,
                                                    errormsg: "Please enter delivery charge",
                                                    borderColor: textFieldBackground,),
                                                  SizedBox(height: 8,),
                                                  controller.orderDeliveryCharge.value==0?SizedBox():
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          if (globalkey.currentState!.validate()) {
                                                            controller.oderAccepted(widget.ordrId);

                                                          }

                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                          decoration: ShapeDecoration(
                                                            color: Color(0xFF00934C),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                          ),
                                                          child: controller.orderAceptedcirculer.value?
                                                          SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              const SizedBox(width: 6),
                                                              Text(
                                                                'Send It',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 10,
                                                                  fontFamily: 'Satoshi',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                                :
                                            SizedBox(height: 8,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // startChild: Container(
                                  //   color: Colors.amberAccent,
                                  // ),
                                ),

                                ///payment by consumer
                                TimelineTile(
                                  hasIndicator: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 28,
                                    indicatorXY: 0.0,
                                    color:controller.orderDetailsResponse.value!.order!.paymentRequested!?kPrimaryColorx: Colors.grey.shade400,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color:controller.orderDetailsResponse.value!.order!.paymentRequested!?Colors.white: Colors.grey.shade400,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(
                                      thickness: 6, color: controller.orderDetailsResponse.value!.order!.paymentRequested!?kPrimaryColorx:Colors.grey.shade400),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Payment By '+( controller.role=="CHEF"?"Consumer":"You"),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        controller.orderDetailsResponse.value!.order!.isAcceptedByChef!?
                                        Column(
                                          children: [
                                            controller.role=="CHEF"?
                                            controller.orderDetailsResponse.value!.order!.paymentRequested!?
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                controller.orderDetailsResponse.value!.order!.paymentProofByCustomer==""?SizedBox():
                                                Container(
                                                  width: 312,
                                                  height: 180,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image:
                                                      NetworkImage(controller.orderDetailsResponse.value!.order!.paymentProofByCustomer??"https://via.placeholder.com/312x180"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 12,),
                                                Text(
                                                  controller.orderDetailsResponse.value!.order!.paymentNoteByCustomer??"",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Satoshi',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                                :
                                            SizedBox()
                                                :
                                            controller.orderDetailsResponse.value!.order!.paymentRequested!?SizedBox(): Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 8,),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Make payment by this instruction: \n',
                                                        style: TextStyle(
                                                          color: Color(0xFF6D7075),
                                                          fontSize: 12,
                                                          fontFamily: 'Satoshi',
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: controller.orderDetailsResponse.value!.order!.chef!.paymentInstruction??"",
                                                        style: TextStyle(
                                                          color: Color(0xFF00934C),
                                                          fontSize: 12,
                                                          fontFamily: 'Satoshi',
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height:controller.filePath.value!=""? 6:0,),
                                                controller.filePath.value!=""?
                                                Container(
                                                  width: 312,
                                                  height: 180,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(File(controller.filePath.value)),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ):SizedBox(),
                                                SizedBox(height: 6,),
                                                InkWell(
                                                  onTap: (){
                                                    controller.filepic();

                                                  },
                                                  child: Container(
                                                    width: 288,
                                                    height: 43,
                                                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFF1EDFC),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                    child:controller.imageCirculer.value?
                                                    SizedBox(
                                                      height: 40,
                                                      child: LoadingWidget(),
                                                    ):
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.90,
                                                          child: Text(
                                                            'Upload prove',
                                                            style: TextStyle(
                                                              color: Color(0xFF01180D),
                                                              fontSize: 12,
                                                              fontFamily: 'Satoshi',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        SvgPicture.asset("assets/icons/image.svg")

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 6,),
                                                SizedBox(height: 8,),
                                                Opacity(
                                                  opacity: 0.90,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                      color: Color(0xFF01180D),
                                                      fontSize: 13,
                                                      fontFamily: 'Satoshi',
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8,),
                                                BackgroundTextfield(
                                                  controller: null,
                                                  readOnly: false,
                                                  isNumber: false,
                                                  isemail: false,
                                                  hintText: "Note",
                                                  height: 55,
                                                  isValueChnged: true,
                                                  tap: (text) {
                                                    if (text.isNotEmpty) {
                                                      controller.orderPaymentNote.value = text;
                                                    } else {
                                                      controller.orderPaymentNote.value = "";
                                                    }
                                                  },
                                                  bgColor: textFieldBackground,
                                                  errormsg: "Please enter notr",
                                                  borderColor: textFieldBackground,),
                                                SizedBox(height: 6,),
                                                InkWell(
                                                  onTap: (){
                                                    controller.oderpaymenrResquest(widget.ordrId);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFF00934C),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    ),
                                                    child: controller.orderPaymentRequestcirculer.value?
                                                    SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          'Send To Chef',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8,),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                          ],
                                        ):
                                        SizedBox(),

                                      ],
                                    ),
                                  ),
                                  // startChild: Container(
                                  //   color: Colors.amberAccent,
                                  // ),
                                ),

                                ///payment acepet by chef
                                TimelineTile(
                                  hasIndicator: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 28,
                                    indicatorXY: 0.0,
                                    color:controller.orderDetailsResponse.value!.order!.isPaymentConfirmed!?kPrimaryColorx: Colors.grey.shade400,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color:controller.orderDetailsResponse.value!.order!.isPaymentConfirmed!?Colors.white: Colors.grey.shade400,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(
                                      thickness: 6, color: controller.orderDetailsResponse.value!.order!.isPaymentConfirmed!?kPrimaryColorx:Colors.grey.shade400),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Payment Accept By Chef',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8,),

                                        controller.role=="CHEF"?
                                        controller.orderDetailsResponse.value!.order!.paymentRequested!?
                                        controller.orderDetailsResponse.value!.order!.isPaymentConfirmed!
                                            ?SizedBox():
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                controller.oderPaymentAccepted(widget.ordrId);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFF00934C),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                ),
                                                child: controller.orderPaymentAceptedcirculer.value?
                                                SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      'Yes, I get it',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: 'Satoshi',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ):SizedBox():SizedBox(),
                                        SizedBox(height: 8,),

                                      ],
                                    ),
                                  ),
                                  // startChild: Container(
                                  //   color: Colors.amberAccent,
                                  // ),
                                ),

                                ///order ready for delivery / pickup
                                TimelineTile(
                                  hasIndicator: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 28,
                                    indicatorXY: 0.0,
                                    color:controller.orderDetailsResponse.value!.order!.isReadyForPickUp!=null?
                                    controller.orderDetailsResponse.value!.order!.isReadyForPickUp!?
                                    kPrimaryColorx: Colors.grey.shade400: Colors.grey.shade400,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color:controller.orderDetailsResponse.value!.order!.isReadyForPickUp!=null?
                                      controller.orderDetailsResponse.value!.order!.isReadyForPickUp!?
                                      Colors.white: Colors.grey.shade400: Colors.grey.shade400,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(
                                      thickness: 6,
                                      color:controller.orderDetailsResponse.value!.order!.isReadyForPickUp!=null?
                                      controller.orderDetailsResponse.value!.order!.isReadyForPickUp!?
                                      kPrimaryColorx:Colors.grey.shade400:Colors.grey.shade400),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order Ready For '+(controller.orderDetailsResponse.value!.order!.deliveryOption=="PickUp"?"Pick Up":"Delivery"),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 8,),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'This Order '+(controller.orderDetailsResponse.value!.order!.deliveryOption=="PickUp"?"Pick Up":"Deliver")+': \n',
                                                    style: TextStyle(
                                                      color: Color(0xFF6D7075),
                                                      fontSize: 12,
                                                      fontFamily: 'Satoshi',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  controller.orderDetailsResponse.value!.order!.deliveryOption=="PickUp"?
                                                  TextSpan(
                                                    text: controller.orderDetailsResponse.value!.order!.chef!.address??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF00934C),
                                                      fontSize: 12,
                                                      fontFamily: 'Satoshi',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )
                                                      :
                                                  TextSpan(
                                                    text: controller.orderDetailsResponse.value!.order!.deliveryAddress??"",
                                                    style: TextStyle(
                                                      color: Color(0xFF00934C),
                                                      fontSize: 12,
                                                      fontFamily: 'Satoshi',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8,),
                                            controller.role=="CHEF"?
                                            controller.orderDetailsResponse.value!.order!.isPaymentConfirmed!?
                                            controller.orderDetailsResponse.value!.order!.isReadyForPickUp!
                                                ?SizedBox():
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    controller.oderReadyFor(widget.ordrId);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFF00934C),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    ),
                                                    child: controller.orderReadyForcirculer.value?
                                                    SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          'Mark Order Ready',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: 'Satoshi',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ):
                                            SizedBox():SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // startChild: Container(
                                  //   color: Colors.amberAccent,
                                  // ),
                                ),

                                ///order close
                                TimelineTile(
                                  hasIndicator: true,
                                  isLast: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 28,
                                    indicatorXY: 0.0,
                                    color:controller.orderDetailsResponse.value!.order!.status=="COMPLETED"?kPrimaryColorx: Colors.grey.shade400,
                                    padding: const EdgeInsets.all(3),
                                    drawGap: true,
                                    height: 28,
                                    // indicator: SvgPicture.asset("assets/icons/box.svg"),
                                    iconStyle: IconStyle(
                                      color:controller.orderDetailsResponse.value!.order!.status=="COMPLETED"?Colors.white: Colors.grey.shade400,
                                      iconData: Icons.done,
                                    ),
                                  ),
                                  beforeLineStyle: LineStyle(
                                      thickness: 6, color: controller.orderDetailsResponse.value!.order!.status=="COMPLETED"?kPrimaryColorx:Colors.grey.shade400),
                                  alignment: TimelineAlign.start,
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 60,
                                    ),
                                    margin: EdgeInsets.only(left: 12, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Chef Close The Order',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        controller.role=="CHEF"?
                                        controller.orderDetailsResponse.value!.order!.isReadyForPickUp!?
                                        controller.orderDetailsResponse.value!.order!.status=="COMPLETED"
                                            ?SizedBox():
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                controller.oderComplete(widget.ordrId,context);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFF00934C),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                ),
                                                child: controller.orderCompletecirculer.value?
                                                SizedBox(height:20,width: 20,child: LoadingWidget()):
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      'Mark as Complete',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: 'Satoshi',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ):
                                        SizedBox():SizedBox(),

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
              );
            }),
          );
        },
      ),
    );
  }

  String convertTo12HourFormat(String time24Hour) {

    int hour = int.parse(time24Hour);
    int minute = int.parse('0');
    String period = (hour >= 12) ? 'PM' : 'AM';
    if (hour > 12) {
      hour -= 12;
    }



    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');

    return '$hourString:$minuteString $period';
  }

  Future<void> refreshList(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}






