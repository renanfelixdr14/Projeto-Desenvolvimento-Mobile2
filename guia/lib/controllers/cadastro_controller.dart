import 'package:flutter/material.dart';
import 'package:guia/models/lugares_model.dart';
import 'package:guia/controllers/lugares_controller.dart';
import 'package:provider/provider.dart';

class CadastroController extends ChangeNotifier {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  void limparCampos() {
    nomeController.clear();
    descricaoController.clear();
    categoriaController.clear();
    latitudeController.clear();
    longitudeController.clear();
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose(); 
    categoriaController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  Future<void> salvarLugar(BuildContext context) async {
    final nome = nomeController.text;
    final descricao = descricaoController.text;
    final categoria = int.tryParse(categoriaController.text);
    final latitude = double.tryParse(latitudeController.text);
    final longitude = double.tryParse(longitudeController.text);

    
    if (nome.isEmpty || descricao.isEmpty || latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha Nome, Descrição, Latitude e Longitude corretamente.')),
      );
      return;
    }

    final novoLugar = LugaresModel(
      id: 0,
      nome: nome,
      descricao: descricao,
      categoriaId: categoria,
      latitude: latitude,
      longitude: longitude,
    );

    final lugaresController = Provider.of<LugaresController>(context, listen: false);
    final resposta = await lugaresController.cadastrarLugar(novoLugar);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resposta)));
      
      if (!resposta.toLowerCase().contains("erro") && !resposta.toLowerCase().contains("não autorizado")) {
        lugaresController.listarLugares(); 
        limparCampos(); 
        Navigator.pop(context);
      }
    }
  }
}