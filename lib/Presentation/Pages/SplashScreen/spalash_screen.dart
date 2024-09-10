import 'dart:async';

import 'package:eatonomy/GetX%20Controller/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Constants/Strings/app_strings.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../Getx Injection/getx_dependenci_injection.dart';
import '../../../Service/LocalDataBase/localdata.dart';



class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  _SpalashScreenState createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  double _textOpacity = 0.0;
  bool isLogin=false;
  bool isChef=false;

  var localBd;
  @override
  void initState(){
    // TODO: implement initState
    // injection();
    // init();
    updateDependency();

    localBd=Get.find<LocalDataGet>();
    checkLogin();

    Timer(Duration(seconds: 4), () {
      setState(() {
        isChef?
        Get.find<HomeController>().selectedIndex.value=2:Get.find<HomeController>().selectedIndex.value=0;

        isLogin?
        Navigator.pushReplacementNamed(context,MAIN_PAGE): Navigator.pushReplacementNamed(
            context, MAIN_PAGE);

        // Navigator.pushReplacementNamed(context,MAIN_PAGE): Navigator.pushReplacementNamed(
        //     context, LOGIN_PAGE_INTRO);
        // isLogin?
        // Navigator.pushReplacement(context, PageTransition(MainScreen())):Navigator.pushReplacement(context, PageTransition(MainScreen()));
      });
    });

    super.initState();
  }
  void checkLogin() async {
    var token=await localBd.getData();

    if (token.get('token') != null) {
      setState(() {
        isLogin=true;
      });
    } else {
      setState(() {
        isLogin=false;
      });
    }
    if (token.get('chefId') != null) {
      setState(() {
        isChef=true;
      });
    } else {
      setState(() {
        isChef=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          height: 1.0.sh,
            width: 1.0.sw,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/logo.svg',height: 200,)
                      ],
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 40,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //
              //       children: [
              //         Text("Powered By",style: TextStyle(fontSize: 12),),
              //         SvgPicture.asset('assets/images/maaclogo.svg')
              //       ],
              //     ),
              //   ),
              // )
            ],
          )

        )
    );
  }


}

