import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';

class MoreExpandedCard extends StatefulWidget {
  final String? title;
  final String? svg;
  final double? mergin;
  final String? expandedText;
  const MoreExpandedCard({Key? key, this.title, this.svg, this.expandedText, this.mergin=0}) : super(key: key);

  @override
  State<MoreExpandedCard> createState() => _MoreExpandedCardState();
}



class _MoreExpandedCardState extends State<MoreExpandedCard> {

  bool? isExpanded=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 12),
        trailing: isExpanded!? const Icon(
          Icons.remove,
          color: Color(0xFF8D8D8D),
        ):
        const Icon(
          Icons.add,
          color: Color(0xFF8D8D8D),
        ),
        onExpansionChanged: (bool expanded) {
         setState(() {
           isExpanded = expanded;
         });
        },
        expandedAlignment: Alignment.center,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: widget.mergin!),
                child: SvgPicture.asset(widget.svg!,color: kPrimaryColorx,height: 20,)),
            SizedBox(width: 12,),
            Text(
              widget.title!,
              style:TextStyle(
                color: Color(0xFF02190E),
                fontSize: 14,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 12),
            child: Text(widget.expandedText??"",style: TextStyle(
              color: Color(0xFF5C6360),
              fontSize: 12.sp,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w300,
            ),textAlign: TextAlign.start,),
          )
        ],
      ),
    );
  }
}
