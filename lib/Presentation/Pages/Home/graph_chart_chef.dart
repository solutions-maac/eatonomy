import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../Data/Model/Dashboard/Dashboard.dart';
import '../../../GetX Controller/Chef/ChefController.dart';

class GraphChartChef extends StatefulWidget {
  final List<Dashboard>? sales;
  final ChefController? controller;
  const GraphChartChef({super.key, this.sales, this.controller});

  @override
  State<GraphChartChef> createState() => _GraphChartChefState();
}

class _GraphChartChefState extends State<GraphChartChef> {
  List<Color> gradientColors = [
    Color(0xFF00934C), Color(0xFFD4ECE4)
  ];



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: LineChart(
               mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
    color: Color(0xFF475466),
    fontSize: 12,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w400,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Agu', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return  SideTitleWidget(
      axisSide: meta.axisSide,
      child:widget.controller!.orderTotalIncomeFilter.value=="Month"? text:Text(value.toInt().toString(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
    color: Color(0xFF344053),
    fontSize: 9,
    fontFamily: 'Sora',
    fontWeight: FontWeight.w400,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 2:
        text = '30k';
        break;
      case 3:
        text = '50k';
        break;
      case 4:
        text = '60k';
        break;
      case 5:
        text = '70k';
        break;
      default:
        return Container();
    }

    return Text(value.toInt().toString(), style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    // List<Dashboard>? sales=[];
    // sales.add(Dashboard("2023-11-12", 120, 1));
    // sales.add(Dashboard("2023-11-14", 110, 1));
    // sales.add(Dashboard("2023-11-13", 100, 1));
    // sales.add(Dashboard("2023-11-12", 90, 1));
    // sales.add(Dashboard("2023-11-11", 95, 1));
    // sales.add(Dashboard("2023-11-10", 90, 1));
    // Logger().e(double.parse(widget.sales![0].date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]));
    // Logger().e(double.parse(widget.sales![widget.sales!.length-1].date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]));
    // Logger().e(double.parse(widget.sales![0].price.toString()));
    // Logger().e(double.parse(widget.sales![widget.sales!.length-1].price.toString()));

    List<FlSpot>? data=[];
    widget.sales!.forEach((element) {
      // Logger().e(element.date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]);
      data.add(
          FlSpot(double.parse(
             element.date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]),
              double.parse(element.price!.toInt().toString()))
          );
    });
    return LineChartData(
      // baselineX:300,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color:  Color(0xFFEDEFF2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color:kPrimaryColorx,
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide( //                    <--- top side
            color: Color(0xFFEDEFF2),
            width: 3.0,
          ),
        ),
      ),
      minY:widget.sales!.isEmpty?0.0: double.parse(widget.sales![0].price.toString()),
      maxY:widget.sales!.isEmpty?0.0: double.parse(widget.sales![widget.sales!.length-1].price.toString()),
      // baselineY: 200,
      minX:widget.sales!.isEmpty?0.0:double.parse(widget.sales![0].date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]),
      maxX:widget.sales!.isEmpty?0.0: double.parse(widget.sales![widget.sales!.length-1].date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]),
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin:Alignment(0, -1.90),
            end: Alignment(-8.00, -2.09),

          ),
          barWidth: 1.90,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }


}