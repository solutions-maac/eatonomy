import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatonomy/Config/text_style.dart';
import 'package:eatonomy/Data/Model/Dashboard/DashboardResponse.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as Img;
import '../../Constants/Colors/app_colors.dart';
import '../../Constants/Strings/app_strings.dart';
import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Data/Model/Location/LocationModel.dart';
import '../../Data/Model/Menu/Menu.dart';
import '../../Data/Model/User/Chef.dart';
import '../../Data/Model/User/ChefData.dart';
import '../../Data/Model/User/ChefDetailsResponse.dart';
import '../../Data/Model/User/ChefFollowRresponse.dart';
import '../../Data/Model/User/ChefNearbyRresponse.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Getx Injection/getx_dependenci_injection.dart';
import '../../Presentation/Widgets/Button/custom_button.dart';
import '../../Presentation/Widgets/Loading/loading_widget.dart';
import '../../Repository/ChefRepository/ChefRepository.dart';
import '../../Service/LocalDataBase/localdata.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart' show ByteData, Size, Uint8List, rootBundle;
import 'dart:ui' as ui;

import '../../service/location_service.dart';
import '../Home/HomeController.dart';

class ChefController extends GetxController implements GetxService{

  final ChefRepository? chefRepository;

  ChefController({this.chefRepository});




  final count = 0.obs;
  final orderPerfomanceFilter = "Month".obs;
  final orderTotalIncomeFilter = "Month".obs;

  final locatioCirculer = false.obs;
  final cuisineList = ["Bengali","Korean","Italian","Turkish","Mexican","Indian","Thai","Chinese"];
  final ratingList = ["1.0","1.5","2.0","2.5","3.0","3.5","4.0","4.5","5.0"];
  final circuler = false.obs;
  final ppCirculer = false.obs;
  final coverCirculer = false.obs;
  Rx<LocationModel?>  location=Rx<LocationModel?>(null);
  var locationService = getIt<LocationService>();
  Rx<ChefDetailsResponse?>  chefDetailsResponse=Rx<ChefDetailsResponse?>(null);


  final name="".obs;
  final token="".obs;

  final about="".obs;
  final chefId="".obs;
  final number="".obs;
  final email="".obs;
  final address="".obs;
  final city="".obs;
  final zipCode="".obs;
  final paymentEmail="".obs;
  final experince="".obs;
  final image="".obs;
  final imageUrl="".obs;
  final ppImageUrl="".obs;
  final filePath="".obs;
  final ppFilePath="".obs;


  final ratingFilter=0.0.obs;
  final radiusFilter=0.0.obs;
  final cusinineFilter=<String>[].obs;


  RxList<String> selectCuisine=<String>[].obs;
  File? file;
  File? ppFile;



  @override
  Future<void> onInit() async {

    ratingFilter.value=0.0;
    radiusFilter.value=0.0;
    cusinineFilter.value=<String>[].obs;


    index.value="";
    chefId.value="";
    experince.value="";
    about.value="";
    address.value="";
    city.value="";
    zipCode.value="";
    name.value="";
    token.value="";
    number.value="";
    paymentEmail.value="";
    image.value="";
    filePath.value="";
    ppFilePath.value="";
    imageUrl.value="";
    ppImageUrl.value="";

    var tokenx = await LocalDataGet().getData();
    number.value=tokenx.get('mobile');
    email.value=tokenx.get('email');

    if(tokenx.get('token')==null){
      token.value= "";
    }else{
      token.value= tokenx.get('token');
    }
    if(tokenx.get('chefId')==null){
      chefId.value= "";
    }else{
      chefId.value= tokenx.get('chefId');
    }


    super.onInit();
  }


  Future<File?> filepic(bool? iscover)async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      ppFilePath.value="";
      File filer = File(result.files.single.path!);

