import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/GetX%20Controller/Menu/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Menu/Menu.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';

class WishCard extends StatelessWidget {
  final Menu? menu;
  final String? craeteat;
  final MenuControllerx? controller;
  const WishCard({Key? key, this.menu, this.craeteat, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        // shadows: [
        //   BoxShadow(
        //     color: Color(0x143E2489),
        //     blurRadius: 24,
        //     offset: Offset(0, 6),
        //     spreadRadius: 0,
        //   )
        // ],
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child:CachedNetworkImage(
                  imageUrl: menu!.images![0],
                  placeholder: (context, url) => LoadingWidget(),
                  imageBuilder: (context, image) =>Container(
                    width: 106,
                    height: 122,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ))



          ),
          SizedBox(width: 14,),
          Expanded(
              flex: 6,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    menu!.title??"",
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RatingBar(
                    initialRating:menu!.chef!.rating!=null?menu!.chef!.rating!.toDouble():0.0,
                    minRating: 0,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 12,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 8,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 6.23,)),
                      half: SizedBox(
                          height: 8,
                          child: SvgPicture.asset('assets/icons/star.svg')),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {

                    },
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        menu!.chef!.name??"",
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 12,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            showAlertDialog(context,controller!);

                          },
                          child: controller!.circuler.value&&controller!.wishMenuId.value==menu!.id?
                          SizedBox(
                              height: 16,
                              width: 16,
                              child: LoadingWidget()): SvgPicture.asset("assets/icons/trash.svg",color: Color(0xFF5C6460),height: 18,))
                    ],
                  ),
                  SizedBox(height: 16,),
                  CustomButton(
                      height: 34,orderRadius: 24,color: kPrimaryColorx,
                      boder: false,textColor: Colors.white,title: "View Post",onTap: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => TimeLineComponent())
                    // );
                        Navigator.pushNamed(context, WISH_DETAILS_PAGE,arguments: {
                          'menu':menu!,
                          'craeteat':craeteat!
                        });
                  }),
                ],
              )
          ),
        ],
      ),
    );
  }


  showAlertDialog(BuildContext context,MenuControllerx controllerx) {
    // set up the buttons
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 14),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0x2600934C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50, color: Color(0xFF00934C)),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00934C),
                fontSize: 14,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(width: 12,),
        InkWell(
          onTap: (){
            controllerx.removeWishListMenu(context: context, id: menu!.id,isFeed: false).then((value){
              controllerx.getWishList(isFirst: true);
              controllerx.circuler.value=false;
            });
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 14),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFF00934C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Remove',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text("Remove from wishlist", style: TextStyle(
          color: Color(0xFF02190E),
          fontSize: 16,
          fontFamily: 'Sora',
          fontWeight: FontWeight.w600,
        ),
          textAlign: TextAlign.start,),
      ),
      content: Container(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Text(
              "Are you sure you want to delete this\nmenu?", style: TextStyle(
            color: Color(0xFF02190E),
            fontSize: 12,
            fontFamily: 'Sora',
            height: 1.30,
            fontWeight: FontWeight.w300,
          ),
              textAlign: TextAlign.start)),
      actions: [
        cancelButton,
        SizedBox(height: 20,)

      ],
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
