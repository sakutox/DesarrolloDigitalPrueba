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
    
    _botonesListView(String titulo, double size, String asset) {
      return Material(
          borderRadius: BorderRadius.circular(3),
          color: Color(0xffebf4f7),
          child: MaterialButton(
            minWidth: 100,
            onPressed: () {
              //funcion crear cuenta
              //signUp(emailController.text, passwordController.text);
            },
            child: Row(
              children: [
                Text(
                  titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size,
                      color: Color(0XFF033236),
                      fontFamily: 'AmazingSlabBold'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(asset)
              ],
            ),
          ));
    }

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
