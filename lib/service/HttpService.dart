import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:portal_ofertas_app_cliente/model/Cliente.dart';
import 'dart:convert';

class HttpService {

  //servicio para los clientes
  Future<List<Cliente>> fetchClientes(http.Client client) async{
    Response response = await client.get('http://3.83.230.246/clientes.php');

    if (response.statusCode == 200) {
      List<dynamic> parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      var clientess = parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
      return clientess;
    } else {
      throw "No se puede obtener clientes.";
    }
  }

}