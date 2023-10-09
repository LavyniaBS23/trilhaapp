import 'dart:convert';
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDioRepository implements PostsRepository{

  @override
  Future<List<PostModel>> getPosts() async {
    var jsonPlaceholderCustomDio = JsonPlaceholderCustomDio();
    var response = await jsonPlaceholderCustomDio.dio.get("/posts");

    if(response.statusCode == 200){
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}