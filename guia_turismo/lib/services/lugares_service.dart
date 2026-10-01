import 'package:guia_turismo/models/lugares_model.dart';
import 'package:http/http.dart' as http;


class LugaresService {
  String endpoint = "https://guiaturismo.onrender.com";
  int pagina = 1;
  int limite = 10;


  Future<List<LugaresModel> buscarLugares() async{
    try {
      final response = await http.get(Uri.parse(endpoint));
      if(response.statusCode == 200) {
        
      }
    } catch(e) {

    }
  }
}
