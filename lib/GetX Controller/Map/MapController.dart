import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logger/logger.dart';
import '../../Constants/Colors/app_colors.dart';
import '../../Constants/Strings/app_strings.dart';
import '../../Data/Model/Location/LocationModel.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Presentation/Widgets/Button/custom_button.dart';
import '../../Presentation/Widgets/CustomePaint/custome_marker.dart';
import '../../Repository/SliderRepository/slider_repository.dart';
import '../../Utils/MapUtils/Utils.dart';
import '../../service/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show Size, rootBundle;
import 'dart:ui' as ui;

import '../../service/location_service_name.dart';

class MapController extends GetxController implements GetxService{


  final currentIndex = 0.obs;
  final radius = 1.0.obs;
  Rx<LocationModel?>  location=Rx<LocationModel?>(null);
  var locationNameService = getIt<LocationNameService>();
  final adress="Getting Location".obs;
  var locationService = getIt<LocationService>();
  Rx<LatLng?> latLng=Rx<LatLng?>(null);
  Rx<LatLng?> pickedLocation=Rx<LatLng?>(null);
  GoogleMapController? googleMapController;
  MapType currentMapType = MapType.normal;
  var bitmapIcon;
   BuildContext? context;

   var loadLoaction=false.obs;


  final List<Marker> markers = [];

  @override
  void onInit() {
    // TODO: implement onInit
    loadLoaction.value=false;
    markers.clear();
    locationService.getLocation().then((value){
      location.value=value;
      latLng.value=LatLng(location.value!.latitude!,location.value!.longitude!);
      Future.delayed(Duration.zero, () {
        getmarker();
        // getChefMarker();
        setAllMarkers();
      });

    });

    super.onInit();
  }

  Future<LocationModel?> getLocationName()async{
    await locationService.getLocation().then((value){
      location.value=value;
      latLng.value=LatLng(location.value!.latitude!,location.value!.longitude!);
      Logger().w(latLng.value);

    });

    return location.value;
  }


  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    googleMapController!.setMapStyle(Utils.mapStyles).whenComplete(() {
    });
  }
  BitmapDescriptor? customIcon;

 Future getmarker() async {
   final Uint8List markerIcon = await getBytesFromAsset('assets/icons/Position.png', 200);
   bitmapIcon=BitmapDescriptor.fromBytes(markerIcon);
    markers.add(Marker(
      markerId: MarkerId('your_marker_id'),
      position: LatLng(latLng.value!.latitude, latLng.value!.longitude),
      icon: bitmapIcon,
     ),
    );

   update();
 }
  setAllMarkers() async {
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(23.707076682772666, 90.39113409833573),
        icon: await getMarkerIcon(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcA3AmOb_BMAsPra4XquXuWFMNAi7grJL0ug&usqp=CAU",
            "DAVID"),
          onTap: (){

            showAlertDialog(context!);
          }
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("2"),
        position: LatLng(23.707322703931542, 90.39243262293517),
        icon: await getMarkerIcon(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcA3AmOb_BMAsPra4XquXuWFMNAi7grJL0ug&usqp=CAU",
            "ROSE"),
          onTap: (){

            showAlertDialog(context!);
          }
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("3"),
        position: LatLng(23.706664531628928, 90.3922073173816),
        icon: await getMarkerIcon(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuIavvjuQFB38Se2ZNa0GkZ1Gol3C5OwioHA&usqp=CAU",
            "JASSABELLE"),
        onTap: (){
          showAlertDialog(context!);

        }
      ),
    );

    update();

  }


  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        side: BorderSide(width: 0.75, color: Color(0xFFD9D9D9)),

      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      content: Container(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/48x48"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(width: 13,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khadija’s Kitchen',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      '+447401859980',
                      style: TextStyle(
                        color: Color(0xFF6D7075),
                        fontSize: 8,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                      ),
                    )
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


  Future<BitmapDescriptor> getMarkerIcon(String image, String name) async {
    if (image != null) {
      final File markerImageFile =
      await DefaultCacheManager().getSingleFile(image);
      Size s = Size(120, 120);

      var icon = await createCustomMarkerBitmapWithNameAndImage(markerImageFile.path, s, name);

      return icon;
    } else {
      return BitmapDescriptor.defaultMarker;
    }
  }







  ///normal methods

  Future getChefMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/marker.png', 70);
    // bitmapIcon=BitmapDescriptor.fromBytes(markerIcon);
    markers.add(Marker(
      markerId: MarkerId('your_marker_idxxx'),
      position: LatLng(23.707076682772666, 90.39113409833573),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

}