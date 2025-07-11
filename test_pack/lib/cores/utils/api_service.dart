import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:test_pack/features/posts/data/models/post_model.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

// remember to study headers and options   VIP

//  To only fetch, not to parse or manipulate data
// This service is responsible for making API calls and returning the raw data without any additional processing.
class ApiService {
  final Dio _dio;

  final baseUrl = "https://jsonplaceholder.typicode.com/";

  ApiService(this._dio);

  Future<List<dynamic>> get({required String endPoint}) async {
    var response = await _dio.get(
      '$baseUrl$endPoint',
      options: optionsKareem(),
    );
    return response.data;
  }

  List<PostEntity> getDataList({required List<dynamic> data, itemKey}) {
    List<PostEntity> dataList = [];
    for (var itemMap in data) {
      dataList.add(PostModel.fromJson(itemMap));
    }

    return dataList;
  }

  Future<void> addPost(PostEntity post) async {
    final response = await _dio.post(
      "$baseUrl/posts",
      data: post,
      options: optionsKareem(),
    );
    log("on addition ${response.data}");
  }

  Future<void> deletePosst(int id) async {
    final response = await _dio.delete(
      '$baseUrl/posts/$id',
      options: optionsKareem(),
    );

    log("on deletion  ${response.data} ");
    // return response.data;
  }

  Future<void> updatePost(PostEntity post) async {
    final response = await _dio.patch(
      "$baseUrl/posts/${post.id}",
      data: post,
      //  options: Options(headers: {"Content-Type": "application/json"}),
      options: optionsKareem(),
    );
    log("on update  ${response.data} ");
  }

  optionsOmran() {
    return Options(headers: {"Content-Type": "application/json"});
  }

  optionsKareem() {
    return Options(
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      },
    );
  }
}
