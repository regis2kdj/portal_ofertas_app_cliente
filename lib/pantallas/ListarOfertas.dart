import 'package:flutter/material.dart';
import 'widget/BezierContainer.dart';
import 'package:portal_ofertas_app_cliente/pantallas/MenuPrincipal.dart';
import 'package:portal_ofertas_app_cliente/service/HttpService.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:portal_ofertas_app_cliente/model/Oferta.dart';

class ListarOfertas extends StatefulWidget {
  ListarOfertas({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListarOfertasState createState() => _ListarOfertasState();
}

class _ListarOfertasState extends State<ListarOfertas> {
  //servicio
  HttpService httpService = HttpService();

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
        //ACCION DE LISTAR TODAS LAS OFERTAS
        //Navigator.push(context, MaterialPageRoute(builder: (context) => VerOferta()))
      },

      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
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
          'Listar todas las Ofertas',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  Widget _title() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Ofertas App - Listar Ofertas',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme
                  .of(context)
                  .textTheme
                  .display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff01579b),
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de todas las Ofertas"),
      ),
      body: FutureBuilder<List<Oferta>>(
        future: httpService.fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Oferta> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              FadeInImage.assetNetwork(
                  placeholder: 'placeholder.svg',
                  image: "${photos[index].images.first.src}",
                  width: 60.0
              ),
              SizedBox(
                height: 5,
              ),
              Text("id: "+photos[index].id.toString()+" producto: "+photos[index].name,
                  style: Theme.of(context).textTheme.title),
              Text("precio regular: "+photos[index].regularPrice+" / oferta: "+photos[index].price,
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
        //return Image.network(photos[index].images.first.src);
      },
    );
  }
}
