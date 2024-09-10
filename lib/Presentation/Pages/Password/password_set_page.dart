import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';
import '../About/Component/action_button.dart';

class PasswordSetPage extends StatefulWidget {
  const PasswordSetPage({Key? key}) : super(key: key);

  @override
  State<PasswordSetPage> createState() => _PasswordSetPageState();
}

class _PasswordSetPageState extends State<PasswordSetPage> {
  TextEditingController passwordTextController=new TextEditingController();
  bool isChecked = false;
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
        title: Text("Set Password",style: boldText(20.sp),),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Column(
             children: [
               SizedBox(height: 12.h,),
               PasswordTextfield(hintText: "New Password",controller: passwordTextController,lable: "Password", readOnly: false, isNumber: false,),
               SizedBox(height: 12.h,),
               PasswordTextfield(hintText: "Confirm New Password",controller: passwordTextController,lable: "Password", readOnly: false, isNumber: false,),
               SizedBox(height: 20.h,),
             ],
           ),


            CustomButton(height: 58.h,color: kPrimaryColorx,textColor: Colors.white,title: "Save Change",onTap: (){

            }),
          ],
        ),

      ),
    );
  }
}

