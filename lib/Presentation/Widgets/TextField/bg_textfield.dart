import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/Colors/app_colors.dart';

class BackgroundTextfield extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  Color? bgColor=textFieldBackground;
  Color? borderColor=textFieldBackground;
  final bool isNumber;
  final bool isValueChnged;
  final bool isemail;
  final bool isNullAble;
  final String? errormsg;
  final double? height;
  final double? contentpadding;
  final Function(String)? tap;
  TextEditingController? controller;
  BackgroundTextfield({required this.controller,
  required this.hintText,required this.readOnly,
  required this.isNumber,this.bgColor,this.borderColor, this.tap,  this.isValueChnged=false,  this.isemail=false,  this.height=45, this.errormsg="Please Fillup", this.contentpadding=16,  this.isNullAble=false});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
       // height: height!,
      child: TextFormField(
        validator: (value) {
          if(isNullAble){
            return null;
          }
          else{
            if (value == null || value.isEmpty) {
              if(isNumber){
                return errormsg??"Please enter your phone number";
              }else if(isemail){
                return errormsg??"Please enter your email address";
              }else{
                return errormsg!;
              }
            }
            else{
              String pattern =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              RegExp regex = RegExp(pattern);
              if(isNumber){
                RegExp regex = RegExp(r"\s");
                RegExp regexx = RegExp(r"-");
                RegExp regedot = RegExp(r"\.");
                RegExp regecoma = RegExp(r",");
                RegExp regeatoz = RegExp(r"[a-z A-Z]");

                return regeatoz.hasMatch(value)||regecoma.hasMatch(value)||regedot.hasMatch(value)|| regex.hasMatch(value)||regexx.hasMatch(value) ?tr('Invalid number'):null;
              }
              else if(isemail){
                return !regex.hasMatch(value)?tr('Invalid email'):null;
              } else{
                return null;
              }

            }
          }


        },
        keyboardType: isNumber?TextInputType.number:TextInputType.text,
        // inputFormatters:isNumber? [
        //   LengthLimitingTextInputFormatter(11),
        // ]:[],
        readOnly: readOnly,
        controller: controller,
        onChanged: isValueChnged?tap:null,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF929B96),
            fontSize: 12,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w400,
          ),
          fillColor: bgColor,
          filled: true,

          contentPadding:
          EdgeInsets.symmetric(vertical: contentpadding!, horizontal: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.red),
          //   borderRadius: BorderRadius.circular(6),
          // ),

          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color:borderColor!, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color:borderColor!, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
        ),
      ),
    );
  }
}
