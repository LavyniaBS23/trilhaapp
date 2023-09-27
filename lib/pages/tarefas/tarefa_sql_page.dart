import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/model/tarefa_sqlite_model.dart';
import 'package:trilhaapp/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaSQLPage extends StatefulWidget {
  const TarefaSQLPage({Key? key}) : super(key: key);

  @override
  State<TarefaSQLPage> createState() => _TarefaSQLPageState();
}

class _TarefaSQLPageState extends State<TarefaSQLPage> {
  TextEditingController descricaoController = TextEditingController(text: "");

  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  var _tarefas = const <TarefaSQLiteModel>[];

  var apenasNaoConcluidos = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async{
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), 
      onPressed: (){
        descricaoController.text = "";
        showDialog(
          context: context, 
          builder: (BuildContext bc){
            return  AlertDialog(
              title: const Text("Adicionar Tarefa"),
              content: TextField(
                controller: descricaoController,
              ),
              actions: [
                TextButton(
                  onPressed: (){
                      Navigator.pop(context);
                  }, 
                  child: const Text("Cancelar")
                  ),
                  TextButton(
                  onPressed: () async{
                    await tarefaRepository.salvar(TarefaSQLiteModel(0,descricaoController.text, false));
                    
                    Navigator.pop(context);
                    obterTarefas();
                    setState(() {});
                  }, 
                  child: const Text("Salvar")
                  )
              ],
            );
          });
      }),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Apenas não concluídos", style: TextStyle(fontSize: 18)),
                  Switch(
                    value: apenasNaoConcluidos, 
                    onChanged: (bool value){
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    }
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index){
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefaRepository.remover(tarefa.id);
                      obterTarefas();
                    },
                    key: Key(tarefa.descricao),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          tarefa.concluido = value;
                          await tarefaRepository.atualizar(tarefa);
                          obterTarefas();
                        },
                        value: tarefa.concluido
                        ),
                    ),
                  );
                },
                ),
            ),
          ],
        ),
      )
    );
  }
}