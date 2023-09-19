import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';
import 'package:trilhaapp/pages/pagina1.dart';
import 'package:trilhaapp/pages/pagina2.dart';
import 'package:trilhaapp/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 int posicaoPagina = 0;
 PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main Page"),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: const Text("Dados Cadastrais")
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: const Text("Termos de uso e privacidade")
                    ),
                  onTap: (){}
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: const Text("Configurações")
                    ),
                  onTap: (){}
                ),
              ],
            ),
          )
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value){
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                //scrollDirection: Axis.vertical,
                children: const [
                  Pagina1Page(),
                  Pagina2Page(),
                  Pagina3Page(),
                ],
              ),
            ),
            BottomNavigationBar(
              onTap: (value){
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items:const [
                BottomNavigationBarItem(
                  label: "Pag1", 
                  icon: Icon(Icons.home)
                ),
                BottomNavigationBarItem(
                  label: "Pag2", 
                  icon: Icon(Icons.add)
                ),
                BottomNavigationBarItem(
                  label: "Pag3", 
                  icon: Icon(Icons.person)
                ),
              ])
          ],
        )
      ),
    );
  }
}



















































/*import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trilhaapp/service/gerador_numero_aleatorio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var numeroGerado = 0;
  var quantidadeCliques = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu App", /*style: GoogleFonts.pacifico()*/),
      ),
      body: Container(
        width: double.infinity,
        //margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Center(child: Text("O número gerado foi $numeroGerado", style: GoogleFonts.acme(fontSize: 20))),
            //Center(child: Text("Foi clicado $quantidadeCliques vezes", style: GoogleFonts.acme(fontSize: 20)))
            SizedBox(/*serve para fixar o tamanho*/
              width: 100,
              height: 100,
              child: Container(
                color: Colors.blueGrey, 
                child: Text("Foi clicado $quantidadeCliques vezes", style: GoogleFonts.acme(fontSize: 20))
              )
            ),
            Text("O número gerado foi $numeroGerado", style: GoogleFonts.acme(fontSize: 20)),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue, 
                    child: Text("Nome", style: GoogleFonts.acme(fontSize: 20))
                  )),
                Expanded(flex: 3, child: Container(color: const Color.fromARGB(255, 208, 243, 33), child: Text("Danilo Perez", style: GoogleFonts.acme(fontSize: 20)))),
                Expanded(flex: 2, child: Container(color: const Color.fromARGB(255, 33, 243, 65), child: Text("30", style: GoogleFonts.acme(fontSize: 20))),)
              ],
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_box),
        onPressed: () {
          setState(() {
            numeroGerado = GeradorNumeroAleatorioService.gerarNumeroAleatorio(10);
            quantidadeCliques = quantidadeCliques + 1;
          });
        },
      ),
    );
  }
}*/
