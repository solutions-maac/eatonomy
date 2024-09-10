
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/Data/Model/Order/OrderMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class ChefOrderUpcomingCard extends StatelessWidget {
  final OrderMenu? menu;
  const ChefOrderUpcomingCard({Key? key, this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all( width: 0.50,color: Color(0xFFE5E5EB),)
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x1400934C),
        //     blurRadius: 18,
        //     offset: Offset(0, 8),
        //     spreadRadius: 0,
        //   )
        // ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.0.sw,
            child: Stack(
              children: [
                Center(
                  child:  CachedNetworkImage(
                    imageUrl: menu!.menu!.images![0]??
                        "https://via.placeholder.com/48x48",
                    placeholder: (context, url) =>
                        SizedBox(
                            height: 34,
                            width: 34,
                            child: LoadingWidget()
                        ),
                    imageBuilder: (context, image) =>
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.cover,

                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),),
                                ),

                              ),
                            ),
                            Container(
                              width: 1.0.sw,
                              height: 140,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.black.withOpacity(0.50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.pushNamed(context, WISH_DETAILS_PAGE,arguments: {
                                            'menu':menu!.menu,
                                            'craeteat':menu!.menu!.createdAt
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                                          height: 26,
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 0.50, color: Color(0xFF00934C)),
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "View Menu",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF00934C),
                                                fontSize: 12,
                                                fontFamily: 'Satoshi',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      menu!.count!.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                      )
                                  ),
                                  SizedBox(height: 2,),
                                  Text(
                                      "orders",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                  ),
                ),
                // Positioned(
                //   left: 0.6.sw,
                //   child: ,
                // ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(right:24.0,left: 24,top: 16,bottom: 16),
            child: Text(
              menu!.menu!.title??'',
              style: TextStyle(
                color: kPrimaryColorx,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Wrap(
              spacing: 8, // space between items
              children: menu!.menu!.menus!
                  .map((e) =>
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    child: InkWell(
                        onTap: () {},
                        child: Text(e,style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ))),
                  ))
                  .toList(),
            ),
          ),
          SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
                height: 48,
                orderRadius: 24,
                color: kPrimaryColorx,
                boder: false,
                textColor: Colors.white,
                title: "View Details",
                onTap: (){
                  Navigator.pushNamed(context, CHEF_ORDER_UP_COME_PAGE,arguments: {
                    'menuId':menu!
                  });

            }),
          ),
          SizedBox(height: 16,),

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
