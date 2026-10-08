import 'package:flutter/foundation.dart';
import 'package:guia/models/lugares_model.dart';
import 'package:guia/services/lugares_service.dart';
import 'package:guia/services/session_service.dart';

class LugaresController extends ChangeNotifier {
  bool carregando = false;
  String erro = "";
  List<LugaresModel> _lugares = [];
  List<LugaresModel> get lugares => _lugares;

  //inicializar
  LugaresController(){
    listarLugares();
  }

  Future<void> listarLugares() async {
    carregando = true;
    notifyListeners(); // informar que algo mudou
    try {
      final lugaresService = LugaresService();
      final listarLugares = await lugaresService.buscarLugares();
      _lugares = List<LugaresModel>.from(listarLugares);
    } catch (error) {
      erro = 'Erro ao listar: ${error.toString()}';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<String> cadastrarLugar(LugaresModel dados) async {
    //final token = await SessionService().pegarToken() ?? '';
    carregando = true;
    erro = "";
    notifyListeners();
    try {
      final lugaresService = LugaresService();
      final resposta = await lugaresService.cadastrarLugar(dados, "");
      return resposta;
    } catch (e) {
      erro = "Erro ao cadastrar: $e";
      return erro;
    }finally {
      carregando = false;
      notifyListeners();
    }
  }
}