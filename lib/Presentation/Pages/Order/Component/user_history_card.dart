import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserOrderHistoryCard extends StatelessWidget {
  const UserOrderHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child:Column(
        children: [
          Container(
            width: 1.0.sw,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.38,
                  color: Color(0xB2D9D9D9),
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://via.placeholder.com/48x48"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shad Mahmud',
                          style: TextStyle(
                            color: Color(0xFF070B37),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  child: SvgPicture.asset("assets/icons/car.svg"),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: Color(0xFF525573),
                                    fontSize: 9,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 12,),
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  child: SvgPicture.asset("assets/icons/clock.svg"),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  'At 3:30 pm',
                                  style: TextStyle(
                                    color: Color(0xFF525573),
                                    fontSize: 9,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              child: SvgPicture.asset("assets/icons/location.svg"),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'Road 06, block d',
                              style: TextStyle(
                                color: Color(0xFF525573),
                                fontSize: 9,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),


                Container(
                  width: 83,
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF00934C)),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(
                    'Delivered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF00934C),
                      fontSize: 12,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),



          SizedBox(height: 12,),
          Container(
            width: 1.0.sw,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.38,
                  color: Color(0xB2D9D9D9),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
