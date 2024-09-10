
import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/Auth/LoginResponse.dart';
import '../../../Data/Model/Auth/OtpResponse.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
 static final formKey = GlobalKey<FormState>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordTextController = new TextEditingController();

  TextEditingController emailTextController = new TextEditingController();

  bool? isloading = false;

  var localBd=getIt<LocalDataGet>();

  @override
  Widget build(BuildContext context) {
    // Get.find<AuthController>().signinFun(email: "sifat@gmail", pasword: "12345678");
    return Container(
      color: Colors.white,
      child: SafeArea(

        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("", style: mediumText(18.sp),),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Color(0xFFF9FCFF),
          body: GetBuilder<AuthController>(
            assignId: true,
            builder: (controller) {
              return Container(
                // height: 1.0.sh,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: LoginPage.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                          height: 50,
                          padding:const EdgeInsets.symmetric(horizontal:0),
                          decoration: BoxDecoration(
                            color:const Color(0xFFE0F7EC),
                            // color:Colors.redAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child:TabBar(
                            labelColor: Colors.white,
                            controller: controller.tabController,
                            unselectedLabelColor:kPrimaryColorx,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.all(4),
                            labelPadding: EdgeInsets.zero,
                            // indicatorWeight: 0.50.sw,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50), // Creates border
                              color: kPrimaryColorx,
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF191D31),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: Color(0xFFA7A9B7),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),

                            tabs: [
                              Tab(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/icons/User.svg",color:controller.tabController!.index==0? Colors.white:kPrimaryColor,),
                                            SizedBox(width: 6,),
                                            Text('User',)
                                          ],
                                        )
                                    )
                                ),
                              ),
                              Tab(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/icons/Chef.svg",color:controller.tabController!.index==0? kPrimaryColor:Colors.white,),
                                            SizedBox(width: 6,),
                                            Text('Chef',)
                                          ],
                                        )
                                    )
                                ),
                              ),

                            ],
                          )
                      ),

                      SizedBox(height: 80,),
                      Text("Log In", style: boldText(24,color: Color(0xFF02190E)),),
                      SizedBox(height: 6,),
                      Text(controller.tabController!.index==0?"Tell us your cravings for today!":"Be the chef of the community!", style:TextStyle(
                        color: Color(0xFF5C6360),
                        fontSize: 14,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),textAlign: TextAlign.center,),
                      SizedBox(height: 20.h,),
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
                      BackgroundTextfield(
                        controller: emailTextController,
                        readOnly: false,
                        isNumber: false,
                        isemail: true,
                        height: 55,
                        contentpadding:16,
                        hintText: "example@gmail.com",
                        bgColor: textFieldBackground,
                        errormsg: "Please enter your email address",
                        borderColor: textFieldBackground,),

                      SizedBox(height: 32.h,),



                      Obx(() {
                        return
                          controller.circuler.value ?
                          Center(child: LoadingWidget(),) :
                          CustomButton(
                              height: 52,
                            orderRadius: 40,
                            color: kPrimaryColorx,
                            textColor: Colors.white,
                            title: "Login",
                            onTap: () {
                              // Navigator.pushReplacementNamed(context, MAIN_PAGE);

                              if (LoginPage.formKey.currentState!.validate()) {
                                signinFun(controller, context);
                              }
                              // Navigator.pushNamed(context, MAIN_PAGE);
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
                      //             child: Text("Or better with",style:regularText(12.sp,color: Color(0xFF6D7076)) ,textAlign: TextAlign.center,),
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
                            LoginPage.formKey.currentState!.reset();
                            Navigator.pushNamed(context, SIGNUP_PAGE);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'I don’t have a account ?',
                                    style: mediumText(
                                        15.sp, color: Color(0xFF5C6360))),
                                TextSpan(text: 'Sign Up',
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
              );
            },
          ),
        ),
      ),
    );
  }

  Future<OtpResponse?> signinFun(AuthController controller, BuildContext context) async {
    var value = controller.otpGet(emailTextController.text,).then((value) async {

      if (value!.statusCode==200) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF0EA01D),
          content: SizedBox(
            height:20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.message!, style: boldText(14, color: Colors.white),),
              ],
            ),
          ),
          duration: Duration(milliseconds: 1500),
        ));
        Navigator.pushNamed(context, OTP_PAGE,arguments: {
          'isLogin':true,
          'email':emailTextController.text,
          'mobile':''
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
    return value;
  }
}


