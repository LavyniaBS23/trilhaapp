import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({Key? key}) : super(key: key);

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado;
  int? qntCliques;
  /*final  CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final CHAVE_QNT_CLIQUES = "chave_qnt_cliques";*/
  late Box boxNumerosAleatorios; // late garante que vai ter um valor
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = await boxNumerosAleatorios.get('numeroGerado') ?? 0;
    qntCliques = await boxNumerosAleatorios.get('qntCliques') ?? 0;

    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Hive")),
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
             boxNumerosAleatorios.put('numeroGerado', numeroGerado);
             boxNumerosAleatorios.put('qntCliques', qntCliques);
            }),
      ),
    );
  }
}
