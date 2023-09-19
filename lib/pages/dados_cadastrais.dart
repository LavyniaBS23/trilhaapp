import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import '/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");

  DateTime? dataNascimento; //pode aceitar nulo

  var nivelRepository = NivelRepository();
  var linguagemRepository = LinguagemRepository();
  var niveis = [];
  var linguagens = [];
  var linguagensSelecionadas = [];
  var nivelSelecionado = "";
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;

  bool salvando = false;

  @override
  void initState() {
    //TODO: implement initState
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagemRepository.retornaLinguagens();
    super.initState();
  }

  List<DropdownMenuItem<int>> returnItens(int qntMax) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= qntMax; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  /*Text returnText(String texto) {
    return Text(
      texto,
       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus Dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                //returnText("Nome"),
                const TextLabel(texto: "Nome"),
                TextField(
                  controller: nomeController,
                ),
                const TextLabel(texto: "Data de Nascimento"),
                TextField(
                  controller: dataNascimentoController,
                  readOnly: true,
                  onTap: () async {
                    var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000, 1, 1),
                        firstDate: DateTime(1900, 5, 20),
                        lastDate: DateTime(2023, 10, 23));
                    if (data != null) {
                      dataNascimentoController.text = data.toString();
                      dataNascimento = data;
                    }
                  },
                ),
                const TextLabel(texto: "Nivel de experiência"),
                Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected: nivelSelecionado == nivel,
                            value: nivel.toString(),
                            groupValue: nivelSelecionado,
                            onChanged: (value) {
                              setState(() {
                                nivelSelecionado = value.toString();
                              });
                            }))
                        .toList()),
                const TextLabel(texto: "Linguagens Preferidas"),

                Column(
                  children: linguagens
                      .map((linguagem) => CheckboxListTile(
                          dense: true,
                          title: Text(linguagem),
                          value: linguagensSelecionadas.contains(linguagem),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() {
                                linguagensSelecionadas.add(linguagem);
                              });
                            } else {
                              setState(() {
                                linguagensSelecionadas.remove(linguagem);
                              });
                            }
                          }))
                      .toList(),
                ),

                const TextLabel(texto: "Tempo de experiência"),
                DropdownButton(
                    value: tempoExperiencia,
                    isExpanded: true,
                    items: returnItens(50),
                    onChanged: (value) {
                      setState(() {
                        tempoExperiencia = int.parse(value.toString());
                      });
                    }),

                TextLabel(
                    texto:
                        "Pretensão Salarial. R\$ ${salarioEscolhido.round().toString()}"),
                Slider(
                    min: 0,
                    max: 10000,
                    value: salarioEscolhido,
                    onChanged: (double value) {
                      setState(() {
                        salarioEscolhido = value;
                      });
                    }),

                TextButton(
                  onPressed: () {
                    if (nomeController.text.trim().length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("O nome deve ser preenchido")));
                      return;
                    }

                    if (dataNascimento == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data de nascimento inválida")));
                      return;
                    }

                    if (nivelSelecionado.trim() == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "O nível de experiência deve ser selecionado")));
                      return;
                    }

                    if (linguagensSelecionadas.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Deve ser selecionado ao menos uma linguagem")));
                      return;
                    }

                    if (tempoExperiencia == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Deve ter ao menos um ano de experiência em uma das linguagens")));
                      return;
                    }

                    if (salarioEscolhido == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "A pretensão salarial deve ser maior que 0")));
                      return;
                    }

                    setState(() {
                      salvando = true;
                    });

                    Future.delayed(const Duration(seconds: 2), () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Dados salvos com sucesso")));

                      setState(() {
                      salvando = false;
                    });/*nesse caso não precisa, mas pro caaso de continuar na msm página sim*/
                    Navigator.pop(context);
                    });
                    
                  },
                  child: const Text("Salvar"),
                )
              ]),
      ),
    );
  }
}