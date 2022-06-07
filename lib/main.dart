import 'package:flutter/material.dart';
import 'package:prueba_tecnica_desarrollo_digital/assets/routes/route_generator.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/crearPublicacion.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/ingresoTelefono.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/paginaDetalle.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/pantallaPrincipal.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/registroCompleto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
