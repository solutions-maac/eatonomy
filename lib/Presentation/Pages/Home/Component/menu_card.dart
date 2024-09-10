
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../../GetX Controller/Home/HomeController.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class MenuCard extends StatefulWidget {
  final String?chefId, chefPP, chefName, title, deliveryInst, orderInst, price,
      createAt, type, feedId;
  final bool? isDeliver, isPickUp, wishListed,isFeed,isHeart,isLogin,isCrad,viewWishButton;
  final Menu? menu;
  final List<String>image, iteams;

  const MenuCard(
      {Key? key, this.chefPP, this.chefName, this.title, this.deliveryInst, this.orderInst, this.price, this.isDeliver, this.isPickUp, required this.image, required this.iteams, this.createAt, this.type, this.chefId, this.menu, this.wishListed = false, this.feedId, this.isHeart=true,this.isLogin=true, this.isCrad=true, this.viewWishButton, this.isFeed=true})
      : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}



class _MenuCardState extends State<MenuCard> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left:widget.isCrad!? 8:0, right: widget.isCrad!? 8:0, bottom:widget.isCrad!? 18:0),
      width: 1.0.sw,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width:widget.isCrad!? 0.50:0, color:widget.isCrad!? Color(0xFFE5E5EB):Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x140D0A2C),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // if(widget.isLogin!){
                  Logger().w( widget.menu!.chefId,);
                    Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                      'id': widget.menu!.chefId,
                      'localuser': true,
                      "directHomePage":false
                    });
                  // }else{
                  //   Get.snackbar(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),borderRadius: 6,"Warning", "You are not Login",backgroundColor: Colors.orangeAccent,colorText: Colors.white);
                  // }

                },
                child: Row(
                  children: [
                    widget.chefPP != null ?
                    Container(
                      width: 42,
                      height: 42,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.chefPP != null ? widget
                              .chefPP! : "https://via.placeholder.com/80x80"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                      ),
                    ):
                    Container(
                      width: 42,
                      height: 42,
                      padding: const EdgeInsets.all(2),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFF2F3F5)),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.chefName!.substring(0,2).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8D8D8D),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.chefName!.length>14?widget.chefName!.substring(0,15)+"..":widget.chefName!,
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 16,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 6,),
                            SvgPicture.asset("assets/icons/location.svg"),
                            SizedBox(width: 4,),
                            Text(
                              widget.menu!.chef!.address!.length>14? widget.menu!.chef!.address!.substring(0,15)+"..": widget.menu!.chef!.address!,
                              style: TextStyle(
                                color: Color(0xFF5C6360),
                                fontSize: 11,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 6,),
                        Text(
                          timeAgo(getCustomFormattedDateTime(widget.createAt!,
                              'MM-dd-yyy h:mm a')),
                          style: TextStyle(
                            color: Color(0xFF8D8D8D),
                            fontSize: 12,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Get.find<HomeController>().chefId.value==""?SizedBox():  PopupMenuButton(
                position: PopupMenuPosition.under,
                constraints: BoxConstraints(maxWidth: 230.w, minWidth: 230.w),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                    value: 0,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, EDIT_MENU_PAGE,arguments: {
                              "menu":widget.menu,
                            });

                          },
                          child: Row(
                            children: [
                             Text("Edit Menu")
                            ],
                          ),
                        ),
                      ],
                    ),
                   )
                  ];
                },
                  child: Container(
                    padding: EdgeInsets.all(12),
                      child: SvgPicture.asset("assets/icons/more.svg"))
              )
            ],
          ),
          SizedBox(height: 16,),

          CarouselSlider(
            options: CarouselOptions(
              height: 180,
                enableInfiniteScroll: false,
                autoPlay: false,
                // widget.image.length>1?true:false,
                viewportFraction: 1.0,
                onPageChanged: (int page, css) {
                  setState(() {
                    currentIndex = page;
                  });
                }
            ),
            items: widget.image.map((slider) {
              return Builder(
                builder: (BuildContext context) {
                  return CachedNetworkImage(
                    imageUrl: slider,
                    placeholder: (context, url) => LoadingWidget(),
                    imageBuilder: (context, image) =>
                        Container(
                          height: 180,
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(14),
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 26,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF8FFFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                      widget.type!+" Menu",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF00934C),
                                        fontSize: 12,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w400,

                                      ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 25,
                                height: 14,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF8FFFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (currentIndex + 1).toString() + '/' +
                                          widget.image.length.toString(),
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,

                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                        ),
                  );
                },
              );
            }).toList(),
          ),

          SizedBox(height: 2,),

          SizedBox(
            width: 1.0.sw,
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/star.svg',height: 15,),
                      Text(
                        widget.menu!.chef!.rating!=null?"  "+widget.menu!.chef!.rating!.toString():"  0.0",
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex:1,
                  child:widget.image.length == 1?SizedBox(): Center(
                    child: DotsIndicator(
                      dotsCount: widget.image.length <= 0 ? 1 : widget.image.length,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: kPrimaryColorx,
                        color:Color(0xFFDFEBE5),
                        size: const Size.square(7.0),
                        activeSize: const Size(18.0, 7.0),
                        spacing: EdgeInsets.only(right: 3),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                      ),
                    )


                    // CarouselIndicator(
                    //   height: 6,
                    //   color: Color(0xFFDFEBE6),
                    //   activeColor: kPrimaryColor,
                    //   cornerRadius: 20,
                    //   width: 11,
                    //   count: widget.image.length <= 0 ? 1 : widget.image.length,
                    //   index: currentIndex,
                    // ),
                  ),
                ),

                widget.isLogin!?
                Expanded(
                    flex:1,
                    child: Get.find<HomeController>().chefId.value==""?
                    GetBuilder<MenuControllerx>(
                      assignId: true,
                      builder: (controller) {
                        return Obx(() {
                          return (controller.wishMenuId.value==widget.menu!.id!) && controller.circuler.value ?
                          SizedBox(height: 24,child: LoadingWidget()) :
                          widget.isHeart!? InkWell(
                            onTap: () {
                              Logger().w(widget.menu!.id);
                              Logger().w(widget.menu!.chefId);

                              widget.wishListed!?
                              controller.removeWishListMenu(isFeed:widget.isFeed ,context: context, id: widget.menu!.id,chefId: widget.menu!.chefId):
                              controller.addWishListMenu(isFeed:widget.isFeed ,context: context, id: widget.menu!.id,chefId: widget.menu!.chefId);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: widget.wishListed!
                                  ? SvgPicture.asset("assets/icons/archive-add.svg",)
                                  : SvgPicture.asset("assets/icons/save.svg",),
                            ),
                          ):SizedBox();
                        });
                      },
                    ):SizedBox()
                ):
                Expanded(
                    flex: 1,
                    child: SizedBox())

              ],
            ),
          ),
          SizedBox(height: 16,),
          widget.menu!.isHotDeal==null?SizedBox():
          widget.menu!.isHotDeal!?
          Column(
            children: [
              Row(
                children: [
                  Image.asset("assets/icons/fire.png"),
                  SizedBox(width: 4,),
                  Text(
                    'Hot Deal',
                    style: TextStyle(
                      color: Color(0xFFF2503B),
                      fontSize: 12,
                      fontFamily: 'Sora',
                      // decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(height: 6,),
            ],
          ):SizedBox(),
          SizedBox(height: 6,),


          Text.rich(
            TextSpan(
              style: TextStyle(
                color: Color(0xFF02190E),
                fontSize: 16,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w700,
              ),
              text: widget.title!, // default text style
              children: [
                // WidgetSpan(child: SizedBox(height: 12,),
                TextSpan(
                  children: [
                    WidgetSpan(child:SizedBox(width: 10,),),
                    WidgetSpan(child:SvgPicture.asset("assets/icons/cycle.svg",color: widget.isDeliver!?kPrimaryColor: Color(0xFF8D8D8D),),),
                    WidgetSpan(child:SizedBox(width: 4,),),
                    WidgetSpan(child:Text(
                      "Delivery",
                      style: TextStyle(
                        color:widget.isDeliver!?kPrimaryColor: Color(0xFF8D8D8D),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),)

                  ]
                ),

                TextSpan(
                  children: [
                    WidgetSpan(child:SizedBox(width: 8,), ),
                    WidgetSpan(child: Container(
                      width: 1,
                      height: 12,
                      color:Color(0xFF8D8D8D),
                    ), ),
                    WidgetSpan(child: SizedBox(width: 8,), ),
                  ]
                ),


                TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.bottom,
                        child: SvgPicture.asset("assets/icons/handbox.svg",color: widget.isPickUp!?kPrimaryColor: Color(0xFF8D8D8D),),),
                      WidgetSpan(child:SizedBox(width: 4,),),
                      WidgetSpan(child:Text(
                        "Pickup",
                        style: TextStyle(
                          color:widget.isPickUp!?kPrimaryColor: Color(0xFF8D8D8D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),)

                    ]
                )
              ],
            ),
          ),





          // Row(
          //   children: [
          //     // Text(
          //     //     widget.title!,
          //     //     style: TextStyle(
          //     //       color: Color(0xFF02190E),
          //     //       fontSize: 16,
          //     //       fontFamily: 'Sora',
          //     //       fontWeight: FontWeight.w700,
          //     //     ),
          //     // ),
          //
          //
          //
          //
          //     SizedBox(width: 10,),
          //
          //   ],
          // ),
          // SizedBox(height: 6,),
          // RatingBar(
          //   initialRating:widget.menu!.chef!.rating==null?0.0:widget.menu!.chef!.rating!.toDouble(),
          //   minRating: 0,
          //   ignoreGestures: true,
          //   direction: Axis.horizontal,
          //   allowHalfRating: true,
          //   itemCount: 5,
          //   itemSize: 12,
          //   itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          //   ratingWidget: RatingWidget(
          //     full: SvgPicture.asset('assets/icons/star.svg'),
          //     half: SvgPicture.asset('assets/icons/star.svg'),
          //     empty: SvgPicture.asset('assets/icons/star_stock.svg'),
          //   ),
          //   onRatingUpdate: (ratingx) {
          //
          //   },
          // ),

          SizedBox(height: 16,),
          Wrap(
            spacing: 8, // space between items
            children: widget.iteams
                .map((e) =>
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  child: InkWell(
                      onTap: () {},
                      child: Text(e,style: TextStyle(
                        color: Color(0xFF5C6360),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w300,
                      ),)),
                ))
                .toList(),
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 3,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/paper_plan.svg"),
                      SizedBox(width: 6,),
                      Text(
                        // widget.isDeliver! &&
                        //     widget.isPickUp!?"Pickup/Delivery Time: ":  widget.menu!.isPickUpAvailable!?"PickUp"+' Day : ':
                        'Delivery Schedule',
                        style: TextStyle(
                          color: Color(0xFF02190E),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
              ),

              Expanded(
                flex: 1,
                  child: Text(
                    ":",
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,

                    ),
                  ),
              ) ,
              Expanded(
                flex: 4,
                  child: Text(
                    widget.menu!.deliveryDay==null?"":widget.menu!.deliveryDay!+" "+convertTo12HourFormat(widget.menu!.deliveryFrom!.toString())+" - "+convertTo12HourFormat(widget.menu!.deliveryTo.toString()),
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 12,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              )
            ],
          ),
          SizedBox(height: 16,),

          // Row(
          //   children: [
          //     Expanded(
          //       flex: 3,
          //       child: Row(
          //         children: [
          //           SvgPicture.asset("assets/icons/delivery_loc.svg"),
          //           SizedBox(width: 6,),
          //           Text(
          //             // widget.isDeliver! &&
          //             //     widget.isPickUp!?"Pickup/Delivery Time: ":  widget.menu!.isPickUpAvailable!?"PickUp"+' Day : ':
          //             "Place Order",
          //             style: TextStyle(
          //               color: Color(0xFF02190E),
          //               fontSize: 12,
          //               fontFamily: 'Sora',
          //               fontWeight: FontWeight.w400,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     SizedBox(width: 8,),
          //     Expanded(
          //       flex: 1,
          //       child: Text(
          //         ":",
          //         style: TextStyle(
          //           color: Color(0xFF02190E),
          //           fontSize: 12,
          //           fontWeight: FontWeight.w400,
          //
          //         ),
          //       ),
          //     ) ,
          //     Expanded(
          //       flex: 5,
          //       child: Text(
          //           widget.menu!.orderTakingBeforeDelivery.toString()+" Hour Before",
          //         style: TextStyle(
          //           color: Color(0xFF02190E),
          //           fontSize: 12,
          //           fontFamily: 'Sora',
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          //
          // SizedBox(height: 16,),


          Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/clock.svg",color: Color(0xFF02190E),),
                    SizedBox(width: 6,),
                    Text(
                      // widget.isDeliver! &&
                      //     widget.isPickUp!?"Pickup/Delivery Time: ":  widget.menu!.isPickUpAvailable!?"PickUp"+' Day : ':
                      "Place Order By",
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  ":",
                  style: TextStyle(
                    color: Color(0xFF02190E),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,

                  ),
                ),
              ) ,
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    SizedBox(
                      width: 162,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.menu!.deliveryDay==null?"":
                              calculateTimeAfterDuration(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt()),
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            TextSpan(
                              text:widget.menu!.deliveryDay==null?"":
                              chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt())!=""?"":
                              ' (',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                              widget.menu!.deliveryDay==null?"":
                              chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt())!=""?"":
                              getOrderTimeReamining(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt()).split(":")[0]+"H"
                                  +" : "+
                                  getOrderTimeReamining(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt()).split(":")[1]+"M",
                              style: TextStyle(
                                color: Color(0xFF00934C),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: widget.menu!.deliveryDay==null?"":
                              chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt())!=""?"":
                              ' )',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),



       SizedBox(height:          widget.menu!.deliveryDay==null||chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt())==""?8: 16,),
          Text(
              widget.menu!.deliveryDay==null?"":
              chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt()),

            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
            ),
          ),
          widget.menu!.deliveryDay==null||chekOrderTimeOver(widget.menu!.deliveryDay!+" "+widget.menu!.deliveryFrom!.toString(), widget.menu!.orderTakingBeforeDelivery!.toInt())==""
              ?SizedBox(): SizedBox(height: 12,),

          Row(
            children: [

              Expanded(
                flex: 6,
                  child:
                  widget.menu!.isHotDeal!=null &&
                  widget.menu!.isHotDeal!?
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/price.svg",height: 28,),
                          SizedBox(width: 6,),
                          Text(
                            '\$' + (widget.menu!.price!-num.parse(widget.menu!.discountedPrice!.toDouble().toStringAsFixed(2))).toStringAsFixed(2),
                            style: TextStyle(
                              color: Color(0xFF00934C),
                              fontSize: 20,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12,),
                      Row(
                        children: [
                          Text(
                            '\$' + double.parse(widget.price!).toStringAsFixed(2),
                            style: TextStyle(
                              color: Color(0xFFEC4439),
                              fontSize: 14,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                    ],
                  ):
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/price.svg",height: 28,),
                      SizedBox(width: 6,),
                      Text(
                        '\$' + double.parse(widget.price!).toStringAsFixed(2),
                        style: TextStyle(
                          color:kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
              ),

              Expanded(
                flex: 4,
                  child:Get.find<HomeController>().chefId.value==""?
                  CustomButton(
                      width: 125,
                      height: 48,
                      orderRadius: 40,
                      textSize: 12,
                      color: kPrimaryColorx,
                      boder: false,
                      textColor: Colors.white,
                      title:widget.isLogin!? "Order Now":"Please Login",
                      onTap: () {
                        if(widget.isLogin!){
                          Navigator.pushNamed(
                              context, ORDER_DETAILS_TAKE_PAGE, arguments: {
                            'menu': widget.menu
                          });
                        }else{
                          Navigator.pushNamed(
                            context, LOGIN_PAGE_INTRO,);
                        }

                      }):SizedBox(),

              )

            ],
          )



        ],
      ),
    );
  }


  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(
        givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    // return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1
          ? "year"
          : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1
          ? "month"
          : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1
          ? "week"
          : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1
          ? "minute"
          : "minutes"} ago";
    return "just now";
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


  String chekLastTime(num time) {
    if(time>-1){
      return time.toString()+" Hour";
    }else{
      return "Apologies, we can't process your order right now.";
    }
  }

  String calculateTimeAfterDuration(String input, int durationInHours) {
    final inputParts = input.split(' ');
    final inputDay = inputParts[0];
    final inputTime = inputParts[1];
    var cureentDate=DateTime.now();
    var cureentyear=cureentDate.year;
    var cureentmonth=cureentDate.month;

    DateTime currentYearAndMonth = DateTime(cureentyear, getNextDayDate(inputDay).month, getNextDayDate(inputDay).day,int.parse(inputTime));

    final timeAfterDuration = currentYearAndMonth.subtract(Duration(hours: durationInHours));

    return DateFormat("EEEE h:mma").format(timeAfterDuration);
  }

  DateTime getNextDayDate(String dayName) {
    List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    int targetDayIndex = weekdays.indexOf(dayName);

    DateTime now = DateTime.now();
    int currentDayIndex = now.weekday - 1;
    int daysToAdd = (targetDayIndex - currentDayIndex + 7) % 7;

    DateTime nextDate = now.add(Duration(days: daysToAdd));
    return nextDate;
  }

  String chekOrderTimeOver(String input, int durationInHours){
    final inputParts = input.split(' ');
    final inputDay = inputParts[0];
    final inputTime = inputParts[1];
    var cureentDate=DateTime.now();
    var cureentyear=cureentDate.year;

    DateTime currentYearAndMonth = DateTime(cureentyear, getNextDayDate(inputDay).month, getNextDayDate(inputDay).day,int.parse(inputTime));

    final timeAfterDuration = currentYearAndMonth.subtract(Duration(hours: durationInHours));
    // Logger().w(timeAfterDuration.toLocal());
    // Logger().e(DateFormat('hh:mm').format(timeAfterDuration.toLocal()));

    if (cureentDate.isAfter(timeAfterDuration)) {

      return "This order will be processed for the upcoming week.";
    } else {
      return "";
    }
  }
  String getOrderTimeReamining(String input, int durationInHours){
    final inputParts = input.split(' ');
    final inputDay = inputParts[0];
    final inputTime = inputParts[1];
    var cureentDate=DateTime.now();
    var cureentyear=cureentDate.year;

    DateTime currentYearAndMonth = DateTime(cureentyear, getNextDayDate(inputDay).month, getNextDayDate(inputDay).day,int.parse(inputTime));

    final timeAfterDuration = currentYearAndMonth.subtract(Duration(hours: durationInHours));
    // Logger().w(timeAfterDuration);
    // Logger().e(DateFormat('hh:mm').format(timeAfterDuration.toLocal()));

    Duration differencex = currentYearAndMonth.difference( DateTime.now());

    // Logger().w(differencex);


    return differencex.toString();
  }


}
