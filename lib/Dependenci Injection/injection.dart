
import 'package:get_it/get_it.dart';

import '../Constants/Strings/app_strings.dart';
import '../Network/api_client.dart';
import '../Presentation/Widgets/AleartDialouge/aleart_dialouge_widget.dart';

import '../Repository/SliderRepository/slider_repository.dart';
import '../Service/LocalDataBase/localdata.dart';
import '../service/location_service.dart';
import '../service/location_service_name.dart';


GetIt getIt=GetIt.instance;

Future updateDependency() async{
    getIt.unregister<ApiClient>();
    getIt.registerSingleton<ApiClient>(ApiClient(appBaseUrl: BASE_URL));
}

Future injection()async{
    getIt.allowReassignment=true;
    // getIt.registerLazySingleton<ApiClient>(()=>ApiClient(appBaseUrl: BASE_URL));
    // getIt.registerSingleton<ApiClient>(ApiClientImplementation(),
    //     signalsReady: true);
    // getIt.registerLazySingleton(() => ApiClient(appBaseUrl: BASE_URL));
    getIt.registerLazySingleton(()=>LocationService());
    getIt.registerLazySingleton(()=>LocationNameService());

    getIt.registerSingleton<ApiClient>(ApiClient(appBaseUrl: BASE_URL));
    // GetIt.I.registerSingleton<ApiClient>(ApiClient(appBaseUrl: BASE_URL));

    // getIt.registerLazySingleton(()=>CustomAleartDialouge());
    // // getIt.registerSingleton(() => ApiClient(appBaseUrl: BASE_URL));

    // getIt.registerSingleton<LocalDataGet>(LocalDataGet());
    getIt.registerLazySingleton(()=>LocalDataGet());
    // getIt.registerSingleton<SliderRepository>(SliderRepository());
    getIt.registerLazySingleton(()=>SliderRepository());


   }

//
// getIt.allowReassignment=true;
//
//
// // getIt.registerSingleton<ApiClient>(ApiClientImplementation(),
// //     signalsReady: true);
// getIt.registerSingleton<ApiClient>(ApiClient(appBaseUrl: BASE_URL),signalsReady: true);
// // getIt.registerSingleton(() => ApiClient(appBaseUrl: BASE_URL));
// getIt.registerSingleton<LocationService>(LocationService());
// getIt.registerSingleton<LocalDataGet>(LocalDataGet());
// getIt.registerSingleton<SliderRepository>(SliderRepository());
// getIt.registerSingleton<CategoryRepository>(CategoryRepository());
// getIt.registerSingleton<CourseRepository>( CourseRepository());
// getIt.registerSingleton<TeacherRepository>(TeacherRepository());