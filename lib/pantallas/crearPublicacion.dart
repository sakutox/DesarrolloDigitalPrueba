import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba_tecnica_desarrollo_digital/models/publicacion.dart';

class CrearPublicacion extends StatefulWidget {
  CrearPublicacion({Key? key}) : super(key: key);

  @override
  State<CrearPublicacion> createState() => _CrearPublicacionState();
}

class _CrearPublicacionState extends State<CrearPublicacion> {
  final controladorNombreLugar = TextEditingController();
  final controladorDescripcion = TextEditingController();

  File? image;
  Publicacion publicacion = Publicacion();
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urlFirebase;

  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    uploadFile();
  }

  Future uploadFile() async {
    final path = 'files/my-image.jpg';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask=  ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete((){});

    final urlDownload = await snapshot.ref.getDownloadURL();
    urlFirebase = urlDownload;
    print('Download link: $urlDownload');
  }

  @override
  Widget build(BuildContext context) {
    final botonContinuar = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(3),
      color: const Color(0xFFF4F9FA),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          publicacion.descripcion = controladorDescripcion.text;
          publicacion.nombre = controladorNombreLugar.text;
          publicacion.imagen = urlFirebase;
          publicacion.createUser(publicacion);
          Navigator.of(context).popAndPushNamed('/');
        },
        child: const Text(
          "Crear Publicación",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color(0XFF033236),
              fontFamily: 'AmazingSlabBold'),
        ),
      ),
    );

    final campoLugar = Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          autofocus: false,
          controller: controladorNombreLugar,
          keyboardType: TextInputType.name,
          onSaved: (value) {
            controladorNombreLugar.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Nombre del lugar"),
        ));

    final campoDescripcion = Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          autofocus: false,
          minLines: 7,
          maxLines: 8,
          controller: controladorDescripcion,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) {
            controladorDescripcion.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: 'AmazingSlabBold', color: Color(0XFF033236)),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Descripcion"),
        ));

    _botonesListView(String titulo, double size, String asset) {
      return Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(3),
          color: Color(0xFFF4F9FA),
          child: MaterialButton(
            height: 30,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: 100,
            onPressed: () {
              publicacion.etiqueta = titulo;
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
                SizedBox(
                  width: 10,
                ),
                Image.asset(asset)
              ],
            ),
          ));
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  selectFile();
                },
                child: Container(
                    height: 200,
                    width: 300,
                    alignment: Alignment.center,
                    color: Color(0XFFe4e9eb),
                    child: pickedFile != null
                        ? Image.file(
                            File(pickedFile!.path!),
                            width: 300,
                            height: 200,
                            fit: BoxFit.fill,
                          )
                        : const Text(
                            "Agregar una imagen",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'AmazingSlabBold'),
                          )),
              ),
              SizedBox(height: 40),
              Container(width: 300, child: campoLugar),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _botonesListView(
                        "Hoteles", 10, "lib/assets/imagenes/cama.png"),
                    SizedBox(
                      width: 20,
                    ),
                    _botonesListView(
                        "Turístico", 10, "lib/assets/imagenes/arbol.png"),
                    SizedBox(
                      width: 20,
                    ),
                    _botonesListView("Restaurantes", 10,
                        "lib/assets/imagenes/mano_saludando.png")
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: campoDescripcion,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          Text("Calificación",
                              style: TextStyle(fontFamily: 'AmazingSlabBold')),
                          SizedBox(
                            width: 90,
                          ),
                          RatingBar.builder(
                            itemSize: 15,
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onRatingUpdate: (rating) {
                              publicacion.calificacion = rating;
                            },
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(width: 280, child: botonContinuar),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 10,
                      fixedSize: const Size(30, 30),
                      shape: const CircleBorder()),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Text(
                    "x",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
