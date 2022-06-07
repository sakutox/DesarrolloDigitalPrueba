import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Publicacion{
  String? nombre;
  String? descripcion;
  String? etiqueta;
  double? calificacion;
  String? imagen;
  String? uid;

  Publicacion({this.nombre, this.descripcion, this.etiqueta, this.calificacion, this.imagen, this.uid});

  var collection = FirebaseFirestore.instance.collection('publicaciones');

  createUser(Publicacion publicacion) async {

    var queryDocumentSnapshot = await collection.doc();
    publicacion.uid = queryDocumentSnapshot.id;
    await queryDocumentSnapshot.set(publicacion.toJson());
    Fluttertoast.showToast(msg: 'Publicacion creada satisfactoriamente');
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreLugar': nombre,
      'descripcion': descripcion,
      'categoria': etiqueta,
      'calificacion': calificacion,
      'imagen': imagen,
      'uid': uid
    };
  }
}