import 'package:flutter/material.dart';
import 'package:prueba_tecnica_desarrollo_digital/main.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/place.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/crearPublicacion.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/ingresoTelefono.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/mapa.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/paginaDetalle.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/pantallaPrincipal.dart';
import 'package:prueba_tecnica_desarrollo_digital/pantallas/registroCompleto.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PantallaPrincipal());
      case '/detalles':
        if (args is Place) {
          return MaterialPageRoute(builder: (_) => PaginaDetalle(data: args));
        }
        return _errorRoute();
      case '/iniciarSesion':
        return MaterialPageRoute(builder: (_) => IngresoTelefono());
      case '/registrar':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => RegistroCompleto(data: args));
        } else {
          return _errorRoute();
        }
      case '/crearPublicacion':
        return MaterialPageRoute(builder: (_) => CrearPublicacion());
      case '/mapa':
        if (args is Place) {
          return MaterialPageRoute(builder: (_) => Mapa(place: args));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
