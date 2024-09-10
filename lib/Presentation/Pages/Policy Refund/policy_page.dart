import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Strings/app_strings.dart';
import 'Component/action_button.dart';
import 'Component/platfrom_card.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        backgroundColor: Color(0XFFF9FAFC),
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_arrow_left,)),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Policy ",style: mediumText(18.sp,color: Colors.black),),
        ),
        body: Container(
            height: 1.0.sh,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child:  CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(PRIVICY_POLICY_CONTENT)
                ),
              ],
            )
        ),


      );
  }
}

class AboutClass{
  String? title;
  String? discriptiom;
  String? image;

  AboutClass(this.title, this.discriptiom, this.image);
}
