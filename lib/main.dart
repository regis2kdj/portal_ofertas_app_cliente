import 'package:flutter/material.dart';

//estilos para pantallas con google fonts
import 'package:google_fonts/google_fonts.dart';
import 'pantallas/Bienvenida.dart';

void main() {
  runApp(OfertasAppCliente());
}

class OfertasAppCliente extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Portal de Ofertas App Cliente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Bienvenida(),
    );
  }
}