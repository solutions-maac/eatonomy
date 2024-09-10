
import 'package:eatonomy/GetX%20Controller/Order/OrderController.dart';
import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Data/Model/Chat/Chat.dart';
import '../../../Data/Model/Chat/ChatLocal.dart';
import '../../../Data/Model/Order/Order.dart';
import '../../../GetX Controller/Chat/ChatController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/bg_textfield.dart';
import '../../Widgets/TextField/icon_bg_textfield.dart';
import 'Component/chat_card.dart';


class ChatPage extends StatefulWidget {
  final Order? order;


  ChatPage({Key? key, this.order}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController chatRexrEditController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,(){
      Get.find<ChatController>().onInit();
      Get.find<ChatController>().orderChatHistory(order: widget.order!.orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return GetBuilder<ChatController>(
      assignId: true,
      builder: (controler) {
        return Obx(() {
          return
            Scaffold(
              backgroundColor:  Colors.white,
              appBar: AppBar(
                backgroundColor: kPrimaryColorx,
                iconTheme: IconThemeData(color: Colors.white,),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Padding(
                        padding: EdgeInsets.all(12),
                        child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,color: Colors.white,))),
                centerTitle: true,
                title: Text(
                  'Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                bottom:PreferredSize(
                    preferredSize: const Size.fromHeight(70.0),
                     child: Container(
                       padding: EdgeInsets.symmetric(
                           horizontal: 24, vertical: 18),
                       color: kPrimaryColorx,
                       child:controler.role.value=="CHEF"?

                       Row(
                         children: [
                           Container(
                             width: 42,
                             height: 42,
                             decoration: ShapeDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(
                                     widget.order!.user!.profilePicture??''),
                                 fit: BoxFit.fill,
                               ),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(44),
                               ),
                             ),
                           ),
                           SizedBox(width: 16,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 widget.order!.user!.name??'',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontFamily: 'Sora',
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               SizedBox(height: 8,),
                               Row(
                                 children: [
                                   Container(
                                     width: 13,
                                     height: 13,
                                     child: SvgPicture.asset(
                                       "assets/icons/call.svg",
                                       color: Colors.white.withOpacity(
                                           0.699999988079071),),
                                   ),
                                   SizedBox(width: 4,),
                                   Text(
                                       widget.order!.user!.mobileNumber??"There has no number",
                                     style: TextStyle(
                                       color: Colors.white.withOpacity(
                                           0.699999988079071),
                                       fontSize: 12,
                                       fontFamily: 'Satoshi',
                                       fontWeight: FontWeight.w400,
                                     ),
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ],
                       )
                           :
                       Row(
                         children: [
                           Container(
                             width: 42,
                             height: 42,
                             decoration: ShapeDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(
                                     widget.order!.chef!.profilePicture??''),
                                 fit: BoxFit.fill,
                               ),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(44),
                               ),
                             ),
                           ),
                           SizedBox(width: 16,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 widget.order!.chef!.name??'',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontFamily: 'Sora',
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               SizedBox(height: 8,),
                               Row(
                                 children: [
                                   Container(
                                     width: 13,
                                     height: 13,
                                     child: SvgPicture.asset(
                                       "assets/icons/call.svg",
                                       color: Colors.white.withOpacity(
                                           0.699999988079071),),
                                   ),
                                   SizedBox(width: 4,),
                                   Text(
                                     widget.order!.chef!.mobileNumber??"There has no location",
                                     style: TextStyle(
                                       color: Colors.white.withOpacity(
                                           0.699999988079071),
                                       fontSize: 12,
                                       fontFamily: 'Satoshi',
                                       fontWeight: FontWeight.w400,
                                     ),
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ],
                       ),
                     )
                ),

              ),
              body:controler.orderChatHistoryCirculer.value?
              LoadingWidget():
              Container(
                height: 1.0.sh,
                color: Colors.white,
                padding: EdgeInsets.only(top: 24),
                child:
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                          controller: controler.scrollController,
                          itemCount: controler.chatList.length,
                          itemBuilder: (context, index) {
                            return Chatcard(
                              date: controler.chatList[index].date,
                              controler:controler ,
                              sender: controler.chatList[index].sender,
                              text:controler.chatList[index].text??"",
                              profilePic: controler.chatList[index].profilepic,
                              type: controler.chatList[index].type,);
                          }
                      ),
                    ),

                    SizedBox(height: 90,)
                  ],
                ),
              ),
              bottomSheet: SizedBox(
                height: 90,
                child: Column(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 24),
                    //   margin: EdgeInsets.symmetric(vertical: 19),
                    //   height: 34,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controler.listOfAction!.value.length,
                    //     itemBuilder: (contex, index) {
                    //       return InkWell(
                    //         onTap: () {
                    //           if(controler.listOfAction!.value[index]=="Yes, Available"){
                    //             controler.chatList.add(ChatModel(text:"chatRexrEditController.text",sender: true,type: ChatType.YesAvailable));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+300,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //           if(controler.listOfAction!.value[index]=="Select your time"){
                    //             controler.chatList.add(ChatModel(text:"",sender: true,type: ChatType.Selectyourtime));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+300,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //           if(controler.listOfAction!.value[index]=="Select Location"){
                    //             controler.chatList.add(ChatModel(text:"",sender: true,type: ChatType.SelectLocation));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+350,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //           if(controler.listOfAction!.value[index]=="My Conditions"){
                    //             controler.chatList.add(ChatModel(text:"",sender: true,type: ChatType.MyConditions));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+300,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //           if(controler.listOfAction!.value[index]=="Your menu bills"){
                    //             showAlertDialog(context,controler);
                    //           }
                    //           if(controler.listOfAction!.value[index]=="Your order confirmed"){
                    //             controler.chatList.add(ChatModel(text:"",sender: true,type: ChatType.Yourorderconfirmed));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+300,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //           if(controler.listOfAction!.value[index]=="Your order delivered"){
                    //             controler.chatList.add(ChatModel(text:"",sender: true,type: ChatType.Yourorderdelivered));
                    //             controler.scrollController.animateTo(
                    //               controler.scrollController.position.maxScrollExtent+300,
                    //               duration: Duration(seconds: 1),
                    //               curve: Curves.fastOutSlowIn,
                    //             );
                    //           }
                    //         },
                    //         child: Container(
                    //             height: 34,
                    //             margin: EdgeInsets.only(right: 12),
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 16, vertical: 0),
                    //             decoration: ShapeDecoration(
                    //               color: Colors.white,
                    //               shape: RoundedRectangleBorder(
                    //                 side: BorderSide(
                    //                     width: 0.50, color: Color(0xFF00934C)),
                    //                 borderRadius: BorderRadius.circular(40),
                    //               ),
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 controler.listOfAction!.value[index],
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                   color: Color(0xFF00934C),
                    //                   fontSize: 12,
                    //                   fontFamily: 'Satoshi',
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //             )
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    Container(
                      height: 90,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1, color: Color(0xFFEAECF0)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:controler.circuler.value?LoadingWidget(): InkWell(
                                  onTap: (){
                                    controler.filepic(orderId:widget.order!.orderId);
                                  },
                                  child: SvgPicture.asset("assets/icons/image-01.svg"))
                          ),
                          SizedBox(width: 11,),
                          Expanded(
                              flex: 8,
                              child: BackgroundTextfield(
                                controller: chatRexrEditController,
                                readOnly: false,
                                isNumber: false,
                                isemail: true,
                                height: 55,
                                contentpadding:16,
                                hintText: "Message",
                                bgColor: Colors.white,
                                errormsg: "Please enter your Message",
                                borderColor: Color(0xFFE5E5EB),),

                          ),
                          SizedBox(width: 14,),
                          InkWell(
                            onTap: (){
                              if(chatRexrEditController.text!=""){
                                controler.sendMsg(orderId:widget.order!.orderId,msg:chatRexrEditController.text,type: "string");
                                controler.chatList.add(ChatModel(profilepic: controler.userImage.value,text:chatRexrEditController.text,sender: true));
                                controler.scrollController.animateTo(
                                  controler.scrollController.position.maxScrollExtent+150,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                );
                                chatRexrEditController.text="";
                              }

                            },
                            child: Container(
                              height: 44,
                              padding: EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Color(0xFF00934C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: SvgPicture.asset(
                                  "assets/icons/send-01.svg"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )


          );
        });
      },
    );
  }




  ///===========
  showAlertDialog(BuildContext context,ChatController chatController) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      backgroundColor: kPrimaryColorx,
      content: Container(
        height: 160,
        child: Column(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        'Menu quantity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: BackgroundTextfield(
                        controller: null,
                        readOnly: false,
                        isNumber: true,
                        isemail: false,
                        height: 32,
                        contentpadding: 0,
                        hintText: "Qty",
                        bgColor: Colors.transparent,
                        errormsg: "Please enter qty",
                        borderColor: Color(0xFFD9D9D9),),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Container(
                  width: 1.0.sw,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.38,
                        color: Colors.white.withOpacity(0.10000000149011612),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        'Delivery charge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: BackgroundTextfield(
                        controller: null,
                        readOnly: false,
                        isNumber: true,
                        isemail: false,
                        height: 32,
                        contentpadding: 0,
                        hintText: "Charge",
                        bgColor: Colors.transparent,
                        errormsg: "Please enter qty",
                        borderColor: Color(0xFFD9D9D9),),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Container(
                  width: 1.0.sw,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.38,
                        color: Colors.white.withOpacity(0.10000000149011612),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        'Total food cost',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '\$320',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
               CustomButton(
                height: 30,
                orderRadius: 6,
                color: Colors.white,
                textColor: kPrimaryColorx,
                title: "Sent",
                onTap: () {
                  Navigator.pop(context);
                  chatController.chatList.add(ChatModel(text:"",sender: true,type: ChatType.Yourmenubills));
                  chatController.scrollController.animateTo(
                    chatController.scrollController.position.maxScrollExtent+300,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


