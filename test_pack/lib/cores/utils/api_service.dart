import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_pack/features/posts/data/models/post_model.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

//  To only fetch, not to parse or manipulate data
// This service is responsible for making API calls and returning the raw data without any additional processing.
class ApiService {
  final Dio _dio;

  final baseUrl = "https://jsonplaceholder.typicode.com/";

  ApiService(this._dio);

  Future<List<dynamic>> get({required String endPoint}) async {
    var response = await _dio.get(
      '$baseUrl$endPoint',
      options: Options(
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        },
      ),
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

  // Future<Map<String, dynamic>> get({required String endPoint}) async {
  //   var response = await _dio.get(
  //     '$baseUrl$endPoint',
  //     options: Options(
  //       headers: {
  //         'User-Agent':
  //             'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
  //         'Accept':
  //             'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  //       },
  //     ),
  //   );
  //   log(response.data.toString());
  //   return response.data;
  // }

  // // get response.data as Map<String, dynamic>,
  // // it contains a list of books in 'items' key
  // // convert to List<BookEntity>

  // List<PostEntity> getDataList({
  //   required Map<String, dynamic> data,
  //   required itemKey,
  // }) {
  //   //List<PostEntity>

  //   List<PostEntity> dataList = []; // List<Entity>
  //   for (var itemMap in data[itemKey]) {
  //     dataList.add(PostModel.fromJson(itemMap));
  //   }
  //   log(dataList.toString());
  //   return dataList;
  // }
  // */

  void deletePosst(int id) async {
    final response = await _dio.delete(
      '$baseUrl/posts/$id',
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    log("on deletion  ${response.data} ");
    // return response.data;
  }

  Future<PostEntity> updatePost(PostEntity post) async {
    final response = await _dio.patch("$baseUrl/posts/${post.id}", data: post);

    log("on update  ${response.data} ");
    return PostModel.fromJson(response.data);
  }

  Future<void> addPost(PostEntity post) async {
    final response = await _dio.post("$baseUrl/posts", data: post);
    log("on addition ${response.data}");
  }
}
