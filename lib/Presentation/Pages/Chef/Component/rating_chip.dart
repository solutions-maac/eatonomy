import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RatingChip extends StatelessWidget {
  final String? rate;
  final bool? isSelect;
  const RatingChip({Key? key, this.rate, this.isSelect=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      margin: EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(top: 8, left: 12, right: 14, bottom: 8),
      decoration: ShapeDecoration(
        color: isSelect!?Color(0xFFEBFFF5):Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color:isSelect!?kPrimaryColorx: Color(0xFFD1D1D1)),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/star.svg',height: 16,),
          SizedBox(width: 6,),
          Text(
            rate??"",
            style: TextStyle(
              color:isSelect!?Color(0xFF00934C): Color(0xFF5C6360),
              fontSize: 12,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
