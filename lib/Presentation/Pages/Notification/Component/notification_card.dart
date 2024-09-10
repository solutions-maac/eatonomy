import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NotificationCard extends StatelessWidget {
  final String? title,message,createdAt,image,status;
  const NotificationCard({Key? key, this.title, this.message, this.createdAt, this.image, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:status=="UNREAD"? Color(0xFFF2FCF7):Colors.white,
      child: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image!=null?image!:"https://via.placeholder.com/48x48"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: title!+"  ",
                              style: TextStyle(
                                color: Color(0XffFF02190E),
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w700,

                              ),
                            ),
                            WidgetSpan(child: SizedBox(height: 6,)),
                            TextSpan(
                              text: message!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        'About '+timeAgo(getCustomFormattedDateTime(createdAt!,'MM-dd-yyy h:mm a')),
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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


  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    // return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }
}
