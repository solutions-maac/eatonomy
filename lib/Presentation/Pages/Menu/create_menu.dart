
import 'package:eatonomy/GetX%20Controller/Order/OrderController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';
import 'package:time_range/time_range.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../GetX Controller/Menu/MenuController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import 'package:flutter/services.dart';
class CreateMenu extends StatefulWidget {
  final String?id;

  CreateMenu({Key? key, this.id}) : super(key: key);

  @override
  State<CreateMenu> createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {
  TextEditingController menuTextController = new TextEditingController();
  final globalkey = GlobalKey<FormState>();
  List<String> fromNumberList = [];
  List<String> toNumberList = [];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,()=>Get.find<MenuControllerx>().onInit());
    for (int i = 1; i <= 24; i++) {
      fromNumberList.add(i.toString());
    }
    Logger().w("run");
    Future.delayed(Duration.zero,(){
      Get.find<MenuControllerx>().orderDeliveryForm.value = "";
      Get.find<MenuControllerx>().orderDeliveryFormView.value = "";
      Get.find<MenuControllerx>().orderDeliveryTo.value = "";
      Get.find<MenuControllerx>().orderDeliveryToView.value = "";
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Create Menu',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<MenuControllerx>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(

              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              height: 1.0.sh,
              child: SingleChildScrollView(
                child: Form(
                  key: globalkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Title',
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
                        hintText: "Title",
                        height: 55,
                        isValueChnged: true,
                        tap: (text){
                          if(text.isNotEmpty){
                            controller.menuTitle.value=text;
                          }else{
                            controller.menuTitle.value="";
                          }
                        },
                        bgColor: textFieldBackground,
                        errormsg: "Please enter title",
                        borderColor: textFieldBackground,),
                      SizedBox(height: 12,),


                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Menu Type',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select menu type";
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
                            hintText: "Menu Type",
                            fillColor: textFieldBackground
                        ),
                        icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                        value: controller.menuType.value,
                        onChanged: (newValue) {
                          controller.menuType.value=newValue!;
                        },
                        items: ["Daily","Weekly","Event",]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16,),


                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Select Cuisine',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
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
                            hintText: "Menu Type",
                            fillColor: textFieldBackground
                        ),
                        icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                        value: controller.selectCuisine.value==""?null:controller.selectCuisine.value,
                        onChanged: (newValue) {
                          controller.selectCuisine.value=newValue!;
                        },
                        items: controller.cuisineListx
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),




                      SizedBox(height: 16,),
                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Price',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),



                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return "Please enter price";
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
                          LengthLimitingTextInputFormatter(6),
                        ],
                        controller: null,
                        onChanged: (text){
                          if(text.isNotEmpty){
                            controller.menuPrice.value=text;
                          }else{
                            controller.menuPrice.value="";
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Price",
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
                      SizedBox(height: 16,),

                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Hot Deal',
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
                                value: controller.hotDealAvailable.value,
                                onChanged: (onChanged){
                                  controller.hotDealAvailable.value=onChanged!;
                                }
                            ),
                          ),
                          SizedBox(width: 8,),
                          Opacity(
                            opacity: 0.90,
                            child: Text(
                              'Available',
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
                      SizedBox(height:controller.hotDealAvailable.value?0: 16,),


                      controller.hotDealAvailable.value?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          Opacity(
                            opacity: 0.90,
                            child: Text(
                              'Discount Price',
                              style: TextStyle(
                                color: Color(0xFF01180D),
                                fontSize: 13,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return controller.hotDealAvailable.value?"Please enter discount price":null;
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
                              LengthLimitingTextInputFormatter(6),
                            ],
                            controller: null,
                            onChanged: (text){
                              if(text.isNotEmpty){
                                controller.menuDiscountPrice.value=text;
                              }else{
                                controller.menuDiscountPrice.value="";
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Discount Price",
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

                          SizedBox(height: 16,),
                        ],
                      ) :SizedBox(),





                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Menu',
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
                        controller: menuTextController,
                        readOnly: false,
                        isNumber: false,
                        isNullAble: true,
                        isemail: false,
                        hintText: "Menu",
                        height: 55,
                        isValueChnged: true,
                        tap: (text){
                          if(text.isNotEmpty){
                            controller.menuIteamType.value=text;
                          }else{
                            controller.menuIteamType.value="";
                          }

                        },
                        bgColor: textFieldBackground,
                        errormsg: "Please enter Menu",
                        borderColor: textFieldBackground,),
                      SizedBox(height: 8,),
                      controller.menuIteam.value.isEmpty?
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: (){
                                  if(controller.menuIteamType.value!=""){
                                    controller.menuIteam.value.add(controller.menuIteamType.value);
                                    controller.menuIteamType.value="";
                                    menuTextController.text="";
                                  }
                                },
                                child: Container(
                                  width: 85,
                                  height: 32,
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, right: 12, bottom: 8),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.50, color:controller.menuIteamType.value==""?Color(0xFFC2C8D3): Color(0xFF00934C)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        child: Icon(
                                          Icons.add, color:menuTextController.text.isEmpty?Color(0xFFC2C8D3): kPrimaryColorx,
                                          size: 16,),
                                      ),
                                      const SizedBox(width: 4),
                                      Opacity(
                                        opacity: 0.90,
                                        child: Text(
                                          'Add More',
                                          style: TextStyle(
                                            color:menuTextController.text.isEmpty?Color(0xFFC2C8D3): Color(0xFF00934C),
                                            fontSize: 10,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              )
                          ),


                          Expanded(
                            flex: 8,
                            child: Text(""),
                          )

                        ],
                      )
                      :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children:controller.menuIteam.value.map((e) {
                              return Container(
                                height: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF5F5F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      e,
                                      style: TextStyle(
                                        color: Color(0xFF5C6360),
                                        fontSize: 12,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: (){
                                        controller.menuIteam.value.removeWhere((element) => element==e);
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFE2E3E7),
                                          shape: OvalBorder(),
                                        ),
                                        child: Icon(Icons.close,size: 12,),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: (){
                                      if(controller.menuIteamType.value!=""){
                                        controller.menuIteam.value.add(controller.menuIteamType.value);
                                        controller.menuIteamType.value="";
                                        menuTextController.text="";
                                      }
                                    },
                                    child: Container(
                                        width: 85,
                                        height: 32,
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 8, right: 12, bottom: 8),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.50, color:controller.menuIteamType.value==""?Color(0xFFC2C8D3): Color(0xFF00934C)),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              child: Icon(
                                                Icons.add, color:controller.menuIteamType.value==""?Color(0xFFC2C8D3): kPrimaryColorx,
                                                size: 16,),
                                            ),
                                            const SizedBox(width: 4),
                                            Opacity(
                                              opacity: 0.90,
                                              child: Text(
                                                'Add More',
                                                style: TextStyle(
                                                  color:menuTextController.text.isEmpty?Color(0xFFC2C8D3): Color(0xFF00934C),
                                                  fontSize: 10,
                                                  fontFamily: 'Satoshi',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  )
                              ),


                              Expanded(
                                flex: 8,
                                child: Text(""),
                              )

                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16,),

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
                                onChanged: (onChanged){
                                  controller.menuIspickup.value=onChanged!;
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
                      SizedBox(height: 14,),
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                                side: BorderSide(color: Color(0xFF0FFD9D9D9)),
                                activeColor: kPrimaryColorx,
                                value: controller.menuIsDelivery.value,
                                onChanged: (onChanged){
                                  controller.menuIsDelivery.value=onChanged!;
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
                      SizedBox(height: 16,),

                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Delivery / Pick Up',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      SizedBox(height: 8,),
                      InkWell(
                        onTap: (){
                          showWeekDayDialog(context,controller);
                        },
                        child: Container(
                          width: 1.0.sw,
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 18),
                          decoration: ShapeDecoration(
                            color: textFieldBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Opacity(
                            opacity: 0.90,
                            child:controller.orderDeliveryDay.value==""? Text(
                              'Select Order Delivery / Pick Up Day',
                              style: TextStyle(
                                color: Color(0xFF929B96),
                                fontSize: 12,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w400,
                              ),
                            ):
                            Text(
                              controller.orderDeliveryDay.value,
                              style: TextStyle(
                                color: Color(0xFF01180D),
                                fontSize: 14,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 16,),

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
                                      return "Please select time";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
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
                                      hintText: "Available Time",
                                      fillColor: textFieldBackground
                                  ),
                                  dropdownColor: textFieldBackground,
                                  icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                                  value: controller.orderDeliveryForm.value==""?null:controller.orderDeliveryForm.value,
                                  onChanged: (newValue) {
                                    controller.orderDeliveryForm.value=newValue!;
                                    controller.orderDeliveryTo.value="";
                                    // Logger().w(widget.menu!.deliveryFrom!.toInt());
                                    // Logger().w(widget.menu!.deliveryTo!.toInt());
                                    toNumberList.clear();
                                    for (int i = int.parse(newValue)+1; i <= 24; i++) {
                                      setState(() {
                                        toNumberList.add(i.toString());
                                      });

                                    }

                                    Logger().w(newValue);
                                    Logger().w(toNumberList);
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
                                      SvgPicture.asset("assets/icons/arrow-down2.svg"),
                                    ],
                                  ),
                                ):
                                DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please select time";
                                    } else {
                                      return null;
                                    }
                                  },
                                  dropdownColor: textFieldBackground,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
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
                                      hintText: "Available Time",
                                      fillColor: textFieldBackground
                                  ),
                                  icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                                  value: controller.orderDeliveryTo.value==""?null:controller.orderDeliveryTo.value,
                                  onChanged: (newValue) {
                                    controller.orderDeliveryTo.value=newValue!;
                                    // Logger().w(controller.orderDeliveryTo.value);
                                    // controller.orderDelivryTime.value=controller.orderFromTimex.value+"-"+controller.orderToTimex.value;
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

                      SizedBox(height: 16,),

                      // TimeRange(
                      //   fromTitle: Text('From', style: TextStyle(fontSize: 18, color: Colors.grey),),
                      //   toTitle: Text('To', style: TextStyle(fontSize: 18, color: Colors.grey),),
                      //   titlePadding: 0,
                      //   textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                      //   activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      //   borderColor: kPrimaryColorx,
                      //   backgroundColor: Colors.transparent,
                      //   activeBackgroundColor: kPrimaryColorx,
                      //   firstTime: TimeOfDay(hour: 1, minute: 00),
                      //   lastTime: TimeOfDay(hour: 24, minute: 00),
                      //   timeStep: 60,
                      //   timeBlock: 60,
                      //   onRangeCompleted: (range){
                      //     Logger().w(range!.start.hour);
                      //     controller.orderDeliveryForm.value = range.start.hour.toString();
                      //     controller.orderDeliveryFormView.value =range.start.hour.toString();
                      //     controller.orderDeliveryTo.value = range.end.hour.toString();
                      //     controller.orderDeliveryToView.value = range.end.hour.toString();
                      //   },
                      // ),
                      // SizedBox(height: 8,),
                      // Text(
                      //       controller.orderDeliveryFormView.value==""||controller.orderDeliveryToView.value=="" ?"":
                      //       " Form "+convertTo12HourFormat(controller.orderDeliveryFormView.value)+" To "+convertTo12HourFormat(controller.orderDeliveryToView.value),
                      //     style: TextStyle(
                      //       color: Color(0xFF01180D),
                      //       fontSize: 14,
                      //       fontFamily: 'Satoshi',
                      //       fontWeight: FontWeight.w700,
                      //     ),
                      //   ),
                      // SizedBox(height: 12,),
                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Order Taking Before Delivery (Hour)',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select hour";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
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
                            hintText: "Select Hour",
                            fillColor: textFieldBackground
                        ),
                        icon: SvgPicture.asset("assets/icons/arrow-down2.svg"),
                        value: controller.orderTakingInstruction.value==""?null:controller.orderTakingInstruction.value,
                        onChanged: (newValue) {
                          controller.orderTakingInstruction.value=newValue!;
                        },
                        items: ["4","8","12","18","24","36","48"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: 16,),



                      Opacity(
                        opacity: 0.90,
                        child: Text(
                          'Picture',
                          style: TextStyle(
                            color: Color(0xFF01180D),
                            fontSize: 13,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      SizedBox(height: 8,),
                      SizedBox(
                        height: 110,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Wrap(
                              children:controller.menuImages.value.map((e) {
                                return  Container(
                                  width: 147,
                                  height: 97,
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(e),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(width:controller.menuImages.value.isEmpty?0: 12,),
                            controller.imageCirculer.value?LoadingWidget(): InkWell(
                              onTap: (){
                                controller.filepic();
                              },
                              child: Container(
                                width: 157,
                                margin: EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.only(
                                  top: 9,
                                  left: 13,
                                  right: 13,
                                  bottom: 15,
                                ),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.75, color: Color(0xFF00934C)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      child: Icon(
                                        Icons.add, color: kPrimaryColorx, size: 24,),
                                    ),
                                    const SizedBox(height: 2),
                                    Opacity(
                                      opacity: 0.90,
                                      child: Text(
                                        'Upload Image',
                                        style: TextStyle(
                                          color: Color(0xFF00934C),
                                          fontSize: 12,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 16,),
                      controller.circuler.value ? LoadingWidget() : CustomButton(
                          height: 52,
                          orderRadius: 40,
                          color:controller.menuTitle.value==""||
                              controller.menuPrice.value==""||
                              controller.orderTakingInstruction.value=="Select Hour"||
                              controller.orderDeliveryDay.value==""||
                              controller.orderDeliveryForm.value==""||
                              controller.orderDeliveryTo.value==""||
                              controller.selectCuisine.value==""||
                              controller.menuImages.isEmpty
                          ?Color(0xFFBCC3C0) :kPrimaryColorx,
                          boder: false,
                          textColor: Colors.white,
                          title: "Create Menu",
                          onTap: () {
                           if (globalkey.currentState!.validate()) {
                             if(double.parse(controller.menuPrice.value).isNegative){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 backgroundColor: Colors.redAccent,
                                 content: Text("Price can't be negative"),
                                 duration: Duration(milliseconds: 700),
                               ));
                             }
                             else{
                               if(
                               controller.menuTitle.value==""||
                                   controller.menuPrice.value==""||
                                   controller.orderTakingInstruction.value=="Select Hour"||
                                   controller.orderDeliveryDay.value==""||
                                   controller.orderDeliveryForm.value==""||
                                   controller.orderDeliveryTo.value==""||
                                   controller.selectCuisine.value==""||
                                   double.parse(controller.menuPrice.value)<0||
                                   controller.menuImages.isEmpty){

                               }else{

                                 if(controller.menuIteam.value.isEmpty){
                                   if(menuTextController.text!=""){
                                     controller.menuIteam.value.add(menuTextController.text);
                                     controller.menuIteamType.value="";
                                     menuTextController.text="";
                                   }else{
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                       backgroundColor: Colors.redAccent,
                                       content: Text("Must add one menu"),
                                       duration: Duration(milliseconds: 700),
                                     ));
                                   }
                                 }else{

                                     if(controller.hotDealAvailable.value&&num.parse(controller.menuPrice.value)<=num.parse(controller.menuDiscountPrice.value)){
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                         backgroundColor: Colors.redAccent,
                                         content: Text("Discount price can't greater or equal then price"),
                                         duration: Duration(milliseconds: 1200),
                                       ));
                                     }
                                   else{
                                     if(controller.menuIspickup.value==false&&controller.menuIsDelivery.value==false){
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                         backgroundColor: Colors.redAccent,
                                         content: Text("Please select available services"),
                                         duration: Duration(milliseconds: 1200),
                                       ));
                                     }else{
                                       controller.createMenu(context, widget.id!).then((value) {
                                         if(value!.statusCode==200){
                                           showAlertDialog(context);
                                         }
                                       });
                                     }

                                   }

                                 }

                               }
                             }
                           }




                          }),
                      SizedBox(height: 24,),

                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        height: 276,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pushReplacementNamed(context, MAIN_PAGE);
                      Navigator.pushNamed(context, SHEF_PROFILE_PAGE,arguments: {
                        'id':widget.id!,
                        'localuser':false
                      });
                    },
                    child: Icon(Icons.close, color: Colors.black,))
              ],
            ),
            SizedBox(height: 4,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/menucreate.svg"),
                SizedBox(height: 12,),
                Text(
                  'Well done',
                  style: TextStyle(
                    color: Color(0xFF01180D),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  'You have successfully created your \n menu',
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
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showWeekDayDialog(BuildContext context,MenuControllerx? controller) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.90,
              child: Text(
                'Select Delivery / Pick Up Day',
                style: TextStyle(
                  color: Color(0xFF01180D),
                  fontSize: 13,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 12,),
            Column(
              children: controller!.weekdays.map((e) {
                return ListTile(
                  title: Text(e),
                  onTap: () {
                    controller.orderDeliveryDay.value = e;
                    Navigator.pop(context);
                    // showDateTimePicker(context: context,controller: controller);
                  },
                  selected: controller.orderDeliveryDay.value == e,
                  selectedTileColor: Colors.green.shade100, // Customize the selected color here
                );;
              }).toList(),
            )
          ],
        ),
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


  Future<DateTime?> showDateTimePicker({required BuildContext context,
   MenuControllerx? controller
   }) async {
    final DateTime? selectedDate = DateTime.now();
    final TimeOfDay? selectedFormTime = await showTimePicker(
      helpText: "Form Date",
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
    );
    if (selectedFormTime == null) return null;
    final TimeOfDay? selectedToTime = await showTimePicker(
      helpText: "To Date",
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
    );



    controller!.orderDeliveryForm.value = selectedFormTime.hour.toString();
    controller.orderDeliveryFormView.value = selectedFormTime.hour.toString();
    controller.orderDeliveryTo.value = selectedToTime!.hour.toString();
    controller.orderDeliveryToView.value = selectedToTime.hour.toString();

    Logger().w( controller.orderDeliveryForm.value+" "+ controller.orderDeliveryTo.value+" "+ controller.orderDeliveryDay.value);

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
}
