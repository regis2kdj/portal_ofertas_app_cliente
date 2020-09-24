import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:portal_ofertas_app_cliente/model/Cliente.dart';
import 'package:portal_ofertas_app_cliente/model/Usuario.dart';
import 'package:portal_ofertas_app_cliente/model/Oferta.dart';
import 'package:portal_ofertas_app_cliente/model/ProductoOferta.dart';
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

  //servicio para autenticacion
 Future<Usuario> fetchLogin(http.Client client, String user, String password) async{
    Response response = await client.post('http://3.83.230.246/validate.php?username='+user+'&pass='+password);
    if(response.statusCode == 200){
      try {
        var parsed = json.decode(response.body);
        var usuario = Usuario.fromJson(parsed);
        return usuario;
      } catch (error) {
          throw new Exception("Usuario o contraseña inválidos");
      }
    }else{
      throw "Usuario o contraseña inválidos";
    }
 }

 //buscar ofertas de produtos comprados
  Future<ProductoOferta> obtenerProducto(String producto) async {
    String url = 'http://3.83.230.246/ordenIndv.php?idOrden='+producto;

    final response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return ProductoOferta.fromJson(json.decode(response.body));
    } else {
      throw ('Producto no encontrado. Favor volver a intentar con un valor distinto');
    }
  }

  //listar todos los productos
  Future<List<Oferta>> fetchPhotos(http.Client client) async {
    final response =
    await client.get('http://3.83.230.246/productos.php');

    final parsed = jsonDecode(clearDesc(response.body)).cast<Map<String, dynamic>>();

    return parsed.map<Oferta>((json) => Oferta.fromJson(json)).toList();
  }

  //utileria
  String clearDesc(String desc) {
    String newDesc = desc;
    newDesc=newDesc.replaceAll('<p>', '');
    newDesc=newDesc.replaceAll('</p>', '');
    newDesc=newDesc.replaceAll('<strong>', '');
    newDesc=newDesc.replaceAll('</strong>', '');
    newDesc=newDesc.replaceAll('<br>', '');
    newDesc=newDesc.replaceAll('<br />', '');
    return newDesc;
  }
}

//clase de buscar oferta
class DatosApp {
  String idOferta;
  DatosApp({this.idOferta});
}

//clase de sesion
class SesionApp {
  String username;
  SesionApp({this.username});
}