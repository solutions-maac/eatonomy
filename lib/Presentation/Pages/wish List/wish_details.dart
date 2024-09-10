import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Data/Model/Menu/Menu.dart';
import '../Home/Component/menu_card.dart';

class WsihDetails extends StatelessWidget {
  final Menu?menu;
  final String?craeteat;
  const WsihDetails({Key? key, this.menu, this.craeteat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Post Detail"),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
      ),
      body: Container(

        child: MenuCard(
          isHeart: false,
          isCrad: false,
          wishListed:true,
          feedId:menu!.id ,
          menu: menu!,
          chefId:menu!.chef!.id,
          type: menu!.type,
          createAt: menu!.createdAt!,
          image:menu!.images!,
          iteams:menu!.menus!,
          title: menu!.title,
          price: menu!.price.toString(),
          chefName: menu!.chef!.name,
          chefPP:menu!.chef!.profilePicture,
          deliveryInst:menu!.deliveryInstruction,
          orderInst: menu!.orderTakingInstruction,
          isDeliver: menu!.isDeliveryAvailable,
          isPickUp: menu!.isPickUpAvailable,
        ),
      ),
    );
  }
}
