import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../Widgets/Button/custom_button.dart';

class ChefMenuUnderOrderCard extends StatelessWidget {
  final Order? order;
  const ChefMenuUnderOrderCard({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            width: 1.0.sw,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0x7FD9D9D9),
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex:8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(order!.user!.profilePicture??"https://via.placeholder.com/48x48"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order!.user!.name??"",
                            style: TextStyle(
                              color: Color(0xFF02190E),
                              fontSize: 16,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Opacity(
                            opacity: 0.80,
                            child: Text(
                             "Total ${order!.quantity} Parcel",
                              style: TextStyle(
                                color: Color(0xFF5C6360),
                                fontSize: 11,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/car.svg",color: Color(0xFF8D8D8D),),
                                  SizedBox(width: 4,),
                                  Text(
                                    order!.deliveryOption??"",
                                    style: TextStyle(
                                      color: Color(0xFF8D8D8D),
                                      fontSize: 10,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 12,),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/clock.svg",color: Color(0xFF8D8D8D),),
                                  SizedBox(width: 4,),
                                  Text(
                                      order!.deliveryFrom==null||order!.deliveryFrom==""?"":
                                    order!.deliveryDay!+" At "+convertTo12HourFormat(order!.deliveryFrom)+" - "+convertTo12HourFormat(order!.deliveryTo),
                                    style: TextStyle(
                                      color: Color(0xFF8D8D8D),
                                      fontSize: 10,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/location.svg"),
                              SizedBox(width: 4,),
                              Text(
                                order!.deliveryAddress==""? order!.chef!.address!:order!.deliveryAddress!,
                                style: TextStyle(
                                  color: Color(0xFF8D8D8D),
                                  fontSize: 10,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),


                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex:2,
                  child: CustomButton(
                      height: 36,
                      orderRadius: 40,
                      width: 70,
                      textSize: 12,
                      boder:  order!.status=="COMPLETED",
                      color:order!.status=="CANCELLED"? Colors.redAccent:kPrimaryColorx,
                      textColor: Colors.white,
                      title:order!.status=="PROCESSING"?"Serving": order!.status=="COMPLETED"?"Served":order!.status=="CANCELLED"?"Cancelled":"Serving",
                      onTap: () {
                        Navigator.pushNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                          'orderId':order!.orderId
                        });
                        // Navigator.pushNamed(context, MAIN_PAGE);
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  String convertTo12HourFormat(String time24Hour) {
    int hour = int.parse(time24Hour);
    int minute = int.parse('0');
    String period = (hour >= 12) ? 'PM' : 'AM';
    if (hour > 12) {
      hour -= 12;
    }

    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');

    return '$hourString:$minuteString $period';
  }
}
