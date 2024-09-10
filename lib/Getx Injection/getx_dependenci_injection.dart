
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/Strings/app_strings.dart';
import '../Dependenci Injection/injection.dart';
import '../GetX Controller/AuthController/AuthController.dart';

import '../GetX Controller/Chat/ChatController.dart';
import '../GetX Controller/Chef/ChefController.dart';
import '../GetX Controller/Home/HomeController.dart';
import '../GetX Controller/Map/MapController.dart';
import '../GetX Controller/Menu/MenuController.dart';
import '../GetX Controller/Notification/NotificationController.dart';
import '../GetX Controller/Order/OrderController.dart';
import '../GetX Controller/Search/SearchControllerx.dart';
import '../GetX Controller/Slider/SliderController.dart';

import '../Network/api_client.dart';
import '../Repository/AuthRepository/AuthRepository.dart';
import '../Repository/ChefRepository/ChefRepository.dart';
import '../Repository/NotificationRepository/NotificationRepository.dart';
import '../Repository/OrderRepository/order_repository.dart';
import '../Repository/SliderRepository/slider_repository.dart';
import '../Service/LocalDataBase/localdata.dart';
import '../service/location_service.dart';
import '../service/location_service_name.dart';


Future<Map<String, Map<String, String>>> init() async {

  // var apiclient=getIt<ApiClient>();
  // var localDb=getIt<LocalDataGet>();
  // print("calll get x");
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: BASE_URL));


  Get.lazyPut(()=>LocalDataGet());
  Get.lazyPut(()=>LocationService());
  Get.lazyPut(()=>LocationNameService());
  Get.lazyPut(() => ApiClient(appBaseUrl: BASE_URL));

  // Repository
  Get.lazyPut(() => SliderRepository());
  Get.lazyPut(() => AuthRepository());
  Get.lazyPut(() => ChefRepository());
  Get.lazyPut(() => NotificationRepository());
  Get.lazyPut(() => OrderRepository());


  // Controller
  Get.lazyPut(() => MapController());
  Get.lazyPut(() => ChatController(orderRepository: Get.find<OrderRepository>()));
  Get.lazyPut(() => ChefController(chefRepository:  Get.find<ChefRepository>()));
  Get.lazyPut(() => MenuControllerx(chefRepository:  Get.find<ChefRepository>()));
  Get.lazyPut(() => SearchControllerx(chefRepository:  Get.find<ChefRepository>()));
  Get.lazyPut(() => HomeController(authRepository: Get.find<AuthRepository>()));
  Get.lazyPut(() => NotificationController(notificationRepository: Get.find<NotificationRepository>()));
  Get.lazyPut(() => AuthController(authRepository: Get.find<AuthRepository>()));
  Get.lazyPut(() => SliderController(sliderRepository: Get.find<SliderRepository>()));
  Get.lazyPut(() => OrderController(orderRepository: Get.find<OrderRepository>()));



  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();

  return _languages;
}