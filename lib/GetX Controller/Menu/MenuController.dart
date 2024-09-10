import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as Img;
import 'package:logger/logger.dart';

import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Data/Model/Menu/Feed.dart';
import '../../Data/Model/Menu/MenuResponse.dart';
import '../../Data/Model/Menu/WishResponse.dart';
import '../../Data/Model/User/Chef.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Repository/ChefRepository/ChefRepository.dart';
import '../../service/location_service.dart';
import '../Chef/ChefController.dart';
import '../Search/SearchControllerx.dart';

class MenuControllerx extends GetxController implements GetxService{

  ChefRepository? chefRepository;


  MenuControllerx({this.chefRepository});

  var locationService = getIt<LocationService>();
  Rx<LatLng?> latLng=Rx<LatLng?>(null);

  final   List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final cuisineListx = ["Bengali","Korean","Italian","Turkish","Mexican","Indian","Thai","Chinese",""];
  final cuisineList = ["Bengali","Korean","Italian","Turkish","Mexican","Indian","Thai","Chinese",];
  final currentIndex = 0.obs;
  final menuSelect = "menu".obs;
  List<String> homeFilterSelect = [];

  final image="".obs;
  final imageUrl="".obs;
  final menuIteamType = "".obs;
  final menuTitle = "".obs;

  final menuType = "".obs;
  final selectCuisine = "".obs;
  final menuPrice = "".obs;
  final menuDiscountPrice = "".obs;
  final menuIteam = [].obs;
  final orderTakingInstruction = "".obs;
  final orderDeliveryDay = "".obs;
  final orderDeliveryForm = "".obs;
  final orderDeliveryFormView = "".obs;
  final orderDeliveryTo = "".obs;
  final orderDeliveryToView = "".obs;
  final menuImages = [].obs;
  final menuIsDelivery = false.obs;
  final menuIspickup = false.obs;
  final hotDealAvailable = false.obs;
  final circuler = false.obs;
  final imageCirculer = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    menuSelect.value = "menu";
    menuTitle.value = "";
    selectCuisine.value = "";
    menuType.value = "Weekly";
    menuPrice.value = "";
    menuDiscountPrice.value = "";
    menuIteam.value = [];
    orderTakingInstruction.value = "";

