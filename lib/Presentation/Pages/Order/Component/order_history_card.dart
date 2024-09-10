
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';
import '../../../Widgets/TextField/text_field_reamarks.dart';

class OrderHistoryCard extends StatelessWidget {
  final Menu? menu;
  final bool? isCancel;
  final OrderController? controller;
  final Order? order;
  final String? createdAt, updatedAt, orderId;

  const OrderHistoryCard(
      {Key? key, this.menu, this.createdAt, this.orderId, this.updatedAt, this.order, this.controller, this.isCancel=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.75, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                height: 121.70,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(menu!.images![0]),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              )
          ),
          SizedBox(width: 14,),
          Expanded(
              flex: 6,
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu!.title ?? '',
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 16,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6,),
                    isCancel!?SizedBox():
                    order!.alreadyReviewed == null ||
                        order!.alreadyReviewed == false?SizedBox():
                    RatingBar(
                      initialRating:order!.customerReview!=null?
                      order!.customerReview!.rating!.toDouble():0.0,
                      minRating: 0,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ratingWidget: RatingWidget(
                        full: SizedBox(
                            height: 8,
                            child: SvgPicture.asset('assets/icons/star.svg',height: 6.23,)),
                        half: SizedBox(
                            height: 8,
                            child: SvgPicture.asset('assets/icons/star.svg')),
                        empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                      ),
                      onRatingUpdate: (ratingx) {

                      },
                    ),

                    SizedBox(height: 6,),
                    Text(
                        menu!.chef!.name!,
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        )
                    ),

                    SizedBox(height: 8,),
                    Text(
                      // getCustomFormattedDateTime(createdAt!,
                      //     'MMM dd yyy h:mm a').toString() + " - " +
                      //     getCustomFormattedDateTime(updatedAt!,
                      //         'MMM dd yyy h:mm a').toString(),
                      getCustomFormattedDateTime(createdAt!,
                          'MMM dd yyy').toString() + " - " +
                          getCustomFormattedDateTime(updatedAt!,
                              'MMM dd yyy').toString(),
                      style: TextStyle(
                        color: Color(0xFF5C6360),
                        fontSize: 11,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10,),
                    controller!.selectOrderId.value == orderId &&
                        controller!.orderReviewcirculer.value
                        ? LoadingWidget()
                        : CustomButton(
                        height: 34,
                        orderRadius: 24,
                        textSize: 12,
                        color: order!.alreadyReviewed == null ||
                              order!.alreadyReviewed == false
                              ?isCancel!?kPrimaryColorx:Colors.orangeAccent: kPrimaryColorx,
                        boder: false,
                        textColor: Colors.white,
                        title:order!.alreadyReviewed == null ||order!.alreadyReviewed == false
                           ? isCancel!?"Order Again": "Rate Now"
                        : "Order Again",
                        onTap: () {

                          if(isCancel!){
                            Navigator.pushNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                              'orderId':orderId
                            });
                          }else {

                            if (order!.alreadyReviewed == null ||
                                order!.alreadyReviewed == false) {
                              controller!.rating1.value = 0;
                              controller!.rating2.value = 0;
                              controller!.rating3.value = 0;
                              controller!.rating4.value = 0;
                              showAlertDialog(context, orderId);
                            } else {
                              Navigator.pushNamed(context, WISH_DETAILS_PAGE,arguments: {
                                'menu':order!.menu,
                                'craeteat':order!.menu!.createdAt
                              });
                            }


                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => TimeLineComponent()),
                          // );
                        }),
                  ],
                );
              })
          ),
        ],
      ),
    );
  }


  showAlertDialog(BuildContext context, String? orderid) {
    // set up the AlertDialog
    Widget cancelButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              height: 38,
              orderRadius: 24,
              color: kPrimaryColorx,
              textColor: Colors.white,
              boder: false,
              title: "Submit",
              onTap: () {
                Navigator.pop(context);
                controller!.submitReview(orderid);

              }),
          SizedBox(height: 12,),
          CustomButton(
              height: 38,
              orderRadius: 24,
              color: kPrimaryColorx,
              textColor: Colors.white,
              boder: true,
              title: "Cancel",
              onTap: () {
                Navigator.pop(context);
                // controller!.submitReview(orderid);
              }),


        ],
      ),
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        color: Colors.white,
        height: 520,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Rate This Order',
                  style: TextStyle(
                    color: Color(0xFF02190E),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 32,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their service?',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      controller!.rating1.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their food hygiene.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      controller!.rating2.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their service intensity.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      controller!.rating3.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their timeliness.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      controller!.rating4.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),


              Text(
                'Any other comments to share? (Optional)',
                style: TextStyle(
                  color: Color(0xFF02190E),
                  fontSize: 16,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12,),
              SalesCreateRemarkTextfield(
                hintText: "Leave us a message...",
                lable: '',
                readOnly: false,
                isNumber: false,
                isValueChnged: true,
                maxLine: 3,
                tap: (text) {
                  if (text.isNotEmpty) {
                    controller!.comment.value = text;
                  } else {
                    controller!.comment.value = "";
                  }
                },


              ),


            ],
          ),
        ),
      ),
      actions: [
        cancelButton,
        SizedBox(height: 20,)

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(
        givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }


}
