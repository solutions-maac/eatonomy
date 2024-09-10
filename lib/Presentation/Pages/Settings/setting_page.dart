import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/TextField/icon_bg_textfield.dart';
import '../About/Component/action_button.dart';
import 'Component/language_card.dart';




class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController searchController=TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        title: Text("Settings",style: boldText(20.sp),),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // LanguageCard(
            //   title: 'Language',
            //   color: Color(0xFFE1F3FF),
            // ),
            // Divider(height: 1,color: Color(0xFFF5F5F5),thickness: 2,),
            SizedBox(height: 16.h,),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, PASSWORD_CHANGE_PAGE);
                },
                child: ActionButton(title: "Password Change")),
            SizedBox(height: 16.h,),
            Divider(height: 1,color: Color(0xFFF5F5F5),thickness: 2,),
            SizedBox(height: 16.h,),
            // Row(
            //   children: [
            //
            //     Expanded(
            //         flex: 1,
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Push Notification",
            //                 style: mediumText(14.sp),
            //               ).tr(),
            //
            //               SizedBox(
            //                 height: 12.h,
            //                 child:Transform.scale(
            //                   scale: .8,
            //                   child: CupertinoSwitch(
            //                       thumbColor: Colors.white,
            //                       activeColor: kPrimaryColorx,
            //                       value: isChecked,
            //                       onChanged: (bool){
            //                        setState(() {
            //                          isChecked = bool;
            //                        });
            //                   }),
            //                 ),
            //               )
            //
            //             ],
            //           ),
            //         )
            //     )
            //   ],
            // ),
            // SizedBox(height: 16.h,),
            // Divider(height: 1,color: Color(0xFFF5F5F5),thickness: 2,),
          ],
        ),

      ),
    );
  }
}

