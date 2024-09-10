import 'package:eatonomy/GetX%20Controller/AuthController/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';


import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../../GetX Controller/Home/HomeController.dart';
import '../../../Getx Injection/getx_dependenci_injection.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import 'Component/more_card.dart';
import 'Component/more_expanded_card.dart';
import 'Component/user_top_card.dart';


class MorePage extends StatefulWidget {
  MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String? token;
  String? name;
  String? image = "";
  String? firstName;
  String? lastName;
  String? role;
  String? mobile;
  String? email;
  String? chefId;


  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().getShopList());

    getToken();
    super.initState();
  }

  void getToken() async {
    var tokenx = await getIt<LocalDataGet>().getData();
    if (tokenx.get('token') != null) {
      setState(() {
        token = tokenx.get('token');
        role = tokenx.get('role');
        chefId = tokenx.get('chefId');
        image = tokenx.get('image');
        name = tokenx.get('name');
        mobile = tokenx.get('mobile');
        email = tokenx.get('email');
        firstName = tokenx.get('firstName');
        lastName = tokenx.get('lastName');
      });
      // Logger().e(tokenx.get('name'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0FFF9FCFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF0FFF9FCFF),
        automaticallyImplyLeading: false,
        title: Text("More",),

      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                 token==null?SizedBox(): UserMoreTopCard(
                      chefId: chefId, name: name, image: image, role: role),
                  const SizedBox(height: 0),

                ],
              ),
            ),
            SizedBox(height: 16,),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, ABOUT_PAGE);
                //     },
                //     child: MoreCard(
                //         title: "About Eatonomy", svg: "assets/icons/book.svg")
                // ),

                MoreExpandedCard(mergin: 6,title: "About Eatonomy", svg: "assets/icons/book.svg",expandedText: ABOUT_PAGE_CONTENT),
                MoreExpandedCard(mergin: 6,title: "FAQ", svg: "assets/icons/microscope.svg",expandedText: FAQ_TEXT),
                MoreExpandedCard(title: "Privacy Policy", svg: "assets/icons/security-time.svg",expandedText: PRIVICY_POLICY_CONTENT),
                MoreExpandedCard(title: "Terms & Conditions",svg: "assets/icons/document-text.svg",expandedText: PRIVICY_POLICY_CONTENT),


                token==null?SizedBox():  role == "USER" ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, WISH_LIST_PAGE);
                    },
                    child: MoreCard(
                        title: "Wish List", svg: "assets/icons/heart.svg")
                ):SizedBox(),
                // token==null?SizedBox():
                // InkWell(
                //     onTap: () {
                //       role == "USER" ?
                //       Navigator.pushNamed(
                //           context, USER_PROFILE_PAGE, arguments: {
                //         "name": name!,
                //         "mobile": mobile!,
                //         "email": email,
                //         "image": image
                //       }) :
                //       Navigator.pushNamed(
                //           context, CHEF_PROFILE_EDIT_PAGE, arguments:
                //       {
                //         'chef':Get.find<ChefController>().chefDetailsResponse.value!.chef!
                //       });
                //       // Navigator.pushNamed(
                //       //     context, SHEF_PROFILE_PAGE, arguments: {
                //       //   'id': chefId,
                //       //   'localuser': false
                //       // });
                //     },
                //     child: MoreCard(
                //         title: "Profile Update",
                //         svg: "assets/icons/useredit.svg")
                // ),
                token==null?SizedBox():  role == "USER"? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, FOLLOW_CHEF_PAGE);

                    },
                    child: MoreCard(
                        title: "Followed Chef",
                        svg: "assets/icons/profile-tick.svg")
                ):SizedBox(),
                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, FAQ_PAGE);
                //     },
                //     child: MoreCard(
                //         title: "FAQ", svg: "assets/icons/microscope.svg")
                // ),

                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, PRIVACY_PAGE);
                //     },
                //     child: MoreCard(
                //         title: "Privacy Policy",
                //         svg: "assets/icons/document-text.svg")
                // ),
                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(
                //           context, REFUND_PAGE);
                //     },
                //     child: MoreCard(
                //         title: "Refund Policy", svg: "assets/icons/document-text.svg")
                // ),
                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, TERMS_PAGE);
                //     },
                //     child: MoreCard(title: "Terms & conditions",
                //         svg: "assets/icons/document-text.svg")
                // ),
                token==null?SizedBox():   GetBuilder<AuthController>(
                  assignId: true,
                  builder: (controller) {
                    return Obx(() {
                      return controller.circuler.value?LoadingWidget():InkWell(
                          onTap: () {
                            deleteAccountShowAlertDialog(context,controller);
                          },
                          child: MoreCard(title: "Delete Account",
                              svg: "assets/icons/trash.svg")
                      );
                    });
                  },
                ),
                InkWell(
                    onTap: () {
                      token == null ?
                      Navigator.pushNamed(context, LOGIN_PAGE_INTRO)
                          :
                      showAlertDialog(context);
                    },
                    child: MoreCard(title: token == null ? "LogIn/Signup" : "Logout",
                        svg: token == null
                            ? "assets/icons/lamp.svg"
                            : "assets/icons/logout.svg")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  deleteAccountShowAlertDialog(BuildContext context, AuthController controller) {
    // set up the buttons
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            height: 48,
            orderRadius: 24,
            width: 120,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: true,
            title: "Cancel",
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(width: 12,),
        CustomButton(
            height: 48,
            width: 120,
            orderRadius: 24,
            color: kPrimaryColorx,
            textColor: Colors.white,
            boder: false,
            title: "Confirm",
            onTap: () {
              // deleteData(context);
              controller.deleteAccount(context);
              Navigator.pop(context);
            })
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text("Confirmation", style: boldText(20.sp, color: Color(0xFF02190E)),
        textAlign: TextAlign.start,),
      content: SizedBox(
          width: 300,
          child: Text(
              "Are you sure you want to Delete Your Account ?",
              style: regularText(15.sp, color: Color(0xFF5C6360)),
              textAlign: TextAlign.start)),
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CustomButton(
        //     height: 48,
        //     orderRadius: 24,
        //     width: 120,
        //     color: kPrimaryColorx,
        //     textColor: Colors.white,
        //     boder: true,
        //     title: "Cancel",
        //     onTap: () {
        //       Navigator.pop(context);
        //     }),


        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 14),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0x2600934C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50, color: Color(0xFF00934C)),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'No',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00934C),
                fontSize: 14,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(width: 12,),
        InkWell(
          onTap: (){
            deleteData(context);
          },
          child: Container(

            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 14),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFF00934C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Yes',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
        // CustomButton(
        //     height: 48,
        //     width: 120,
        //     orderRadius: 24,
        //     color: kPrimaryColorx,
        //     textColor: Colors.white,
        //     boder: false,
        //     title: "Logout",
        //     onTap: () {
        //       deleteData(context);
        //     })
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text("Log out", style: TextStyle(
          color: Color(0xFF02190E),
          fontSize: 16,
          fontFamily: 'Sora',
          fontWeight: FontWeight.w600,
        ),
          textAlign: TextAlign.start,),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
          child: Text(
              "Are you sure??", style: TextStyle(
            color: Color(0xFF02190E),
            fontSize: 12,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w300,
            height: 0.11,
          ),
              textAlign: TextAlign.start)),
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

  void deleteData(BuildContext context) async {
    var users = await Hive.openBox('users');
    users.clear().then((value) {
      injection();
      init();
    });

    ///update bearer token in api client
    ///update dependencies

    Navigator.pushNamedAndRemoveUntil(
      context, LOGIN_PAGE_INTRO, (route) => false,);
  }


}



