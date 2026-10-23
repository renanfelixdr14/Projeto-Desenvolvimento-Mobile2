import 'package:flutter/foundation.dart';
import 'package:guia/models/lugares_model.dart';
import 'package:guia/services/lugares_service.dart';
import 'package:guia/services/session_service.dart';

class LugaresController extends ChangeNotifier {
  bool carregando = false;
  String erro = "";
  List<LugaresModel> _lugares = [];
  List<LugaresModel> get lugares => _lugares;

  LugaresController(){
    listarLugares();
  }

  Future<void> listarLugares() async {
    carregando = true;
    notifyListeners();
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
    carregando = true;
    erro = "";
    notifyListeners();
    try {
      final token = await SessionService().pegarToken() ?? '';
      final lugaresService = LugaresService();
      final resposta = await lugaresService.cadastrarLugar(dados, token);
      return resposta;
    } catch (e) {
      erro = "Erro ao cadastrar: $e";
      return erro;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }
}