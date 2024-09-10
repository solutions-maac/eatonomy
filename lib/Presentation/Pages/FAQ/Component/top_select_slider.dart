import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';

class TopSelectSlider extends StatelessWidget {
 final String? title;
 final String? icon;
 final bool? select;
  const TopSelectSlider({Key? key, this.title, this.icon, this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration:  BoxDecoration(
          color:select!?Color(0xFFEDFCF8): Colors.white.withOpacity(0.10),
          border: Border.all(color:select!? kPrimaryColorx:Colors.grey.withOpacity(0.30))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon!,color:select!? kPrimaryColorx:Colors.black,),
          Text(title!,style: mediumText(14.sp,color: select!? kPrimaryColorx:Colors.black),)
        ],
      ),
    );
  }
}
