import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../Config/text_style.dart';
import '../../Constants/Colors/app_colors.dart';
import '../../Constants/Strings/app_strings.dart';
import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Data/Model/Location/LocationModel.dart';
import '../../Data/Model/User/ChefData.dart';
import '../../Data/Model/User/ChefRresponse.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Getx Injection/getx_dependenci_injection.dart';
import '../../Network/api_client.dart';
import '../../Presentation/Widgets/Button/custom_button.dart';
import '../../Repository/AuthRepository/AuthRepository.dart';
import '../../Service/LocalDataBase/localdata.dart';
import '../AuthController/AuthController.dart';
import '../Chef/ChefController.dart';

class HomeController extends GetxController implements GetxService{
  final AuthRepository? authRepository;

  HomeController({this.authRepository});


  final  selectedIndex = 0.obs;
  final PageController pageController=PageController();

  final brand = "".obs;
  final deviceId = "".obs;
  final devicetype = "".obs;
  final firebasetoken = "".obs;

  final name = "".obs;
  final token = "".obs;

  final notificationResister = "".obs;
  final chefId = "".obs;
  final userImage = "".obs;
  final email = "".obs;
  final role = "".obs;
  final selectedShop = "".obs;
  final selectedShopImage = "".obs;
 Rx<LocationModel?>  location=Rx<LocationModel?>(null);


  void onItemTapped(int index) {
      selectedIndex.value = index;
      // pageController.jumpToPage(index);
      update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController.dispose();
    super.onClose();
  }

 @override
  void onInit() {
    // TODO: implement onInit
   Permission.notification.isDenied.then((value) {
     if (value) {
       Permission.notification.request();
     }
   });
   name.value='';
   token.value='';
   chefId.value='';
   notificationResister.value='';
   userImage.value='';
   selectedShop.value='';
   selectedShopImage.value='';
     getToken().then((value){
       name.value= value.get('name');
       notificationResister.value= value.get('notificationResister');
       // Logger().e(value.get('chefId'));
       if(value.get('token')==null){
         token.value= "";
       }else{
         token.value= value.get('token');
       }
       if(value.get('chefId')==null){
         chefId.value= "";
       }else{
         chefId.value= value.get('chefId');
       }


       if(value.get('role')==null){
         role.value="";
       }else{
         role.value=value.get('role');
       }

       if(value.get('image')==null){
         userImage.value= "";
       }else{
         userImage.value= value.get('image');
       }
       if(value.get('email')==null){
         email.value= "";
       }else{
         email.value= value.get('email');
       }

       if(notificationResister.value=="none"){
         getDeviceInfo();
       }
     });

    super.onInit();
  }


  Future requestPermission(BuildContext context) async {
    FirebaseMessaging messaging = await FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Logger().e('User authorized notifications');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      Logger().e('User authorized notifications provisionnal');
    } else {
      Logger().e('User declined notifications');
      if(Platform.isAndroid){
        showAlertDialog(context);
      }
    }
  }

  void getDeviceInfo()async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if(Platform.isAndroid){
     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
     brand.value=androidInfo.model;
     devicetype.value="android";
   }else if(Platform.isIOS){
     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
     brand.value=iosInfo.model;
     devicetype.value="ios";

     // print('Running on ${iosInfo.utsname.machine}');
   }
    try {
      deviceId.value = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      deviceId.value = 'Failed to get Unique Identifier';
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Logger().e('Running on ${fcmToken}');
    await authRepository!.registerNotification(deviceId:deviceId.value ,deviceType:devicetype.value ,model:brand.value ,pushToken:fcmToken ).then((value) {
      if(value.statusCode==200){
        Box? users= Hive.box('users');
        users.put("notificationResister", "done");
        // Get.snackbar("update", "Device Token",backgroundColor: Colors.green);

      }
    });



  }

  getToken() async {
    var tokenx = await LocalDataGet().getData();
    return tokenx;
  }


  Rx<ChefRresponse?>  shopList=Rx<ChefRresponse?> (null);
  final shopChircule=false.obs;
  Future getShopList()async {
    shopChircule.value=true;
    await authRepository!.getShopList().then((value) {
      if(value.statusCode==null||value.statusCode!=200){
        Logger().e("error");
        Logger().e(token.value);
        if(token.value!=""){
          updateDependency();
          injection();
          init();
        }
        Future.delayed(Duration(seconds: 4),(){
          if(role.value!="CHEF"&& role.value!=""){
            getShopList();
          }
        });


      }else{
        shopList.value=value;
        // shopList.value!.chefAdmins!.insert(0, shopList.value!.chefAdmins![0]);
        // shopList.value!.chefAdmins!.insert(value.chefAdmins!.length, shopList.value!.chefAdmins![0]);
        getSelectedShopNameImage();
      }
      shopChircule.value=false;

    });
  }

  var localBd=getIt<LocalDataGet>();
  final shopswitchChircule=false.obs;
  Future switchToShop(String? id,BuildContext context) async{
    shopswitchChircule.value=true;
    await authRepository!.switchToShop(id).then((value) async {
      if(value.statusCode==200){
        await localBd.storeTokenUserdata(email: value.email,token: value.token,name: value.name,
            mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId).then((value){
          updateDependency();
          Future.delayed(Duration(seconds: 10),(){
            shopswitchChircule.value=false;
            Get.find<ChefController>().circleUpdateChef.value=false;
            selectedIndex.value=2;
            Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE,(route) => false,);
          });
        });
      }else{
        Get.snackbar(
            backgroundColor: Colors.redAccent,
            borderRadius: 4,
            "Something Wriong", value.message!);
      }

    });
  }

  getSelectedShopNameImage(){
    if(chefId.value.isNotEmpty){
      Get.find<ChefController>().getChefDetails(chefId.value).then((value){
        var chef=Get.find<ChefController>().chefDetailsResponse.value;

        Logger().e(chef);
        Logger().e(chef!.chef!.name!);
        selectedShop.value=chef.chef!.name!;

        selectedShopImage.value=chef.chef!.profilePicture!;
      });

    }else{
      selectedShop.value='';
      selectedShopImage.value='';
    }
  }

  Future<LoginResponse?> switchToUser(BuildContext context)async {
    shopswitchChircule.value=true;
    await authRepository!.switchToUser().then((value) async {
      if(value.statusCode==200){
        await localBd.storeTokenUserdata(email: value.email,token: value.token,name: value.name,
            mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId).then((value){
          updateDependency();
          Future.delayed(Duration(seconds: 10),(){
            shopswitchChircule.value=false;
            Get.find<AuthController>().circuler.value=false;
            selectedIndex.value=0;
            Navigator.pushNamedAndRemoveUntil(context, MAIN_PAGE,(route) => false,);
          });

          // injection();
          // getIt<ApiClient>().update();
          // init();

        });


      }else{
        Get.snackbar(
            backgroundColor: Colors.redAccent,
            borderRadius: 4,
            "Something Wriong", value.message!);
      }

    });

    return null;
  }


  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            height: 48.h,
            orderRadius: 4,
            width: 120,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: true,
            title: "Cancel",
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(width: 12,),
        CustomButton(
            height: 48.h,
            width: 120,
            orderRadius: 4,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: false,
            title: "App Settings",
            onTap: () async {
              Navigator.pop(context);
              await  openAppSettings();
            })
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text("Permission Need", style: boldText(20.sp, color: kPrimaryColorx),
        textAlign: TextAlign.center,),
      content: SizedBox(
          width: 300,
          child: Text(
              "To gain more benefits, grant notification permission by navigating to your app settings and enabling notifications.", style: regularText(15.sp,),
              textAlign: TextAlign.center)),
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