    orderDeliveryDay.value = "";
    orderDeliveryForm.value = "";
    orderDeliveryTo.value = "";
    menuImages.value = [];
    menuIsDelivery.value = false;
    hotDealAvailable.value = false;
    imageCirculer.value=false;
    menuIspickup.value = false;
    locationService.getLocation().then((value){
      // latLng.value=LatLng(value!.latitude!,value.longitude!);
      // getFeedMenu(homeFilterSelect.value,true);
      // getnewChef(true);
    });
    super.onInit();
  }

  final filePath="".obs;
  File? file;

  Future<File?> filepic()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      File filer = File(result.files.single.path!);
      filePath.value=result.files.single.path!;
      imageCirculer.value=true;
      reduceImageSize(filer).then((value){
        if(value!=null){
          return value;
        }else{
          imageCirculer.value=false;
        }
      });


    } else {
      // User canceled the picker
    }
  }
  Future<File> reduceImageSize(File imageFile) async {
    Img.Image? image = Img.decodeImage(imageFile.readAsBytesSync());
    int width = image!.width;
    int height = image.height;
    if (width > 800 || height > 800) {
      double aspectRatio = width / height;
      if (width > height) {
        width = 800;
        height = (width / aspectRatio).round();
      } else {
        height = 800;
        width = (height * aspectRatio).round();
      }
      image = Img.copyResize(image, width: width, height: height);
    }
    File reducedFile = File(imageFile.path.replaceAll('.jpg', '_reduced.jpg'));
    reducedFile.writeAsBytesSync(Img.encodeJpg(image, quality: 75));
    file=reducedFile;

    chefRepository!.uploadImage(file).then((value){
      imageCirculer.value=false;
      if(value!.url!=null){
        menuImages.value.add(value.url!);
      }else{
        menuImages.value.add("https://via.placeholder.com/34x34");
      }
    });

    return reducedFile;
  }



  Future<LoginResponse?>  createMenu(BuildContext context,String? chefId) async{
    circuler.value=true;
    LoginResponse? data;
    await chefRepository?.createMenu(chefId: chefId,type: menuType.value,price:menuPrice.value ,
        images:List<String>.from(menuImages.value) ,
        isDeliveryAvailable: menuIsDelivery.value,
        isPickUpAvailable:menuIspickup.value ,
        menus:List<String>.from(menuIteam.value),
        deliveryDay:orderDeliveryDay.value,
        deliveryFrom:orderDeliveryForm.value,
        deliveryTo:orderDeliveryTo.value,
        orderTakingInstruction: orderTakingInstruction.value,title:menuTitle.value,
      discount: menuDiscountPrice.value,
      isHotDeal: hotDealAvailable.value,
      selectCuisine:selectCuisine.value
    ).then((value) async {
      circuler.value=false;
      data=value;
      if(value!.statusCode==200){
        // Get.snackbar("Done create", value.message!,backgroundColor: Colors.green,borderRadius: 4);

      }else{
        Get.snackbar("Some thing Wromh", value.message!,backgroundColor: Colors.red,borderRadius: 4);
      }

      Logger().w(data!.message!);
    });
    return data!;
  }


  final wishMenuId = "".obs;
  Future<LoginResponse?>  addWishListMenu(
      {BuildContext? context, String? id,String? chefId,bool? isFeed}) async{
    wishMenuId.value=id!;
    LoginResponse? data;
    isFeed!?
    list!.where((element) => element.menu!.id==id).first.alreadyInWishList=true:null;
    update();
    circuler.value=true;
    await chefRepository?.addWishListMenu(id).then((value) async {
      circuler.value=false;
      data=value;
      if(value!.statusCode==200){
        Get.find<SearchControllerx>().searchMenu();
        if(chefId!=null){
          Get.find<ChefController>().getChefDetails(chefId);
        }
        // Get.snackbar("Successfully", "Added to Wish List",backgroundColor: Colors.green,colorText: Colors.white,borderRadius: 4,padding: EdgeInsets.all(12));
        // getFeedMenu(homeFilterSelect.value,true);
      }else{
        Get.snackbar("Some thing Wrong", value.message!,backgroundColor: Colors.red,colorText: Colors.white,borderRadius: 4,padding: EdgeInsets.all(12));
      }

      Logger().w(data!.message!);
    });
    return data!;
  }

  Future<LoginResponse?>  removeWishListMenu(
      {BuildContext? context, String? id, String? chefId,bool? isFeed}) async{
    LoginResponse? data;
    isFeed!?
    list!.where((element) => element.menu!.id==id).first.alreadyInWishList=true:null;
    update();
    circuler.value=true;
    wishMenuId.value=id!;
    await chefRepository?.removeWishListMenu(id).then((value) async {
      circuler.value=false;
      data=value;
      if(value!.statusCode==200){
        Get.find<SearchControllerx>().searchMenu();
        if(chefId!=null){
          Get.find<ChefController>().getChefDetails(chefId);
        }
        // Get.snackbar("Successfully", "Remove to Wish List",backgroundColor: Colors.green,colorText: Colors.white,borderRadius: 4,padding: EdgeInsets.all(12));
        getFeedMenu(homeFilterSelect,true);
      }else{
        Get.snackbar("Some thing Wrong", value.message!,backgroundColor: Colors.red,colorText: Colors.white,borderRadius: 4,padding: EdgeInsets.all(12));
      }

      Logger().w(data!.message!);
    });
    return data!;
  }


  ///=========Feed with pagination========///////
  final circle = false.obs;

  List<Feed>? list = null;
  ScrollController controller = ScrollController();
  int listLength = 2;
  int page = 0;
  final feedPagingCirculer=false.obs;
  Rx<MenuResponse?>  menuResponse=Rx<MenuResponse?>(null);
  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        Logger().w("call");
        listLength++;
        page++;
        getFeedPagingData(page: page.toString());
        update();
      }
    });
  }

  Future<MenuResponse?>  getFeedMenu(List<String> url,bool isFirstr) async{
    circuler.value=true;
    circle.value=true;
    list=[];
    page=0;
    if(isFirstr){
      addItems();
    }
    await chefRepository?.feedMenu(
      "10",
      '0',
      homeFilterSelect,
        latLng.value
    ).then((value) {
      circuler.value=false;
      circle.value=false;
      if(value.statusCode==200){
        menuResponse.value=value;
        for(var i=0;i<value.feeds!.length;i++){
          list!.add(value.feeds![i]);
        }
      }
    });
  }

  getFeedPagingData({String? page}) async{
    feedPagingCirculer.value=true;
    await chefRepository!.feedMenu(
      '10',
      page??'0',
      homeFilterSelect,
      latLng.value

    ).then((value){
      for(var i=0;i<value.feeds!.length;i++){
        list!.add(value.feeds![i]);
      }
      update();
      feedPagingCirculer.value=false;
    });

  }

