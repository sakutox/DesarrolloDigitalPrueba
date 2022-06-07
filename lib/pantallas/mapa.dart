import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/place.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mapa extends StatelessWidget {
  final Place place;
  const Mapa({Key? key, required this.place}) : super(key: key);

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

    _textStyle(double size, Color color) {
      return TextStyle(
          fontFamily: 'AmazingSlabBold', fontSize: size, color: color);
    }

    Future<Position> getLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    }

    _tiempoEstimado(IconData icon, String etiqueta) {
      return Container(
        height: 50,
        width: 120,
        child: Stack(
          children: [
            Positioned(
                right: 20,
                child: Icon(
                  icon,
                  size: 15,
                )),
            Positioned(
              bottom: 15,
              child: Text(
                etiqueta,
                style: _textStyle(15, Color(0xff033236)),
              ),
            )
          ],
        ),
      );
    }

    _markerEtiqueta(LatLng posicion, String etiqueta) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: posicion,
        builder: (context) => Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Text(
                    etiqueta,
                    style: _textStyle(10, Color(0xff033236)),
                  )),
            ),
            Image.asset('lib/assets/imagenes/pin.png'),
          ],
        ),
      );
    }

    buildMapa(LatLng posicionUser, LatLng posicionLugar, String etiqueta) {
      return FlutterMap(
        options: MapOptions(
          center: posicionLugar,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              _markerEtiqueta(posicionUser, 'estas aqui'),
              _markerEtiqueta(posicionLugar, etiqueta)
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: 810,
              child: FutureBuilder<Position>(
                future: getLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildMapa(
                        LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        LatLng(place.location!.latitude,
                            place.location!.longitude),
                        place.name);
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ));
                    // return buildMapa(LatLng(8.101366, -73.131864),
                    //     LatLng(8.101366, -73.131864));
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                height: 170,
                width: 400,
                color: Colors.white,
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 360,
                          padding: EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: [
                              Text(
                                place.name,
                                style: _textStyle(35, Color(0xff033236)),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 40,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            width: 360,
                            padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.topLeft,
                            child: Text(place.address,
                                style: _textStyle(
                                  20,
                                  Color(0xffFCA772),
                                ))),
                        Container(
                          width: 360,
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _tiempoEstimado(
                                  FontAwesomeIcons.carSide, '20 minutos'),
                              _tiempoEstimado(
                                  FontAwesomeIcons.personWalking, '56 minutos')
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
