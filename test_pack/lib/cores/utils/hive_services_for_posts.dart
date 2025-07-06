import 'package:hive/hive.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

class HiveServicesForPosts {
   void savePostsData(List<PostEntity> itemsListTobeCached, String boxName) {
    var box = Hive.box<PostEntity>(boxName);
    box.addAll(itemsListTobeCached);
  }

     void clearPostsData( String boxName) {
    var box = Hive.box<PostEntity>(boxName);
    box.clear();
  }
}
