import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as Http;
import 'Bloc/Home/home_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Config/text_style.dart';
import 'Constants/Colors/app_colors.dart';
import 'Data/Model/ChatHistoryHive/history.dart';
import 'Dependenci Injection/injection.dart';
import 'Getx Injection/getx_dependenci_injection.dart' as di;
import 'Route/app_route.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger().d("run");
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDPhNKObwfVvBHR1PtyVPeYG4zadmYocYI",
          appId: "1:99355049494:ios:e84020d8bc1f946426bf37",
          messagingSenderId: "99355049494",
          projectId: "activation-53aba"),
    );
  } else {
    await Firebase.initializeApp();
  }
  print('A bg message just showed up :  ${message.messageId}');
}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  ///dp path
  var databasePath = await getApplicationDocumentsDirectory();
  ///Hydrate bloc Init
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  HttpOverrides.global =await  MyHttpOverrides();
  ///Firebase init
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyADChMpvtamd7yjP8QhUMRYoMK5oNq-JLI",
          appId: "1:244012276431:ios:b176558ef1e6f7ccec75ba",
          messagingSenderId: "244012276431",
          projectId: "eatonomy-5567c"),
    );
  } else {
    await Firebase.initializeApp();
  }
  if (Platform.isIOS) {
   await FirebaseMessaging.instance.requestPermission();
  }
  ///push notification
 await FirebaseMessaging.instance.subscribeToTopic("all");
  await FirebaseMessaging.instance.subscribeToTopic("staging-eatonomy");
  await FirebaseMessaging.instance.subscribeToTopic("eatonomy");
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    Logger().w(message.data);
    Logger().w(message);
    Logger().w("${notification!.android!} test");
    if(notification.android!.imageUrl!=null) {
      final Http.Response response = await Http.get(Uri.parse(notification.android!.imageUrl!));
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: DarwinNotificationDetails(threadIdentifier: 'thread_id'),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: kPrimaryColorx,
            styleInformation: BigPictureStyleInformation(
                ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes))),
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            playSound: true,
            channelShowBadge: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),

      );
    }
    else{
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: DarwinNotificationDetails(threadIdentifier: 'thread_id'),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: kPrimaryColorx,
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            playSound: true,
            channelShowBadge: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  });
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  Hive.init(databasePath.path);


  // Hive.registerAdapter(CourseDbAdapter());
  ///dependenci injection
  await injection();

  ///Getx dependenci injection
  Map<String, Map<String, String>> _languages = await di.init();
  ///status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
  ));

  runApp(
      DevicePreview(
          enabled: false,
          builder: (BuildContext context) {
            return MyApp(router: AppRouter());
          },
      )
  );
}




class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({super.key, required this.router});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
        ],
        child:ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Eatonomy',
                theme: ThemeData(
                  useMaterial3: false,
                    primaryColor: kPrimaryColorx,
                    colorScheme: ColorScheme.light(primary: const Color(0xFF00934C)),
                    fontFamily: "Sora",
                  appBarTheme: AppBarTheme(
                      elevation: 0,
                      backgroundColor: whiteBackground,
                      centerTitle: true,
                      iconTheme: IconThemeData(
                          color: textColor,
                          size: 32
                      ),
                      titleTextStyle: semiBoldText(18,color: textColor)
                  ),

                ),
                onGenerateRoute: router.generateRoute,

              );
            })
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {

    return super.createHttpClient(context) ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}