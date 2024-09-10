import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/ChatHistoryHive/history.dart';
import '../../Data/Model/Menu/MenuSearchResponse.dart';
import '../../Data/Model/User/ChefNearbyRresponse.dart';
import '../../Repository/ChefRepository/ChefRepository.dart';
import '../../Repository/SliderRepository/slider_repository.dart';
import '../../Service/LocalDataBase/localdata.dart';
import '../../service/LocalDataBase/history_service.dart';

class SearchControllerx extends GetxController implements GetxService{
  final ChefRepository? chefRepository;

  SearchControllerx({ this.chefRepository});

  List<History> history=<History>[];
  final currentIndex = 0.obs;
  final searchText = "".obs;
  final token = "".obs;
  final circuler = false.obs;
  final topCirculer = false.obs;
  Rx<MenuSearchResponse?>  searchResponse=Rx<MenuSearchResponse?>(null);
  Rx<ChefNearbyRresponse?>  topChefResponse=Rx<ChefNearbyRresponse?>(null);
  @override
  void onInit() {
    // TODO: implement onInit
    searchText.value="";
    topChef();
    getToken().then((value){

      // Logger().e(value.get('chefId'));
      if(value.get('token')==null){
        token.value= "";
      }else{
        token.value= value.get('token');
      }

    });
    HiveService().getItems().then((value) {
      history= value;
      Logger().w(history.length);
    });
    super.onInit();
  }

  getToken() async {
    var tokenx = await LocalDataGet().getData();
    return tokenx;
  }
  Future searchMenu() async{
    circuler.value=true;
    searchResponse.value=null;
    await chefRepository?.searchMenu(searchText.value).then((value) {
      circuler.value=false;
      if(value.statusCode==200){
        searchResponse.value=value;
      }
    });
  }
  Future topChef() async{
    topCirculer.value=true;
    topChefResponse.value=null;
    await chefRepository?.topChef().then((value) {
      topCirculer.value=false;
      if(value.statusCode==200){
        topChefResponse.value=value;
      }
    });
  }

  // increment() {
  //   currentIndex.value++;
  //   print("object");
  //
  //   sliderRepository!.getCheck();
  // }
}