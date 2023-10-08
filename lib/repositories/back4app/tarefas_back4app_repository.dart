import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4app_custom_dio.dart';

class TarefasBack4AppRepository {
  final _customDio = Back4AppCustomDio();
  var _env = DotEnv();

  TarefasBack4AppRepository() {}
  Future<TarefasBack4AppModel> obterTarefas(naoConcluidos) async {
    var url = "/Tarefas";

    if (naoConcluidos) {
      url = "$url?where={\"concluido\":false}";
    }

    var result = await _customDio.dio.get(url);

    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      var response = await _customDio.dio.post("/Tarefas",
          data: tarefaBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      var response = await _customDio.dio.put("/Tarefas/${tarefaBack4AppModel.objectId}",
          data: tarefaBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      var response = await _customDio.dio.delete("/Tarefas/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
