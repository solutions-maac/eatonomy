import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Data/Model/Dashboard/Dashboard.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import 'dart:ui' as ui;

class GraphChartChef2 extends StatefulWidget {
  final List<Dashboard>? sales;
  final ChefController? controller;
  const GraphChartChef2({super.key, this.sales, this.controller});

  @override
  State<GraphChartChef2> createState() => _GraphChartChef2State();
}

class _GraphChartChef2State extends State<GraphChartChef2> {
  List<Color> gradientColors = [
    Color(0xFF00934C), Color(0xFFD4ECE4)
  ];



  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[];
    String text;
    const style = TextStyle(
      color: Color(0xFF475466),
      fontSize: 12,
      fontFamily: 'Sora',
      fontWeight: FontWeight.w400,
    );
    String? getMonth(int num){

      switch (num.toInt()) {
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
          text ='Sep';
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

      return text;
    }
    widget.sales!.forEach((element) {
      chartData.add(
          ChartData(
              int.parse(element.date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]).toString(),
              double.parse(element.price!.toInt().toString())));
    });

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
        ),
        series: <ChartSeries>[
          SplineAreaSeries<ChartData, String>(
            borderDrawMode: BorderDrawMode.excludeBottom,
            // gradient: LinearGradient(
            //     colors: [
            //       Color(0xFF00934C).withOpacity(0.25),
            //             Color(0xFFD4ECE4)
            //     ],
            //     begin:Alignment(1.0, -1.90),
            //   end: Alignment(-8.00, -2.09),
            //
            //  ),
              borderWidth: 2,

              onCreateShader: (ShaderDetails details) {
                return ui.Gradient.linear(
                  details.rect.topCenter,
                  details.rect.bottomLeft,
                  <Color>[
                    Color(0xFF00934C).withOpacity(0.25),
                    Color(0xFFD4ECE4)
                  ],
                  <double>[
                    0.10,
                    1.0,
                  ],
                  TileMode.mirror,

                );
              },
              borderGradient:LinearGradient(
                  colors: gradientColors,
                  begin:Alignment(0, -1.90),
                  end: Alignment(-8.00, -2.09),
                  stops: <double>[
                    0.2,
                    0.9
                  ]
              ) ,
              // color: Color(0xFFD4ECE4),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) =>widget.controller!.orderTotalIncomeFilter.value=="Month"?getMonth(int.parse(data.x)): data.x,
              yValueMapper: (ChartData data, _) => data.y
          ),
        ]
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}




// class _GraphChartChef2State extends State<GraphChartChef2> {
//   List<Color> gradientColors = [
//     Color(0xFF00934C), Color(0xFFD4ECE4)
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final List<ChartData> chartData = <ChartData>[];
//     String text;
//     const style = TextStyle(
//       color: Color(0xFF475466),
//       fontSize: 12,
//       fontFamily: 'Sora',
//       fontWeight: FontWeight.w400,
//     );
//     String? getMonth(int num){
//
//       switch (num.toInt()) {
//         case 1:
//           text = 'Jan';
//           break;
//         case 2:
//           text = 'Feb';
//           break;
//         case 3:
//           text = 'Mar';
//           break;
//         case 4:
//           text = 'Apr';
//           break;
//         case 5:
//           text = 'May';
//           break;
//         case 6:
//           text = 'Jun';
//           break;
//         case 7:
//           text = 'Jul';
//           break;
//         case 8:
//           text = 'Agu';
//           break;
//         case 9:
//           text ='Sep';
//           break;
//         case 10:
//           text = 'Oct';
//           break;
//         case 11:
//           text = 'Nov';
//           break;
//         case 12:
//           text = 'Dec';
//           break;
//         default:
//           text = '';
//           break;
//       }
//
//       return text;
//     }
//     widget.sales!.forEach((element) {
//       chartData.add(
//           ChartData(
//               int.parse(element.date!.split("-")[widget.controller!.orderTotalIncomeFilter.value=="Month"?1:2]),
//               double.parse(element.price!.toInt().toString())));
//     });
//
//     return SfCartesianChart(
//
//         series: <ChartSeries>[
//           SplineAreaSeries<ChartData, int>(
//             // gradient: LinearGradient(
//             //     colors: [
//             //       Color(0xFF00934C).withOpacity(0.25),
//             //             Color(0xFFD4ECE4)
//             //     ],
//             //     begin:Alignment(1.0, -1.90),
//             //   end: Alignment(-8.00, -2.09),
//             //
//             //  ),
//               borderWidth: 2,
//
//               onCreateShader: (ShaderDetails details) {
//                 return ui.Gradient.linear(
//                   details.rect.topCenter,
//                   details.rect.bottomLeft,
//                   <Color>[
//                     Color(0xFF00934C).withOpacity(0.25),
//                     Color(0xFFD4ECE4)
//                   ],
//                   <double>[
//                     0.10,
//                     1.0,
//                   ],
//                   TileMode.mirror,
//
//                 );
//               },
//               borderGradient:LinearGradient(
//                   colors: gradientColors,
//                   begin:Alignment(0, -1.90),
//                   end: Alignment(-8.00, -2.09),
//                   stops: <double>[
//                     0.2,
//                     0.9
//                   ]
//               ) ,
//               // color: Color(0xFFD4ECE4),
//               dataSource: chartData,
//               xValueMapper: (ChartData data, _) => data.x,
//               yValueMapper: (ChartData data, _) => data.y
//           ),
//         ]
//     );
//   }
// }