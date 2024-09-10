import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../../Getx Injection/getx_dependenci_injection.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  TextEditingController newPasswordTextController = new TextEditingController();
  TextEditingController confirmPasswordTextController = new TextEditingController();
  TextEditingController oldPasswordTextController = new TextEditingController();
  bool isChecked = false;
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
        title: Text("Password Change", style: boldText(20.sp),),
      ),
      body: GetBuilder<AuthController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _globalkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20.h,),
                        PasswordTextfield(hintText: "Current Password",
                          controller: oldPasswordTextController,
                          lable: "Password",
                          readOnly: false,
                          isNumber: false,),
                        SizedBox(height: 12.h,),
                        PasswordTextfield(hintText: "New Password",
                          controller: newPasswordTextController,
                          lable: "Password",
                          readOnly: false,
                          isNumber: false,),
                        SizedBox(height: 12.h,),
                        PasswordTextfield(hintText: "Confirm New Password",
                          controller: confirmPasswordTextController,
                          lable: "Password",
                          readOnly: false,
                          isNumber: false,),
                        SizedBox(height: 20.h,),
                      ],
                    ),

                    controller.circuler.value ?
                    LoadingWidget() :
                    CustomButton(height: 48.h,
                        color: kPrimaryColorx,
                        textColor: Colors.white,
                        title: "Save Change",
                        onTap: () async{
                          if (_globalkey.currentState!.validate()) {
                           await controller.passwordChange(
                                oldPasswordTextController.text,
                                newPasswordTextController.text,
                                confirmPasswordTextController.text).then((value) {
                             if (value!.success!) {
                               // Get.snackbar("", "",
                               //     backgroundColor: Color(0XFF0EA01D),
                               //     borderRadius: 4,
                               //     titleText: Text(value.message!,style: mediumText(14,color: Colors.white),),
                               //     messageText: Text("..",style: mediumText(14,color: Colors.white),),
                               //     icon: Image.asset("assets/icons/done2.png"),
                               //     colorText: Colors.white,
                               //     padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                               //     duration: Duration(seconds: 2)
                               // );
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 behavior: SnackBarBehavior.floating,
                                 backgroundColor: Color(0XFF0EA01D),
                                 content: Text(value.message!, style: boldText(12, color: Colors.white),),
                                 duration: Duration(milliseconds: 1500),
                               ));
                               deleteData(context);
                             } else {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 behavior: SnackBarBehavior.floating,
                                 backgroundColor: Colors.red,
                                 content: Text(value.error!, style: boldText(12, color: Colors.white),),
                                 duration: Duration(milliseconds: 1500),
                               ));
                             }
                               }
                            );
                          }

                        }),
                  ],
                ),
              ),

            );
          });
        },
      ),
    );
  }

  void deleteData(BuildContext context)async{
    var users = await Hive.openBox('users');
    users.clear().then((value) {
      injection();
      init();
    });
    ///update bearer token in api client
    ///update dependencies

    Navigator.pushNamedAndRemoveUntil(context, LOGIN_PAGE_INTRO,(route) => false,);

  }
}


