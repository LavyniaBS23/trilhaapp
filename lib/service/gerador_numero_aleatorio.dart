import 'dart:math';

class GeradorNumeroAleatorioService {
  static int gerarNumeroAleatorio(int maximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(maximo);
  }
}
