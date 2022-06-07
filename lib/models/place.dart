import 'package:prueba_tecnica_desarrollo_digital/models/location.dart';

class Place {
  String name;
  String address;
  String description;
  LocationLatLng? location;
  String photo;
  String category;
  String rate;

  Place(
      {required this.name,
      required this.address,
      required this.description,
      required this.location,
      required this.photo,
      required this.category,
      required this.rate}) {}
}
