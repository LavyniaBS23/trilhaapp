import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  /*final CHAVE_NOME_USUARIO = "nome_usuario";
  final CHAVE_ALTURA = "altura";
  final CHAVE_RECEBER_NOTIFICACOES = "receber_notificacoes";
  final CHAVE_TEMA_ESCURO = "tema_escuro";*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
  }

   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Configurações Hive")),
            body: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: nomeUsuarioController,
                      decoration:
                          const InputDecoration(hintText: "Nome usuário"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: alturaController,
                      decoration: const InputDecoration(hintText: "Altura"),
                    ),
                  ),
                  SwitchListTile(
                      title: const Text("Receber Notificações"),
                      value: configuracoesModel.receberNotificacoes,
                      onChanged: (bool value) {
                        setState(() {
                          configuracoesModel.receberNotificacoes = value;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Tema escuro"),
                      value: configuracoesModel.temaEscuro,
                      onChanged: (bool value) {
                        setState(() {
                          configuracoesModel.temaEscuro = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        try {
                          configuracoesModel.altura = double.parse(alturaController.text);
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("Meu App"),
                                  content: const Text(
                                      "Favor informar uma altura válida!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"))
                                  ],
                                );
                              });
                        }
                        configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                        configuracoesRepository.salvar(configuracoesModel);
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"))
                ],
              ),
            )));
  }
}

/**
 * 
 * import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  
}
 */
