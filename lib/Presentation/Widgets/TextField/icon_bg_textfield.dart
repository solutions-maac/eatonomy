 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class IconBackgroundTextfield extends StatelessWidget {
  final String hintText;
  final String icons;
  final double borderRadius;
  final bool readOnly;
  Color? bgColor=Color(0xFFE7EBF6);
  Color? borderColor=Color(0xFFE7EBF6);
  final bool isNumber;
  final bool isValueChnged;
  final bool isemail;
  final bool iconsLats;
  final Function(String)? tap;
  final Function()? onSubmit;
  TextEditingController? controller;
  IconBackgroundTextfield({required this.controller,
  required this.hintText,required this.readOnly,
  required this.isNumber,this.bgColor,this.borderColor, this.tap,  this.isValueChnged=false,  this.isemail=false,  required this.icons,  this.iconsLats=false,  this.borderRadius=40.0, this.onSubmit});
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 48.h,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            if(isNumber){
              return tr("Enter a valid mobile number");
            }else if(isemail){
              return tr("Enter a valid email address");
            }else{
              return tr("Fill the field");
            }
          }else{
            String pattern =
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$";
            RegExp regex = RegExp(pattern);

            if(isNumber){
              return value.length < 11 ?tr('invalid number'):null;
            }
            else if(isemail){
             return !regex.hasMatch(value)?tr('invalid email'):null;
            } else{
              return null;
            }
          }
        },
        keyboardType: isNumber?TextInputType.number:TextInputType.text,
        inputFormatters:isNumber? [
          LengthLimitingTextInputFormatter(11),
        ]:[],
        readOnly: readOnly,
        controller: controller,
        textInputAction: TextInputAction.done,
        onEditingComplete:onSubmit,
        onChanged: isValueChnged?tap:null,
        decoration: InputDecoration(
          hintText: tr(hintText),
          hintStyle: TextStyle(color: Color(0xFF8D8D8D)),
          suffixIcon:iconsLats? Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.asset(icons,color: Color(0xFF8D8D8D),), // icon is 48px widget.
          ):null,
          prefixIcon:!iconsLats?  Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
            child: SvgPicture.asset(icons,color: Color(0xFF8D8D8D),), // icon is 48px widget.
          ):null,
          fillColor: bgColor,
          filled: true,
          isDense: true,
          contentPadding:
          EdgeInsets.symmetric(vertical: 16, horizontal: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color:borderColor!, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color:borderColor!, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
    );
  }
}
