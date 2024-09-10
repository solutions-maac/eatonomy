import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';

class MoreCard extends StatelessWidget {
  final Color? iconColor;
  final String? title;
  final String? svg;
  const MoreCard({Key? key, this.title, this.svg, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(6),
        ),

      ),
      child: Row(
        children: [

          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(svg!,color: kPrimaryColorx,height: 20,),
                      SizedBox(width: 12,),
                      Text(
                        title!,
                        style: TextStyle(
                          color: Color(0xFF02190E),
                          fontSize: 14,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),

                  // Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Color(0xFF9A9A9A),),

                ],
              )
          )
        ],
      ),
    );
  }
}
