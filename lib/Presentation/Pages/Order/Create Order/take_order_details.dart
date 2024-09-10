
import 'package:eatonomy/Config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';
import 'package:time_range/time_range.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../../GetX Controller/Home/HomeController.dart';
import '../../../../GetX Controller/Menu/MenuController.dart';
import '../../../../GetX Controller/Order/OrderController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';

class OrderTakeDetails extends StatefulWidget {
  final Menu? menu;
  OrderTakeDetails({Key? key, this.menu}) : super(key: key);

  @override
  State<OrderTakeDetails> createState() => _OrderTakeDetailsState();
}

class _OrderTakeDetailsState extends State<OrderTakeDetails> {
  TextEditingController quantiyEdittext=TextEditingController();

  List<String> fromNumberList = [];
  List<String> toNumberList = [];




  @override
  void initState() {
    // TODO: implement initState
      Get.find<OrderController>().onInit();
      Get.find<OrderController>().orderQty.value =1;
      quantiyEdittext.text="1";
      if(widget.menu!.isPickUpAvailable!){
        Get.find<OrderController>().menuIspickup.value=true;
        Get.find<OrderController>().deliveryOption.value ="PickUp";
      }else if(widget.menu!.isDeliveryAvailable!){
        Get.find<OrderController>().menuIsDelivery.value=true;
        Get.find<OrderController>().deliveryOption.value ="Delivery";
      }

      for (int i = widget.menu!.deliveryFrom!.toInt(); i <= (widget.menu!.deliveryTo!.toInt()-1); i++) {
        fromNumberList.add(i.toString());
      }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: SizedBox(
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))
                  ),
                ),
                title: Text("Order Create"),
              ),
              body:Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 24, vertical: 0),
                margin: EdgeInsets.only(bottom: 18),
                height: 1.0.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.deliveryOption.value =="PickUp"?SizedBox(): SizedBox(height: 18,),
                                controller.deliveryOption.value =="PickUp"?SizedBox(): Text(
                                  'Fill out and order delivery charge will be added.',
                                  style: TextStyle(
                                    color: Color(0xFF5C6360),
                                    fontSize: 13,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // SizedBox(height: 12,),
                                // Text.rich(
                                //   TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text:widget.menu!.isPickUpAvailable!?"Pick Up"+' Time : ':"Delivery"+' Time : ',
                                //         style: TextStyle(
                                //           color: Color(0xFF070B37),
                                //           fontSize: 12,
                                //           fontFamily: 'Satoshi',
                                //           fontWeight: FontWeight.w400,
                                //
                                //         ),
                                //       ),
                                //       TextSpan(
                                //         text:widget.menu!.deliveryDay==null?"":widget.menu!.deliveryDay!+" "+convertTo12HourFormat(widget.menu!.deliveryFrom!.toString())+" - "+convertTo12HourFormat(widget.menu!.deliveryTo.toString()),
                                //         style: TextStyle(
                                //           color: kPrimaryColorx.withOpacity(0.80),
                                //           fontSize: 14,
                                //           fontFamily: 'Satoshi',
                                //           fontWeight: FontWeight.w700,
                                //
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                SizedBox(height: 16,),
                                // Text(
                                //   "Select "+(menu!.isPickUpAvailable!?"Pick Up"+' Time : ':"Delivery"+' Time : '),
                                //   style: TextStyle(
                                //     color: Color(0xFF01180D),
                                //     fontSize: 13,
                                //     fontFamily: 'Satoshi',
                                //     fontWeight: FontWeight.w700,
                                //   ),
                                // ),
                                // TimeRange(
                                //   fromTitle: Text('From', style: TextStyle(fontSize: 18, color: Colors.grey),),
                                //   toTitle: Text('To', style: TextStyle(fontSize: 18, color: Colors.grey),),
                                //   titlePadding: 0,
                                //   textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                                //   activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                //   borderColor: kPrimaryColorx,
                                //   backgroundColor: Colors.transparent,
                                //   activeBackgroundColor: kPrimaryColorx,
                                //   firstTime: TimeOfDay(hour: menu!.deliveryFrom!.toInt(), minute: 00),
                                //   lastTime: TimeOfDay(hour: menu!.deliveryTo!.toInt(), minute: 00),
                                //   timeStep: 60,
                                //   timeBlock: 60,
                                //   onRangeCompleted: (range) => controller.orderDelivryTime.value=range!.start.hour.toString()+"-"+range.end.hour.toString(),
                                // ),
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
                                              for (int i = int.parse(newValue)+1; i <= widget.menu!.deliveryTo!.toInt(); i++) {
                                                setState(() {
                                                  toNumberList.add(i.toString());
                                                });

                                              }
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
                                              controller.orderDelivryTime.value=controller.orderFromTimex.value+"-"+controller.orderToTimex.value;
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


                                // InkWell(
                                //   onTap: (){
                                //     _selectTime(context,controller);
                                //   },
                                //   child: Container(
                                //     width: 1.0.sw,
                                //     height: 48,
                                //     decoration: BoxDecoration(
                                //       color: textFieldBackground,
                                //       borderRadius: BorderRadius.circular(4),
                                //       border: Border.all(color:
                                //       !isNumberInRange(controller.orderDelivryTime.value,menu!.deliveryFrom!.toInt(),menu!.deliveryTo!.toInt())
                                //           &&
                                //           controller.orderDelivryTime.value!=0?Colors.redAccent:
                                //       textFieldBackground)
                                //     ),
                                //     padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                                //     child: Text(controller.orderDelivryTime.value>=0?convertTo12HourFormat(controller.orderDelivryTime.value.toString())
                                //         :"Select Order Delivery Time",style: mediumText(14,color: textColor),),
                                //   ),
                                // ),
                                SizedBox(height: 16,),
                                Opacity(
                                  opacity: 0.90,
                                  child: Text(
                                    'Quantity',
                                    style: TextStyle(
                                      color: Color(0xFF01180D),
                                      fontSize: 13,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFEDFCEF),
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
                                              widget.menu!.isHotDeal!=null &&
                                                  widget.menu!.isHotDeal!?
                                            "\$"+((widget.menu!.price!-widget.menu!.discountedPrice!).toDouble()*int.parse(quantiyEdittext.text)).toStringAsFixed(2)
                                                :
                                              "\$"+(widget.menu!.price!.toDouble()*int.parse(quantiyEdittext.text)).toStringAsFixed(2),
                                              style: TextStyle(
                                                color: Color(0xFF02190E),
                                                fontSize: 16,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      flex: 2,
                                      child:Container(
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                                            Expanded(
                                                child:InkWell(
                                                    onTap:(){
                                                      if(controller.orderQty.value<=1){

                                                      }else{
                                                        controller.orderQty.value-=1;
                                                        quantiyEdittext.text=controller.orderQty.value.toString();
                                                      }

                                                    },
                                                    child: Icon(Icons.remove))
                                            ),
                                            Container(
                                              width: 1,
                                              height: 24,
                                              color: Colors.black26,
                                            ),
                                            Expanded(
                                              child:Center(
                                                child: Text(
                                                  quantiyEdittext.text,
                                                  style: TextStyle(
                                                    color: Color(0xFF02190E),
                                                    fontSize: 16,
                                                    fontFamily: 'Sora',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 24,
                                              color: Colors.black26,
                                            ),
                                            Expanded(
                                                child:InkWell(
                                                    onTap: (){
                                                      controller.orderQty.value+=1;
                                                      quantiyEdittext.text=controller.orderQty.value.toString();
                                                    },
                                                    child: Icon(Icons.add))
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.end,
                                    //     children: [
                                    //       CustomButton(
                                    //         color: kPrimaryColorx,
                                    //         height: 48,
                                    //         width: 48,
                                    //         onTap: (){
                                    //           controller.orderQty.value+=1;
                                    //           quantiyEdittext.text=controller.orderQty.value.toString();
                                    //         },
                                    //         title: "+",
                                    //         orderRadius: 4,
                                    //         textColor: Colors.white,
                                    //         textSize: 24,
                                    //       ),
                                    //       SizedBox(width: 6,),
                                    //       CustomButton(
                                    //         color: kPrimaryColorx,
                                    //         height: 48,
                                    //         width: 48,
                                    //         orderRadius: 4,
                                    //         onTap: (){
                                    //           if(controller.orderQty.value>1){
                                    //             controller.orderQty.value-=1;
                                    //             quantiyEdittext.text=controller.orderQty.value.toString();
                                    //           }
                                    //
                                    //         },
                                    //         title: "-",
                                    //         textColor: Colors.white,
                                    //         textSize: 28,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),


                                SizedBox(height: 16,),

                                widget.menu!.isPickUpAvailable! && widget.menu!.isDeliveryAvailable! ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Opacity(
                                      opacity: 0.90,
                                      child: Text(
                                        'Available Services',
                                        style: TextStyle(
                                          color: Color(0xFF01180D),
                                          fontSize: 13,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                             side: BorderSide(color: Color(0xFF0FFD9D9D9)),
                                              activeColor: kPrimaryColorx,
                                              value: controller.menuIspickup.value,
                                              onChanged: (onChanged) {
                                                controller.menuIspickup.value = onChanged!;
                                                controller.menuIsDelivery.value = false;
                                                if(onChanged){
                                                  controller.deliveryOption.value ="PickUp";
                                                }else{
                                                  controller.deliveryOption.value ="";
                                                }

                                              }
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Opacity(
                                          opacity: 0.90,
                                          child: Text(
                                            'Pick Up',
                                            style: TextStyle(
                                              color: Color(0xFF01180D),
                                              fontSize: 12,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                              side: BorderSide(color: Color(0xFF0FFD9D9D9)),
                                              activeColor: kPrimaryColorx,
                                              value: controller.menuIsDelivery.value,
                                              onChanged: (onChanged) {
                                                controller.menuIsDelivery.value = onChanged!;
                                                controller.menuIspickup.value=false;
                                                if(onChanged){
                                                  controller.deliveryOption.value ="Delivery";
                                                }else{
                                                  controller.deliveryOption.value ="";
                                                }

                                              }
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Opacity(
                                          opacity: 0.90,
                                          child: Text(
                                            'Delivery',
                                            style: TextStyle(
                                              color: Color(0xFF01180D),
                                              fontSize: 12,
                                              fontFamily: 'Satoshi',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ):SizedBox(),

                                SizedBox(height: 16,),
                                controller.deliveryOption.value =="Delivery" ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12,),

                                    Opacity(
                                      opacity: 0.90,
                                      child: Text(
                                        'Delivery Address',
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
                                      height: 55,
                                      isValueChnged: true,
                                      tap: (text) {
                                        if (text.isNotEmpty) {
                                          controller.deliveryAdress.value = text;
                                        } else {
                                          controller.deliveryAdress.value = "";
                                        }
                                      },
                                      hintText: "Write your address",
                                      bgColor: textFieldBackground,
                                      errormsg: "Please enter Delivery Address",
                                      borderColor: textFieldBackground,),
                                    SizedBox(height: 32,),
                                    Center(child: SvgPicture.asset("assets/images/delivery-2.svg",height: 154,width: 182,)),
                                    SizedBox(height: 12,),
                                    Center(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Your delivery charge will be added from chef',
                                              style: TextStyle(
                                                color: Color(0xFF5C6360),
                                                fontSize: 13,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w500,
                                                height: 0.09,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  ],
                                ):SizedBox(),

                                controller.deliveryOption.value =="PickUp"?
                                Container(
                                  width: 1.0.sw,
                                  margin: EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pick Up Location',
                                        style: TextStyle(
                                          color: Color(0xFF02190E),
                                          fontSize: 13,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SvgPicture.asset("assets/icons/location.svg",color: kPrimaryColorx,),
                                          SizedBox(width: 4,),
                                          Opacity(
                                            opacity: 0.90,
                                            child: Text(
                                              widget.menu!.chef!.address??"",
                                              style: TextStyle(
                                                color: Color(0xFF5C6360),
                                                fontSize: 12,
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ):
                                SizedBox(),


                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          controller.circuler.value
                              ? LoadingWidget()
                              : CustomButton(
                              height: 52,
                              orderRadius: 40,
                              color: controller.orderQty.value == 0 ||
                                  controller.deliveryOption.value == ""||
                                  controller.orderDelivryTime.value==""||
                                  (controller.deliveryOption.value == "Delivery"?controller.deliveryAdress.value=="":false)
                                  ? Color(0xFFBCC3C0) : kPrimaryColorx,
                              boder: false,
                              textColor: Colors.white,
                              title: "Go Ahead",
                              onTap: () {
                                if(controller.orderQty.value == 0 ||
                                    controller.deliveryOption.value == ""||
                                    controller.deliveryOption.value == ""||
                                    controller.orderDelivryTime.value==""||
                                    (controller.deliveryOption.value == "Delivery"?controller.deliveryAdress.value=="":false)){
                                }else{

                                  Logger().w(controller.orderDelivryTime.value);
                                  controller.createOrder(id: widget.menu!.id!).then((value){
                                    if(value!.statusCode==200){
                                      // showAlertDialog(context);
                                      // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                                      Navigator.pushReplacementNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                                        'orderId':value.order!.orderId
                                      });

                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Color(0xFFF01212),
                                        content: Container(
                                          // constraints: BoxConstraints(
                                          //   maxHeight: 2,
                                          // minHeight: 24,
                                          // ),
                                          padding: EdgeInsets.all(4),
                                          child: Text(value.message!),
                                        ),
                                        duration: Duration(milliseconds: 1500),
                                      ));
                                    }
                                  });
                                }



                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),

          );
        });
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            height: 48.h,
            orderRadius: 4,
            width: 120,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: true,
            title: "Cancel",
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE, (route) => false);
            }),
        SizedBox(width: 12,),
        CustomButton(
            height: 48.h,
            width: 120,
            orderRadius: 4,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: false,
            title: "Okay",
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE, (route) => false);
              Get.find<HomeController>().onItemTapped(1);

            })
      ],
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        height: 220,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/order.svg"),
                SizedBox(height: 12,),
                Text(
                  'Menu Ordered',
                  style: TextStyle(
                    color: Color(0xFF01180D),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  'Your Order Are Placed, Go to Order History And See Details ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF01180D),
                    fontSize: 12,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12,),

              ],
            )
          ],
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

  bool isNumberInRange(int number, int minRange, int maxRange) {
    return number >= minRange && number <= maxRange;
  }
}

