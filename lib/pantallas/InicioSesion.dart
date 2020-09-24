import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portal_ofertas_app_cliente/pantallas/RegistroUsuario.dart';
import 'package:portal_ofertas_app_cliente/pantallas/MenuPrincipal.dart';
import 'package:portal_ofertas_app_cliente/pantallas/app.dart';
import 'package:portal_ofertas_app_cliente/pantallas/last_page.dart';
import 'package:portal_ofertas_app_cliente/service/HttpService.dart';
import 'package:portal_ofertas_app_cliente/model/Cliente.dart';
import 'package:portal_ofertas_app_cliente/model/Usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'widget/BezierContainer.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({Key key, this.title, this.client}) : super(key: key);

  final String title;
  final List<Cliente> client;

  @override
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  //servicio
  HttpService httpService = HttpService();

  //para uso del formulario
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController  userEntry = new TextEditingController();
  TextEditingController  passEntry = new TextEditingController();
  //para circular
  double _progress = 0;

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {
          if (_progress == 1) {
            timer.cancel();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuPrincipal())); //App
          } else {
            _progress += 0.25;
          }
        },
      ),
    );
  }


  //1
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Atras',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  //2
  Widget _entryField(String title, TextEditingController field, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: field,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  //3 clientes usuariosClientes)
  Widget _submitButton(List<Cliente> usuariosClientes) {
    return InkWell(
        onTap: () {
          setState(() {
            _progress = 0;
          });

          //AQUI VERIFICAR QUE ESTE EN LOS CLIENTES VALIDOS DEL JSON OJO
          if (keyForm.currentState.validate()) {
            var user = "${userEntry.text}";
            var pass = "${passEntry.text}";

            httpService.fetchLogin(http.Client(),user, pass).then((value)  => {
              validarUsuario(value)
            }).catchError((e) {
              enviarError(e);
              return 42;
            });
          }
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffbdbdbd), Color(0xff01579b)])),
      child:  Text(
        'Entrar', //ASI SE LLAMA EL BOTON ENTRAR EN LOGIN
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    )
    );
  }

  //4 UN o , PODRÍA SER UNA LINEA (TAMBIEN HABRIA QUE HACER UN WIDGET DE LINEA)
  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          CircularProgressIndicator(
            value: _progress,
          ),
          //Text('o'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  //5 EL FACE..
  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Entrar con Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  //6 NO TIENES CUENTA, ESTA ABAJITO DE ENTRAR CON FACE...
  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegistroUsuario()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No\'tienes una cuenta ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Registrarse',
              style: TextStyle(
                  color: Color(0xff01579b),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  //7 TITULO QUE DICE OFERTAS APP - INICIE SESION
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Ingrese sus datos',
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff01579b),
          ),
          children: [
            TextSpan(
              text: '',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '',
              style: TextStyle(color: Color(0xff01579b), fontSize: 30),
            ),
          ]),
    );
  }

  //8 LOGIN
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[

        new Form(
          key: keyForm,
          child: Column(
            children: <Widget>[
              _entryField("Correo/Username",userEntry),
              _entryField("Contrasena",passEntry, isPassword: true),
            ],
          )
        ),
      ],
    );
  }

  //9 AQUI LLAMA TODOS LOS ELEMENTOS DEL PAISAJE INICIO SESION
  @override
  Widget build(BuildContext context) {
    //var jsonData = '{"clientes":[{"id":13,"date_created":"2020-09-16T01:13:40","date_created_gmt":"2020-09-16T01:13:40","date_modified":null,"date_modified_gmt":null,"email":"baster2602@gmail.com","first_name":null,"last_name":null,"role":"customer","username":"baster2602","password":"123"},{"id":19,"date_created":"2020-09-17T21:59:22","date_created_gmt":"2020-09-17T21:59:22","date_modified":null,"date_modified_gmt":null,"email":"eligiovega16@gmail.com","first_name":null,"last_name":null,"role":"customer","username":"eligiovega16","password":"123"},{"id":12,"date_created":"2020-09-15T18:29:18","date_created_gmt":"2020-09-15T18:29:18","date_modified":null,"date_modified_gmt":null,"email":"machavez02@gmail.com","first_name":null,"last_name":null,"role":"customer","username":"machavez02","password":"123"}]}';
    //var parsedJson = json.decode(jsonData);
    //var usuariosClientes = clientes.fromJson(parsedJson);

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      //_submitButton(),
                      _submitButton(widget.client),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Olvidaste tu Clave?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      _divider(),
                      _facebookButton(),
                      SizedBox(height: height * .055),
                      _createAccountLabel()
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),);
  }//AQUI TERMINA BUILD

  validarUsuario(Usuario usuario){
    var _credencialesValidas = usuario != null
        ? true : false;
    if(_credencialesValidas){
      startTimer();
    }
  }

  enviarError(Exception e){
    // crear button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // configurar AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Falló inicio sesión"),
      content: Text("${e.toString()}"),
      actions: [
        okButton,
      ],
    );

    // mostrar el dialogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}