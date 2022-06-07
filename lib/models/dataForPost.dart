import 'dart:convert';
import 'package:http/http.dart' as http;

class DataForPost {
  static final DataForPost _instance = DataForPost._privado();

  DataForPost._privado();

  factory DataForPost() {
    return _instance;
  }

  Future<List<dynamic>> get dataForPost async {

    final response = await http.get(Uri.parse(
        "https://us-central1-domi-test-d4e69.cloudfunctions.net/getPlacesTest"));

    Map<String, dynamic> places = json.decode(response.body);

    List<dynamic> data = places["places"];
    
    return data;
  }
}
