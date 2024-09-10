
import 'dart:io';

import 'package:eatonomy/Constants/Strings/app_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../../Config/text_style.dart';
import '../../Data/Model/Auth/OtpResponse.dart';

import '../../Getx Injection/getx_dependenci_injection.dart' as di;
import '../../Data/Model/Auth/ForgetPasswordResponse.dart';
import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Getx Injection/getx_dependenci_injection.dart';
import '../../Network/api_client.dart';
import '../../Repository/AuthRepository/AuthRepository.dart';
import 'package:image/image.dart' as Img;

import '../../Service/LocalDataBase/localdata.dart';
import '../Chef/ChefController.dart';
import '../Home/HomeController.dart';


class AuthController extends GetxController with GetTickerProviderStateMixin implements GetxService {
  final AuthRepository? authRepository;
  AuthController({ this.authRepository});

    final circuler=false.obs;
    final tokenReseting=false.obs;
    final updateCirculer=false.obs;
  var localBd=getIt<LocalDataGet>();
  final count = 0.obs;
  final otpText = "".obs;

  increment() {
    count.value++;
    authRepository!.getCheck();
  }
  final fisrtname="".obs;
  final lastName="".obs;
  final name="".obs;
  final number="".obs;
  final image="".obs;
  final imageUrl="".obs;

  TabController? tabController;
 final index=0.obs;


 @override
  void onClose() {
    // TODO: implement onClose
   tabController!.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(_handleTabSelection);
    index.value=0;
    fisrtname.value="";
    lastName.value="";
     name.value="";
     number.value="";
     image.value="";
     filePath.value="";
    imageUrl.value="";
    super.onInit();
  }

  _handleTabSelection() {
    if (tabController!.indexIsChanging) {

        index.value=tabController!.index;
        Logger().e(index.value);
        update();

    }
  }

  Future<OtpResponse?> otpGet(String email)  async{
    circuler.value=true;
    OtpResponse? data;
    await authRepository?.otpGet(email).then((value){
      circuler.value=false;
      data=value;
    });
    return data!;
  }
  Future<OtpResponse?> checkUserExist(String email,phone)  async{
    circuler.value=true;
    OtpResponse? data;
    await authRepository?.checkUserExist(email,phone).then((value){
      circuler.value=false;
      data=value;
    });
    return data!;
  }

 Future<LoginResponse?> SignUp({
     String? mobile,  String? email,
     String? otp,String? name,String? image,String? address,
     String? city,String? zipcode,}) async{

    circuler.value=true;
    LoginResponse? data;
   await authRepository?.SignUp(iamge: imageUrl.value,mobile: mobile!,email: email,otp: otp,image: imageUrl.value,
       name:name,address: address,city: city,zipcode: zipcode
   ).then((value){
     circuler.value=false;
     data=value;
     Logger().w(data!.message!);
   });
    return data!;
  }

  Future<LoginResponse?>  signinFun({required String email, required String otp,bool? isChef}) async{
    circuler.value=true;
    LoginResponse? data;
    await authRepository?.signinFun(email,otp,isChef).then((value) async {
      circuler.value=false;
      data=value;
      ///update bearer token in api client
      ///update dependencies
      injection();
      // await di.init();
      Logger().w(data!.message!);
    });
    return data!;
  }

  Future<ForgetPasswordResponse?> resetPassword({String? email}) async{
    circuler.value=true;
    ForgetPasswordResponse? data;
    await authRepository?.resetPassword(email!).then((value){
      circuler.value=false;
      data=value;
      Logger().w(value.success);
    });
    return data!;
  }


  final filePath="".obs;
  File? file;

  Future<File?> filepic()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      File filer = File(result.files.single.path!);
      filePath.value=result.files.single.path!;
      circuler.value=true;
      reduceImageSize(filer).then((value){
        return value;
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

    authRepository!.uploadImage(file).then((value){
      circuler.value=false;
      if(value!.url!=null){
        imageUrl.value=value.url!;
      }else{
        imageUrl.value="https://via.placeholder.com/34x34";
      }
    });

    return reducedFile;
  }





  Future<ForgetPasswordResponse?> passwordChange(String old, String newP, String confrim)  async{
    circuler.value=true;
    ForgetPasswordResponse? data;
    await authRepository?.passwordChange(old,newP,confrim).then((value){
      circuler.value=false;
      data=value;
      Logger().w(value.success);
    });
    return data!;
  }

  Future updateUser({String? mobile,   String? email,  String? zipcode,
    String? city,  String? address, String? name, required BuildContext context})async {
    circuler.value=true;
    // value.email=email;
    // token: value.token,name: value.name,
    // mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId
    //
    await authRepository?.updateUser(iamge: imageUrl.value,mobile: mobile!,email: email,image: imageUrl.value,
        name:name,address: address,city: city,zipcode: zipcode
    ).then((value){

      Get.find<HomeController>().chefId.value = "";
      // Get.find<HomeController>().switchToUser(context);
      signinFun(email: email!, otp: "54321").then((value)async{
        await localBd.storeTokenUserdata(email: value!.email,token: value.token,name: value.name,
            mobile: value.mobileNumber,role:value.type,image: value.profilePicture,chefId: value.chefId).then((valuex) async {
          circuler.value=true;
          ///update dependence api service token update
          updateDependency();
          injection();
          init();

          Future.delayed(Duration(seconds: 10),(){
            circuler.value=false;
            Get.snackbar("Successfully", "Updated your profile",backgroundColor: Colors.green,colorText: Colors.white,borderRadius: 8);
            Navigator.pop(context);
            Get.find<HomeController>().selectedIndex.value=0;
            Future.delayed(Duration.zero,()=> Get.find<HomeController>().onInit());
            Get.find<ChefController>().getUserDetails();
          });

        });
      });
      Logger().w(value!.message!);
    });
  }


  Future deleteAccount(BuildContext context) async{
    circuler.value=true;
    await authRepository?.deleteAccount().then((value) async {
      if(value.statusCode==200){
        var users = await Hive.openBox('users');
        users.clear().then((value) {
          injection();
          init();
        });
        Future.delayed(Duration(seconds: 10),(){
          circuler.value=false;
          Navigator.pushNamedAndRemoveUntil(context, LOGIN_PAGE_INTRO, (route) => false);
        });
      }else{
        Get.snackbar("Failed", value.message!,backgroundColor: Colors.redAccent);
      }
    });
  }
}