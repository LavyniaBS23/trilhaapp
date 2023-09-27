import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() => _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

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
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text = (await (storage.getConfiguracoesAltura())).toString();
    receberNotificacoes = await storage.getConfiguracoesReceberNotificacoes();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
    setState(() {});
  }

   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Configurações")),
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
                      value: receberNotificacoes,
                      onChanged: (bool value) {
                        setState(() {
                          receberNotificacoes = !receberNotificacoes;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Tema escuro"),
                      value: temaEscuro,
                      onChanged: (bool value) {
                        setState(() {
                          temaEscuro = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        try {
                          await storage.setConfiguracoesAltura(double.parse(alturaController.text));
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
                        await storage.setConfiguracoesNomeUsuario(nomeUsuarioController.text);

                        await storage.setConfiguracoesReceberNotificacoes( receberNotificacoes);

                        await storage.setConfiguracoesTemaEscuro(temaEscuro);

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
