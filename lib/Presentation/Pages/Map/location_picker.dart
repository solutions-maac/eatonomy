
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../Config/text_style.dart';
import '../../../Data/Model/Location/LocationModel.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../../GetX Controller/Map/MapController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';

class MapLocationPicker extends StatelessWidget {
  final TextEditingController? addressTextController,cityTextController,zipCodeTextController;
  const MapLocationPicker({Key? key, this.addressTextController, this.cityTextController, this.zipCodeTextController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<MapController>().onInit();
      Get.find<MapController>().context=context;
    });

    return GetBuilder<MapController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColorx,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.keyboard_arrow_left,color: Colors.white,)),
              title: Text("Location Pick",style: semiBoldText(14,color: Colors.white),),
            ),
            bottomSheet: Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              color: kPrimaryColorx,
              child: Column(
                children: [
                  Wrap(
                    children: [
                      controller.pickedLocation.value!=null?  Text('Picked location: ${controller.pickedLocation.value!.latitude},'
                            ' ${controller.pickedLocation.value!.longitude}',
                          style: boldText(12,color: Colors.white),
                        ):Text('For Picked location: Drag Your Map',
                        style: boldText(12,color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  controller.loadLoaction.value?SizedBox(
                      height: 44,
                      child: LoadingWidget()):  CustomButton(
                      height: 44,
                      orderRadius: 4,
                      color: Colors.white,
                      boder: true,
                      textColor: kPrimaryColorx,
                      title: "Pick Location",
                      onTap: () {
                        if(controller.pickedLocation.value!=null ){
                          controller.loadLoaction.value = true;
                          controller.locationNameService.getLocationName(controller.pickedLocation.value!.latitude, controller.pickedLocation.value!.longitude).then((valuex) {
                            controller.loadLoaction.value = false;

                            Get.find<ChefController>().address.value=valuex![0].locality.toString() + ", " + valuex[0].subLocality.toString();
                            Get.find<ChefController>().city.value=valuex[0].subAdministrativeArea.toString();
                            Get.find<ChefController>().zipCode.value=valuex[0].postalCode.toString();
                            Get.find<ChefController>().location.value=LocationModel(latitude: controller.pickedLocation.value!.latitude,longitude: controller.pickedLocation.value!.longitude);
                            addressTextController!.text = valuex[0].locality.toString() + ", " +
                                valuex[0].subLocality.toString();
                            cityTextController!.text = valuex[0].subAdministrativeArea.toString();
                            zipCodeTextController!.text = valuex[0].postalCode.toString();
                            Logger().w( Get.find<ChefController>().address.value+"  "+ Get.find<ChefController>().city.value);
                            Navigator.pop(context);
                          });
                        }

                      }),
                ],
              ),
            ),
            
            body: Stack(
              children: [

                controller.latLng.value == null
                    ? Center(child: Text("loading"),)
                    :
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: controller.latLng.value!,
                    zoom: 17,
                  ),
                  onCameraMove: (CameraPosition position) {
                    controller.pickedLocation.value = position.target;
                    Logger().w( controller.pickedLocation.value);
                  },
                  onTap: (LatLng location) {
                    controller.pickedLocation.value = location;
                    Logger().w( controller.pickedLocation.value);
                  },
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  // onMapCreated: controller.onMapCreated,
                  mapType: MapType.normal,

                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 2.5,
                  right: MediaQuery.of(context).size.width/3,
                  child:Lottie.asset('assets/lottie/location_picker.json',height: 120),
                ),

              ],
            ),
          );
        });
      },
    );
  }
}
