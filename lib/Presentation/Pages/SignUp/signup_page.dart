import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/Auth/OtpResponse.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  static final globalkey = GlobalKey<FormState>();

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController mobileTextController = new TextEditingController();

  TextEditingController emailTextController = new TextEditingController();

  bool? isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF9FCFF),
        title: Text("", style: mediumText(18.sp),),
        automaticallyImplyLeading: false,
        // leading: BackButton(color: Colors.black,),

      ),
      backgroundColor: Color(0xFFF9FCFF),
      body: GetBuilder<AuthController>(
          builder: (controller) {
            return Container(
              height: 1.0.sh,
              width: 1.0.sw,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: SignupPage.globalkey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text("Sign Up", style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 20,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),),
                      SizedBox(height: 6,),
                      Text("Complete this step for best adjustment.", style: TextStyle(
                        color: Color(0xFF5C6360),
                        fontSize: 14,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),textAlign: TextAlign.start,),
                      SizedBox(height: 32,),

                      Text(
                        'Your Email',
                        style: TextStyle(
                          color: Color(0xFF313634),
                          fontSize: 13,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5,),
                      BackgroundTextfield(controller: emailTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: true,
                        height: 65,
                        contentpadding: 16,
                        hintText: "Email",
                        errormsg: "Please enter your email address",
                        bgColor:textFieldBackground,
                        borderColor:textFieldBackground,),
                      SizedBox(height: 20,),
                      Text(
                        'Your Phone',
                        style: TextStyle(
                          color: Color(0xFF313634),
                          fontSize: 13,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5,),
                      BackgroundTextfield(controller: mobileTextController,
                        readOnly: false,
                        isNumber: true,
                        isemail: false,
                        height: 65,
                        hintText: "Mobile",
                        errormsg: "Please enter your phone number",
                        bgColor:textFieldBackground,
                        borderColor:textFieldBackground,),
                      SizedBox(height: 32,),

                      Obx(() {
                        return
                          controller.circuler.value ?
                          Center(child: LoadingWidget(),) :
                          CustomButton(
                              orderRadius: 40,
                              height: 52,
                            color: kPrimaryColorx,
                            textColor: Colors.white,
                            title: "Sign Up",
                            onTap: () {
                              // Navigator.pushReplacementNamed(context, OTP_PAGE);
                              if (SignupPage.globalkey.currentState!.validate()) {
                                signUpFun(controller,context);

                              }
                              // Navigator.pushNamed(context, OTP_PAGE);
                            });
                      }),


                      // Column(
                      //   children: [
                      //     SizedBox(height: 23.h,),
                      //     SizedBox(
                      //       width: 1.0.sw,
                      //       child:  Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Expanded(
                      //             child: Divider(height: 0.9,color: Color(0xFF6D7076),thickness: 0.8,),
                      //           ),
                      //           Expanded(
                      //             child: Text("Or better with",style:regularText(12.sp,color: Color(0xFF8D8D8D)) ,textAlign: TextAlign.center,),
                      //           ),
                      //           const Expanded(
                      //             child:  Divider(height: 0.9,color: Color(0xFF6D7076),thickness: 0.8,),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(height: 24,),
                      //     SizedBox(
                      //       width: 1.0.sw,
                      //       child:  Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             height: 42,
                      //             width: 42,
                      //             decoration: BoxDecoration(
                      //                 color: Color(0xFFD9D9D9),
                      //                 borderRadius: BorderRadius.circular(50)
                      //             ),
                      //             child: Image.asset("assets/icons/google.png"),
                      //           ),
                      //           SizedBox(width: 12,),
                      //           Container(
                      //             height: 42,
                      //             width: 42,
                      //             decoration: BoxDecoration(
                      //                 color: Color(0xFFD9D9D9),
                      //                 borderRadius: BorderRadius.circular(50)
                      //             ),
                      //             child: Image.asset("assets/icons/facebook.png"),
                      //           )
                      //
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(height: 24,),
                      Center(
                        child: InkWell(
                          onTap: () {
                            SignupPage.globalkey.currentState!.reset();
                            Navigator.pushNamed(context, LOGIN_PAGE);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'I already have an account ? ',
                                    style: mediumText(
                                        15.sp, color: Color(0xFF5C6360))),
                                TextSpan(text: 'Log In',
                                    style: mediumText(
                                        15.sp, color: kPrimaryColorx))
                              ],
                            ),

                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<OtpResponse?> signUpFun(AuthController authController,BuildContext context) async{

    var value = authController.checkUserExist(emailTextController.text,mobileTextController.text).then((valuex){
       if(valuex!.statusCode==200){
         var value = authController.otpGet(emailTextController.text,).then((value) async {
           if (value!.statusCode==200) {

             // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             //   behavior: SnackBarBehavior.floating,
             //   backgroundColor: Color(0xFF0EA01D),
             //   content: SizedBox(
             //     height:20,
             //     child: Column(
             //       crossAxisAlignment: CrossAxisAlignment.start,
             //       children: [
             //         Text(value.message!, style: boldText(14, color: Colors.white),),
             //       ],
             //     ),
             //   ),
             //   duration: Duration(milliseconds: 1500),
             // ));
             Navigator.pushNamed(context, OTP_PAGE,arguments: {
               'isLogin':false,
               'email':emailTextController.text,
               'mobile':mobileTextController.text
             });
           } else {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               behavior: SnackBarBehavior.floating,
               backgroundColor: Colors.red,
               content: SizedBox(
                 height:20,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(value.message!, style: mediumText(14.sp, color: Colors.white),),
                   ],
                 ),
               ),
               duration: Duration(milliseconds: 3000),
             ));
           }
         });
       }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           behavior: SnackBarBehavior.floating,
           backgroundColor: Colors.red,
           content: SizedBox(
             height:20,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(valuex.message!, style: mediumText(14.sp, color: Colors.white),),
               ],
             ),
           ),
           duration: Duration(milliseconds: 3000),
         ));
       }
    });


  return value;
  }
}


