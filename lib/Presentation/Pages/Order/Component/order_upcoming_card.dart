
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../../Data/Model/Order/Order.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class OrderUpcomingCard extends StatelessWidget {
  final String? title,chef,location,image,orderId,ordertype;
  final Menu? menu;
  final Order? order;
  const OrderUpcomingCard({Key? key, this.title, this.chef, this.location, this.image, this.orderId, this.menu, this.ordertype, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24,right: 24,bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child:CachedNetworkImage(
                  imageUrl: image!,
                  placeholder: (context, url) => LoadingWidget(),
                  imageBuilder: (context, image) =>
                      Container(
                    padding: EdgeInsets.all(8),
                    height: 132.70,
                    width: 109,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 22,
                          padding: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
                          decoration: ShapeDecoration(
                            color:order!.isAcceptedByChef!?Color(0xFFF0F9F4): Color(0xFFFCF4E3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                order!.isReadyForPickUp! && order!.isPaymentConfirmed! && order!.isAcceptedByChef! && order!.paymentRequested!?"Ready":///Order Accept
                                order!.isPaymentConfirmed! && order!.isAcceptedByChef! && order!.paymentRequested!?"Payment": ///Payment Accept
                                order!.isAcceptedByChef! && order!.paymentRequested!?"Payment":///Payment Accept
                                order!.isAcceptedByChef!?"Accepted":
                                "Pending",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:order!.isAcceptedByChef!?kPrimaryColorx: Color(0xFFFCB116),
                                  fontSize: 12,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
          ),
          SizedBox(width: 14,),
          Expanded(
            flex: 6,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                 Text(chef!,
                   style: TextStyle(
                          color: Color(0xFF00934C),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    title!,
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(height: 6,),
                  // Text(
                  //   chef!,
                  //   style: TextStyle(
                  //     color: Color(0xFF6D7075),
                  //     fontSize: 12,
                  //     fontFamily: 'Sora',
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),

                  SizedBox(height: 8,),
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: SvgPicture.asset("assets/icons/delivery.svg",color: Color(0xFF5C6360),)
                        ),
                        WidgetSpan(
                            child: SizedBox(width: 6,)
                        ),
                        TextSpan(
                          text: ordertype!+' date: ',
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 10,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: menu!.deliveryDay??"",
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 10,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: SvgPicture.asset("assets/icons/location.svg",color: Color(0xFF5C6360),)
                        ),
                        WidgetSpan(
                            child: SizedBox(width: 6,)
                        ),
                        TextSpan(
                          text: ' $ordertype location: ',
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 10,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: location!,
                          style: TextStyle(
                            color: Color(0xFF5C6360),
                            fontSize: 10,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14,),
                  CustomButton(
                      height: 32,
                      orderRadius: 24,
                      color: kPrimaryColorx,
                      textSize: 12,
                      boder: false,
                      textColor: Colors.white,
                      title: "View Order",
                      onTap: (){
                        Navigator.pushNamed(context, ORDE_TIMELINE_DETAILS_PAGE,arguments: {
                          'orderId':orderId
                        });

                  }),
                ],
              )
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
