import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:eatonomy/Data/Model/Chat/ChatResponse.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as Img;
import '../../Data/Model/Chat/Chat.dart';
import '../../Data/Model/Chat/ChatLocal.dart';
import '../../Data/Model/Location/LocationModel.dart';
import '../../Repository/ChefRepository/ChefRepository.dart';
import '../../Repository/OrderRepository/order_repository.dart';
import '../../Service/LocalDataBase/localdata.dart';

class ChatController extends GetxController implements GetxService{
  final OrderRepository? orderRepository;


  ChatController({this.orderRepository});

  final count = 0.obs;
  Rx<LocationModel?>  location=Rx<LocationModel?>(null);

  ScrollController scrollController = ScrollController();
  RxList<String>? listOfAction=<String>[].obs;
  RxList<ChatModel> chatList=<ChatModel>[].obs;

  final name = "".obs;
  final mobile = "".obs;
  final role = "".obs;
  final userImage = "".obs;




  @override
  void onInit() {
    name.value='';
    mobile.value='';
    role.value='';
    userImage.value='';
    imageUrl.value="";
    getToken().then((value){
      name.value= value.get('name');
      mobile.value= value.get('mobile');
      // Logger().e(value.get('chefId'));
      if(value.get('role')==null){
        role.value= "";
      }else{
        role.value= value.get('role');
      }
      if(value.get('image')==null){
        userImage.value= "";
      }else{
        userImage.value= value.get('image');
      }


    });
    // TODO: implement onInit
    listOfAction!.value.add("Yes, Available");
    listOfAction!.value.add("Select your time");
    listOfAction!.value.add("Select Location");
    listOfAction!.value.add("My Conditions");
    listOfAction!.value.add("Your menu bills");
    listOfAction!.value.add("Your order confirmed");
    listOfAction!.value.add("Your order delivered");

    // chatList.value.add(ChatModel(sender: true,text: "siss",type:ChatType.Text ));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.YesAvailable));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.SelectLocation));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.Selectyourtime));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.MyConditions));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.Yourmenubills));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.Yourorderconfirmed));
    // chatList.value.add(ChatModel(sender: true,text: "sifat jsnjsns",type: ChatType.Yourorderdelivered));
    //
    //
    // chatList.value.add(ChatModel(sender: false,text: "siss",type:ChatType.Text ));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.YesAvailable));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.SelectLocation));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.Selectyourtime));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.MyConditions));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.Yourmenubills));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.Yourorderconfirmed));
    // chatList.value.add(ChatModel(sender: false,text: "sifat jsnjsns",type: ChatType.Yourorderdelivered));
    //




    Future.delayed(Duration.zero,(){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
    super.onInit();
  }


  getToken() async {
    var tokenx = await LocalDataGet().getData();
    return tokenx;
  }


  Rx<ChatResponse?>  chatHistoryResponse=Rx<ChatResponse?>(null);
  final orderChatHistoryCirculer=false.obs;

  Future orderChatHistory({String? order})async {
    orderChatHistoryCirculer.value=true;
    chatHistoryResponse.value=null;
    await orderRepository?.orderChatHistory(order).then((value){
      orderChatHistoryCirculer.value=false;
      if(value!.statusCode==200){
        chatHistoryResponse.value=value;
        chatList.clear();
        for(var i=0; i<value.chats!.length;i++){
          Logger().w(mobile.value);
          Logger().w(value.chats![i].sender!.mobileNumber);
          Logger().w(value.chats![i].sender!.mobileNumber==mobile.value);
          chatList.add(
              ChatModel(
                date: value.chats![i].createdAt??"",
                  text:value.chats![i].message??"",
                  sender: value.chats![i].sender!.mobileNumber==mobile.value,
                profilepic: value.chats![i].sender!.profilePicture??"",
                type: value.chats![i].type=="string"?ChatType.Text:ChatType.Image
              )
          );

          Logger().e(value.chats![i].sender!.profilePicture);
        }


      }else{

      }
    });
  }

  Future sendMsg({String? orderId, String? msg,String? type}) async{
    await orderRepository?.orderChatSend(orderId:orderId,message:msg,type:type).then((value){
    // orderChatHistoryCirculer.value=false;
    if(value!.statusCode==200){
    // orderMenuFullHistoryResponse.value=value;

    }else{

    }
    });
  }




  final filePath="".obs;
  final imageUrl="".obs;
  final circuler=false.obs;
  File? file;

  Future<File?> filepic({String? orderId})async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      imageUrl.value="";
      file=null;
      File filer = File(result.files.single.path!);
      filePath.value=result.files.single.path!;
      circuler.value=true;
      reduceImageSize(filer,orderId).then((value){
        return value;
      });
    } else {
      // User canceled the picker
    }
  }
  Future<File> reduceImageSize(File imageFile, String? orderId) async {
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

    orderRepository!.uploadImage(file).then((value){
      circuler.value=false;
      if(value!.url!=null){
        imageUrl.value=value.url!;
        sendMsg(orderId:orderId,msg:imageUrl.value,type: "image");
        chatList.add(
            ChatModel(
                text: imageUrl.value,
                sender: true,
                profilepic: userImage.value,
                type: ChatType.Image
            )
        );
      }else{
        // imageUrl.value="https://via.placeholder.com/34x34";
        Get.snackbar("Something Wrong", "Try again to send photo",backgroundColor: Colors.redAccent,colorText: Colors.white,padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6));
      }
    });
    return reducedFile;
  }



}