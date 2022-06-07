import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CrearPublicacion extends StatefulWidget {
  CrearPublicacion({Key? key}) : super(key: key);

  @override
  State<CrearPublicacion> createState() => _CrearPublicacionState();
}

class _CrearPublicacionState extends State<CrearPublicacion> {
  final controladorNombreLugar = TextEditingController();
  final controladorDescripcion = TextEditingController();

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
          // var user = UserFirebase(
          //   correo: controladorCorreo.text,
          //   direccion: controladorDireccion.text,
          //   telefono: data,
          //   nombreCompleto: controladorNombreCompleto.text,
          // );

          // user.createUser(user);
          Navigator.of(context).pushNamed('/');
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
          keyboardType: TextInputType.number,
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
                onTap: () {},
                child: Container(
                  height: 200,
                  width: 300,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(30),
                  color: Color(0XFFe4e9eb),
                  child: const Text(
                    "Agregar una imagen",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'AmazingSlabBold'),
                  ),
                ),
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
                              print(rating);
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
