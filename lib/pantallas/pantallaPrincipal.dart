import 'package:flutter/material.dart';
import 'package:prueba_tecnica_desarrollo_digital/assets/widgets/Carousel.dart';
import 'package:prueba_tecnica_desarrollo_digital/assets/widgets/cabeceraPantallaPrincipal.dart';
import 'package:prueba_tecnica_desarrollo_digital/assets/widgets/parteMediaPantallaPrincipal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaPrincipal extends StatefulWidget {
  PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CabeceraPantallaPrincipal(),
            ParteMediaPantallaPrincipal(),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 30),
              child: Text("Más lugares",
                  style:
                      TextStyle(fontFamily: 'AmazingSlabBold', fontSize: 25)),
            ),
            Carousel()
          ],
        ),
      ),
    );
  }
}
