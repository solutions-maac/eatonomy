import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:eatonomy/GetX%20Controller/Chef/ChefController.dart';
import 'package:eatonomy/GetX%20Controller/Menu/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../../../Data/Model/Menu/Menu.dart';

class CuisineCrad extends StatelessWidget {
  final String? name;
  final MenuControllerx? controller;
  final ChefController? chefController;
  const CuisineCrad({super.key, this.name, this.controller, this.chefController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        controller!.selectCuisine.value=name!;
        // List<Menu> list=[];

        Logger().w(name);
        chefController!.menusCopy=chefController!.menus.where((element) => element.cuisine==name).toList();
        // Logger().e(chefController!.menus.where((element) => element.cuisine!.toLowerCase()==name!.toLowerCase()).toList());
        // Logger().w(chefController!.menus);
        chefController!.update();
        controller!.update();
      },
      child: Container(
        width: 55,
        height: 77,
        margin: EdgeInsets.only(right: 12),
        decoration: ShapeDecoration(
          color:controller!.selectCuisine.value==name? Color(0xFFD4ECE4):Colors.white,
          shape: RoundedRectangleBorder(
            // side: BorderSide(width: 1, color: controller!.selectCuisine.value==name? kPrimaryColor:Colors.white),
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/$name.svg"),
            SizedBox(height: 8,),
            Text(
              name??"",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00934C),
                fontSize: 10,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
