

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(size.width*0.9777778,size.height*0.3823529);
path_0.cubicTo(size.width*0.9777778,size.height*0.5935206,size.width*0.7000000,size.height*0.9705882,size.width*0.4962963,size.height);
path_0.cubicTo(size.width*0.2925933,size.height*0.9705882,size.width*0.01481570,size.height*0.5935206,size.width*0.01481570,size.height*0.3823529);
path_0.cubicTo(size.width*0.01481570,size.height*0.1711853,size.width*0.2303822,0,size.width*0.4962963,0);
path_0.cubicTo(size.width*0.7622111,0,size.width*0.9777778,size.height*0.1711853,size.width*0.9777778,size.height*0.3823529);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xff00934C).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}