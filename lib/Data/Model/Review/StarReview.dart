// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import '../Location/LocationModel.dart';


part 'StarReview.g.dart';

@JsonSerializable()
class StarReview{


  num? rating;
  num? percentage;


  StarReview(this.rating, this.percentage);

  factory StarReview.fromJson(Map<String,dynamic>json)=>
      _$StarReviewFromJson(json);
  Map<String,dynamic>toJson()=>_$StarReviewToJson(this);
}