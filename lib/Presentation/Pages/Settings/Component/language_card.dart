import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Config/text_style.dart';
import 'language_switch.dart';




class LanguageCard extends StatefulWidget {
  final String? title;
  final Color? color;


  LanguageCard({this.title, this.color, Key? key})
      : super(key: key);

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,

      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(

            children: [
              SizedBox(width: 4.w,),
              Expanded(
                  flex: 7,
                  child: Text(
                    widget.title!,
                    style: mediumText(14.sp),
                  ).tr()),
              Expanded(flex: 3, child: LanguageTabbar())
            ],
          ),
        ],
      ),
    );
  }
}
