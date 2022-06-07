import 'package:flutter/material.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/dataForPost.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/location.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/place.dart';

class ParteMediaPantallaPrincipal extends StatefulWidget {
  ParteMediaPantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<ParteMediaPantallaPrincipal> createState() =>
      _ParteMediaPantallaPrincipalState();
}

class _ParteMediaPantallaPrincipalState
    extends State<ParteMediaPantallaPrincipal> {
  
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

  _recuadro(double alto, double letra, double letra2, String imagen,
      String nombre, String categoria, Place datos,
      [double paddingOpc = 0]) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detalles',
          arguments: datos,
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: paddingOpc),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              //imagen del sitio
              Container(
                width: 150,
                height: alto,
                child: Image.network(imagen, fit: BoxFit.cover),
              ),
              //Texto descripción de la imagen acá
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 130,
                      color: Colors.white70,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: _textStyle(letra, Color(0xFF033236)),
                          ),
                          Text(categoria,
                              style: _textStyle(letra2, Color(0xFFFCA772)))
                        ],
                      ),
                    ),
                  )),
              //icono corazon acá
              Positioned(top: 10, right: 10, child: Icon(Icons.favorite_border))
            ],
          ),
        ),
      ),
    );
  }

  _recuadro2(String imagen, String nombre, String categoria, Place datos) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detalles',
          arguments: datos,
        );
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              //imagen del sitio
              Container(
                width: 170,
                height: 390,
                child: Image.network(imagen, fit: BoxFit.cover),
              ),
              //Texto descripción de la imagen acá
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      color: Colors.white70,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: _textStyle(14, Color(0xFF033236)),
                          ),
                          Text(categoria,
                              style: _textStyle(10, Color(0xFFFCA772)))
                        ],
                      ),
                    ),
                  )),
              //icono corazon acá
              Positioned(top: 10, right: 10, child: Icon(Icons.favorite_border))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Place> listaPlaces = [];
    DataForPost().dataForPost;

    return Container(
      padding: EdgeInsets.only(left: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 60,
              width: 300,
              padding: EdgeInsets.only(top: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _botonesListView(
                      "Hoteles", 10, "lib/assets/imagenes/cama.png"),
                  SizedBox(
                    width: 20,
                  ),
                  _botonesListView("Calificación", 10,
                      "lib/assets/imagenes/carita_estrella.png"),
                  SizedBox(
                    width: 20,
                  ),
                  _botonesListView(
                      "Ubicación", 10, "lib/assets/imagenes/mano_saludando.png")
                ],
              ),
            ),
            SizedBox(height: 20,),
          Text("Lugares", style: _textStyle(21, Color(0xFF033236))),
          Text("Destacados", style: _textStyle(21, Color(0xFF033236))),
          SizedBox(height: 20),
          FutureBuilder(
              future: DataForPost().dataForPost,
              builder: (BuildContext context, AsyncSnapshot response) {
                
                if (response.hasData) {
                  for (var i = 0; i < 12; i++) {
                    listaPlaces.add(Place(
                        name: response.data[i]['name'],
                        address: response.data[i]['address'],
                        description: response.data[i]['description'],
                        location: LocationLatLng(
                            latitude: response.data[0]['location']['_latitude'],
                            longitude: response.data[0]['location']
                                ['_longitude']),
                        photo: response.data[i]['photo'],
                        category: response.data[i]['category'],
                        rate: response.data[i]['rate'].toString()));
                  }
                  return response.data.isNotEmpty
                      ? Row(
                          children: [
                            _recuadro2(
                                listaPlaces[0].photo,
                                listaPlaces[0].name,
                                listaPlaces[0].category,
                                listaPlaces[0]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _recuadro(
                                    185,
                                    10,
                                    8,
                                    listaPlaces[1].photo,
                                    listaPlaces[1].name,
                                    listaPlaces[1].category,
                                    listaPlaces[1],
                                    15),
                                _recuadro(
                                    190,
                                    10,
                                    8,
                                    listaPlaces[2].photo,
                                    listaPlaces[2].name,
                                    listaPlaces[2].category,
                                    listaPlaces[2])
                              ],
                            )
                          ],
                        )
                      : Center(child: Text("No data"));
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ));
                }
              }),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 10,
                  fixedSize: const Size(30, 30),
                  shape: const CircleBorder()),
              onPressed: () {
                Navigator.of(context).pushNamed('/crearPublicacion');
              },
              child: Text(
                "+",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
