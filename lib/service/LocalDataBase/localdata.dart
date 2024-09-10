
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';



class LocalDataGet{
   getData() async{
    var users= await Hive.openBox('users');

    if(users.get('token')==null){
      print("hive ");
    }else{
      print("hive "+users.get('token'));
    }

    return users;
  }

   Future storeTokenUserdata(
       {String? token,
      String? role,
      String? chefId,
      String? image,
      String? name,
      String? email,
      String? mobile}) async{


     Box? users= Hive.box('users');

     users.put("notificationResister", "none");

     if(token!=null){
       users.put("token", token);
     }
     if(role!=null){
       users.put("role", role);
     }
     if(email!=null){
       users.put("email", email);
     }
     if(name!=null){
       users.put("name", name);
     }
     users.put("chefId", chefId);
     if(mobile!=null){
       users.put("mobile", mobile);
     }
     if(image!=null){
       users.put("image", image);
     }



     Logger().w(users.get('token'));

     return "done";
   }



   /// hive model store methods
  //  Future<String>addItem(CoursesInfo item) async {
  //    var box = await Hive.openBox<CourseDb>('courseDb');
  //    CourseDb clone=CourseDb(
  //      id: item.id,
  //      title:item.title ,
  //      price: item.price,
  //      case_study:item.case_study ,
  //      course_category_id:item.course_category_id ,
  //      course_code: item.course_code,
  //      course_end:item.course_end ,
  //      course_start:item.course_start ,
  //      cover:item.cover,
  //      created_at:item.created_at ,
  //      discount: item.discount,
  //      duration: item.duration,
  //      lang: item.lang,
  //      number_of_user: item.number_of_user,
  //      pdf: item.pdf,
  //      promo_applied:item.promo_applied ,
  //      summary: item.summary,
  //      tags: item.tags,
  //      user_owner_id:item.user_owner_id ,
  //      validity: item.validity,
  //      vat: item.vat,
  //      video: item.video
  //    );
  //
  //
  //    String result="";
  //    if (!box.values.toList().contains(clone)) {
  //      box.add(clone);
  //      result="Successfully add to cart";
  //    }else{
  //      result="Already you add this item in cart";
  //    }
  //    return result;
  //  }
  //
  //
  //  List<CourseDb> _inventoryList = <CourseDb>[];
  //  List get inventoryList => _inventoryList;
  //
  //  Future<List<CourseDb>> getItem() async {
  //    final box = await Hive.openBox<CourseDb>('courseDb');
  //
  //    _inventoryList = box.values.toList();
  //
  //    // Logger().w(_inventoryList.length);
  //
  //    return _inventoryList;
  //  }
  //
  // Future<List<CourseDb>>  removeCourse(int index) async{
  //   final box = await Hive.openBox<CourseDb>('courseDb');
  //
  //   box.deleteAt(index);
  //   _inventoryList = box.values.toList();
  //
  //
  //   return _inventoryList;
  // }
  // Future<List<CourseDb>>  clearCartCourse() async{
  //   final box = await Hive.openBox<CourseDb>('courseDb');
  //
  //   box.clear();
  //   _inventoryList = box.values.toList();
  //
  //
  //   return _inventoryList;
  // }
}