import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Constants/Colors/app_colors.dart';

class Compliment extends StatelessWidget {
  final String? name,image,number;
  const Compliment({Key? key, this.name, this.image, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Color(0xFFEAF6F4),
                    borderRadius: BorderRadius.circular(100),
                  border: Border.all(color:Color(0xFFA4D8C2) )
                ),
                child: Center(child: SvgPicture.asset(image??"",height: 32,)),
              ),
              Positioned(
                right: 2,
                child: Container(
                    height: 20,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: kPrimaryColorx,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(
                      child: Text(
                        number??"",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          Text(
              name??"",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF02190E),
                fontWeight: FontWeight.w400,
              )
          )
        ],
      ),
    );
  }
}
