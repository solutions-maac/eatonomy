import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:flutter/material.dart';


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../Data/Model/Dashboard/Dashboard.dart';
import '../../../GetX Controller/Chef/ChefController.dart';

class LinearChartChef extends StatefulWidget {
  final List<Dashboard>? sales;
  final List<Dashboard>? uniqueUser;
  final ChefController? controller;
  LinearChartChef({super.key, this.sales, this.uniqueUser, this.controller});

  @override
  State<LinearChartChef> createState() => _LinearChartChefState();
}

class _LinearChartChefState extends State<LinearChartChef> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(widget.controller!.orderPerfomanceFilter.value=="Month"? text:value.toString(), style: style),
    );
  }

  final betweenSpace = 0.10;

  BarChartGroupData generateGroupData(
    int? x,
    double? pilates,
    double? quickWorkout,
    double? cycling
  ) {
    return BarChartGroupData(
      x: x!,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates!,
          color: kPrimaryColorx,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout!,
          color: Color(0xFFFCB116),
          width: 5,
        ),
      ],
    );
  }

  List<BarChartGroupData>?data=[];

  @override
  void initState() {
    // TODO: implement initState
    widget.sales!.forEach((element) {

    });

    super.initState();
  }
  // generateGroupData(0, 2, 3, 2),
  @override
  Widget build(BuildContext context) {
    data!.clear();

    for(var i=0;i<widget.sales!.length;i++){

      // Logger().w(
      //     (widget.uniqueUser!.length>i ?
      //         (widget.sales![i].numberOfOrder!.toDouble()-widget.uniqueUser![i].numberOfOrder!.toDouble()):0.0)
      //         +
      //         (widget.uniqueUser!.length>i ?widget.uniqueUser![i].numberOfOrder!.toDouble():0.0)
      // );
      data!.add(
          BarChartGroupData(
            x:  int.parse(widget.sales![i].date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2])-(widget.controller!.orderTotalIncomeFilter.value=="Month"?1:0),
            groupVertically: true,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: widget.uniqueUser!.length>i ?
                widget.sales![i].numberOfOrder!.toDouble()-widget.uniqueUser![i].numberOfOrder!.toDouble():widget.sales![i].numberOfOrder!.toDouble(),
                color: kPrimaryColorx,
                width: 5,
              ),
              BarChartRodData(
                fromY:widget.uniqueUser!.length>i ?
                widget.sales![i].numberOfOrder!.toDouble()-widget.uniqueUser![i].numberOfOrder!.toDouble():0.0,
                toY: (widget.uniqueUser!.length>i ?
                (widget.sales![i].numberOfOrder!.toDouble()-widget.uniqueUser![i].numberOfOrder!.toDouble()):0.0)
                    +
                    (widget.uniqueUser!.length>i ?widget.uniqueUser![i].numberOfOrder!.toDouble():0.0),
                color: Color(0xFFFCB116),
                width: 5,
              ),
            ],
          )
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    // sideTitles: SideTitles(
                    //   showTitles: true,
                    //   reservedSize: 52,
                    // ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 20,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                  bottom: BorderSide( //                    <--- top side
                    color: Color(0xFFEDEFF2),
                    width: 3.0,
                   ),
                 ),
                ),
                gridData:  FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Color(0xFFEDEFF2),
                    strokeWidth: 2,
                  ),
                  drawVerticalLine: false,
                ),
                barGroups:data,
                // extraLinesData: ExtraLinesData(
                //   horizontalLines: [
                //     HorizontalLine(
                //       y: 3.3,
                //       color: kPrimaryColorx,
                //       strokeWidth: 1,
                //       dashArray: [1, 1],
                //     ),
                //     HorizontalLine(
                //       y: 8,
                //       color: kPrimaryColorx,
                //       strokeWidth: 1,
                //       dashArray: [20, 4],
                //     ),
                //     HorizontalLine(
                //       y: 11,
                //       color: kPrimaryColorx,
                //       strokeWidth: 1,
                //       dashArray: [20, 4],
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: ShapeDecoration(
                              color: Color(0xFF00934C),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8,),
                  Text(
                    'Recurrent',
                    style: TextStyle(
                      color: Color(0xFF4A4F67),
                      fontSize: 10,
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(width: 8,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment
                      .center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        // color: Colors.green
                      ),
                      child: widget.controller!.orderPerfomanceResponse.value!.orderIncrease!.toInt()<0?
                      SvgPicture.asset("assets/icons/line_dowon.svg")
                          :
                      SvgPicture.asset("assets/icons/line_up.svg") ,
                    ),
                    const SizedBox(width: 2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.controller!.orderPerfomanceResponse.value!.orderIncrease!}% ',
                            style: TextStyle(
                              color:widget.controller!.orderPerfomanceResponse.value!.orderIncrease!.toInt()<0?Colors.redAccent: Color(0xFF027947),
                              fontSize: 8,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16,),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFCB116),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8,),
                  Text(
                    'New User',
                    style: TextStyle(
                      color: Color(0xFF4A4F67),
                      fontSize: 10,
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(width: 8,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment
                      .center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        // color: Colors.green
                      ),
                      child: widget.controller!.orderPerfomanceResponse.value!.incomeIncrease!.toInt()<0?
                      SvgPicture.asset("assets/icons/line_dowon.svg")
                          :
                      SvgPicture.asset("assets/icons/line_up.svg") ,
                    ),
                    const SizedBox(width: 2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.controller!.orderPerfomanceResponse.value!.incomeIncrease!}% ',
                            style: TextStyle(
                              color:widget.controller!.orderPerfomanceResponse.value!.incomeIncrease!.toInt()<0?Colors.redAccent: Color(0xFF027947),
                              fontSize: 8,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
