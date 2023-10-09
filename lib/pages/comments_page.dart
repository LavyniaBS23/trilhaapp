import 'package:flutter/material.dart';
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comment_repository.dart';

import '../repositories/comments/impl/comment_dio_repository.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentRepository commentsRepository;
  var comments = <CommentModel>[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
    commentsRepository = CommentDioRepository();
  }

  carregarDados() async {
    comments = await commentsRepository.retornaComentarios(widget.postId);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Comentários do Post: ${widget.postId}"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18
          ),
          child: comments.isEmpty ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: comments.length,
          itemBuilder: (_, int index){
          var comment = comments[index];
          return Card(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(comment.name.substring(6)),
                      Text(comment.email),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(comment.body),
                ],
              ),
            )
          );
        })),
      )
    );
  }
}

class CommentsRepository {
}