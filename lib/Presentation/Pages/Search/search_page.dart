import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/service/LocalDataBase/history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/ChatHistoryHive/history.dart';
import '../../../GetX Controller/Search/SearchControllerx.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/icon_bg_textfield.dart';
import '../Home/Component/menu_card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchTextController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero, () => Get.find<controller>().onInit());
    Future.delayed(Duration.zero, () => Get.find<SearchControllerx>().onInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FCFF),
        appBar: AppBar(
          backgroundColor:  Color(0xFFF9FCFF),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:  Padding(
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
          title: Text('Search',),
        ),
        body: GetBuilder<SearchControllerx>(
          assignId: true,
          builder: (controller) {
            return Obx(() {
              return Container(
                color:Color(0xFFF9FCFF),
                height: 1.0.sh,
                width: 1.0.sw,
                child: RefreshIndicator(
                  onRefresh: () => refreshList(context),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 8,)),
                      SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            color: Color(0xFFF9FCFF),
                            height: 60.h,
                            child: IconBackgroundTextfield(
                              bgColor: whiteBackground,
                              controller: searchTextController,
                              hintText: "Search for menu",
                              isNumber: false,
                              readOnly: false,
                              isValueChnged: true,
                              tap: (text) {
                                if (text.isEmpty) {
                                  controller.searchText.value = "";
                                } else {
                                  controller.searchText.value = text;
                                  controller.searchMenu();
                                }
                              },
                              onSubmit: (){
                                final DateTime now = DateTime.now();
                                String formattedDate = DateFormat('dd MMM yyyy  kk:mm').format(now);
                                // Logger().w(formattedDate)
                                HiveService().getItems().then((value){
                                  (value.where((element) => element.qus==controller.searchText.value)).toList().isEmpty?HiveService().createItem(History(date: formattedDate,qus:controller.searchText.value)):null;
                                });
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              borderColor: Color(0xFFD9D9D9),
                              icons: "assets/icons/search.svg",
                            ),
                          )
                      ),

                      controller.searchText.value != ""
                          ? SliverToBoxAdapter(child: SizedBox())
                          : SliverToBoxAdapter(
                          child: SizedBox(height: 16,)),
                      controller.searchText.value != ""
                          ? SliverToBoxAdapter(child: SizedBox())
                          :
                      SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0),
                            child:controller.token.value==""?SizedBox(): Text('Top Chef',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 14,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                      ),

                      controller.searchText.value != ""
                          ? SliverToBoxAdapter(child: SizedBox())
                          : SliverToBoxAdapter(
                          child: SizedBox(height: 16,)
                      ),
                      controller.searchText.value != ""
                          ? SliverToBoxAdapter(child: SizedBox())
                          :
                      SliverToBoxAdapter(
                        child:controller.token.value==""?
                        SizedBox() : Container(
                          height: 70.0,
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: controller.topCirculer.value ?
                          LoadingWidget() :
                          controller.topChefResponse.value!.chefs!.isEmpty
                              ?
                          Text(
                            "There Has No To Chef", style: regularText(8),)
                              :
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.topChefResponse.value!
                                .chefs!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SHEF_PROFILE_PAGE,
                                      arguments: {
                                        'id': controller.topChefResponse
                                            .value!.chefs![index].id,
                                        'localuser': true,
                                        "directHomePage":false
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [

                                      CachedNetworkImage(
                                        imageUrl: controller.topChefResponse
                                            .value!.chefs![index]
                                            .profilePicture ?? "",
                                        placeholder: (context, url) =>
                                            LoadingWidget(),
                                        imageBuilder: (context, image) =>
                                            Container(
                                              width: 38,
                                              height: 38,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      44),
                                                ),
                                              ),
                                            ),
                                      ),

                                      SizedBox(height: 4,),
                                      Text(
                                        controller.topChefResponse.value!
                                            .chefs![index].name ?? "",
                                        style: TextStyle(
                                          color: Color(0xFF5C6360),
                                          fontSize: 10,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),



                      ///recent search
                      controller.searchText.value!=""?SliverToBoxAdapter(child:SizedBox()): SliverToBoxAdapter(child: SizedBox(height: 24,)),
                      controller.searchText.value!=""?SliverToBoxAdapter(child:SizedBox()): SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0),
                            child: Text('Recent Searches',
                              style: TextStyle(
                                color: Color(0xFF02190E),
                                fontSize: 14,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                      ),
                      controller.searchText.value!=""?SliverToBoxAdapter(child:SizedBox()): SliverToBoxAdapter(child: SizedBox(height: 16,)),
                      controller.searchText.value!=""?SliverToBoxAdapter(child:SizedBox()): SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Wrap(
                            spacing: 14, // space between items
                            children: controller.history.map((e) =>
                                InkWell(
                                  onTap: (){
                                    searchTextController.text=e.qus??"";
                                    controller.searchText.value = e.qus??"";
                                    controller.searchMenu();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEFEFEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    child: Text(
                                      e.qus??"",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5C6360),
                                        fontSize: 12,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ))
                                .toList(),
                          ),
                        ),
                      ),


                      controller.searchText.value != "" ?
                      controller.circuler.value ?
                      SliverToBoxAdapter(child: LoadingWidget()) :
                      controller.searchResponse.value!.menus!.isEmpty ?
                      SliverToBoxAdapter(child: EmptyWidget()) :
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return MenuCard(
                                isFeed: false,
                                wishListed: controller.searchResponse.value!
                                    .menus![index].alreadyInWishList==null?false:controller.searchResponse.value!.menus![index].alreadyInWishList,
                                isHeart:controller.token.value!="" ,
                                isLogin:controller.token.value!="",
                                menu: controller.searchResponse.value!
                                    .menus![index],
                                chefId: controller.searchResponse.value!
                                    .menus![index].chef!.id,
                                type: controller.searchResponse.value!
                                    .menus![index].type,
                                createAt: controller.searchResponse.value!
                                    .menus![index].createdAt,
                                image: controller.searchResponse.value!
                                    .menus![index].images!,
                                iteams: controller.searchResponse.value!
                                    .menus![index].menus!,
                                title: controller.searchResponse.value!
                                    .menus![index].title,
                                price: controller.searchResponse.value!
                                    .menus![index].price.toString(),
                                chefName: controller.searchResponse.value!
                                    .menus![index].chef!.name,
                                chefPP: controller.searchResponse.value!
                                    .menus![index].chef!.profilePicture,
                                deliveryInst: controller.searchResponse
                                    .value!.menus![index]
                                    .deliveryInstruction,
                                orderInst: controller.searchResponse.value!
                                    .menus![index].orderTakingInstruction,
                                isDeliver: controller.searchResponse.value!
                                    .menus![index].isDeliveryAvailable,
                                isPickUp: controller.searchResponse.value!
                                    .menus![index].isPickUpAvailable,
                              );
                            },
                            childCount: controller.searchResponse.value!
                                .menus!.length,

                          )) : SliverToBoxAdapter(child: SizedBox()),

                      SliverToBoxAdapter(child: SizedBox(height: 16,)),

                    ],
                  ),
                ),
              );
            });
          },
        )
    );
  }

  Future<void> refreshList(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
