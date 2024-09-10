
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/Presentation/Pages/Chat/Component/qty_card.dart';
import 'package:eatonomy/Presentation/Pages/Chat/Component/time_select_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Data/Model/Chat/Chat.dart';
import '../../../../Data/Model/Chat/ChatLocal.dart';
import '../../../../GetX Controller/Chat/ChatController.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import 'condetion_chat_card.dart';
import 'location_select_card.dart';
import 'menu_bill_chat_card.dart';
import 'order_confirm_chat_card.dart';
import 'order_delivered_chat_card.dart';

class Chatcard extends StatelessWidget {
  final bool? sender;
  final String? text;
  final String? date;
  final String? profilePic;
  final ChatType? type;
  final ChatController controler;
  const Chatcard({Key? key, this.sender, this.text, this.type, required this.controler, this.profilePic, this.date}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:24,vertical:12),
      width:1.0.sw ,
      child: Column(
        children: [
          Text(
            date==null?"":
            getCustomFormattedDateTime(date??"","EEEE HH:mm")??"",
            style: TextStyle(
              color: Color(0xFF8D8D8D),
              fontSize: 10,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 7,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:sender!? MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
              sender!?SizedBox():
              CachedNetworkImage(
                imageUrl: profilePic!,
                placeholder: (context, url) => SizedBox(
                    height: 34,
                    width: 34,
                    child: LoadingWidget()),
                imageBuilder: (context, image) => Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
              ),
              sender!?SizedBox(): SizedBox(width: 12,),

              Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0,right:sender!?0: 55,left:sender!?55: 0 ),
                    padding: ChatType.Image==type?EdgeInsets.zero:EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color:sender!? kPrimaryColorx:Color(0xFFF2F3F6),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8) ,bottomRight: Radius.circular(sender!?0:8),bottomLeft: Radius.circular(sender!?8:0) )
                    ),
                    child:
                    type==ChatType.Image?
                    CachedNetworkImage(
                      imageUrl: text!,
                      placeholder: (context, url) => SizedBox(
                          height: 34,
                          width: 34,
                          child: LoadingWidget()),
                      imageBuilder: (context, image) =>
                        Container(
                        width:200,
                        height: 200,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    )
                        :
                    type==ChatType.YesAvailable?
                    ChatQtyCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.Selectyourtime?
                    TimeDateSelectCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.SelectLocation?
                    LocationSelectCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.MyConditions?
                    CondetionChatCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.Yourmenubills?
                    MenuBillChatCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.Yourorderconfirmed?
                    OrderConfirmChatCard(sender: sender,controler: controler,)
                        :
                    type==ChatType.Yourorderdelivered?
                    OrderDeliveredChatCard(sender: sender,controler: controler,)
                        :
                    Text(text!,style: TextStyle(
                      color: sender!? Colors.white:textColor,
                      fontSize: 12,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w400,
                    ),),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(
        givenDateTime, true);
    var local = date.toLocal().toString();
    // print(local);
    final DateTime docDateTime = DateTime.parse(local);
    return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }
}
