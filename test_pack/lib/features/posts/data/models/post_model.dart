import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({int? id, required String title, required String body})
    : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // return from the same class type -- solid principles of OOP
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    // not  factory, because it doesn't return the same class type
    return {'id': id, 'title': title, 'body': body};
  }
}
//
