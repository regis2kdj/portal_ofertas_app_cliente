import 'package:flutter/material.dart';
import 'widget/BezierContainer.dart';
import 'package:portal_ofertas_app_cliente/pantallas/MenuPrincipal.dart';
import 'package:portal_ofertas_app_cliente/pantallas/app.dart';
import 'package:portal_ofertas_app_cliente/pantallas/last_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:portal_ofertas_app_cliente/pantallas/GenratesQR.dart';

class CrearQR extends StatefulWidget {
  CrearQR({Key key, this.title, this.idOrden}) : super(key: key);

  final String title;
  final int idOrden;

  @override
  _CrearQRState createState() => _CrearQRState();
}

class _CrearQRState extends State<CrearQR> {
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


  Widget _submitButton() {
    return InkWell(
      onTap: () {
        //ACCION DE CALIFICAR LA COMPRA
        Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
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
        child: Text(
          'Califique su compra!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _subtitle() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Para redimir su oferta, espere a que el comercio lea el código generado',
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            )
        )
    );
  }

  Widget _buttonsMenu_CreateQR() {
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
                onTap: () => {
                  //ACCION DE CREAR CODIGO QR
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenratesQR()))
                },
                child: QrImage(
                  data: widget.idOrden.toString(),
                  version: QrVersions.auto,
                  size: 320,
                  gapless: false,
                )
              ),
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
                    _subtitle(),
                    SizedBox(
                      height: 10,
                    ),

                    _buttonsMenu_CreateQR(),

                    SizedBox(
                      height: 5,
                    ),
                    _submitButton(), //boton submit
                    SizedBox(height: height * .14),
                  ],
                ),
              ),
            ),
            Positioned(top: 20, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}