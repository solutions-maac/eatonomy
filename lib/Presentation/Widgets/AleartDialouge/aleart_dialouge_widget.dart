
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';


class CustomAleartDialouge{
  showAlertDialog(
      {BuildContext? context,
      String? title,
      String? discription,
      String? image,
      String? actionbutton,
      String? navigationName,
      String? buttonText}) {

    // set up the button
    Widget okButton = TextButton(
      child: Text(buttonText??""),
      onPressed: () {
        Navigator.pop(context!);
      },
    );
    Widget actionButton = TextButton(
      child: Text(actionbutton??""),
      onPressed: () {
        Navigator.pushNamed(context!,navigationName!);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      content: Container(
        height: 314,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context!);
                    },
                    child: Icon(Icons.close,color: Colors.black,))
              ],
            ),
            SizedBox(height: 24,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image!=null?Image.asset(image):SizedBox(),
                SizedBox(height: 34,),
                Text(discription??"",style: regularText(13.sp,color: Colors.black),),
                SizedBox(height: 12,),
                InkWell(
                    onTap: (){
                      Navigator.pushNamed(context!,navigationName!);
                    },
                    child: Text(title??"",style: boldText(16.sp,color: kPrimaryColorx),))
              ],
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

