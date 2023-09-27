import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({Key? key}) : super(key: key);

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  TextEditingController descricaoController = TextEditingController(text: "");

  late TarefaHiveRepository tarefaRepository;
  var _tarefas = const <TarefaHiveModel>[];

  var apenasNaoConcluidos = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async{
    tarefaRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaRepository.obterDados(apenasNaoConcluidos);
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
                    await tarefaRepository.salvar(TarefaHiveModel.criar(descricaoController.text, false));
                    obterTarefas();
                    Navigator.pop(context);
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
                      await tarefaRepository.excluir(tarefa);
                      obterTarefas();
                    },
                    key: Key(tarefa.key),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          tarefa.concluido = value;
                          await tarefaRepository.alterar(tarefa);
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