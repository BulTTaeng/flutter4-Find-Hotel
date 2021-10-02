
import 'package:flutter/foundation.dart';

class Product {
  const Product({
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.location,
    @required this.star,
    @required this.phone,
    @required this.explain,
  })  : assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(location != null),
        assert(star != null),
        assert(phone != null),
        assert(explain  != null);

  final int id;
  final bool isFeatured;
  final String name;
  final String location;
  final int star;
  final String phone;
  final String explain;

  String get assetName => 'images/$id-0.jpg';


  @override
  String toString() => "$name (id=$id)";
}
