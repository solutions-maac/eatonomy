
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../Config/text_style.dart';

class EmptyWidget extends StatelessWidget {
 final String? image;
 final String? title;
 final String? supertitle;
 final String? discription;
 final bool? lotti;
 final double? height;
  const EmptyWidget({Key? key, this.image="assets/lottie/empty_box.json", this.title, this.discription,this.lotti=true, this.height=140, this.supertitle,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          lotti! ?
          Lottie.asset(image!,height: height,repeat: false,)
              :
          Image.asset(image!,height: height,),
          supertitle!=null? SizedBox(height: 14,):SizedBox(),
          Text(supertitle??"",style: boldText(18.sp,color: Color(0xFF595959)),textAlign: TextAlign.center,),
          Text(title??"",style: mediumText(14.sp,color: Color(0xFF595959)),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