      if(iscover!){
        filePath.value=result.files.single.path!;
        coverCirculer.value=true;
      }else{
        ppFilePath.value=result.files.single.path!;
        ppCirculer.value=true;
      }
      reduceImageSize(filer,iscover).then((value){
        return value;
      });
    } else {
      // User canceled the picker
    }
  }
  Future<File?> filePPpic()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      filePath.value="";
      ppFilePath.value="";
      File filer = File(result.files.single.path!);


        ppFilePath.value=result.files.single.path!;
        ppCirculer.value=true;

      reducePPImageSize(filer).then((value){
        return value;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<File> reduceImageSize(File imageFile, bool? iscover) async {
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
    if(iscover!){
      file=reducedFile;
    }else{
      ppFile=reducedFile;
    }


    chefRepository!.uploadImage(file).then((value){
      if(iscover){
        coverCirculer.value=false;
      }else{
        ppCirculer.value=false;
      }

      if(value!.url!=null){
        if(iscover){
          imageUrl.value=value.url!;
        }else{
          ppImageUrl.value=value.url!;
        }
      }else{
        Get.snackbar("Something wrong", "Failed To Upload Photo ",backgroundColor: Colors.redAccent,colorText: Colors.white);

        if(iscover){
          imageUrl.value="";
        }else{
          ppImageUrl.value="";
        }

      }
    });

    return reducedFile;
  }
  Future<File> reducePPImageSize(File imageFile) async {
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

      ppFile=reducedFile;
    chefRepository!.uploadImage(ppFile).then((value){
        ppCirculer.value=false;
      if(value!.url!=null){
          ppImageUrl.value=value.url!;

      }else{
        Get.snackbar("Something wrong", "Failed To Upload Photo ",backgroundColor: Colors.redAccent,colorText: Colors.white);
        ppImageUrl.value="";
      }
    });

    return reducedFile;
  }


  Future<LoginResponse?>  createChef(BuildContext context) async{
    circuler.value=true;
    LoginResponse? data;
    await chefRepository?.createChef(name: name.value,address:address.value ,city:city.value ,
    zipcode: zipCode.value,email:email.value ,mobile:number.value ,bannerImage:imageUrl.value ,
    locationdata: location.value, paymentInstraction: paymentEmail.value,
        profileImage: ppImageUrl.value,eperince: int.parse(experince.value),couisine: selectCuisine.value).then((value) async {
      circuler.value=false;
      data=value;

      if(value!.statusCode==200){
        Navigator.pop(context);
        Navigator.pushNamed(context, SHEF_PROFILE_PAGE,arguments: {
          "id":value.chef!.id,
          "localuser":false
        });
      }else{
        Get.snackbar("Some thing Wromh", value.message!,backgroundColor: Colors.red,borderRadius: 4);
      }

      Logger().w(data!.message!);
    });
    return data!;
  }




  List<Menu> menus = <Menu>[].obs;
  List<Menu> menusCopy = <Menu>[].obs;

  Future<ChefDetailsResponse?>  getChefDetails(String? id) async{
    selectCuisine.value=[];
    circuler.value=true;
    await chefRepository?.getChefDetails(id).then((value) {
      circuler.value=false;
      if(value.statusCode==200){
        chefDetailsResponse.value=value;
        menus=value.menus!;
        menusCopy=value.menus!;
      }
    });
  }
  Future<ChefDetailsResponse?>  getUserDetails() async{
    selectCuisine.value=[];
    circuler.value=true;
    await chefRepository?.getUserDetails().then((value) {
      circuler.value=false;
      if(value.statusCode==200){
        chefDetailsResponse.value=value;
      }
    });
  }


  final index="".obs;
  Future followChef({String? id,num?indexx}) async{
    circuler.value=true;
    index.value=indexx.toString();
    await chefRepository?.followChef(id!).then((value) {
      circuler.value=false;
      if(value!.statusCode==200){
        getChefDetails(id);
        // Get.snackbar("Successfully", "Now You Follow This Chef",backgroundColor: kPrimaryColorx);
      }
    });
  }

  Future deleteFollowChef({String? id,num?indexx}) async{
    circuler.value=true;
    index.value=indexx.toString();
    await chefRepository?.deleteFollowChef(id!).then((value) {
      circuler.value=false;
      if(value!.statusCode==200){
        getChefDetails(id);
        // Get.snackbar("Successfully", "Now You Follow This Chef",backgroundColor: kPrimaryColorx);
      }
    });
  }


  ///=========Chefs with pagination========///////
  final circle = false.obs;

  List<Chef> list = [];
  ScrollController controller = ScrollController();
  int listLength = 10;
  int page = 0;
  final chefPagingCirculer=false.obs;

  var bitmapIcon;
  final List<Marker> markers = [];
  Rx<LatLng?> latLng=Rx<LatLng?>(null);
  BuildContext? context;

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

  Future<ChefNearbyRresponse?>  getChefs(bool isFirstr) async{
    circuler.value=true;
    circle.value=true;
    list.clear();
    markers.clear();
    page=1;
    if(isFirstr){
      addItems();
    }
    await  chefRepository?.getChefs("30", '0',radiusFilter.value,ratingFilter.value,cusinineFilter.value
    ).then((value) {
      circuler.value=false;
      circle.value=false;
      if(value.statusCode==200){
        for(var i=0;i<value.chefs!.length;i++){
          list.add(value.chefs![i]);
        }

        locationService.getLocation().then((value){
          location.value=value;
          latLng.value=LatLng(location.value!.latitude!,location.value!.longitude!);
          Logger().w(latLng.value);
          Logger().w("latLng.value");
          Future.delayed(Duration.zero, () {
            getmarker();
            // getChefMarker();
            setAllMarkers();
          });

        });


      }
    });
  }

  getFeedPagingData({String? page}) async{
    chefPagingCirculer.value=true;
    markers.clear();
    await chefRepository!.getChefs(
        '30',
        page??'0',
        radiusFilter.value,ratingFilter.value,cusinineFilter.value

    ).then((value){
      for(var i=0;i<value.chefs!.length;i++){
        list.add(value.chefs![i]);
      }
      locationService.getLocation().then((value){
        location.value=value;
        latLng.value=LatLng(location.value!.latitude!,location.value!.longitude!);
        Future.delayed(Duration.zero, () {
          getmarker();
          // getChefMarker();
          setAllMarkers();
        });

      });
      update();
      chefPagingCirculer.value=false;
    });

  }



  Future getmarker() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/Position.png', 200);
    bitmapIcon=BitmapDescriptor.fromBytes(markerIcon);
    markers.add(Marker(
      markerId: MarkerId('your_marker_id'),
      position: LatLng(location.value!.latitude!, location.value!.longitude!),
      icon: bitmapIcon,
    ),
    );

    update();
  }
  setAllMarkers() async {
    markers.clear();
    for(var i=0;i<list.length;i++){



        markers.add(
          Marker(
              markerId: MarkerId(list[i].id!+i.toString()),
              position: LatLng(list[i].location!.latitude!, list[i].location!.longitude!),
              icon: await getMarkerIcon(list[i].profilePicture!=null?list[i].profilePicture!
                  :
              "https://via.placeholder.com/22x22",
                  list[i].name!),
              onTap: (){
                showAlertDialog(context!,list[i]);
              }
          ),
        );


    }

    // Logger().e(list.length);
    Logger().w(markers.length);
    // list.forEach((element) async {
    //   Logger().w(element.id!);
    //   Logger().w(element.location!.latitude!.toString()+","+element.location!.longitude!.toString());
    //   markers.add(
    //
    //       Marker(
    //           markerId: MarkerId("element.id!"),
    //           position: LatLng(element.location!.latitude!, element.location!.longitude!),
    //           icon: await getMarkerIcon(element.profilePicture!=null?element.profilePicture!
    //               :
    //           "https://via.placeholder.com/22x22",
    //           element.name!),
    //       onTap: (){
    //         showAlertDialog(context!,element);
    //       }
    //   ),
    //   );
    // });
    update();
    // markers.forEach((element) {
    //   // log(markers.toString());
    //   Logger().i(element);
    // });



  }
  showAlertDialog(BuildContext context,Chef chef) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        side: BorderSide(width: 0.75, color: Color(0xFFD9D9D9)),

      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
      content: Container(
        height:chef.isHotDeal==null?55: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    imageUrl: chef.profilePicture!=null?chef.profilePicture!:"https://via.placeholder.com/32x32",
                      placeholder: (context, url) => SizedBox(
                          height: 34,
                          width: 34,
                          child: LoadingWidget()),
                      imageBuilder: (context, image) =>
                      Container(
                        width: 32,
                        height: 32,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      )
                ),
                SizedBox(width: 13,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chef.name??'',
                      style: TextStyle(
                        color: Color(0xFF02190E),
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6,),
                    RatingBar(
                      initialRating:chef.rating==null?0.0:chef.rating!.toDouble(),
                      minRating: 0,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      ratingWidget: RatingWidget(
                        full: SvgPicture.asset('assets/icons/star.svg'),
                        half: SvgPicture.asset('assets/icons/star.svg'),
                        empty: SvgPicture.asset('assets/icons/star_stock.svg'),
                      ),
                      onRatingUpdate: (ratingx) {

                      },
                    ),
                    SizedBox(height: 6,),
                    Text(
                      chef.mobileNumber??"",
                      style: TextStyle(
                        color: Color(0xFF6D7075),
                        fontSize: 8,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6,),
                    chef.isHotDeal==null?SizedBox():
                    chef.isHotDeal!?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/icons/fire.png"),
                        SizedBox(width: 4,),
                        Text(
                          'Hot deal',
                          style: TextStyle(
                            color: Color(0xFFF2503B),
                            fontSize: 11,
                            fontFamily: 'Sora',
                            // decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                        :SizedBox()
                  ],
                ),
              ],
            ),


            CustomButton(
                height: 30,
                width: 61,
                orderRadius: 30,
                color: kPrimaryColorx,
                boder: false,
                textColor: Colors.white,
                title: "Profile",
                textSize: 10,
                onTap: (){
                  // if(token.value==""||token.value==null){
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     backgroundColor: Colors.orange,
                  //     content: Text("You need to be login",style: boldText(14,color: Colors.white),),
                  //     duration: Duration(milliseconds: 800),
                  //   ));
                  // }else{
                    Navigator.pushNamed(context, SHEF_PROFILE_PAGE, arguments: {
                      'id': chef.id,
                      'localuser': true,
                      "directHomePage":false
                    });


                }),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(String imagePath, Size size, String name) async {
    TextSpan span = new TextSpan(
        style: new TextStyle(
          height: 1.2,
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        text: name);

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas canvas = new Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;


    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = kPrimaryColorx;


    ///new line
    Path path_0 = Path();
    path_0.moveTo(size.width*0.9777778,size.height*0.3823529);
    path_0.cubicTo(size.width*0.9777778,size.height*0.5935206,size.width*0.7000000,size.height*0.9705882,size.width*0.4962963,size.height);
    path_0.cubicTo(size.width*0.2925933,size.height*0.9705882,size.width*0.01481570,size.height*0.5935206,size.width*0.01481570,size.height*0.3823529);
    path_0.cubicTo(size.width*0.01481570,size.height*0.1711853,size.width*0.2303822,0,size.width*0.4962963,0);
    path_0.cubicTo(size.width*0.7622111,0,size.width*0.9777778,size.height*0.1711853,size.width*0.9777778,size.height*0.3823529);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff00934C).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);
    ///new line

    // Add shadow circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(
    //           size.width / 8, size.width / 2, size.width, size.height),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: Radius.circular(3),
    //     ),
    //     shadowCirclePaint);

    // TEXT BOX BACKGROUND
    // Paint textBgBoxPaint = Paint()..color = kPrimaryColorx;
    //
    // Rect rect = Rect.fromLTWH(
    //   0,
    //   10,
    //   tp.width + 35,
    //   40,
    // );
    //
    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(rect, Radius.circular(30.0)),
    //   textBgBoxPaint,
    // );

    //ADD TEXT WITH ALIGN TO CANVAS
    // tp.paint(canvas, new Offset(20.0, 8.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(16, 10, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));


    // ADD  PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(
        imagePath);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }


  Future<BitmapDescriptor> getMarkerIcon(String? image, String name) async {
    if (image != null) {
      final File markerImageFile =
      await DefaultCacheManager().getSingleFile(image!);
      Size s = Size(120, 120);

      var icon = await createCustomMarkerBitmapWithNameAndImage(markerImageFile.path, s, name);

      return icon;
    } else {
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }




  ///=========Chefs with pagination========///////
  final circleFollow = false.obs;
  List<ChefData> listFollow = [];
  ScrollController controllerFollow = ScrollController();
  int followListLength = 10;
  int pageFollow = 0;
  final followChefPagingCirculer=false.obs;

  addFollowItems() async {
    controllerFollow.addListener(() {
      if (controllerFollow.position.maxScrollExtent == controllerFollow.position.pixels) {
        Logger().w("call");
        followListLength++;
        pageFollow++;
        getFollowPagingData(page: pageFollow.toString());
        update();
      }
    });
  }

  Future<ChefFollowRresponse?>  getFollowChefs(bool isFirstr) async{
    circleFollow.value=true;
    circleFollow.value=true;
    locationService.getLocation().then((value){
      location.value=value;
      latLng.value=LatLng(location.value!.latitude!,location.value!.longitude!);
      Future.delayed(Duration.zero, ()async {
        listFollow.clear();
        pageFollow=1;
        if(isFirstr){
          addFollowItems();
        }
        await  chefRepository?.getFollowChefs("10", '0',
        ).then((value) {
          circleFollow.value=false;
          circleFollow.value=false;
          if(value.statusCode==200){
            for(var i=0;i<value.follows!.length;i++){
              listFollow.add(value.follows![i]);
            }
          }
        });
      });

    });

  }

  getFollowPagingData({String? page}) async{
    followChefPagingCirculer.value=true;
    await chefRepository!.getFollowChefs(
      '10',
      page??'0',
    ).then((value){
      for(var i=0;i<value.follows!.length;i++){
        listFollow.add(value.follows![i]);
      }
      update();
      followChefPagingCirculer.value=false;
    });

  }

  final circleAbout = false.obs;
  Future updateChefAbout(String? id)async {
    circleAbout.value=true;
    await chefRepository?.updateChefAbout(id!,about.value).then((value) {
      circleAbout.value=false;
    if(value.statusCode==200){
      getChefDetails(id);
     Get.snackbar("Successfully", "Add About",backgroundColor: kPrimaryColorx);
    }
    });
  }


  var localBd=getIt<LocalDataGet>();
  final circleUpdateChef = false.obs;
  Future updateChef(String? id, BuildContext context)async {
    circleUpdateChef.value=true;
    await chefRepository?.updateChef(
      id:id!,
        name: name.value,address:address.value ,city:city.value ,
        zipcode: zipCode.value,email:email.value ,mobile:number.value ,bannerImage:imageUrl.value ,
        locationdata: location.value,profileImage: ppImageUrl.value , paymentInstraction: paymentEmail.value,about:about.value

    ).then((value) async{

      if(value.statusCode==200){
        Get.snackbar("Successfully", "Update profile",backgroundColor: kPrimaryColorx,colorText: Colors.white);
        await chefRepository?.getChefDetails(id).then((valuex) async{
          circuler.value=false;
          if(valuex.statusCode==200){
            Logger().w( valuex.chef!.name);
            await localBd.storeTokenUserdata(email: valuex.chef!.email,name: valuex.chef!.name,token:token.value ,
                image: valuex.chef!.profilePicture,mobile: valuex.chef!.mobileNumber,role:"CHEF",chefId:id).then((valuer){
                  Navigator.pop(context);
                  getChefDetails(id);
            });
          }
        });



      }
    });

  }


  final circleOrderPerfomance = false.obs;
  final circleOrderTotalIncome = false.obs;
  Rx<DashboardResponse?>  orderPerfomanceResponse=Rx<DashboardResponse?>(null);
  Future getChefOrderPerformance() async{
    circleOrderPerfomance.value=true;
    // orderPerfomanceResponse.value=null;
    await chefRepository?.getChefOrderPerformance(
        orderPerfomanceFilter.value=="Month"?true:false
    ).then((value) {
      circleOrderPerfomance.value=false;
      if(value.statusCode==200){
        orderPerfomanceResponse.value=value;
      }else{
        if(token.value!=""){
          Logger().e("message");
          updateDependency();
          injection();
          init();
          // Future.delayed(Duration(seconds: 3));
          Future.delayed(Duration(seconds: 3),(){
            getChefOrderPerformance();
          });
        }
      }
    });
  }


  Rx<DashboardResponse?>  orderTotalIncomeResponse=Rx<DashboardResponse?>(null);
  Future getChefTotalIncome() async{
    circleOrderTotalIncome.value=true;
    // orderTotalIncomeResponse.value=null;
    await chefRepository?.getChefOrderPerformance(
        orderTotalIncomeFilter.value=="Month"?true:false
    ).then((value) {
      circleOrderTotalIncome.value=false;
      if(value.statusCode==200){
        orderTotalIncomeResponse.value=value;
      }
    });
  }









}