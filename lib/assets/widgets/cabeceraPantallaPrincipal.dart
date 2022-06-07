import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CabeceraPantallaPrincipal extends StatefulWidget {
  CabeceraPantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<CabeceraPantallaPrincipal> createState() =>
      _CabeceraPantallaPrincipalState();
}

class _CabeceraPantallaPrincipalState extends State<CabeceraPantallaPrincipal> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _sesion;

  Future<void> getSesion() async {
    final SharedPreferences prefs = await _prefs;
    final bool sesion = prefs.getBool('iniciar_sesion') ?? false;

    setState(() {
      _sesion = prefs.setBool('iniciar_sesion', sesion).then((bool success) {
        return sesion;
      });
    });
  }

  @override
  void initState() {
    _sesion = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('iniciar_sesion') ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
        child: Container(
          color: Color(0xffebf4f7),
          width: 400,
          height: 420,
          padding: EdgeInsets.only(top: 25, left: 30),
          child: Column(
            children: [
              // Menu y Boton de iniciar sesion
              Row(
                children: [
                  Icon(Icons.menu_open),
                  SizedBox(
                    width: 215,
                  ),
                  FutureBuilder(
                    future: _sesion,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.data == false
                          ? SizedBox(
                              width: 100,
                              height: 30,
                              child: FloatingActionButton(
                                elevation: 0,
                                backgroundColor: Color(0xFFFCA772),
                                onPressed: () {},
                                child: InkWell(
                                  onTap: () {
                                    print('presionado');
                                    Navigator.of(context)
                                        .pushNamed('/iniciarSesion');
                                  },
                                  child: const Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                        fontFamily: 'AmazingSlabBold',
                                        fontSize: 10),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            )
                          : const SizedBox(
                              width: 100,
                              height: 30,
                              child: Text('logeado'),
                            );
                    },
                  ),
                ],
              ),

              // Texto grande con mano saludando
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    width: 200,
                    child: Stack(children: [
                      Text(
                        "Encuentra los mejores lugares de La ciudad",
                        style: TextStyle(
                            fontFamily: 'AmazingSlabBold', fontSize: 32),
                      ),
                      Positioned(
                          bottom: 13,
                          right: 10,
                          child: Container(
                            child: Image.asset(
                                "lib/assets/imagenes/mano_saludando.png"),
                          ))
                    ]),
                  )
                ],
              ),
              // Que estas buscando hoy (texto)
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Que estas buscando hoy?",
                  style: TextStyle(fontFamily: 'AmazingSlabBold', fontSize: 16),
                ),
              ),
              // Barra de busqueda
              Container(
                width: 300,
                child: TextFormField(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
