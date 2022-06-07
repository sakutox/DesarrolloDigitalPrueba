import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserFirebase {
  String? uid;
  String? nombreCompleto;
  String? correo;
  String? direccion;
  String? telefono;

  UserFirebase(
      {this.uid,
      this.nombreCompleto,
      this.correo,
      this.direccion,
      this.telefono});

  var collection = FirebaseFirestore.instance.collection('users');

  getUsers() async {
    List<UserFirebase> users = [];
 
    var querySnapshot = await collection.get();

    for (var queryDocumentSnaphot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnaphot.data();
      users.add(UserFirebase(
          uid: data['uid'],
          correo: data['correo'],
          direccion: data['direccion'],
          nombreCompleto: data['nombreCompleto'],
          telefono: data['telefono']));
    }
    
    return users;
  }

  createUser(UserFirebase user) async {

    var queryDocumentSnapshot = await collection.doc();
    user.uid = queryDocumentSnapshot.id;
    await queryDocumentSnapshot.set(user.toJson());
    Fluttertoast.showToast(msg: 'Cuenta creada satisfactoriamente');
  }



  factory UserFirebase.fromJson(Map<String, dynamic> map) {
    return UserFirebase(
        uid: map['uid'],
        nombreCompleto: map['nombreCompleto'],
        correo: map['correo'],
        direccion: map['direccion'],
        telefono: map['telefono']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nombreCompleto': nombreCompleto,
      'correo': correo,
      'direccion': direccion,
      'telefono': telefono
    };
  }
}
