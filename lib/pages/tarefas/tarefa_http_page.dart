import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/model/tarefa_sqlite_model.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';
import 'package:trilhaapp/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({Key? key}) : super(key: key);

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TextEditingController descricaoController = TextEditingController(text: "");

  TarefasBack4AppRepository tarefaRepository = TarefasBack4AppRepository();
  var _tarefasBack4App = TarefasBack4AppModel([]);

  var apenasNaoConcluidos = false;
  var carregando = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async{
    setState(() {
      carregando = true;
    });
    _tarefasBack4App = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tarefas Http")),
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
                    await tarefaRepository.criar(TarefaBack4AppModel.criar(descricaoController.text, false));
                    
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
            carregando ? const CircularProgressIndicator() : Expanded(
              child: ListView.builder(
                itemCount: _tarefasBack4App.tarefas.length,
                itemBuilder: (BuildContext bc, int index){
                  var tarefa = _tarefasBack4App.tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefaRepository.remover(tarefa.objectId);
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