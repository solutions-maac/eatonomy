import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


import 'package:image/image.dart' as Img;
import '../../Constants/Colors/app_colors.dart';
import '../../Data/Model/Auth/OtpResponse.dart';
import '../../Data/Model/Order/Order.dart';
import '../../Data/Model/Order/OrderDetailsResponse.dart';
import '../../Data/Model/Order/OrderMenuResponse.dart';
import '../../Data/Model/Order/OrderResponse.dart';
import '../../Presentation/Widgets/Button/custom_button.dart';
import '../../Presentation/Widgets/TextField/bg_textfield.dart';
import '../../Presentation/Widgets/TextField/text_field_reamarks.dart';
import '../../Repository/OrderRepository/order_repository.dart';
import '../../Repository/SliderRepository/slider_repository.dart';
import '../../Service/LocalDataBase/localdata.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepository? orderRepository;

  OrderController({ this.orderRepository});

  final rejectType = ["Capacity issue","Distance for delivery","Unwell","Request another delivery slot"];

  final orderQty = 0.obs;
  final rating1 = 0.obs;
  final rating2 = 0.obs;
  final rating3 = 0.obs;
  final rating4 = 0.obs;
  final deliveryAdress = "".obs;
  final role = "".obs;
  final chefId = "".obs;
  final orderDeliveryCharge = 0.00.obs;
  final orderPaymentNote = "".obs;
  final orderSupportText = "".obs;
  final orderPaymentImage = "".obs;
  final selectRejectType = "".obs;


  final deliveryOption = "".obs;
  final menuIsDelivery = false.obs;
  final dateTimeRejctClick = false.obs;
  final dateTimeAcceptClick = false.obs;
  final menuIspickup = false.obs;
  final circuler = false.obs;
  final imageCirculer = false.obs;
  final status = "".obs;
  final comment = "".obs;

  final orderDelivryTime ="".obs;
  final orderFromTimex ="".obs;
  final orderToTimex ="".obs;





  @override
  void onInit() {
    dateTimeRejctClick.value=false;
    dateTimeAcceptClick.value=false;
    orderQty.value=0;
    orderSupportText.value="";
    orderDelivryTime.value="";
    selectRejectType.value="";
    orderFromTimex.value="";
    orderToTimex.value="";
    chefId.value="";
    rating1.value=0;
    rating2.value=0;
    rating3.value=0;
    rating4.value=0;
    orderDeliveryCharge.value=0.00;
    orderPaymentNote.value="";
    filePath.value="";
    comment.value="";
    orderPaymentImage.value="";
    deliveryAdress.value="";
    deliveryOption.value="";
    status.value="PROCESSING";//Cancel and Completed
    circuler.value=false;
    orderAceptedcirculer.value=false;
    menuIsDelivery.value=false;
    menuIspickup.value=false;

    getToken().then((value){
      role.value= value.get('role');
      chefId.value= value.get('chefId');
    });
    super.onInit();
  }

  getToken() async {
    var tokenx = await LocalDataGet().getData();
    return tokenx;
  }


  ///image upload
  final filePath="".obs;
  File? file;

  Future<File?> filepic()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      File filer = File(result.files.single.path!);
      imageCirculer.value=true;
      reduceImageSize(filer).then((value){
        return value;
      });
      update();
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

    orderRepository!.uploadImage(file).then((value){
      imageCirculer.value=false;
      if(value!.url!=null){
        filePath.value=file!.path;
        orderPaymentImage.value=value.url!;
      }else{
        orderPaymentImage.value="https://via.placeholder.com/34x34";
      }

      update();

    });

    return reducedFile;
  }




  Rx<OtpResponse?>  otpResponse=Rx<OtpResponse?>(null);
  Future<OrderDetailsResponse?> createOrder({String? id}) async{
    circuler.value=true;
    orderDetailsResponse.value=null;
   await orderRepository!.createOrder(
     id:id ,
     deliveryoption: deliveryOption.value,
     address: deliveryAdress.value,
     qty: orderQty.value,
     fromTime:  orderDelivryTime.value.split("-")[0],
     toTime:  orderDelivryTime.value.split("-")[1],
   ).then((value) {
     circuler.value=false;
     orderDetailsResponse.value=value;
   });
   return orderDetailsResponse.value;
  }




  ///=========Feed with pagination========///////
  final circle = false.obs;

  List<Order> list = [];
  ScrollController controller = ScrollController();
  int listLength = 2;
  int page = 0;
  final orderPagingCirculer=false.obs;
  Rx<OrderResponse?>  orderResponse=Rx<OrderResponse?>(null);
  addItems({bool? isChef}) async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        Logger().w("call");
        listLength++;
        page++;
        getFeedPagingData(page: page.toString(),isChef: isChef);
        update();
      }
    });
  }

  Future<OrderResponse?>  orderHistory({bool? isFirstr,bool? isChef=false}) async{
    circuler.value=true;
    circle.value=true;
    list.clear();
    page=0;
    if(isFirstr!){
      addItems(isChef: isChef);
    }
    await orderRepository?.orderHistory(
        "10",
        '0',
        status.value,
        isChef
    ).then((value) {
      circuler.value=false;
      circle.value=false;
      if(value.statusCode==200){

        for(var i=0;i<value.orders!.length;i++){
          list.add(value.orders![i]);
        }
      }
    });
  }

  getFeedPagingData({String? page,bool? isChef}) async{
    orderPagingCirculer.value=true;
    await orderRepository?.orderHistory(
        "10",
        page!,
        status.value,
        isChef
    ).then((value){
      for(var i=0;i<value.orders!.length;i++){
        list.add(value.orders![i]);
      }
      update();
      orderPagingCirculer.value=false;
    });

  }



  ///=========Feed with pagination========///////


  Rx<OrderDetailsResponse?>  orderDetailsResponse=Rx<OrderDetailsResponse?>(null);
  Future<OrderDetailsResponse?> orderDetails(String? ordrId)async {
    circuler.value=true;
    orderDetailsResponse.value=null;
    await orderRepository?.orderDetails(ordrId).then((value){
      circuler.value=false;
      orderDetailsResponse.value=value;


    });
  }


  final orderAceptedcirculer = false.obs;
  Future oderAccepted(String? ordrId)async {
    orderAceptedcirculer.value=true;
    await orderRepository?.oderAccepted(ordrId,orderDeliveryCharge.value).then((value){
      orderAceptedcirculer.value=false;
      onInit();
      orderDetails(ordrId);

    });
  }
  Future oderCancel(String? ordrId)async {
    orderAceptedcirculer.value=true;
    await orderRepository?.oderCancel(ordrId,).then((value){
      orderAceptedcirculer.value=false;
      onInit();
      orderDetails(ordrId);

    });
  }
  Future rejectOrder(String? ordrId)async {
    orderAceptedcirculer.value=true;
    await orderRepository?.rejectOrder(ordrId,selectRejectType.value).then((value){
      orderAceptedcirculer.value=false;
      onInit();
      orderDetails(ordrId);

    });
  }

  final orderSupportcirculer = false.obs;
  Future  sendSuport(String? ordrId,type)async {
    orderSupportcirculer.value=true;
    await orderRepository?.sendSuport(ordrId,type,orderSupportText.value,orderPaymentImage.value).then((value){
      orderSupportcirculer.value=false;
      onInit();
      orderDetails(ordrId);

    });
  }

  Future chnageTime(String? orderId, String from, String to)async {
    orderAceptedcirculer.value=true;
    await orderRepository?.chnageTime(orderId!,from,to).then((value){
      orderAceptedcirculer.value=false;
      onInit();
      orderDetails(orderId!);

    });
  }

  final orderPaymentRequestcirculer = false.obs;
  Future oderpaymenrResquest(String? ordrId) async{
    orderPaymentRequestcirculer.value=true;
    await orderRepository?.oderpaymenrResquest(ordrId,orderPaymentNote.value,orderPaymentImage.value).then((value){
    orderPaymentRequestcirculer.value=false;
    onInit();
    orderDetails(ordrId);

    });
  }

  final orderPaymentAceptedcirculer = false.obs;
  Future oderPaymentAccepted(String? ordrId) async{
    update();
    orderPaymentAceptedcirculer.value=true;
    await orderRepository?.oderPaymentAccepted(ordrId).then((value){
      orderPaymentAceptedcirculer.value=false;
      update();
    onInit();
    orderDetails(ordrId);

    });
  }

  final orderReadyForcirculer = false.obs;
  Future oderReadyFor(String? ordrId) async{
    orderReadyForcirculer.value=true;
    update();
    await orderRepository?.oderReadyFor(ordrId).then((value){
      orderReadyForcirculer.value=false;
    onInit();
      update();
    orderDetails(ordrId);

    });
  }


  final orderCompletecirculer = false.obs;
  Future oderComplete(String? ordrId, BuildContext context) async{
    orderCompletecirculer.value=true;
    await orderRepository?.oderComplete(ordrId).then((value){
      orderCompletecirculer.value=false;
      onInit();
      orderDetails(ordrId);

    });
  }


  Future oderAcceptedbyCustome({String? ordrId, BuildContext? context}) async{
    orderCompletecirculer.value=true;
    update();
    await orderRepository?.oderAcceptedbyCustome(ordrId).then((value){
      orderCompletecirculer.value=false;
      onInit();
      update();
      showRateNowAlertDialog(context: context,orderid: ordrId);
      // showAlertDialog(context!,ordrId);
      orderDetails(ordrId);

    });
  }


  final orderReviewcirculer = false.obs;
  final selectOrderId = "".obs;
  Future submitReview(String? ordrId) async{
    orderReviewcirculer.value=true;
    selectOrderId.value=ordrId!;
    await orderRepository?.submitReview(
        ordrId: ordrId,
        commenet: comment.value,
        rarting1: rating1.value,
        rarting2: rating2.value,
        rarting3: rating3.value,
        rarting4: rating4.value
    ).then((value){
      orderReviewcirculer.value=false;
      if(value!.statusCode==200){
        // Get.find<OrderController>().status.value="COMPLETED";
        Get.find<OrderController>().orderHistory(isFirstr: true);
        orderDetails(ordrId);
        // Get.snackbar(
        //     backgroundColor:kPrimaryColorx,
        //     borderRadius: 4,
        //     "Successfully add", value.message!);
      }else{
        Get.snackbar(
            backgroundColor:  Colors.red,
            borderRadius: 4,
            "Something Wrong", value.message!);
      }

      onInit();
    });
  }



  Future chefSubmitReview(String? ordrId) async{
    orderReviewcirculer.value=true;
    selectOrderId.value=ordrId!;
    await orderRepository?.chefSubmitReview(ordrId,comment.value,rating1.value).then((value){
      orderReviewcirculer.value=false;
      orderCompletecirculer.value=false;
      onInit();
      orderDetails(ordrId);
      if(value!.statusCode==200){

        // Get.snackbar(
        //     backgroundColor:kPrimaryColorx,
        //     borderRadius: 4,
        //     "Successfully add", value.message!);
      }else{
        Get.snackbar(
            backgroundColor:  Colors.red,
            borderRadius: 4,
            "Something Wrong", value.message!);
      }

      onInit();
    });
  }



  showAlertDialog(BuildContext context, String? orderid) {
    // set up the AlertDialog
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            height: 38,
            orderRadius: 4,
            width: 120,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: true,
            title: "Cancel",
            onTap: () {
              // chefSubmitReview(orderid);
              orderCompletecirculer.value=false;
              Navigator.pop(context);
              Navigator.pop(context);
            }),
        SizedBox(width: 12,),
        CustomButton(
            height: 38,
            width: 120,
            orderRadius: 4,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: false,
            title: "Okay",
            onTap: () {
              chefSubmitReview(orderid);
              Navigator.pop(context);
            })
      ],
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        height: 130,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rate This Order',
                  style: TextStyle(
                    color: Color(0xFF01180D),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8,),
                BackgroundTextfield(
                  controller: null,
                  readOnly: false,
                  isNumber: false,
                  isemail: true,
                  hintText: "Enter Review",
                  isValueChnged: true,
                  tap: (text) {
                    if (text.isNotEmpty) {
                      comment.value = text;
                    } else {
                      comment.value = "";
                    }
                  },
                  bgColor: Color(0XFFF5F5F5),
                  borderColor: Color(0XFFF5F5F5),),
                SizedBox(height: 12,),
                RatingBar.builder(
                  initialRating: 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 22,
                  unratedColor: kPrimaryColorx.withOpacity(0.25),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  onRatingUpdate: (ratingx) {
                    print(ratingx.round());
                   rating1.value = ratingx.round();
                  },
                ),
                SizedBox(height: 12,),

              ],
            )
          ],
        ),
      ),
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

  final orderMenuHistoryCirculer = false.obs;

  Rx<OrderMenuResponse?>  orderMenuResponse=Rx<OrderMenuResponse?>(null);

  Future orderMenuHistory() async{
    orderMenuHistoryCirculer.value=true;
    orderMenuResponse.value=null;
    await orderRepository?.orderMenuHistory().then((value){

      orderMenuHistoryCirculer.value=false;

      if(value.statusCode==200){
        orderMenuResponse.value=value;

      }else{

      }
    });
  }

  Rx<OrderResponse?>  orderMenuFullHistoryResponse=Rx<OrderResponse?>(null);
  List<Order> orderList = <Order>[].obs;
  Future orderMenuFullHistory({String? menuId})async {
    orderMenuHistoryCirculer.value=true;
    orderMenuFullHistoryResponse.value=null;
    await orderRepository?.orderMenuFullHistory(menuId).then((value){
    orderMenuHistoryCirculer.value=false;
    if(value.statusCode==200){
      orderMenuFullHistoryResponse.value=value;


      // List result = value.orders!
      //     .fold({}, (previousValue, element) {
      //   Map val = previousValue as Map;
      //   String date = element.createdAt!.split("T")[0];
      //   if (!val.containsKey(date)) {
      //     val[date] = [];
      //   }
      //   element.createdAt!.split("T")[0];
      //   val[date]?.add(element);
      //   return val;
      // })
      //     .entries
      //     .map((e) => {e.key: e.value})
      //     .toList();
      //
      // Logger().e(result);

    }else{

    }
    });
  }





  showRateNowAlertDialog({BuildContext? context, String? orderid}) {
    // set up the AlertDialog
    Widget cancelButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              height: 38,
              orderRadius: 24,
              color: kPrimaryColorx,
              textColor: Colors.white,
              boder: false,
              title: "Submit",
              onTap: () {
                Navigator.pop(context!);
                Logger().w(orderid);
                submitReview(orderid);

              }),
          SizedBox(height: 12,),
          CustomButton(
              height: 38,
              orderRadius: 24,
              color: kPrimaryColorx,
              textColor: Colors.white,
              boder: true,
              title: "Review Later",
              onTap: () {
                Navigator.pop(context!);
                // controller!.submitReview(orderid);
              }),

        ],
      ),
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      content: Container(
        color: Colors.white,
        height: 520,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Rate This Order',
                  style: TextStyle(
                    color: Color(0xFF02190E),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 32,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their service?',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      rating1.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their food hygiene.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      rating2.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their service intensity.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      rating3.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please rate their timeliness.',
                    style: TextStyle(
                      color: Color(0xFF02190E),
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12,),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      half: SizedBox(
                          height: 12,
                          child: SvgPicture.asset('assets/icons/star.svg',height: 16,)),
                      empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                    ),
                    onRatingUpdate: (ratingx) {
                      print(ratingx.round());
                      rating4.value = ratingx.round();
                    },
                  ),
                ],
              ),
              SizedBox(height: 24,),


              Text(
                'Any other comments to share? (Optional)',
                style: TextStyle(
                  color: Color(0xFF02190E),
                  fontSize: 16,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12,),
              SalesCreateRemarkTextfield(
                hintText: "Leave us a message...",
                lable: '',
                readOnly: false,
                isNumber: false,
                isValueChnged: true,
                maxLine: 3,
                tap: (text) {
                  if (text.isNotEmpty) {
                   comment.value = text;
                  } else {
                   comment.value = "";
                  }
                },


              ),


            ],
          ),
        ),
      ),
      actions: [
        cancelButton,
        SizedBox(height: 20,)

      ],
    );

    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }










}