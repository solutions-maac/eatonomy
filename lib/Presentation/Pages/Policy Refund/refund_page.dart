import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Strings/app_strings.dart';
import 'Component/action_button.dart';
import 'Component/platfrom_card.dart';

class RefundPage extends StatefulWidget {
  const RefundPage({Key? key}) : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  

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
          title: Text("Refund Policy ",style: mediumText(18.sp,color: Colors.black),),
        ),
        body: Container(
            height: 1.0.sh,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child:  CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text("At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias exceptur sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laboru et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minu id quod maxime placeat facere possimus, omnis volupt assumenda est, omnis dolor repellendus. Temporibus aut quibusdam et aut officiis debitis aut rerum necessit saepe eveniet ut et voluptates repudiandae sint et mol non recusandae. Itaque earum rerum hic tenetur a sapi delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repel."),
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
