import 'package:shared_preferences/shared_preferences.dart';

class Sesion{
  SharedPreferences? sharedPreferences;

  Sesion({this.sharedPreferences});

  var sesion = SharedPreferences.getInstance();

  almacenarPreferencia(){
    
  }
}