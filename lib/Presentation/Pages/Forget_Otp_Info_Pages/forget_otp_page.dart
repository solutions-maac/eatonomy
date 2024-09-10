import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/password_bg_textfield.dart';

class ForgetOtpPage extends StatefulWidget {
  const ForgetOtpPage({Key? key}) : super(key: key);

  @override
  State<ForgetOtpPage> createState() => _ForgetOtpPageState();
}

class _ForgetOtpPageState extends State<ForgetOtpPage> {
  TextEditingController textEditingController = TextEditingController();
  num? otp;
  bool validation=false;
  String? currentText;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("OTP",style: mediumText(18.sp),),
            leading: BackButton(color: Colors.black,),
          ),
          backgroundColor: const Color(0XFFFFFFFF),
          body: Container(
            height: 1.0.sh,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Column(

                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Form(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30),
                              child: PinCodeTextField(
                                backgroundColor: Colors.transparent,
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
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
                                  borderRadius: BorderRadius.circular(1),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  selectedColor: Colors.orange,
                                  inactiveColor: Colors.transparent,
                                  inactiveFillColor: Color(0XFFF5F5F5),
                                  activeFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,

                                onCompleted: (v) {
                                  print(v+"complete");
                                  print(otp);
                                  print(otp!.toInt()==int.parse(v));
                                  setState(() {
                                    currentText = v;
                                  });

                                },
                                // onTap: () {
                                //   print("Pressed");
                                // },
                                onChanged: (value) {
                                  print("print otp "+value);
                                  if(value.isEmpty){
                                    setState(() {
                                      currentText = null;
                                    });
                                  }else{
                                    setState(() {
                                      currentText = value;
                                    });
                                  }

                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc

                                  return true;
                                },
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.0.sw,
                      child: RichText(
                        textAlign: TextAlign.start
                        ,
                        text:  TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Enter code that we have sent to your email\n', style: mediumText(12.sp)),
                            TextSpan(text: 'jorxxxxx@email.com ',style: mediumText(12.sp,color: kPrimaryColorx)),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    validation?Center(child: CircularProgressIndicator(),): InkWell(
                        onTap: (){
                          setState(() {
                            validation=true;
                          });
                        },
                        child: Text("Resend Code ",style: boldText(15.sp,color: Colors.black),).tr())
                  ],
                ),
                SizedBox(height: 20.h,),
                CustomButton(height: 48.h,orderRadius: 4,color: kPrimaryColorx,textColor: Colors.white,title: "Next",onTap: (){
                  Navigator.pushNamed(context, PASSWORD_SET_PAGE);
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
