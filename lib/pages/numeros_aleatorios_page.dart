import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({Key? key}) : super(key: key);

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado;
  int? qntCliques;
  /*final  CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final CHAVE_QNT_CLIQUES = "chave_qnt_cliques";*/
  AppStorageService storage =
      AppStorageService(); // late garante que vai ter um valor
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumerosAleatoriosNumeroGerado();
    qntCliques = await storage.getNumerosAleatoriosQntCliques();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Gerador de números")),
        body: Container(
            alignment: Alignment.center, //centraliza horizontalmente
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //vertical
              children: [
                Text(
                  numeroGerado == null
                      ? "Nenhum número gerado"
                      : numeroGerado.toString(),
                  style: const TextStyle(fontSize: 22),
                ),
                Text(
                  qntCliques == null
                      ? "Nenhum clique efetuado"
                      : qntCliques.toString(),
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              //await storage.remove(CHAVE_NUMERO_ALEATORIO);
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                qntCliques = qntCliques! + 1;
              });
              await storage.setNumerosAleatoriosNumeroGerado(
                  numeroGerado!); //! garante que o número não é nulo
              await storage.setNumerosAleatoriosQntCliques(qntCliques!);
            }),
      ),
    );
  }
}
