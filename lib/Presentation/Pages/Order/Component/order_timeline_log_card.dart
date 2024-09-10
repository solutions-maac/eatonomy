import 'dart:ffi';

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
import 'package:flutter/services.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';

class OrderLogCard extends StatefulWidget {
  final OrderLog? orderLog;
  final Order? order;
  final int? index;
  final OrderController? controller;
  OrderLogCard({super.key, this.orderLog, this.order, this.controller, this.index});

  @override
  State<OrderLogCard> createState() => _OrderLogCardState();
}

class _OrderLogCardState extends State<OrderLogCard> {

  List<String> fromNumberList = [];
  List<String> toNumberList = [];
final globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.orderLog!.createdBy!.profilePicture??"",
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
                      fontSize: 9,
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

        widget.index!.toInt()==0?
        Text(
          widget.orderLog!.note!.split(" ")[0]+" "+convertTo12HourFormat(widget.orderLog!.note!.split(" ")[1])+" - "+convertTo12HourFormat(widget.orderLog!.note!.split(" ")[3]),
          style: TextStyle(
            color:widget.orderLog!.value=="Rejected"? Color(0xFFF32828):Color(0xFF5C6360),
            fontSize: 12,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ):
        Text(
          widget.orderLog!.value=="Rejected"?"Rejected":
          widget.orderLog!.note??"",
          style: TextStyle(
            color:widget.orderLog!.value=="Rejected"? Color(0xFFF32828):Color(0xFF5C6360),
            fontSize: 12,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6,),
        Text(
          getCustomFormattedDateTime(widget.orderLog!.datetime!, "h:mm a").toString(),
          style: TextStyle(
            color: Color(0xFF00934C),
            fontSize: 8,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
        ),



           (widget.order!.customerStatus=="PAYMENT"||widget.order!.customerStatus=="ORDER_DELIVERY"||widget.order!.customerStatus=="DELIVERED")
            &&
            widget.order!.dateAndTimeLogs!.length-1==widget.index
            &&
            widget.orderLog!.value=="Accepted By Chef"?
        Column(
          children: [
            SizedBox(height: 6,),
            Row(
              children: [
                Icon(Icons.done_all,size: 14,color: kPrimaryColorx,),
                SizedBox(width: 4,),
                Text(
                  'Accepted',
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
       ( widget.order!.customerStatus=="REJECTED"||widget.order!.customerStatus=="DateTime_Reject")&&widget.orderLog!.value=="Processing"&&widget.controller!.role!="CHEF"?
        Column(
          children: [
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                for (int i = widget.controller!.orderDetailsResponse.value!.order!.menu!.deliveryFrom!.toInt(); i <= (widget.controller!.orderDetailsResponse.value!.order!.menu!.deliveryTo!.toInt()-1); i++) {
                  fromNumberList.add(i.toString());
                }

                Logger().w(widget.controller!.orderFromTimex.value);
                Logger().w(toNumberList);
                toNumberList.clear();
                widget.controller!.orderToTimex.value="";
                Logger().w(widget.controller!.orderToTimex.value);
                showTimeForomToAlertDialog(context,widget.controller!);
              },
              child: Container(
                width: 1.0.sw,
                height: 43,
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                decoration: ShapeDecoration(
                  color: Color(0xFFEDFCEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.controller!.orderDelivryTime.value==""?'Reorder':
                      convertTo12HourFormat(widget.controller!.orderDelivryTime.value.split("-")[0])+" - "+convertTo12HourFormat(widget.controller!.orderDelivryTime.value.split("-")[1]),
                      style: TextStyle(
                        color: widget.controller!.orderDelivryTime.value==""? Color(0xFF929B96):Color(0xFF02190E),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SvgPicture.asset("assets/icons/box.svg",height: 20,color: kPrimaryColorx,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  height: 28,
                  width: 65,
                  color: kPrimaryColorx,
                  onTap: (){
                    widget.controller!.chnageTime(widget.order!.orderId,widget.controller!.orderDelivryTime.value.split("-")[0],widget.controller!.orderDelivryTime.value.split("-")[1]);
                    widget.controller!.update();
                  },
                  textColor: Colors.white,
                  title: "Send",
                  textSize: 10,
                  boder: false,
                  orderRadius: 5,
                ),
              ],
            )
          ],
        ):SizedBox(),



        widget.order!.customerStatus=="DATE_AND_TIME"&&(widget.order!.dateAndTimeLogs!.length-1)==widget.index&&widget.controller!.role=="CHEF"?
        Column(
          children: [
            SizedBox(height: 10,),
            widget.controller!.orderAceptedcirculer.value?
            SizedBox(height:20,width: 20,child: LoadingWidget()):
            widget.controller!.dateTimeRejctClick.value?
            Column(
              children: [
                SizedBox(height: 8,),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Fill the field";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: textFieldBackground, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: textFieldBackground, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      border: OutlineInputBorder(

                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Describe The Reason",
                      fillColor: textFieldBackground
                  ),
                  icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                  value: widget.controller!.selectRejectType.value==""?null:widget.controller!.selectRejectType.value,
                  onChanged: (newValue) {
                    widget.controller!.selectRejectType.value=newValue!;
                  },
                  items: widget.controller!.rejectType
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      height: 28,
                      width: 65,
                      color: kPrimaryColorx,
                      onTap: (){
                        if(widget.controller!.selectRejectType.value!=""){
                          widget.controller!.rejectOrder(widget.order!.orderId);
                          widget.controller!.update();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text("Select Reason",style: boldText(14,color: Colors.white),),
                            duration: Duration(milliseconds: 1000),
                          ));
                        }

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
            ):
            widget.controller!.dateTimeAcceptClick.value?
            Form(
              key: globalkey,
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter delivery charge";
                      }

                    },
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false),
                    inputFormatters: <TextInputFormatter>[
                      // FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      FilteringTextInputFormatter.deny(
                        RegExp(r'^0+'),
                      ),
                      LengthLimitingTextInputFormatter(4),
                    ],
                    controller: null,
                    onChanged: (text){
                      if (text.isNotEmpty) {
                        widget.controller!.orderDeliveryCharge.value = double.parse(text);
                      } else {
                        widget.controller!.orderDeliveryCharge.value = 0;
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Write your delivery charge",
                      hintStyle: TextStyle(
                        color: Color(0xFF929B96),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: textFieldBackground,
                      filled: true,

                      contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(color: Colors.red),
                      //   borderRadius: BorderRadius.circular(6),
                      // ),

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:textFieldBackground, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:textFieldBackground, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                    ),
                  ),



                  SizedBox(height: 8,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        height: 28,
                        width: 65,
                        color: kPrimaryColorx,
                        onTap: (){
                          if (globalkey.currentState!.validate()) {
                            if(widget.controller!.orderDeliveryCharge.value!=0){
                              widget.controller!.oderAccepted(widget.order!.orderId);
                              widget.controller!.update();
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text("Give Delivery Charge",style: boldText(14,color: Colors.white),),
                                duration: Duration(milliseconds: 1000),
                              ));
                            }
                          }


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
              ),
            )
                :
            Row(
              children: [
                CustomButton(
                  height: 28,
                  width: 65,
                  color: Color(0xFFF32727),
                  onTap: (){
                    widget.controller!.dateTimeRejctClick.value=true;
                    widget.controller!.update();
                  },
                  title: "Reject",
                  textSize: 10,
                  boder: true,
                  orderRadius: 5,
                ),
                SizedBox(width: 8,),
                widget.order!.deliveryOption=="PickUp"?
                CustomButton(
                  height: 28,
                  width: 75,
                  color: kPrimaryColorx,
                  onTap: (){
                    widget.controller!.oderAccepted(widget.order!.orderId);
                  },
                  textColor: Colors.white,
                  title: "Accept",
                  textSize: 10,
                  boder: false,
                  isIcon: true,
                  icon: Icons.done,
                  orderRadius: 5,
                )
                    :
                CustomButton(
                  height: 28,
                  width: 170,
                  color: kPrimaryColorx,
                  onTap: (){
                    widget.controller!.dateTimeAcceptClick.value=true;
                    widget.controller!.update();
                  },
                  textColor: Colors.white,
                  title: "Accept & Add Delivery Fee",
                  textSize: 10,
                  boder: false,
                  isIcon: true,
                  icon: Icons.done,
                  orderRadius: 5,
                )
              ],
            ),
          ],
        ):SizedBox(),

        SizedBox(height: 10,),
      ],
    );
  }

  showTimeForomToAlertDialog(BuildContext context,OrderController controller) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 229,
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
                      'Select  Another Time',
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 16,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 13,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: 8,),
                              DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: textFieldBackground, width: 2.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: textFieldBackground, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "Time Select",
                                    fillColor: textFieldBackground
                                ),
                                dropdownColor: textFieldBackground,
                                icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                                value: controller.orderFromTimex.value==""?null:controller.orderFromTimex.value,
                                onChanged: (newValue) {
                                  controller.orderFromTimex.value=newValue!;
                                  controller.orderToTimex.value="";
                                  // Logger().w(widget.menu!.deliveryFrom!.toInt());
                                  // Logger().w(widget.menu!.deliveryTo!.toInt());
                                  toNumberList.clear();
                                  for (int i = int.parse(newValue)+1; i <= controller.orderDetailsResponse.value!.order!.menu!.deliveryTo!.toInt(); i++) {
                                    setState(() {
                                      toNumberList.add(i.toString());
                                    });
                                  }
                                  Logger().w(controller.orderFromTimex.value);
                                  Logger().w(toNumberList);
                                  Logger().w(controller.orderToTimex.value);

                                },
                                items: fromNumberList
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(convertTo12HourFormat((value))),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 13,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: 8,),
                              toNumberList.isEmpty?Container(
                                width: 156,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFEDFCEF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Time Select',
                                      style: TextStyle(
                                        color: Color(0xFF929B96),
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w400,

                                      ),
                                    ),
                                    SvgPicture.asset("assets/icons/arrow-down2.svg",),
                                  ],
                                ),
                              ):

                              DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                dropdownColor: textFieldBackground,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: textFieldBackground, width: 2.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: textFieldBackground, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    border: OutlineInputBorder(

                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "Time Select",
                                    fillColor: textFieldBackground
                                ),
                                icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                                value: controller.orderToTimex.value==""?null:controller.orderToTimex.value,
                                onChanged: (newValue) {
                                  controller.orderToTimex.value=newValue!;
                                  setState(() {});
                                },
                                items: toNumberList
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(convertTo12HourFormat((value))),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),
                    CustomButton(
                        height: 52,
                        orderRadius: 40,
                        color: kPrimaryColorx,
                        boder: false,
                        textColor: Colors.white,
                        title: "Add",
                        onTap: () {
                          controller.orderDelivryTime.value=controller.orderFromTimex.value+"-"+controller.orderToTimex.value;
                          controller.update();
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
