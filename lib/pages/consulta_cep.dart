import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({Key? key}) : super(key: key);

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viaCepModel = ViaCepModel();
  var viaCepRepository = ViaCepRepository();

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text("Consulta de CEP", style: TextStyle(fontSize: 22)),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              //maxLength: 8,
              onChanged: (String value) async {
                //var cep = value.trim().replaceAll(".", "");

                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viaCepModel = await viaCepRepository.consultarCep(cep);
                }
                setState(() {
                  loading = false;
                });
              },
            ),
            const SizedBox(height: 50),
            Text(viaCepModel.logradouro ?? "",
                style: const TextStyle(fontSize: 22)),
            Text("${viaCepModel.localidade ?? ""} - ${viaCepModel.uf ?? ""}",
                style: const TextStyle(fontSize: 22)),
            //if (loading) CircularProgressIndicator(),
            Visibility(
              visible: loading,
              child: const CircularProgressIndicator(),
            )
          ],
        ),
      ),
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
          }),
    ));
  }
}
