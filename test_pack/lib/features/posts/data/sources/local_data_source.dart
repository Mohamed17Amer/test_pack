import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_pack/cores/utils/constants.dart';
import 'package:test_pack/cores/utils/hive_services.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

abstract class LocalDataSource {
List<PostEntity> fetchPosts();
}

class LocalDataSourceImpl implements LocalDataSource {
  final HiveServices hiveServices;
  LocalDataSourceImpl(this.hiveServices);
  @override
  List<PostEntity> fetchPosts() {
    var box = Hive.box<PostEntity>(postsBox);
    int length = box.values.length;
    if (length == 0) {
      return [];
    } else {
      return box.values.toList();
    }
  }
}
