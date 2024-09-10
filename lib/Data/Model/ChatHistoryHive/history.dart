import 'package:hive/hive.dart';
part 'history.g.dart';


@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  String? qus;
  @HiveField(1)
  String? date;

  History({
     this.qus,
     this.date,
  });
}