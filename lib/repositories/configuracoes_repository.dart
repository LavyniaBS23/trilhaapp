import 'package:hive/hive.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._criar();

  Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen('Configuracoes')) {
      _box = Hive.box('Configuracoes');
    } else {
      _box = await Hive.openBox('Configuracoes');
    }
    return ConfiguracoesRepository._criar();
  }

  void salvar(ConfiguracoesModel configuracoesModel){
    _box.put('ConfiguracoesModel', {
      'nomeUsuario' : configuracoesModel.nomeUsuario,
      'altura' : configuracoesModel.altura,
      'receberNotificacoes' : configuracoesModel.receberNotificacoes,
      'temaEscuro' : configuracoesModel.temaEscuro
    });
  }

  ConfiguracoesModel obterDados(){
    var configuracoes = _box.get('configuracoesModel');

    if(configuracoes == null){
      return ConfiguracoesModel.vazio();
    }

    return ConfiguracoesModel(
      configuracoes['nomeUsuario'],
      configuracoes['altura'],
      configuracoes['receberNotificacoes'], configuracoes['temaEscuro']);
  }
}
