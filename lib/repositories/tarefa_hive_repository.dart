import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';

class TarefaHiveRepository {
  static late Box _box;

  TarefaHiveRepository._criar();

  static Future<TarefaHiveRepository> carregar() async {
    if (Hive.isBoxOpen('tarefaHiveModel')) {
      _box = Hive.box('tarefaHiveModel');
    } else {
      _box = await Hive.openBox('TarefaHiveModel');
    }
    return TarefaHiveRepository._criar();
  }

  salvar(TarefaHiveModel tarefa) {
    _box.add(TarefaHiveModel());
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if(naoConcluido){
      return _box.values.cast<TarefaHiveModel>().where((element) => !element.concluido).toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }

  alterar(TarefaHiveModel tarefaHiveModel){
    tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel){
    tarefaHiveModel.delete();
  }

}
