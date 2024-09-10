import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Config/text_style.dart';

class ExpanedListFAQ extends StatefulWidget {
  String? title;
  List<String>? children;
   ExpanedListFAQ({Key? key,this.title,this.children}) : super(key: key);

  @override
  State<ExpanedListFAQ> createState() => _ExpanedListFAQState();
}

class _ExpanedListFAQState extends State<ExpanedListFAQ> {
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          trailing: isExpanded? Icon(
            Icons.remove,
          ):Icon(
            Icons.add,
          ),
          onExpansionChanged: (bool expanded) {
            setState(() => isExpanded = expanded);
          },
          expandedAlignment: Alignment.topLeft,
          title: Text(widget.title!,style: semiBoldText(13.sp),),
          children: widget.children!.map((e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: Text(e),
          )).toList(),
        ),
        isExpanded?Container(): SizedBox(height: 20.h,),
        isExpanded?Container(): Divider(height: 1,color: Color(0xFFF5F5F5),thickness: 2,),
      ],
    );
  }
}

