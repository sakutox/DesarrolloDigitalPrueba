import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IngresoTelefono extends StatefulWidget {
  IngresoTelefono({Key? key}) : super(key: key);

  @override
  State<IngresoTelefono> createState() => _IngresoTelefonoState();
}

class _IngresoTelefonoState extends State<IngresoTelefono> {
  //controladores
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final controladorTelefono = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore instanciaFireBase = FirebaseFirestore.instance;
  UserFirebase userFirebase = UserFirebase();
  List<UserFirebase> listaUsers = [];

  @override
  Widget build(BuildContext context) {
    var prefs = SharedPreferences.getInstance();

    Future<void> _handleSignIn() async {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    }

    ingresar(String numeroTelefono) async {
      final SharedPreferences prefs = await _prefs;
      listaUsers = await userFirebase.getUsers();
      var boleano = false;

      for (var i = 0; i < listaUsers.length; i++) {
        if (listaUsers[i].telefono == numeroTelefono) {
          boleano = true;
        }
      }

      if (boleano) {
        Fluttertoast.showToast(msg: 'Usuario logeado con telefono');
        Navigator.of(context).pushNamed('/');
      } else {
        prefs.setBool('sesion_iniciada', true);
        Fluttertoast.showToast(
            msg: 'No existe un usuario registrado con este numero de telefono');
        Navigator.of(context)
            .pushNamed('/registrar', arguments: numeroTelefono);
      }
    }

    final campoTelefono = TextFormField(
      autofocus: false,
      controller: controladorTelefono,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        controladorTelefono.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "+",
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
          ingresar(controladorTelefono.text);
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
                  Stack(children: [
                    const Text(
                      "lugareños",
                      style: TextStyle(
                          fontFamily: 'AmazingSlabBold', fontSize: 30),
                    ),
                    const Positioned(
                        top: 10,
                        left: 69,
                        child: Icon(
                          Icons.favorite_border,
                          size: 8,
                          color: Color(0XFFFCA772),
                        ))
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Ingresa tu numero de teléfono",
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
                      campoTelefono,
                      const SizedBox(
                        height: 30,
                      ),
                      botonContinuar,
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "También puedes con",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'AmazingSlabBold', fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 400,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.facebook,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            InkWell(
                              onTap: (){
                                _handleSignIn();
                              },
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.red[300],
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 100,
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
