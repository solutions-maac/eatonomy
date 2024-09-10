import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';


class ForgetPasswordMailPage extends StatelessWidget {
  ForgetPasswordMailPage({Key? key}) : super(key: key);
  TextEditingController passwordTextController = new TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        title: Text("Forget Password", style: boldText(20.sp),),
      ),
      body: GetBuilder<AuthController>(
        assignId: true,
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _globalkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h,),
                      Text("We’ll send you an emial with a link to reset it",
                        style: mediumText(12.sp, color: Color(0XFF4F4F4F)),),
                      SizedBox(height: 12.h,),
                      BackgroundTextfield(controller: passwordTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: true,
                        hintText: "Email/Phone",
                        bgColor: Color(0XFFF5F5F5),
                        borderColor: Color(0XFFF5F5F5),),
                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),

                Obx(() {
                  return
                    controller.circuler.value ?
                    Center(child: CircularProgressIndicator(),) :
                    CustomButton(height: 48.h,
                        orderRadius: 4,
                        color: kPrimaryColorx,
                        textColor: Colors.white,
                        title: "Request Change Password",
                        onTap: () {
                          if (_globalkey.currentState!.validate()) {
                            resetPassword(controller, context);
                          }
                          // Navigator.pushNamed(context, MAIN_PAGE);
                        });
                }),

              ],
            ),

          );
        },
      ),
    );
  }



  Future resetPassword(AuthController controller, BuildContext context) async {
    var value = controller.resetPassword(
      email: passwordTextController.text,
    ).then((value) async {
      if (value!.success!) {
        Navigator.pushReplacementNamed(context, FORGET_PASS_MAIL_SUCESS_PAGE);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          content: Text(value.error!, style: boldText(12, color: Colors.white),),
          duration: Duration(milliseconds: 1500),
        ));
      }
    });
    return value;
  }

}




