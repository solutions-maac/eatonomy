
import 'package:eatonomy/Presentation/Pages/Chef/BecomeChef/become_location_deatils_page.dart';
import 'package:eatonomy/Presentation/Pages/Menu/hot_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/User/user_cubit.dart';
import '../Constants/Strings/app_strings.dart';
import '../Presentation/Pages/About/about_page.dart';
import '../Presentation/Pages/Chat/chat_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/become_chef_business_name_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/become_chef_slider_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/become_other_details_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/become_payment_details_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/become_profile_page.dart';
import '../Presentation/Pages/Chef/BecomeChef/chef_profile_page.dart';
import '../Presentation/Pages/Chef/follow_chef_page.dart';
import '../Presentation/Pages/FAQ/faq_page.dart';
import '../Presentation/Pages/Forget_Otp_Info_Pages/forget_otp_page.dart';
import '../Presentation/Pages/Forget_Otp_Info_Pages/info_page.dart';
import '../Presentation/Pages/Forget_Otp_Info_Pages/otp_page.dart';
import '../Presentation/Pages/Login/login_page.dart';
import '../Presentation/Pages/Login/login_page_intro.dart';
import '../Presentation/Pages/Menu/create_menu.dart';
import '../Presentation/Pages/Menu/edit_menu.dart';
import '../Presentation/Pages/Order/Create Order/take_order_details.dart';
import '../Presentation/Pages/Order/Page/chef_upcome_orde_page.dart';
import '../Presentation/Pages/Order/Page/order_details_timeline.dart';
import '../Presentation/Pages/Order/Page/order_details_timeline_new_design.dart';
import '../Presentation/Pages/Order/order_details.dart';
import '../Presentation/Pages/Order/order_request.dart';
import '../Presentation/Pages/Password/forget_password_mail_page.dart';
import '../Presentation/Pages/Password/forgetpass_mail_sucess_page.dart';
import '../Presentation/Pages/Password/password_change_page.dart';
import '../Presentation/Pages/Password/password_set_page.dart';
import '../Presentation/Pages/Policy Refund/policy_page.dart';
import '../Presentation/Pages/Policy Refund/refund_page.dart';
import '../Presentation/Pages/Policy Refund/trems_page.dart';
import '../Presentation/Pages/Profile/chef_profile_edit.dart';
import '../Presentation/Pages/Profile/profile_page.dart';
import '../Presentation/Pages/Profile/user_profile_page.dart';
import '../Presentation/Pages/Search/search_page.dart';
import '../Presentation/Pages/Settings/setting_page.dart';
import '../Presentation/Pages/SignUp/signup_page.dart';
import '../Presentation/Pages/SignUp/signup_sucess_page.dart';
import '../Presentation/Pages/SplashScreen/spalash_screen.dart';
import '../Presentation/Pages/wish List/wish_details.dart';
import '../Presentation/Pages/wish List/wish_list.dart';
import '../Presentation/main_screen.dart';


class AppRouter {

  Route? generateRoute(RouteSettings settings) {
    // final ScreenArguments? arguments = settings.arguments as ScreenArguments;
    final Map? args = settings.arguments as Map?;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SpalashScreen());
      case MAIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>MainScreen()
        );
      case LOGIN_PAGE_INTRO:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPageIntro()
        );
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage()
        );
      case SIGNUP_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignupPage()
        );
        case SIGNUP_SUCESS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignupSucessPage()
        );
        case FORGET_PASS_MAIL_SUCESS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ForgetPassMailSucessPage()
        );
      case OTP_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpPage(isLogin: args!['isLogin'],email: args['email'],mobile:args['mobile'] ,)
        );
      case INFO_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => InfoPage(email: args!['email'],mobile:args['mobile'],otp: args['otp'],)
        );
      case SEARCH_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => SearchPage()
        );
      case BEACOME_SHEF_SLIDER_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BecomeChefpage()
        );
        case BEACOME_SHEF_BUSINESS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BusinessName()
        );
      case BEACOME_SHEF_LOCATION_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChefLocationDetailsPage()
        );
      case BEACOME_SHEF_OTHER_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BusinessOtherDetails()
        );
      case BEACOME_PAYMENT_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BusinessPaymentDetails()
        );
      case BEACOME_SHEF_PROFILE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => BecomeChefProfilePage()
        );
      case SHEF_PROFILE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>ChefProfilePage(id: args!['id'], localUser: args['localuser'],directHomePage: args['directHomePage'],)
        );
      case CREATE_MENU_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>CreateMenu(id: args!['id'],)
        );
      case HOT_MENU_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>HotMenuPage(id: args!['id'],)
        );
      case EDIT_MENU_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>EditMenu(menu: args!['menu'],)
        );
      case CHEF_ORDER_UP_COME_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>ChefOrderUpComePage(orderMenu: args!["menuId"],)
        );
        case ORDER_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>OrderDetailsPage()
        );
      case ORDE_TIMELINE_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>OrderTimelineDetailsPageNewDesign(ordrId: args!['orderId'],)
        );
      case ORDER_REQUEST_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>OrderRequestPage()
        );
        case ORDER_DETAILS_TAKE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>OrderTakeDetails(menu: args!['menu'],)
        );
      case CHAT_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>ChatPage(order: args!["order"],)
        );
      case WISH_LIST_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>WishList()
        );
      case FOLLOW_CHEF_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>FollowChefPage()
        );
      case WISH_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>WsihDetails(menu: args!['menu'],craeteat: args['craeteat'],)
        );


      case CHEF_PROFILE_EDIT_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChefProfileUpdate(chef: args!['chef'],)
        );
      case USER_PROFILE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserProfilePage(
              name: args!['name'],mobile:args['mobile']
              ,image:args['image'] ,email:args['email'],
                  address:args['address'] ,city:args['city'],zipcode: args['zipcode'],)
        );
      case PROFILE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(name: args!['name'] ,image:args['image'] ,email:args['email'] ,)
        );
      case SETTINGS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingPage()
        );

      case ABOUT_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => AboutPage()
        );
      case REFUND_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => RefundPage()
        );
      case PRIVACY_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => PolicyPage()
        );
      case TERMS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => TremsPage()
        );

      case FAQ_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(),
                ),
              ],
              child: FAQPage(),
            )
        );

      case PASSWORD_CHANGE_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(),
                ),
              ],
              child: PasswordChangePage(),
            )
        );
      case FORGET_PASSWORD_MAIL_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(),
                ),
              ],
              child: ForgetPasswordMailPage(),
            )
        );
      case FORGET_OTP_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(),
                ),
              ],
              child: ForgetOtpPage(),
            )
        );
      case PASSWORD_SET_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(),
                ),
              ],
              child: PasswordSetPage(),
            )
        );


    // case HOME_PAGE:
    //   return MaterialPageRoute(builder: (_) => Home());


      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => UserCubit(),
              child: SpalashScreen(),
            ));
    }
  }
}
