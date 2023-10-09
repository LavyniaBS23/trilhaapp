import 'dart:convert';

import 'package:trilhaapp/model/comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/repositories/comments/comment_repository.dart';

class CommentHttpRepository implements CommentRepository{
  
  @override
  Future<List<CommentModel>> retornaComentarios(int posId) async {
    var response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/$posId/comments"));

    if (response.statusCode == 200) {
      var jsonComments = jsonDecode(response.body);

      return (jsonComments as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
