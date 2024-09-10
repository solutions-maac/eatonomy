
import 'dart:ffi';

import 'package:eatonomy/GetX%20Controller/Chef/ChefController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../Data/Model/Dashboard/Dashboard.dart';

class BarChartChef extends StatefulWidget {
  final List<Dashboard> sales;
  final ChefController? controller;
  BarChartChef({super.key, required this.sales, this.controller});



  @override
  State<StatefulWidget> createState() => BarChartChefState();
}

class BarChartChefState extends State<BarChartChef> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Jan';
        break;
      case 2:
        text = 'Feb';
        break;
      case 3:
        text = 'Mar';
        break;
      case 4:
        text = 'Apr';
        break;
      case 5:
        text = 'May';
        break;
      case 6:
        text = 'Jun';
        break;
      case 7:
        text = 'Jul';
        break;
      case 8:
        text = 'Agu';
        break;
      case 9:
        text = 'Sep';
        break;
      case 10:
        text = 'Oct';
        break;
      case 11:
        text = 'Nov';
        break;
      case 12:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(widget.controller!.orderPerfomanceFilter.value=="Month"?text:value.toInt().toString(), style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> xxx=[];
    widget.sales.forEach((element) {
      xxx.add(BarChartGroupData(
        x: int.parse(element.date!.split("-")[widget.controller!.orderPerfomanceFilter.value=="Month"?1:2]),
        barsSpace: 12,
        barRods: [
          BarChartRodData(
            toY: element.numberOfOrder!.toDouble(),
            rodStackItems: [
              BarChartRodStackItem(0, 300, Colors.green),
            ],
            borderRadius:BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            width: 35,
            gradient:  LinearGradient(
              begin: Alignment(0.27,  0.45),
              end: Alignment(0.37, 1.44),
              colors: [Color(0xFF00934C), Color(0xFFFCB116)],
            ),
          ),

        ],
      ));
    });


    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {

            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                // baselineY: 600.0,
                barTouchData: BarTouchData(
                  enabled: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 5 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Color(0xFFEDEFF2),
                    strokeWidth: 2,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide( //                    <--- top side
                      color: Color(0xFFEDEFF2),
                      width: 3.0,
                    ),
                  ),
                  show: true,
                ),
                groupsSpace: 12,
                barGroups: xxx,
              ),
            );
          },
        ),
      ),
    );
  }

  // List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
  //   return widget.sales!.map((e) {
  //     return BarChartGroupData(
  //       x: 0,
  //       barsSpace: barsSpace,
  //       barRods: [
  //         BarChartRodData(
  //           toY: 300,
  //           rodStackItems: [
  //             BarChartRodStackItem(0, 300, Colors.green),
  //           ],
  //           borderRadius:BorderRadius.only(
  //             topLeft: Radius.circular(4),
  //             topRight: Radius.circular(4),
  //           ),
  //           width: barsWidth,
  //           gradient:  LinearGradient(
  //             begin: Alignment(0.27,  0.45),
  //             end: Alignment(0.37, 1.44),
  //             colors: [Color(0xFF00934C), Color(0xFFFCB116)],
  //           ),
  //         ),
  //
  //       ],
  //     );
  //   });
  // }
}