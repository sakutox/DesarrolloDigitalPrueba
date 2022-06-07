import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/place.dart';

class PaginaDetalle extends StatelessWidget {
  //cambiar despues
  final Place data;

  const PaginaDetalle({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textStyle(double size, Color color) {
      return TextStyle(
          fontFamily: 'AmazingSlabBold', fontSize: size, color: color);
    }

    final botonCalificacion = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(3),
      color: Color(0xFFF4F9FA),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 100,
        onPressed: () {
          //funcion crear cuenta
          //signUp(emailController.text, passwordController.text);
        },
        child: Row(
          children: [
            Text(
              "Calificación",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0XFF033236),
                  fontFamily: 'AmazingSlabBold'),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset("lib/assets/imagenes/carita_estrella.png")
          ],
        ),
      ),
    );

    final botonComoLlegar = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(3),
      color: Color(0xFFF4F9FA),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 100,
        onPressed: () {
          //funcion para redirigir a mapa
          Navigator.of(context).pushNamed('/mapa', arguments: data);
        },
        child: Row(
          children: [
            Text(
              "Como llegar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0XFF033236),
                  fontFamily: 'AmazingSlabBold'),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset("lib/assets/imagenes/pin.png")
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //imagen
              Stack(children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),

                    //foto acá
                    child: Container(
                      width: 400,
                      height: 400,
                      child: Image.network(
                        data.photo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
                Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                    ))
              ]),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                child: Column(
                  children: [
                    //titulo acá
                    Container(
                      width: 300,
                      child: Text(
                        data.name,
                        textAlign: TextAlign.left,
                        style: _textStyle(32, Color(0XFF033236)),
                      ),
                    ),
                    //dirección
                    Container(
                      width: 300,
                      child: Text(
                        data.address,
                        textAlign: TextAlign.left,
                        style: _textStyle(20, Color(0XFFFCA772)),
                      ),
                    ),
                    //descripcion
                    Container(
                      width: 300,
                      child: Text(
                        data.description,
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: _textStyle(12, Color(0XFF033236)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        botonCalificacion,
                        SizedBox(
                          width: 30,
                        ),
                        botonComoLlegar,
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
