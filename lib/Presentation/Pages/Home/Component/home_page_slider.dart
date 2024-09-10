
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Bloc/Slider/slider_cubit.dart';
import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Slider/SliderController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SliderCubit>(context).getSlider();
    return GetBuilder<SliderController>(
      assignId: true,
      builder: (controller) {
        return Column(
          children: [
            BlocBuilder<SliderCubit, SliderState>(
              builder: (context, state) {
                if(state is !SlidersGet){
                  return Center(child: CircularProgressIndicator(),);
                }
                final data=(state as SlidersGet).sliderResponse;
                return Column(
                  children: [
                    Container(
                      height:170,
                      width: 1.0.sw,
                      child: CarouselSlider(
                        options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            viewportFraction: 1.0,
                            onPageChanged: (int page, css) {
                              controller.currentIndex.value = page;
                            }
                        ),
                        items: data!.data!.map((slider) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFEC7323),
                                        const Color(0xFFF9B417),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Container(
                                              //   padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                              //   decoration: BoxDecoration(
                                              //       color: Color(0xFFF08F4F).withOpacity(0.75),
                                              //       borderRadius: BorderRadius.circular(50)
                                              //   ),
                                              //   child: Text(
                                              //     slider.heading!,
                                              //     style: regularText(
                                              //         13, color: Color(0XFFFBE3D3)),),
                                              // ),
                                              // SizedBox(height: 8.h,),
                                              Text(
                                                slider.text!,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.25,
                                                ),),
                                              // SizedBox(height: 12.h,),
                                              // CustomButton(orderRadius: 4,
                                              //     height: 29,
                                              //     width: 83,
                                              //     color: Colors.white,
                                              //     textColor: kPrimaryColorx,
                                              //     title: "Details",
                                              //     onTap: () {
                                              //
                                              //     }),
                                            ],
                                          ),
                                        )
                                    ),
                                    Expanded(
                                      flex:7,
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(right: 12),
                                          child: CachedNetworkImage(
                                            imageUrl: BASE_URL_IMAGE+slider.image!,
                                            placeholder: (context, url) => LoadingWidget(),
                                            imageBuilder: (context, image) =>  Container(

                                              decoration:  BoxDecoration(
                                                  borderRadius:  BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                      image: image,
                                                      scale: 1.0,

                                                  )
                                              ),
                                            ),
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Obx(() {
                      return CarouselIndicator(
                        height: 8.h,
                        color: Color(0xffFBE3D3),
                        activeColor: Color(0xffEC7323),
                        count: data.data!.length,
                        index: controller.currentIndex.value,
                      );
                    }),
                  ],
                );
              },
            ),


          ],
        );
      },
    );
  }
}


