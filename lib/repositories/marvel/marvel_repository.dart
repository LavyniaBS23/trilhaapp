import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:dotenv/dotenv.dart';
import 'package:hex/hex.dart';

class MarvelRepository{
  Future<CharactersModel> getCharacters(int offset) async{
    var dio = Dio();
    var env = DotEnv();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = env["MARVELPUBLIC"] ?? "";
    var privateKey = env["MARVELAPIKEY"] ?? "";

    var hash = generateMd5(ts + privateKey + publicKey);
    var query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";
    var result = await dio.get("https://gateway.marvel.com/v1/public/characters?$query");

    var charactersModel = CharactersModel.fromJson(result.data);

    return charactersModel;
  }

  generateMd5(String data){
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return HEX.encode(digest.bytes);
  }
}