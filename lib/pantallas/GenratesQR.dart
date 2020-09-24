import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenratesQR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}class GeneratePageState extends State<GenratesQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR code'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.edit),
                trailing: FlatButton(
                  child: Text(
                    "GENERAR",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      dummyData = qrTextController.text == ""
                          ? null
                          : qrTextController.text;
                    });
                  },
                ),
                title: TextField(
                  controller: qrTextController,
                  decoration: InputDecoration(
                    hintText: "Coloque un texto",
                  ),
                ),
              ),
            ),
          ),
          (dummyData == null)
              ? Center(child: Text("Ingrese un texto para generar qr..."))
              : QrImage(
            embeddedImage: NetworkImage(
              "https://avatars1.githubusercontent.com/u/41328571?s=280&v=4",
            ),
            data: dummyData,
            gapless: true,
          ),
        ],
      ),
    );
  }
}String dummyData;TextEditingController qrTextController = TextEditingController();