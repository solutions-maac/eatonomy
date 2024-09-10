import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Config/text_style.dart';

class ActionButton extends StatelessWidget {
  final Color? iconColor;
  final String? title;
  final String? svg;
  const ActionButton({Key? key, this.title, this.svg, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

      ),
      child: Row(
        children: [

          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: mediumText(14.sp),
                    ).tr(),

                    Icon(Icons.arrow_forward_ios_outlined,size: 14.sp,color: Color(0XFF9A9A9A),)

                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
