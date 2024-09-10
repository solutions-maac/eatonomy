import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Review/Review.dart';

class ReviewCrad extends StatelessWidget {
  final Review? review;
  const ReviewCrad({Key? key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Expanded(
             flex: 2,
             child:review!.userInfo!.profilePicture!=null?
             CircleAvatar(
               backgroundColor: Colors.indigoAccent,
               backgroundImage: NetworkImage(review!.userInfo!.profilePicture!),
               radius: 18,
             )
                 :
             CircleAvatar(
               backgroundColor: Colors.indigoAccent,
               radius: 18,
               child: Text("j"),
             ),
           ),
          SizedBox(width: 6,),
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review!.userInfo!.name??"",
                      style: TextStyle(
                        color: Color(0xFF070B37),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icons/star.svg',height: 15,),

                        Text(
                            review!.rating!.toDouble().toString(),
                          style: TextStyle(
                            color: Color(0xFF9FA8B8),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                SizedBox(height: 4,),
                Text(
                  timeAgo(getCustomFormattedDateTime(review!.createdAt!,
                      'MM-dd-yyy h:mm a')),
                  style: TextStyle(
                    color: Color(0xFF525573),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 6,),
                Text(
                  review!.comment??"",
                  style: TextStyle(
                    color: Color(0xFF070B37),
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                ),

                // RatingBar.builder(
                //   initialRating: review!.rating!.toDouble(),
                //   minRating: 1,
                //   direction: Axis.horizontal,
                //   allowHalfRating: false,
                //   itemCount: 5,
                //   itemSize: 22,
                //   unratedColor: kPrimaryColorx.withOpacity(0.25),
                //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                //   itemBuilder: (context, _) =>
                //       Icon(Icons.star, color: Colors.amber,), onRatingUpdate: (double value) {  },
                //
                // ),
                // RatingBar(
                //   initialRating:review!.rating!.toDouble(),
                //   minRating: 0,
                //   ignoreGestures: true,
                //   direction: Axis.horizontal,
                //   allowHalfRating: true,
                //   itemCount: 5,
                //   itemSize: 12,
                //   itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                //   ratingWidget: RatingWidget(
                //     full: SvgPicture.asset('assets/icons/star.svg'),
                //     half: SvgPicture.asset('assets/icons/star.svg'),
                //     empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                //   ),
                //   onRatingUpdate: (ratingx) {
                //
                //   },
                // ),
                // SizedBox(height: 4,),

              ],
            ),
          )
        ],
      ),
    );
  }


  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(
        givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    // return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1
          ? "year"
          : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1
          ? "month"
          : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1
          ? "week"
          : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1
          ? "minute"
          : "minutes"} ago";
    return "just now";
  }
}
