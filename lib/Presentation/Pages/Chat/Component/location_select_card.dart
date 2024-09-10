
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Data/Model/Chat/ChatLocal.dart';
import '../../../../Dependenci Injection/injection.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';
import '../../../../GetX Controller/Map/MapController.dart';
import '../../../../service/location_service.dart';

class LocationSelectCard extends StatelessWidget {
  final bool? sender;
  final ChatController?controler;

  const LocationSelectCard({Key? key, this.sender, this.controler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Click the button for share your current location.',
          style: TextStyle(
            color: sender! ? Colors.white : textColor,
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
                color: sender!
                    ? Colors.white.withOpacity(0.20000000298023224)
                    : Colors.black.withOpacity(0.20000000298023224),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        GetBuilder<MapController>(
          assignId: true,
          builder: (controller) {
            return Obx(() {
              return controller.loadLoaction.value?Text("Please wait Get Location...",style: semiBoldText(14,color: Colors.white),):
              InkWell(
                onTap: () {
                  controller.getLocationName().then((value) {
                    controller.loadLoaction.value=true;
                    controller.locationNameService.getLocationName(value!.latitude, value.longitude).then((valuex) {
                      controller.loadLoaction.value=false;
                      controler!.chatList.add(
                          ChatModel(
                              text: "Address:" +
                                  valuex![0].locality.toString() +
                                  "," +
                                  valuex[0].subLocality.toString()
                                  + "\nCoordinate:" +
                                  value.latitude.toString() +
                                  "," + value.longitude.toString(),
                              sender: true,
                              type: ChatType.Text)
                      );

                      controler!.scrollController.animateTo(
                        controler!.scrollController.position.maxScrollExtent +
                            150,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    });
                  });
                },
                child: Container(
                  height: 30,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 4),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50,
                          color: sender! ? Colors.white : kPrimaryColorx),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Share Location',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: sender! ? Colors.white : kPrimaryColorx,
                          fontSize: 12,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        )
      ],
    );
  }


}
