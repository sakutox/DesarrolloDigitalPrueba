import 'package:flutter/material.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/user.dart';

class RegistroCompleto extends StatelessWidget {
  final String data;
  RegistroCompleto({Key? key, required this.data}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final controladorNombreCompleto = TextEditingController();
  final controladorDireccion = TextEditingController();
  final controladorCorreo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _campos(TextEditingController controlador, String etiqueta) {
      return TextFormField(
        autofocus: false,
        controller: controlador,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          controladorNombreCompleto.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: etiqueta,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      );
    }

    final campoDireccion = TextFormField(
      autofocus: false,
      controller: controladorDireccion,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        controladorDireccion.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Dirección",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final botonContinuar = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(3),
      color: const Color(0xFFF4F9FA),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          var user = UserFirebase(
            correo: controladorCorreo.text,
            direccion: controladorDireccion.text,
            telefono: data,
            nombreCompleto: controladorNombreCompleto.text,
          );

          user.createUser(user);
          Navigator.of(context).pushNamed('/');
        },
        child: const Text(
          "Continuar",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color(0XFF033236),
              fontFamily: 'AmazingSlabBold'),
        ),
      ),
    );

    final campoCorreo = TextFormField(
      autofocus: false,
      controller: controladorCorreo,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Porfavor ingresa un correo");
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Porfavor ingresa un correo valido");
        }
        return null;
      },
      onSaved: (value) {
        controladorCorreo.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1000,
              child: Image.asset(
                "lib/assets/imagenes/borde_superior.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                children: [
                  const Text(
                    "Lugareños",
                    style:
                        TextStyle(fontFamily: 'AmazingSlabBold', fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Completa los siguientes campos para iniciar",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontFamily: 'AmazingSlabBold', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _campos(controladorNombreCompleto, "Nombre completo"),
                      const SizedBox(
                        height: 30,
                      ),
                      campoCorreo,
                      const SizedBox(
                        height: 30,
                      ),
                      campoDireccion,
                      const SizedBox(
                        height: 30,
                      ),
                      botonContinuar,
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ))
                ],
              ),
            ),
            Container(
             width: 1000,
              child: Image.asset("lib/assets/imagenes/borde_inferior.png",
                  fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
