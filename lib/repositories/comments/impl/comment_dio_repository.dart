import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comment_repository.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';

class CommentDioRepository implements CommentRepository {
  
  @override
  Future<List<CommentModel>> retornaComentarios(int posId) async {
    var jsonPlaceholderCustomDio = JsonPlaceholderCustomDio();
    var response = await jsonPlaceholderCustomDio.dio
        .get("posts/$posId/comments");

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
