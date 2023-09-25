import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetail cardDetail;

  const CardDetailPage({Key? key, required this.cardDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: SafeArea(
        child: Scaffold(
         // appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                      Image.network(cardDetail.url,
                          // width: 20,
                          height: 100),
                    ],
                  ),
                  Text(cardDetail.title,
                      style:
                          const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(cardDetail.text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
