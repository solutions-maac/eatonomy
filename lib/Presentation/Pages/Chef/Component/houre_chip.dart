import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class HoureChip extends StatelessWidget {
  final String? houre;
  const HoureChip({Key? key, this.houre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      margin: EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(top: 8, left: 12, right: 14, bottom: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFD1D1D1)),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            houre??"",
            style: TextStyle(
              color: Color(0xFF6D7075),
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
