import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../GetX Controller/Slider/SliderController.dart';
import '../../Widgets/Button/custom_button.dart';

class LoginPageIntro extends StatefulWidget {
  const LoginPageIntro({Key? key}) : super(key: key);

  @override
  State<LoginPageIntro> createState() => _LoginPageIntroState();
}

class _LoginPageIntroState extends State<LoginPageIntro> {
  CarouselController buttonCarouselController = CarouselController();
  int? currentIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.find<SliderController>().increment();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0XFFFFFFFF),
          body: Container(
            height: 1.0.sh,
            child: Column(
              children: [
                Expanded(
                    flex: 6,
                    child: CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          aspectRatio: 16/20,
                          viewportFraction: 1.0,
                          onPageChanged: (int page,css){
                            setState(() {
                              currentIndex=page;
                            });
                          }
                      ),
                      items: ["Home-made food","Future is here now","Be knowledgeable"].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex:12,
                                    child:Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset("assets/images/login_image.png",height: 330,))
                                ),
                                SizedBox(height: 36,),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                    i,textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 20,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w600,
                                         ),
                                        ),
                                ),
                                SizedBox(height: 8,),
                                Expanded(
                                    flex: 1,
                                    child:
                                    Text("For you and  your friends and families.",
                                      style:
                                      TextStyle(
                                        color: Color(0xFF5C6360),
                                        fontSize: 14,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    )
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      // decoration: const BoxDecoration(
                      //   color: Color(0xFF0F66DB),
                      //   borderRadius: BorderRadius.only(topLeft:Radius.circular(16),topRight: Radius.circular(16) )
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DotsIndicator(
                            dotsCount:3,
                            position: currentIndex!.toDouble(),
                            decorator: DotsDecorator(
                              activeColor: kPrimaryColorx,
                              color:Color(0xFFDFEBE5),
                              size: const Size.square(7.0),
                              activeSize: const Size(18.0, 7.0),
                              spacing: EdgeInsets.only(right: 3),
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Column(
                            children: [
                              CustomButton(height: 52,orderRadius: 40,color: kPrimaryColorx,textColor: Colors.white,title: "Login with Email/Phone",onTap: (){
                                Navigator.pushNamed(context, LOGIN_PAGE);
                              }),
                              SizedBox(height: 12,),
                              CustomButton(height: 52,orderRadius: 40,color: kPrimaryColorx,boder: true,textColor: Colors.black,title: "Signup",onTap: (){
                                Navigator.pushNamed(context, SIGNUP_PAGE);
                              }),


                            ],
                          ),

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
                          SizedBox(height: 100,),


                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Text("By Creating an account, You accept Somriddhi’s Terms of Servics and Privacy Policy",style: mediumText(14.sp,color: Colors.white),textAlign: TextAlign.center,),
                          // ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
