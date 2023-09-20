import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';
import 'package:trilhaapp/pages/login_page.dart';


class CustomDrawer extends StatelessWidget{
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      context: context,
                      builder: (BuildContext bc){
                        return  Wrap(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: const Text("Câmera"),
                              leading: const Icon(Icons.camera),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: const Text("Galeria"),
                              leading: const Icon(Icons.album),
                            ),
                          ],
                        );
                      }
                    );
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.orange),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network("https://escolhaideal.org/wp-content/uploads/2023/01/1644436653-768x400.jpg")),
                    accountName: const Text("Lavynia Barbosa"), accountEmail: const Text("email@email.com")),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 5),
                        Text("Dados Cadastrais"),
                      ],
                    )
                    ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  const DadosCadastraisPage(
                        )));
                  }
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 5),
                        Text("Termos de uso e privacidade"),
                      ],
                    )
                    ),
                  onTap: (){
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      context: context, 
                      builder:(BuildContext bc){
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        child: const Column(
                          children: [
                            Text("Termos de uso e privacidade", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            )),
                            SizedBox(height: 20),
                            Text('Sed in augue velit. Cras consequat metus at ante fringilla, nec elementum dui molestie. Sed ut erat at magna condimentum posuere in eu sem. Pellentesque eget varius lectus. Sed sem ipsum, consequat a ultricies vitae, condimentum in nibh.',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,

                            )),
                          ],
                        ),
                      );
                    });
                  }
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.album),
                        SizedBox(width: 5),
                        Text("Configurações"),
                      ],
                    )
                    ),
                  onTap: (){}
                ),

                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 5),
                        Text("Sair"),
                      ],
                    )
                    ),
                  onTap: (){
                    showDialog(
                      context: context, 
                      builder: (BuildContext bc){
                        return  AlertDialog(
                          alignment: Alignment.centerLeft,
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: const Text("Meu app", style: TextStyle(fontWeight: FontWeight.bold)),
                          content: const Wrap(
                            children: [
                              Text("Você sairá do aplicativo!"),
                              Text("Deseja realmente sair do aplicativo?"),
                            ]
                          ),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              }, 
                              child: const Text("Não")
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                              }, child: const Text("Sim")
                            ),
                          ]
                        );
                      });
                  }
                ),
              ],
            ),
          )
        );
  }
}

/*class MyWidget extends StatelessWidget{
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  }
}*/