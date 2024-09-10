import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../Widgets/Button/custom_button.dart';

class BecomeChefpage extends StatefulWidget {
   BecomeChefpage({Key? key}) : super(key: key);

  @override
  State<BecomeChefpage> createState() => _BecomeChefpageState();
}

class _BecomeChefpageState extends State<BecomeChefpage> {
  CarouselController buttonCarouselController = CarouselController();

  int? currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text(currentIndex==0?'Varied cuisines':currentIndex==1?"Almost there":"Chef of the town",),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: Container(
        padding: EdgeInsets.all(24),
        height: 1.0.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  height: 300,
                  viewportFraction: 1.0,
                  onPageChanged: (int page,css){
                    setState(() {
                      currentIndex=page;
                    });
                  }
              ),
              items: ["Just post your menu in our community and become a\n professional chef.",
                "Prepare meals, pick them up, or deliver them to folks who\n are craving of home cooking!",
                "Interested? Let's begin working together\n right now!"].asMap().entries.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: SvgPicture.asset(i.key==0?"assets/images/chef1.svg":i.key==1?"assets/images/shef3.svg":"assets/images/chef2.svg",height: 250,)),
                        SizedBox(height: 4,),
                        Text(i.value,
                          style: regularText(12,color: Color(0xFF5C6360)),textAlign: TextAlign.center,),

                      ],
                    );
                  },
                );
              }).toList(),
            ),


            SizedBox(height: 8,),

            DotsIndicator(
              dotsCount: 3,
              position: currentIndex!.toDouble(),
              decorator: DotsDecorator(
                activeColor: kPrimaryColorx,
                color:Color(0xffD8D8D8),
                size: const Size.square(7.0),
                activeSize: const Size(18.0, 7.0),
                spacing: EdgeInsets.only(right: 3),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
              ),
            ),
            SizedBox(height: 24,),
            CustomButton(height: 52,
                orderRadius: 40,
                color: kPrimaryColorx,
                boder: false,
                textColor: Colors.white,
                title: "Get Started",
                onTap: (){
                Navigator.pushNamed(context, BEACOME_SHEF_BUSINESS_PAGE);
            }),

          ],
        ),
      ),
    );
  }
}
