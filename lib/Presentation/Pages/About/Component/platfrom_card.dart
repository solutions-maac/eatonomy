import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Config/text_style.dart';

class PlatFromCard extends StatelessWidget {
  final String? svgAsstes;
  final String? title;
  final String? subTitle;
  const PlatFromCard({Key? key, this.svgAsstes, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Color(0xFFF0F0F0) )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
              child: SvgPicture.asset(svgAsstes!)
          ),
          SizedBox(width: 11.w,),
          Expanded(
            flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!,style: boldText(16.sp),),
                  SizedBox(height: 8.h,),
                  Text(subTitle!,style: mediumText(14.sp),),
                ],
              )
          ),

        ],
      ),
    );
  }
}
