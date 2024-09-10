
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';


class SignupSucessPage extends StatelessWidget {
  SignupSucessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0XFFFFFFFF),
          body: Container(
            width: 1.0.sw,
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/email-sent.png",height: 120.h,width: 200.w,),
                SizedBox(height: 32.h,),
                Text("Check your email",style: boldText(20.sp),),
                SizedBox(height: 13.h,),
                Text("We’ve sent you an email. Complete the process of creating your account by clicking the link in that email",style: regularText(14.sp),textAlign: TextAlign.center,),
                SizedBox(height: 24.h,),
                CustomButton(height: 48.h,
                color: kPrimaryColorx,
                textColor: Colors.white,
                title: "Login",
                onTap: () {
                  Navigator.pushReplacementNamed(context, LOGIN_PAGE);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}


