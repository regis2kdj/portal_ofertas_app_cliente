import 'package:flutter/material.dart';
import 'widget/BezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:portal_ofertas_app_cliente/model/ProductoOferta.dart';
import 'package:portal_ofertas_app_cliente/pantallas/CrearQR.dart';
import 'package:portal_ofertas_app_cliente/service/HttpService.dart';


  class VerOferta extends StatefulWidget {
    final DatosApp datosApp;

    VerOferta({Key key, this.title, @required this.datosApp}) : super(key: key);
  //  VerOferta({Key key, this.title, @required ofertaID}) : super(key: key);

  final String title;

   @override
  _VerOfertaState createState() => _VerOfertaState(datosApp);

}
class _VerOfertaState extends State<VerOferta> {
  //servicio
  HttpService httpService = HttpService();

  //orden de producto
  int idOrden;

  final DatosApp datosApp;

  _VerOfertaState(this.datosApp);

  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController  numOferta = new TextEditingController();

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


  Widget _title() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Detalle de la Oferta',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff01579b),
            )
        )
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CrearQR(idOrden : idOrden)));
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
          'Crear QR',
          style: TextStyle(fontSize: 20, color: Colors.white),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _title(),
                  SizedBox(
                    height: 10,
                  ),
                  Center (
                    child: FutureBuilder<ProductoOferta>(
                        future: httpService.obtenerProducto(datosApp.idOferta),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) { //checks if the response returns valid data
                            idOrden = snapshot.data.id;
                            return Center(
                              child: Column(
                                children: <Widget>[

                                  SizedBox(
                                    height: 30,
                                  ),

                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: '#Orden : ${datosApp.idOferta}',
                                          style: GoogleFonts.portLligatSans(
                                            textStyle: Theme.of(context).textTheme.display1,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff01579b),
                                          )
                                      )
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Oferta: ${snapshot.data.id}"),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("Descripción de la oferta: ${clearDesc(snapshot.data.lineItems.first.name)}",style: Theme.of(context).textTheme.title),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Precio SubTotal: ${snapshot.data.lineItems.first.subtotal}",style: Theme.of(context).textTheme.title),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Precio Total: ${snapshot.data.lineItems.first.total}",style: Theme.of(context).textTheme.title),

                                  SizedBox(
                                    height: 5,
                                  ),

                                  Text("Fecha creación: ${DateFormat("MM/dd/yyyy").format(DateTime.parse(snapshot.data.dateCreated)).toString()}",style: Theme.of(context).textTheme.title),
                                  Text("Estado: ${snapshot.data.status}",style: Theme.of(context).textTheme.title),

                                  SizedBox(
                                    height: 30,
                                  ),

                                  _submitButton(),

                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("${snapshot.error}",
                                    style: Theme.of(context).textTheme.title),
                                  ],
                                ),
                              );
                          }
                          return CircularProgressIndicator();
                        }
                    ),
                  ),
                ]
              )
            ),

                  SizedBox(height: height * .14),

            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}