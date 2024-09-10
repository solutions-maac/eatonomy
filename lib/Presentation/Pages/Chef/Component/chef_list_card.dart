import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Data/Model/Location/LocationModel.dart';
import 'package:eatonomy/GetX%20Controller/Chef/ChefController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Constants/Strings/app_strings.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import 'package:geolocator/geolocator.dart';

class ChefListCard extends StatelessWidget {
  final String? name,image,shop,address,id;
  final num? rating,items;
  final bool? isHotDeal,directHomePage;
  final LocationModel? locationModel;
  final ChefController? controller;
  const ChefListCard({Key? key, this.name, this.image, this.shop, this.address, this.rating, this.isHotDeal, this.locationModel, this.controller, this.items, this.id, this.directHomePage=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 1.0.sw,
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFE5E5EB)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: (){
                // controller!.token.value==""?
                // Get.snackbar(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),borderRadius: 6,"Warning", "You are not Login",backgroundColor: Colors.orangeAccent,colorText: Colors.white)
                //     :
                Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                  'id': id,
                  'localuser': true,
                  "directHomePage":directHomePage
                });
              },
              child: CachedNetworkImage(
                  imageUrl: image!,
                  errorWidget: (context,url,error)=>Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(2),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFF2F3F5)),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                    child: Center(
                      child: Text(
                          name!.length>2? name!.substring(0,2).toUpperCase():"EA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      height: 48,
                      width: 48,
                      child: LoadingWidget()),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    // radius: 38,
                  ),
                ),
            ),
          ),
          SizedBox(width: 13,),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex:4,
                      child: InkWell(
                        onTap: (){
                          // controller!.token.value==""?
                          // Get.snackbar(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),borderRadius: 6,"Warning", "You are not Login",backgroundColor: Colors.orangeAccent,colorText: Colors.white)
                          //     :
                          Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                            'id': id,
                            'localuser': true,
                            "directHomePage":false
                          });
                        },
                        child: Text(
                          name!,
                          style: TextStyle(
                            color: Color(0xFF02190E),
                            fontSize: 14,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      padding: const EdgeInsets.only(top: 4, left: 6, right: 8, bottom: 4),
                      decoration: ShapeDecoration(
                        color: Color(0xFFF0F9F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/box-tick.svg"),
                          const SizedBox(width: 4),
                          Text(
                            items==null?"0 times":'$items times',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00934C),
                              fontSize: 10,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6,),
                RatingBar(
                  initialRating:rating==null?0.0: rating!.toDouble(),
                  minRating:0.0,
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  ratingWidget: RatingWidget(
                    full: SizedBox(
                        height: 8,
                        child: SvgPicture.asset('assets/icons/star.svg')),
                    half: SizedBox(
                        height: 8,
                        child: SvgPicture.asset('assets/icons/star.svg')),
                    empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                  ),
                  onRatingUpdate: (ratingx) {

                  },
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller!.location.value==null?"Getting Your Location..":
                      getDistance(locationModel!,controller).toString()+" km far away",
                      style: TextStyle(
                        color: Color(0xFF5C6360),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    isHotDeal==null?SizedBox():
                    isHotDeal!?
                    InkWell(
                      onTap: (){
                        // controller!.token.value==""?
                        // Get.snackbar(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),borderRadius: 6,"Warning", "You are not Login",backgroundColor: Colors.orangeAccent,colorText: Colors.white)
                        //     :
                        Navigator.pushNamed(context, HOT_MENU_PAGE,arguments: {
                          "id":id!
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset("assets/icons/fire.png"),
                          SizedBox(width: 4,),
                          Text(
                            'Hot deal',
                            style: TextStyle(
                              color: Color(0xFFF2503B),
                              fontSize: 11,
                              fontFamily: 'Sora',
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ):SizedBox()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  getDistance(LocationModel? locationModel,ChefController? controller){

    double distanceInMeters = Geolocator.distanceBetween(
        locationModel!.latitude!, locationModel.longitude!,
        controller!.location.value!.latitude!,controller.location.value!.longitude!);


    return (distanceInMeters*0.001).toStringAsFixed(2).toString();
  }
}


