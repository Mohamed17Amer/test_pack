import 'package:hive/hive.dart';
 part 'post_entity.g.dart';
@HiveType(typeId: 0)
class PostEntity extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
    String? title;
  @HiveField(2)
   String? body;

  PostEntity({this.id, required this.title, required this.body});
}
// flutter packages pub run build_runner build