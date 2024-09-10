import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/Config/text_style.dart';
import 'package:eatonomy/Data/Model/Order/Order.dart';
import 'package:eatonomy/Data/Model/Order/OrderLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:logger/logger.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';
import '../../../Widgets/TextField/text_field_reamarks.dart';

class OrderPaymentLogCard extends StatefulWidget {
  final OrderLog? orderLog;
  final Order? order;
  final int? index;
  final OrderController? controller;
  OrderPaymentLogCard({super.key, this.orderLog, this.order, this.controller, this.index});

  @override
  State<OrderPaymentLogCard> createState() => _OrderPaymentLogCardState();
}

class _OrderPaymentLogCardState extends State<OrderPaymentLogCard> {

  List<String> fromNumberList = [];
  List<String> toNumberList = [];

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.orderLog!.createdBy!.profilePicture!,
              errorWidget: (context,url,error)=>Container(
                width: 14,
                height: 14,
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
                    widget.orderLog!.createdBy!.name!.substring(0,2).toUpperCase(),
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
              placeholder: (context, url) => SizedBox(
                  width: 14,
                  height: 14,
                  child: LoadingWidget()),
              imageBuilder: (context, image) => Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.fill,
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),

            SizedBox(width: 4,),
            Text(
              widget.orderLog!.createdBy!.name??"",
              style: TextStyle(
                color: Color(0xFF02190E),
                fontSize: 12,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        SizedBox(height: 6,),
        Text(
          widget.orderLog!.value=="TICKET"?"Please wait until we get back":
          widget.orderLog!.note??"",
          style: TextStyle(
            color:widget.orderLog!.value=="TICKET"? Color(0xFFF32828):Color(0xFF5C6360),
            fontSize: 12,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6,),
        widget.orderLog!.image!=null&&widget.orderLog!.image!=""?
            Column(
              children: [
                Container(
                  width: 115,
                  height: 60,
                  padding: EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Color(0xFF5C6360),
                    image: DecorationImage(
                      image:
                      NetworkImage(widget.orderLog!.image??""),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: InkWell(
                      onTap: (){
                        showImageAlertDialog(context,widget.controller!,widget.orderLog!.image!);
                      },
                      child: SvgPicture.asset("assets/icons/image_show.svg",height: 24,width: 24,)),
                ) ,
                SizedBox(height: 6,),
              ],
            ):SizedBox(),

        Text(
          getCustomFormattedDateTime(widget.orderLog!.datetime!, "h:mm a").toString(),
          style: TextStyle(
            color: Color(0xFF00934C),
            fontSize: 8,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ),

        widget.orderLog!.value=="Payment"&&widget.controller!.role=="CHEF"?
        widget.order!.customerStatus=="ORDER_DELIVERY"||widget.order!.paymentLogs!.length-1>widget.index!?SizedBox():
        Column(
          children: [
            SizedBox(height: 10,),
            widget.controller!.orderPaymentAceptedcirculer.value||widget.controller!.orderSupportcirculer.value?LoadingWidget():
            Row(
              children: [
                CustomButton(
                  height: 28,
                  width: 83,
                  color: Color(0xFFF32727),
                  onTap: (){
                    showSuppoortToAlertDialog(context,widget.controller!);
                    widget.controller!.filePath.value="";
                    setState((){});
                  },
                  title: "Support",
                  textSize: 10,
                  boder: true,
                  orderRadius: 5,
                ),
                SizedBox(width: 8,),
                CustomButton(
                  height: 28,
                  width: 105,
                  color: kPrimaryColorx,
                  onTap: (){
                    widget.controller!.oderPaymentAccepted(widget.order!.orderId);
                  },
                  textColor: Colors.white,
                  title: "Yay! got it",
                  textSize: 10,
                  boder: false,
                  isIcon: true,
                  icon: Icons.done,
                  orderRadius: 5,
                ),
              ],
            ),
          ],
        ):SizedBox(),



        (widget.order!.customerStatus=="ORDER_DELIVERY"||widget.order!.customerStatus=="DELIVERED")
            &&
            widget.order!.paymentLogs!.length-1==widget.index
            &&
        widget.orderLog!.value=="Payment Confirmed By Chef"?
        Column(
          children: [
            SizedBox(height: 6,),
            Row(
              children: [
                Icon(Icons.done_all,size: 14,color: kPrimaryColorx,),
                SizedBox(width: 4,),
                Text(
                  'Yay, I got it',
                  style: TextStyle(
                    color: Color(0xFF00934C),
                    fontSize: 12,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
        ):SizedBox(),

        SizedBox(height: 10,),
      ],
    );
  }




  showSuppoortToAlertDialog(BuildContext context,OrderController controller) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height:controller.filePath.value!=""||controller.imageCirculer.value?420: 320,
            width: 1.0.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.pushReplacementNamed(context, MAIN_PAGE);
                        },
                        child: Icon(Icons.close, color: Colors.black,))
                  ],
                ),
                SizedBox(height: 4,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Any Issues?Tell Us',
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 16,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                    SalesCreateRemarkTextfield(
                      controller: null,
                      readOnly: false,
                      isNumber: false,
                      maxLine: 5,
                      hintText: "Description",
                      isValueChnged: true,
                      tap: (text) {
                        if (text.isNotEmpty) {
                          widget.controller!.orderSupportText.value = text;
                        } else {
                          widget.controller!.orderSupportText.value = "";
                        }
                      }, lable: '',
                    ),
                    SizedBox(height:controller.filePath.value!=""? 26:16,),
                    controller.imageCirculer.value?LoadingWidget():
                    controller.filePath.value!=""?
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: FileImage(File(controller.filePath.value)),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        controller.filePath.value="";
                        controller.filepic().then((value){
                          setState((){});
                        });
                        Future.delayed(Duration(seconds: 10),(){
                          setState((){});
                        });
                        setState((){});
                        controller.update();
                      },
                      child: Container(
                        width: 125,
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                        decoration: ShapeDecoration(
                          color: Color(0xFFEDFCEF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset("assets/icons/gallery-export.svg")
                            ),
                            const SizedBox(width: 8),
                            Opacity(
                              opacity: 0.90,
                              child: Text(
                                'Add Image',
                                style: TextStyle(
                                  color: Color(0xFF00934C),
                                  fontSize: 12,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    CustomButton(
                        height: 52,
                        orderRadius: 40,
                        color: kPrimaryColorx,
                        boder: false,
                        textColor: Colors.white,
                        title: "Submit",
                        onTap: () {
                          if(widget.controller!.orderSupportText.value!= ""){
                            controller.sendSuport(widget.order!.orderId,"PAYMENT");
                            controller.update();
                          }

                          Navigator.pop(context);
                        }
                    )
                  ],
                )
              ],
            ),
          );
        },

      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  showImageAlertDialog(BuildContext context,OrderController controller,String image) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height:420,
            width: 1.0.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12,top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(context, MAIN_PAGE);
                          },
                          child: Icon(Icons.close, color: Colors.white,))
                    ],
                  ),
                ),

              ],
            ),
          );
        },

      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
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
