
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_follow_list_view.dart';
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_list_map.dart';
import 'package:eatonomy/Presentation/Pages/Chef/page/chef_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../../GetX Controller/Map/MapController.dart';
import 'Component/houre_chip.dart';
import 'Component/rating_chip.dart';

class ChefPage extends StatefulWidget {
  const ChefPage({Key? key}) : super(key: key);

  @override
  State<ChefPage> createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> with SingleTickerProviderStateMixin{

  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    Get.find<ChefController>().getChefs(true);
    Get.find<ChefController>().onInit();
    Get.find<ChefController>().context=context;
    Get.find<ChefController>().radiusFilter.value=25.0;
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Color(0xFFF9FCFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FCFF),
        automaticallyImplyLeading: false,
        title: Text('Chef',),
        actions: [
          // _tabController!.index==0?
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                  onTap: (){
                    showFilter(context,Get.find<ChefController>());
                  },
                  child: SvgPicture.asset("assets/icons/filter.svg",height: 18,)
              )
          )
              // :SizedBox()
        ],
      ),
      body:  Container(
        color:Color(0xFFF9FCFF),
        height: 1.0.sh,
        width: 1.0.sw,
        child:   Container(
          padding:const EdgeInsets.symmetric(horizontal: 5,vertical: 18),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFF9FCFF),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    //padding:const EdgeInsets.symmetric(horizontal: 30),
                    margin:const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color:const Color(0xFFE0EBE0),
                      // color:Colors.redAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:TabBar(

                      indicatorSize: TabBarIndicatorSize.label,
                      // isScrollable: true,
                      controller: _tabController,
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      // indicatorWeight: 0.50.sw,
                      labelColor: Colors.white,
                      unselectedLabelColor: kPrimaryColorx,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(_tabController!.index==0? 44:0),
                            bottomLeft:Radius.circular(_tabController!.index==0? 44:0),
                          topRight: Radius.circular(_tabController!.index==0? 0:44),
                            bottomRight:Radius.circular(_tabController!.index==0? 0:44),
                        ), // Creates border
                        color: kPrimaryColorx,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.normal,
                      ),
                      onTap: (ner){
                        setState(() {

                        });
                      },
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width:double.infinity,
                              child: Center(child: Text('List View',))),
                        ),
                        Tab(
                          child: SizedBox(
                            width:double.infinity,
                            child: Center(child: Text('Map View',))),
                        ),

                      ],
                    )
                ),
              ),
              SizedBox(height: 12.h,),
              Expanded(
                flex: 28,
                child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ChefListView(),
                      ChefMapView(),
                      // PjpTabViewToday(token: token),
                      // PjpTabViewThisMonth(token: token),
                      // PjpTabViewTodate(token: token),
                    ]
                ),

              )
            ],
          ),
        ),
      ),
    );
  }

  Future showFilter(BuildContext context,ChefController controller){
    return showMaterialModalBottomSheet(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20),),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context,setState)=>Container(
            padding: EdgeInsets.symmetric(horizontal: 21,vertical:12 ),
            width: 1.0.sw,
            height:480.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child:InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close,size: 24,color: Color(0XFFC4C4C4),))
                      ),
                      Expanded(
                          flex: 12,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Text(
                                'Filters',
                                style: TextStyle(
                                  color: Color(0xFF02190E),
                                  fontSize: 18,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                  Text(
                    'Rating',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,

                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                      height: 32,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.ratingList.length,
                          itemBuilder:(context,index){
                            return  InkWell(
                                onTap: (){
                                  controller.ratingFilter.value=double.parse(controller.ratingList[index]);
                                  setState((){

                                  });
                                },
                                child: RatingChip(rate: controller.ratingList[index],isSelect:controller.ratingFilter.value==double.parse(controller.ratingList[index]),));
                          }
                      )
                  ),
                  // SizedBox(height: 24,),
                  // Text(
                  //   'Hours',
                  //   style: TextStyle(
                  //     color: Color(0xFF02190E),
                  //     fontSize: 16,
                  //     fontFamily: 'Sora',
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(height: 8,),
                  // SizedBox(
                  //   height: 32,
                  //   child: ListView(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       HoureChip(houre: "10 AM-12 AM",),
                  //       HoureChip(houre: "10 AM-12 AM",),
                  //       HoureChip(houre: "10 AM-12 AM",),
                  //       HoureChip(houre: "10 AM-12 AM",),
                  //
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 24,),
                  Text(
                    'Cuisine',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Wrap(
                    spacing: 12, // space between items
                    children: controller.cuisineList.map((e) =>
                        InkWell(
                          onTap: (){


                            if(controller.cusinineFilter.value.isEmpty){
                              if(controller.cusinineFilter.value.contains(e)){
                                controller.cusinineFilter.value.remove(e);
                              }else{
                                controller.cusinineFilter.value.add(e);
                              }
                            }else{
                              controller.cusinineFilter.value.clear();
                              controller.cusinineFilter.value.add(e);
                            }



                            setState((){

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: ShapeDecoration(
                              color: controller.cusinineFilter.value.contains(e)?Color(0xFFEBFFF5):Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color:controller.cusinineFilter.value.contains(e)?kPrimaryColorx: Color(0xFFD1D1D1)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: semiBoldText(
                                    12,
                                    color:  controller.cusinineFilter.value.contains(e)?kPrimaryColor:Color(0xFF5C6360))
                            ),
                          ),
                        ))
                        .toList(),
                  ),
                  SizedBox(height: 24,),
                  Text(
                    'Radius',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0,),
                  SliderTheme(
                    data: const SliderThemeData(
                      trackShape: CustomSliderTrackShape(),
                      thumbShape: CustomSliderThumbShape(),
                      overlayShape: CustomSliderOverlayShape(),
                    ),
                    child: Slider(
                      value: controller.radiusFilter.value,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      inactiveColor: Color(0xFFEBFFF5),
                      onChanged: (value) {
                        setState((){});
                        controller.radiusFilter.value=value;
                      },
                    ),
                  ),
                  Text(controller.radiusFilter.value.toStringAsFixed(2).toString()+" Km",style: boldText(16,color: Color(0xFF02190E)),),
                  SizedBox(height: 16,),
                  SizedBox(
                    width: 1.0.sw,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.find<ChefController>().onInit();
                              Get.find<ChefController>().getChefs(true);
                              Get.find<ChefController>().radiusFilter.value=25.0;
                              setState((){});
                              Navigator.pop(context);
                            },
                            child: Container(

                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              decoration: ShapeDecoration(
                                color: Color(0xFFE0EBE0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Clear',
                                    style: TextStyle(
                                      color: Color(0xFF00934C),
                                      fontSize: 14,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.find<ChefController>().getChefs(true);
                              Get.find<MapController>().onInit();
                              Get.find<MapController>().context=context;
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              decoration: ShapeDecoration(
                                color: Color(0xFF00934C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Apply',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends RoundSliderThumbShape {
  const CustomSliderThumbShape({super.enabledThumbRadius = 10.0});

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    super.paint(context,
        center.translate(-(value - 0.5) / 0.5 * enabledThumbRadius, 0.0),
        activationAnimation: activationAnimation,
        enableAnimation: enableAnimation,
        isDiscrete: isDiscrete,
        labelPainter: labelPainter,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        textDirection: textDirection,
        value: value,
        textScaleFactor: textScaleFactor,
        sizeWithOverflow: sizeWithOverflow);
  }
}

class CustomSliderOverlayShape extends RoundSliderOverlayShape {
  final double thumbRadius;
  const CustomSliderOverlayShape({this.thumbRadius = 10.0});

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    super.paint(
        context, center.translate(-(value - 0.5) / 0.5 * thumbRadius, 0.0),
        activationAnimation: activationAnimation,
        enableAnimation: enableAnimation,
        isDiscrete: isDiscrete,
        labelPainter: labelPainter,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        textDirection: textDirection,
        value: value,
        textScaleFactor: textScaleFactor,
        sizeWithOverflow: sizeWithOverflow);
  }
}
