import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../Widgets/Button/custom_button.dart';
import 'Component/expanded_list_item.dart';
import 'Component/top_select_slider.dart';




class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int? currentIndex=0;

  List<ExpandableListItem> courseData = [
    ExpandableListItem(title: "01. How do I take a Somriddhi course?", children: [
      "After choosing a course from Somriddhi, complete the purchase process and then you can start taking your courses. If the course is free then right after choosing the course you can start taking it."
    ]),
    ExpandableListItem(title: "02. Do I have to start my Somriddhi course at a certain time? And how long do I have to complete it?", children: [
      "From the time of completing the purchase process the validity time is started. Depending on the validity time of the course time is varied. In that validity time, the course should be started taking and completed."
    ]),
    ExpandableListItem(title: "03. Is Somriddhi an accredited institution? Do I receive anything after I complete a course?", children: [
     "Yes, Somriddhi is an accredited institution. You will be received a certificate after completion."
    ]),
    ExpandableListItem(title: "04. Is there any way to preview a course?", children: [
      "Every Somriddhi course has a few free lectures that the instructor has chosen to give students a taste of the course material and teaching style. To get to a course's Course Landing Page, click on the course icon or title. After that, go to the content and take a glance at the Preview."
    ]),
    ExpandableListItem(title: "05. What if I don’t like a course I purchased?", children: [
      "There is a refund process for that."
    ]),
    ExpandableListItem(title: "06. How to download Course Resources?", children: [
     "As a way to improve the learning experience of the course, Somriddhi includes extra resources in their lectures, such as PDFs, design templates, and source code. If the resources are free, they can be immediately downloaded and watched on your computer."
    ]),
    ExpandableListItem(title: "07.Will I continue to have access to the course even after I complete it?", children: [
     "As long as the validity time is not expired, you have access to your courses."
    ]),
    ExpandableListItem(title: "08 .I bought the course in a sale. Does this affect how long I have access to the course?", children: [
      "There is no difference between the course bought in a sale or other times. The access depends on the validity time of the course"
    ]),
    ExpandableListItem(title: "09 Do free courses offer lifetime access?", children: [
    "Yes, free courses offer lifetime access."

    ]),
    ExpandableListItem(title: "10. Will I have lifetime access to subscripted content?", children: [
      "As long as your subscription is active, you will have unrestricted access to subscription content. You will have access to the subscription content until the end of your billing month, which is displayed on your Subscriptions page if you cancel your membership."
    ]),
    ExpandableListItem(title: "11. What happens if the instructor removes the course from Somriddhi?", children: [
     "There is no way that the instructor can remove the content or the course itself."
    ]),
    ExpandableListItem(title: "12. Can my courses ever be removed from Somriddhi?", children: [
     "Courses can be removed from Somriddhi. In that situation, you will be able to continue your paid courses or, in the worst-case scenario, you will be refunded."
    ]),

  ];


  List<ExpandableListItem> certificateData = [
    ExpandableListItem(title: "01. How to Download Your Certificate of Completion.", children: [
      "You will receive a certificate of completion after you complete a Somriddhi course, which you may share with your friends, relatives, coworkers, and potential employers! There is a download and print option on the certificate tab, making it simple to obtain the certificate."
    ]),
    ExpandableListItem(title: "02. Do all courses offer certificates of completion?", children: [
      "Yes, all courses offer certificates of completion."
    ]),
    ExpandableListItem(title: "03. Can I change the formatting of my certificate of completion? Or add an image?", children: [
      "At this moment, certificate formatting is not supported."
    ]),
    ExpandableListItem(title: "04. I need to change the name or language on my certificate of completion. How can I?.", children: [
      "The name you entered when you registered your Somriddhi account is used to generate certificates of completion. If you need to alter the name of the certificate, first change the name of your account, then log out and log back in. For the time being, the change of language is not supported."
    ]),
  ];
  List<ExpandableListItem> paymentData = [
    ExpandableListItem(title: "01. Payment Methods on Somriddhi.", children: [
      "Depending on your account country and location, Somriddhi currently allows a variety of payment methods and mobile wallet choices."
    ]),
    ExpandableListItem(title: "02. How to Confirm Your Payment on Somriddhi?", children: [
      "When you completed the purchase process you will be notified. You will be able to see the course in the dashboard on ‘My Courses’. If there is any problem that occurs, connect with Somriddhi support."
    ]),
    ExpandableListItem(title: "03. How to Solve Payment Issues?", children: [
      "Every step of purchase will be notified to you but if you still face issues connect with Somriddhi support."
    ]),
  ];
  List<ExpandableListItem> returnData = [
    ExpandableListItem(title: "01. How to request a refund from your Purchase history?", children: [
      "Are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable."
    ]),
    ExpandableListItem(title: "02. Where can I see the status of my refund?", children: [
      "Are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable."
    ]),
    ExpandableListItem(title: "03. When will I receive my refund?", children: [
     "Are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable."
    ]),
    ExpandableListItem(title: "04. I requested a refund more than 10 business days ago, but I still do not see it in my bank account. Where is my refund?", children: [
    "Are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable."
    ]),
    ExpandableListItem(title: "05. It has been more than 30 days since I requested my refund but I haven’t received it yet. What do I do now?", children: [
      "Are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable."
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0XFFF9FAFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Text("FAQ",style: boldText(18.sp,color: Colors.black),),
        ),
        body:Container(
            height: 1.0.sh,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child:  CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                      "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias exceptur sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laboru et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minu id quod maxime placeat facere possimus, omnis volupt assumenda est, omnis dolor repellendus. Temporibus aut quibusdam et aut officiis debitis aut rerum necessit saepe eveniet ut et voluptates repudiandae sint et mol non recusandae. Itaque earum rerum hic tenetur a sapi delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repel."
                  ),
                ),
              ],
            )
        ),
      );
  }
}



class ExpandableListItem {
  String title;
  List<String> children;

  ExpandableListItem({required this.title, required this.children});
}