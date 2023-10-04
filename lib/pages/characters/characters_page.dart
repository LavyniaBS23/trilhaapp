import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage>{

  ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();

  int offset = 0;

  var carregando = false;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() { 
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if( _scrollController.position.pixels > posicaoParaPaginar){
        carregarDados();
      }

    });
    marvelRepository = MarvelRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async{
    if(carregando) return;
    if(characters.data == null || characters.data!.results == null){
      characters = await marvelRepository.getCharacters(offset);
    }else{
      setState(() {
        carregando = true;
      });
      offset = offset + characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    
    setState(() {});
  }

  int retornaQuantidadeTotal(){
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual(){
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Heróis: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}")
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null
                || characters.data!.results == null) ? 0 : characters.data!.results!.length,
                itemBuilder: (_, int index){
                  var character = characters.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network("${character.thumbnail!.path!}.${character.thumbnail!.extension!}", width: 150, height: 150,)),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(character.name!, style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                                )),
                                Text(character.description!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  );
                }),
            ),
            !carregando ? ElevatedButton(
              onPressed: (){
                carregarDados();
              },
              child: const Text("Carregar mais itens")) : const CircularProgressIndicator()
          ],
        ),
        )

    );
  }
}

