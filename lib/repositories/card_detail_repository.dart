import 'package:trilhaapp/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async{
    await Future.delayed(const Duration(seconds: 3));
    return CardDetail(
        1,
        "Meu Card",
        "https://escolhaideal.org/wp-content/uploads/2023/01/1644436653-768x400.jpg",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum finibus est nec facilisis. Nam nec fringilla mi. Sed ullamcorper faucibus enim, vitae pulvinar arcu ultricies at. Sed scelerisque turpis quis neque fermentum, at rhoncus nisi dictum. Fusce sit amet turpis eget arcu malesuada vehicula. Fusce dignissim nibh elementum mi aliquet dictum. Donec blandit malesuada odio, in efficitur augue pretium vel. Proin sed vestibulum tortor. Morbi nec auctor elit. Phasellus aliquet placerat turpis nec fringilla.");
  }
}
