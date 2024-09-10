import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Data/Model/Chat/ChatLocal.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';

class TimeDateSelectCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;
  const TimeDateSelectCard({Key? key, this.sender, this.controler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Please select your preferred time to get your food.',
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
        InkWell(
          onTap: (){
            showDateTimePicker(context: context).then((value) {
              controler!.chatList.add(ChatModel(text:value.toString(),sender: true,type: ChatType.Text));
              controler!.scrollController.animateTo(
                controler!.scrollController.position.maxScrollExtent+350,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            });

          },
          child: Container(
            height: 45,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50, color:sender!? Colors.white:kPrimaryColorx),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select your date & time',
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
      ],
    );
  }


  Future<DateTime?> showDateTimePicker({required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,}) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

   

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
}
