import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portal_ofertas_app_cliente/model/Cliente.dart';
import 'package:portal_ofertas_app_cliente/service/HttpService.dart';
import 'package:portal_ofertas_app_cliente/pantallas/InicioSesion.dart';
import 'package:portal_ofertas_app_cliente/pantallas/RegistroUsuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class Bienvenida extends StatefulWidget {
  Bienvenida({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BienvenidaState createState() => _BienvenidaState();
}

//buena estrategia de los botones de bienvenida le dan un paso a paso para llamar los servicios
class _BienvenidaState extends State<Bienvenida> {
  HttpService httpService = HttpService();
  List<Cliente> clientte;

  //widget del submit cuando aprieta el boton iniciar sesion
  //ok
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        List<Cliente> client = clientte;
        Navigator.push(context, MaterialPageRoute(builder: (context) => InicioSesion(client : client)));
      },
      //ah estos son los elementos user y paswd
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffbdbdbd).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Iniciar Sesión', //así se llama el boton que invoca a: http://3.83.230.246/clientes.php
          style: TextStyle(fontSize: 20, color: Color(0xff01579b)),
        ),
      ),
    );
  }

  //este wid es para ele registro
  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          //servicio para segundo release aqui se llama y se hace post
            context, MaterialPageRoute(builder: (context) => RegistroUsuario()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Registrarse',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  //cuando se use este wid estará nice!
  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Inicio rapido con Huella ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Huella ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Bienvenidos al Portal de Ofertas!',
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: '',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff01579b), Color(0xff303030)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 30,
              ),
              Center(
                child: FutureBuilder<List<Cliente>>(
                  future: httpService.fetchClientes(http.Client()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      clientte = snapshot.data;
                      print("clientes encontrados");
                      return Text("");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}",
                        style: TextStyle(color: Colors.white.withOpacity(0.6)),);
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
              _submitButton(),
              SizedBox(
                height: 15,
              ),
              _signUpButton(),
              SizedBox(
                height: 15,
              ),
              _label(),
            ],
          ),
        ),
      ),
    );
  }
}