///=========Feed with pagination========///////






  ///=========New Chef with pagination========///////
  final recentCgefcirculer = false.obs;
  List<Chef> chefList = [];
  ScrollController chefController = ScrollController();
  int chefListLength = 2;
  int chefPage = 0;
  final chefPagingCirculer=false.obs;

  chefAddItems() async {
    chefController.addListener(() {

      if (chefController.position.maxScrollExtent == chefController.position.pixels) {
        Logger().w("call");
        chefListLength++;
        chefPage++;
        getChefPagingData(chefPage: chefPage.toString());
        update();
      }
    });
  }

  Future<MenuResponse?>  getnewChef(bool isFirstr) async{
    recentCgefcirculer.value=true;
    chefList.clear();
    chefPage=0;
    if(isFirstr){
      chefAddItems();
    }
    await chefRepository?.getnewChef(
        "10",
        '0',

    ).then((value) {
      recentCgefcirculer.value=false;
      if(value.statusCode==200){

        for(var i=0;i<value.chefs!.length;i++){
          chefList.add(value.chefs![i]);
        }
      }
    });
  }

  getChefPagingData({String? chefPage}) async{
    chefPagingCirculer.value=true;
    await chefRepository!.getnewChef(
        '10',
      chefPage??'0',
    ).then((value){
      for(var i=0;i<value.chefs!.length;i++){
        chefList.add(value.chefs![i]);
      }
      update();
      chefPagingCirculer.value=false;
    });

  }

///=========Feed with pagination========///////





///=========WishList with pagination========///////


  final wishcirculer = false.obs;
  List<Feed> wishList = [];
  ScrollController wishController = ScrollController();
  int wishListLength = 2;
  int wishPage = 0;
  final wishPagingCirculer=false.obs;


  wishAddItems() async {
    wishController.addListener(() {
      if (wishController.position.maxScrollExtent == wishController.position.pixels) {
        Logger().w("call");
        wishListLength++;
        wishPage++;
        getwishPagingData(wishPage: wishPage.toString());
        update();
      }
    });
  }

  Future<WishResponse?>  getWishList({bool? isFirst}) async{
    wishcirculer.value=true;
    wishList.clear();
    wishPage=0;
    if(isFirst!){
      wishAddItems();
    }
    await chefRepository?.getWishList(
      "10",
      '0',

    ).then((value) {
      wishcirculer.value=false;
      if(value.statusCode==200){

        for(var i=0;i<value.follows!.length;i++){
          wishList.add(value.follows![i]);
        }
      }
    });
  }

  getwishPagingData({String? wishPage}) async{
    wishPagingCirculer.value=true;
    await chefRepository!.getWishList(
      '10',
      wishPage??'0'
    ).then((value){
      for(var i=0;i<value.follows!.length;i++){
        wishList.add(value.follows![i]);
      }
      update();
      wishPagingCirculer.value=false;
    });

  }

///=========WishList with pagination========///////

  Future<LoginResponse?>  updateMenu(BuildContext context,String? id) async{
    circuler.value=true;
    LoginResponse? data;
    await chefRepository?.updateMenu(menuId: id,type: menuType.value,price:menuPrice.value ,
        images:List<String>.from(menuImages.value) ,isDeliveryAvailable: menuIsDelivery.value,
        isPickUpAvailable:menuIspickup.value ,
        menus:List<String>.from(menuIteam.value),
        deliveryDay:orderDeliveryDay.value,
        deliveryFrom:orderDeliveryForm.value,
        deliveryTo:orderDeliveryTo.value,
        orderTakingInstruction: orderTakingInstruction.value,title:menuTitle.value,
        discount: menuDiscountPrice.value,
        isHotDeal: hotDealAvailable.value,
        selectCuisine:selectCuisine.value
    ).then((value) async {
      circuler.value=false;
      data=value;
      if(value!.statusCode==200){
        // Get.snackbar("Done Update", value.message!,backgroundColor: Colors.green,borderRadius: 4);

      }else{
        Get.snackbar("Some thing Wromh", value.message!,backgroundColor: Colors.red,borderRadius: 4);
      }

      Logger().w(data!.message!);
    });
    return data!;
  }
}