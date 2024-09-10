
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../../GetX Controller/Map/MapController.dart';
import '../../../Widgets/EmptyCard/empty_widget.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../Component/chef_list_card.dart';

class ChefMapView extends StatelessWidget {
  const ChefMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<MapController>().onInit();
      Get.find<MapController>().context=context;
    });

    return GetBuilder<ChefController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return  controller.circle.value ? LoadingWidget() :
          controller.list.isEmpty ? EmptyWidget(title: "No Chef Found") : Stack(
            children: [
              controller.latLng.value == null
                  ? Center(child: Text("loading"),)
                  :
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.latLng.value!,
                  zoom: 17,
                ),
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(controller.markers),
                zoomControlsEnabled: false,
                // onMapCreated: controller.onMapCreated,
                mapType: MapType.normal,
              ),
            ],
          );
        });
      },
    );
  }
}
