import 'package:eatonomy/GetX%20Controller/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import 'Page/cancel_page.dart';
import 'Page/history_page.dart';
import 'Page/upcoming_page.dart';


class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF9FCFF),
      appBar: AppBar(
        backgroundColor:  Color(0xFFF9FCFF),
        automaticallyImplyLeading: false,
        title: Text('Order',),
      ),
      body: GetBuilder<HomeController>(
        assignId: true,
        builder: (controller) {
          return
            controller.token.value==""?
            SizedBox(
              height: 1.0.sh,
              width: 1.0.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You Are Not Registered",style: boldText(16,color: textColor),),
                  SizedBox(height: 8,),
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, LOGIN_PAGE_INTRO);
                      },
                      child: Text("Please Signup",style: boldText(16,color:kPrimaryColor),)),

                ],
              ),
            )
                :
            DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Container(
              color: Color(0xFFF9FCFF),
              height: 1.0.sh,
              width: 1.0.sw,
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          //This is for background color
                          color: Colors.white.withOpacity(0.0),
                          //This is for bottom border that is needed
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFF5F5F5), width: 2.sp)),
                        ),
                        child: TabBar(
                          labelPadding: EdgeInsets.all(0),
                          labelColor: kPrimaryColorx,
                          unselectedLabelColor: Color(0xFF5C6360),
                          indicatorColor: kPrimaryColorx,
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF5C6360),
                          ),
                          tabs: [
                            Tab(
                              child: Text('History',

                              ),
                            ),
                            Tab(
                              child: Text('Upcoming',

                              ),
                            ),
                            Tab(
                              child: Text('Cancelled',

                              ),
                            ),
                          ],
                        ),
                      )
                  ),

                  Expanded(
                    flex: 20,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HistoryPage(),
                        UpcomingPage(),
                        CancelPage(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
