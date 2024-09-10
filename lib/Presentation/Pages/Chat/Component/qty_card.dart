import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Data/Model/Chat/ChatLocal.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';
import '../../../Widgets/TextField/bg_textfield.dart';

class ChatQtyCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;
  ChatQtyCard({Key? key, this.sender, this.controler}) : super(key: key);

  TextEditingController qtyEditController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Yes, available. Please tell us the number of item you want to order.',
          style: TextStyle(
            color:sender!? Colors.white:textColor,
            fontSize: 12,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: 1.0.sw,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.38,
                color:sender!?  Colors.white.withOpacity(0.20000000298023224):Colors.black.withOpacity(0.20000000298023224),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex:6,
              child: SizedBox(

                child: BackgroundTextfield(
                  controller: qtyEditController,
                  readOnly: false,
                  isNumber: true,
                  isemail: false,
                  contentpadding: 0,
                  hintText: "Qty",
                  height: 30,
                  bgColor: Colors.transparent,
                  errormsg: "Please enter qty",
                  borderColor: Color(0xFF9FACC3),),
              ),
            ),
            SizedBox(width: 6,),
            Expanded(
                flex:3,
                child:InkWell(
                  onTap: (){
                    controler!.chatList.add(ChatModel(text:qtyEditController.text,sender: true,type: ChatType.Text));
                    controler!.scrollController.animateTo(
                      controler!.scrollController.position.maxScrollExtent+150,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color:sender!? Colors.white:kPrimaryColorx),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:sender!? Colors.white:kPrimaryColorx,
                            fontSize: 12,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        )
      ],
    );
  }
}
