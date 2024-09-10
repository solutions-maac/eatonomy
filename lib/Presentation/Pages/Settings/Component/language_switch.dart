import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../main_screen.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageTabbar extends StatefulWidget {
  @override
  _LanguageTabbarState createState() => _LanguageTabbarState();
}

class _LanguageTabbarState extends State<LanguageTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale.toString() == "en_US"
        ? _tabController.index = 1
        : _tabController.index = 0;
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Container(
          //padding:const EdgeInsets.symmetric(horizontal: 5),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25 .h,
                width: 120.w,
                //padding:const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0XFFE1E8EF),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  onTap: (index) {
                    if (context.locale.toString() == "en_US") {
                      context.locale = Locale('bn', 'BD');
                    } else {
                      context.locale = Locale('en', 'US');
                    }
                    Navigator.pushReplacement(
                        context, PageTransition(MainScreen()));
                  },
                  controller: _tabController,
                  labelColor: Colors.white,
                  padding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Creates border
                    color: kPrimaryColorx,
                  ),
                  tabs:  [
                    Tab(
                      child: Text(
                        'বাং',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'En',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PageTransition extends PageRouteBuilder {
  final Widget page;
  PageTransition(this.page) : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}