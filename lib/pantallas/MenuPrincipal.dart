import 'package:flutter/material.dart';
import 'widget/BezierContainer.dart';
import 'package:portal_ofertas_app_cliente/pantallas/InicioSesion.dart';
import 'package:portal_ofertas_app_cliente/pantallas/RegistroUsuario.dart';
import 'package:portal_ofertas_app_cliente/pantallas/BuscarOferta.dart';
import 'package:portal_ofertas_app_cliente/pantallas/ComprarOferta.dart';
import 'package:portal_ofertas_app_cliente/pantallas/ListarOfertas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class MenuPrincipal extends StatefulWidget {
  MenuPrincipal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {

  double _progress = 0;

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {
          if (_progress == 1) {
            timer.cancel();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => InicioSesion()));
          } else {
            _progress += 0.25;
          }
        },
      ),
    );
  }

  Widget _exitButton() {
    return InkWell(
      onTap: () {

        setState(() {
          _progress = 0;
        });

        startTimer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 2, top: 10, bottom: 10),
              child: Image.asset("images/exit.png", width: 25, height: 25, fit: BoxFit.cover),
            ),
            SizedBox(
              width: 10,
            ),
            Text('salir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

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

  Widget _entryField(String title, {bool isPassword = false}) {
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
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
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
      child: Text(
        'Registrarse Ya',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }


  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Portal de Ofertas',
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff01579b),
          )
      )
    );
  }

  /*Widget _buttonsMenu_CreateQR() {
    return InkWell(

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              // needed
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegistroUsuario())), // needed
                child: Image.asset(
                  "images/register.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Crear cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buttonsMenu_Find() {
    return InkWell(

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              // needed
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BuscarOferta())), // needed
                child: Image.asset(
                  "images/find.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Buscar Oferta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  /*Widget _buttonsMenu_BuyOffer() {
    return InkWell(

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              // needed
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ComprarOferta())), // needed
                child: Image.asset(
                  "images/buy_offer_icon.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Nueva Oferta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }*/


  Widget _buttonsMenu_ListAll() {
    return InkWell(

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              // needed
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ListarOfertas())), // needed
                child: Image.asset(
                  "images/list_all.png",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Listar Todas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 20,
                    ),

                    _divider(),

                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //_buttonsMenu_CreateQR(),
                        //_buttonsMenu_Find(),
                      ],
                    ),

                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buttonsMenu_Find(),
                        //_buttonsMenu_BuyOffer(),
                        _buttonsMenu_ListAll(),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                   // _submitButton(), //boton submit
                    SizedBox(height: height * .14),
                  ],
                ),
              ),
            ),
            Positioned(top: 30, left: 0, child: _exitButton()),
          ],
        ),
      ),
    );
  }
}