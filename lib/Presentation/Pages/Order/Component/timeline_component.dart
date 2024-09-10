import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineComponent extends StatelessWidget {
  const TimeLineComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
         child:Column(
           children: [
             TimelineTile(
               hasIndicator: true,
               isFirst: true,
               indicatorStyle: IndicatorStyle(color: Colors.redAccent),
               beforeLineStyle: LineStyle(thickness: 5),
               alignment: TimelineAlign.center,
               endChild: Container(
                 constraints: const BoxConstraints(
                   minHeight: 120,
                 ),
                 color: Colors.lightGreenAccent,
               ),
               // startChild: Container(
               //   color: Colors.amberAccent,
               // ),
             ),
             TimelineTile(
               hasIndicator: true,
               indicatorStyle: IndicatorStyle(
                 width: 40,
                 indicatorXY: 0.0,
                 color: Colors.redAccent,
                 padding: const EdgeInsets.all(2),
                 drawGap: true,
                 height: 30,
                 // indicator: SvgPicture.asset("assets/icons/box.svg"),
                 iconStyle: IconStyle(
                   color: Colors.white,
                   iconData: Icons.insert_emoticon,
                 ),
               ),
               beforeLineStyle: LineStyle(thickness: 5),
               alignment: TimelineAlign.center,
               endChild: Container(
                 constraints: const BoxConstraints(
                   minHeight: 120,
                 ),
                 color: Colors.lightGreenAccent,
               ),
               // startChild: Container(
               //   color: Colors.amberAccent,
               // ),
             ),
           ],
         )
      ),
    );
  }
}





class Example10Vertical extends StatelessWidget {
  const Example10Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.purple,
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.purple,
                    thickness: 6,
                  ),
                ),
                const TimelineDivider(
                  begin: 0.1,
                  end: 0.9,
                  thickness: 6,
                  color: Colors.purple,
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.9,
                  beforeLineStyle: const LineStyle(
                    color: Colors.purple,
                    thickness: 6,
                  ),
                  afterLineStyle: const LineStyle(
                    color: Colors.deepOrange,
                    thickness: 6,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.cyan,
                  ),
                ),
                const TimelineDivider(
                  begin: 0.1,
                  end: 0.9,
                  thickness: 6,
                  color: Colors.deepOrange,
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isLast: true,
                  beforeLineStyle: const LineStyle(
                    color: Colors.deepOrange,
                    thickness: 6,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Example10Horizontal extends StatelessWidget {
  const Example10Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 120),
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    isFirst: true,
                    indicatorStyle: const IndicatorStyle(
                      height: 20,
                      color: Colors.purple,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: Colors.purple,
                      thickness: 6,
                    ),
                  ),
                  const TimelineDivider(
                    axis: TimelineAxis.vertical,
                    begin: 0.1,
                    end: 0.9,
                    thickness: 6,
                    color: Colors.purple,
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.9,
                    beforeLineStyle: const LineStyle(
                      color: Colors.purple,
                      thickness: 6,
                    ),
                    afterLineStyle: const LineStyle(
                      color: Colors.deepOrange,
                      thickness: 6,
                    ),
                    indicatorStyle: const IndicatorStyle(
                      height: 20,
                      color: Colors.cyan,
                    ),
                  ),
                  const TimelineDivider(
                    axis: TimelineAxis.vertical,
                    begin: 0.1,
                    end: 0.9,
                    thickness: 6,
                    color: Colors.deepOrange,
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    isLast: true,
                    beforeLineStyle: const LineStyle(
                      color: Colors.deepOrange,
                      thickness: 6,
                    ),
                    indicatorStyle: const IndicatorStyle(
                      height: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}