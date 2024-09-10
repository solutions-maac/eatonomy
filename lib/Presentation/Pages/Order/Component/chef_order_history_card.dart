import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../../Data/Model/User/User.dart';
import '../../../Widgets/Button/custom_button.dart';

class ChefOrderHistoryCard extends StatelessWidget {
  final User?user;
  final Order?order;
  final String? meneName,createAt,orderId;
  const ChefOrderHistoryCard({Key? key, this.user, this.meneName, this.createAt, this.orderId, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user!.profilePicture??"https://via.placeholder.com/48x48"),
                      fit: BoxFit.cover,
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
                      user!.name??"",
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 16,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text(
                        meneName??"",
                      style: TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6,),
                    order!.alreadyReviewed == null ||
                        order!.alreadyReviewed == false?SizedBox():
                    RatingBar(
                      initialRating:order!.customerReview!=null?
                      order!.customerReview!.rating!.toDouble():0.0,
                      minRating: 0,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ratingWidget: RatingWidget(
                        full: SizedBox(
                            height: 8,
                            child: SvgPicture.asset('assets/icons/star.svg',height: 6.23,)),
                        half: SizedBox(
                            height: 8,
                            child: SvgPicture.asset('assets/icons/star.svg')),
                        empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                      ),
                      onRatingUpdate: (ratingx) {

                      },
                    ),
                    SizedBox(height: 6,),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          child: SvgPicture.asset("assets/icons/calendar.svg"),
                        ),
                        SizedBox(width: 4,),
                        Text(
                          getCustomFormattedDateTime(order!.updatedAt!,'MMM-dd-yyy h:mm a').toString() ,
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 11,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                  'orderId':order!.orderId
                });
              },
              child: Container(
              height: 26,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: ShapeDecoration(
                 color: Colors.white,
                 shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Color(0xFF00934C)),
                   borderRadius: BorderRadius.circular(40),
              ),
              ),
              child: Center(
                child: Text(
                  'View',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00934C),
                    fontSize: 12,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
                      ),
            ),
          )
        ],
      ),

    );
  }

  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    return DateFormat(dateFormat).format(docDateTime);
    // return docDateTime;
  }
}
