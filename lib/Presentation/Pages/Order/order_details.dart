import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import 'Component/user_history_card.dart';
import 'Page/cancel_page.dart';
import 'Page/history_page.dart';
import 'Page/upcoming_page.dart';



class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_arrow_left,)),
        title: Text('Order Details',),
      ),
      body:  DefaultTabController(
        length: 3,
        child: Container(
          color: Colors.white,
          height: 1.0.sh,
          width: 1.0.sw,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                height: 152,
                decoration: BoxDecoration(color: Color(0xFF00934C)),
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: Container(
                        width: 100,
                        height: 97,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://via.placeholder.com/100x97"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ),
                    SizedBox(width: 18,),
                    Expanded(
                      flex:4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bengalis set menu 01',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Wrap(
                            spacing: 8, // space between items
                            children: ["Popular","Nearby","Followed",].map((e) =>
                                Container(
                                  height: 26,
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.20000000298023224),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                  ),
                              child: InkWell(
                                  onTap: (){},
                                  child: Text(
                                    'Chicken Roast',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Today’s Order',
                  style: TextStyle(
                    color: Color(0xFF6D7076),
                    fontSize: 12,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              UserOrderHistoryCard(),
              UserOrderHistoryCard(),


              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '22 January 2023',
                  style: TextStyle(
                    color: Color(0xFF6D7076),
                    fontSize: 12,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              UserOrderHistoryCard(),
              UserOrderHistoryCard(),
            ],
          ),
        ),
      ),
    );
  }
}
