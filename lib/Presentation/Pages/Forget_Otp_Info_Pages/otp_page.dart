
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/Auth/LoginResponse.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/AuthController/AuthController.dart';
import '../../../GetX Controller/Home/HomeController.dart';
import '../../../Getx Injection/getx_dependenci_injection.dart';
import '../../../Network/api_client.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';



class OtpPage extends StatefulWidget {
  final bool? isLogin;
  final String? email,mobile;

  OtpPage({Key? key, this.isLogin, this.email, this.mobile}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var localBd=getIt<LocalDataGet>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                // appBar: AppBar(
                //   elevation: 0,
                //   backgroundColor: Colors.white,
                //   title: Text("", style: mediumText(18.sp),),
                //   leading: BackButton(color: Colors.black,),
                // ),
                backgroundColor: const Color(0XFFFFFFFF),
                body: Container(
                  height: 1.0.sh,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h,),

                      Text("OTP", style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 20,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),),
                      SizedBox(height: 6,),
                      Text("Take a look at the email we sent you.",
                        style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 14,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,),

                      Text(widget.email!,
                        style: semiBoldText(14, color: kPrimaryColorx),
                        textAlign: TextAlign.start,),
                      SizedBox(height: 32,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enter your OTP',
                                    style: TextStyle(
                                      color: Color(0xFF313634),
                                      fontSize: 13,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Form(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 0),
                                        child: PinCodeTextField(
                                          backgroundColor: Colors.transparent,
                                          appContext: context,
                                          pastedTextStyle: TextStyle(
                                            color: Colors.green.shade600,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          length: 5,
                                          obscureText: false,
                                          obscuringCharacter: '*',
                                          // obscuringWidget: FlutterLogo(
                                          //   size: 24,
                                          // ),
                                          blinkWhenObscuring: false,
                                          animationType: AnimationType.fade,
                                          validator: (v) {

                                          },
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius: BorderRadius.circular(10),
                                            fieldHeight: 50,
                                            fieldWidth: 50,
                                            selectedColor: kPrimaryColorx,
                                            inactiveColor: textFieldBorder,
                                            inactiveFillColor: textFieldBorder,
                                            activeFillColor: textFieldBorder,
                                            selectedFillColor: textFieldBorder,
                                          ),
                                          cursorColor: Colors.black,
                                          animationDuration: Duration(milliseconds: 300),
                                          enableActiveFill: true,
                                          controller: null,
                                          textStyle: TextStyle(
                                            color: Color(0xFF02190E)
                                          ),
                                          keyboardType: TextInputType.number,

                                          onCompleted: (v) {
                                            print(v + "complete");
                                            controller.otpText.value=v;
                                          },
                                          // onTap: () {
                                          //   print("Pressed");
                                          // },
                                          onChanged: (value) {
                                            print("print otp " + value);
                                            controller.otpText.value=value;
                                          },
                                          beforeTextPaste: (text) {
                                            print("Allowing to paste $text");
                                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                            //but you can show anything you want here, like your pop up saying wrong paste format or etc

                                            return true;
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              SizedBox(height: 0,),
                              controller.circuler.value?SizedBox():
                              InkWell(
                                  onTap: () {
                                    controller.otpGet(widget.email!,);
                                  },
                                  child: Text("Resend Code ", style: TextStyle(
                                    color: kPrimaryColorx,
                                    fontSize: 14,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w600,
                                  ),).tr()),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 32,),
                      controller.circuler.value||controller.tokenReseting.value?LoadingWidget():
                      CustomButton(
                          height: 52,
                          orderRadius: 40,
                          color:controller.otpText.value.length==5? kPrimaryColorx:Color(0xFFBCC3C0),
                          textColor: Colors.white,
                          title: "Next",
                          onTap: () {
                            if (widget.isLogin!) {
                              if(controller.otpText.value.length==5)
                              signinFun(controller,context);
                            } else {
                              if(controller.otpText.value.length==5){
                                Navigator.pushNamed(context, INFO_PAGE,arguments: {
                                  'email':widget.email!,
                                  'mobile':widget.mobile!,
                                  'otp':controller.otpText.value
                                });
                              }
                            }
                          }),

                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<LoginResponse?> signinFun(AuthController controller, BuildContext context) async {
    var value = controller.signinFun(email: widget.email!,otp:controller.otpText.value,isChef: (controller.index.value==0?false:true)).then((value) async {
      if (value!.statusCode == 200) {

        await localBd.storeTokenUserdata(email: value.email,token: value.token,name: value.name,
            mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId).then((valuex) async {
          controller.tokenReseting.value=true;
          ///update dependence api service token update
          updateDependency();
          injection();
          init();

          Future.delayed(Duration(seconds: 10),(){
            controller.tokenReseting.value=false;
            Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE,(route) => false,);
            controller.tabController!.index==1?
            Get.find<HomeController>().selectedIndex.value=2:
            Get.find<HomeController>().selectedIndex.value=0;
            Future.delayed(Duration.zero,()=> Get.find<HomeController>().onInit());
          });

        });

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Color(0xFF0EA01D),
        //   content: SizedBox(
        //     height: 20,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(value.message!, style: boldText(14, color: Colors.white),),
        //       ],
        //     ),
        //   ),
        //   duration: Duration(milliseconds: 1500),
        // ));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: SizedBox(
            height: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value.message=="Incorrect password"?"Wrong OTP":value.message!,
                  style: mediumText(14.sp, color: Colors.white),),
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



