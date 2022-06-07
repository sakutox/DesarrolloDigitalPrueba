import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/location.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/place.dart';

import '../../models/dataForPost.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

_textStyle(double size, Color color) {
  return TextStyle(fontFamily: 'AmazingSlabBold', fontSize: size, color: color);
}

_recuadro(double alto, double letra, double letra2, String imagen,
      String nombre, String categoria, Place datos, BuildContext context, 
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
              width: 300,
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
                    width: 280,
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
          ],
        ),
      ),
    ),
  );
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    List<Place> listaPlaces = [];
    DataForPost().dataForPost;

    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: FutureBuilder(
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

                return _CarouselBuilder(listaPlaces.length, listaPlaces, context);

              } else {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 5,
                ));
              }
            }));
  }

  _CarouselBuilder(int lenght, List<Place> items, BuildContext context) {
    return CarouselSlider.builder(
      itemCount: lenght,
      itemBuilder: (context, index, realIndex){
        
        return _recuadro(300, 15, 13, items[index].photo, items[index].name,items[index].category, items[index], context);
      },
      options: CarouselOptions(autoPlay: true),
    );
  }
}
