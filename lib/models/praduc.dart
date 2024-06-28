import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Praduct extends ChangeNotifier {
  final String id;
  String title;
  num price;
  Color color;

  Praduct({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
  });

  factory Praduct.fromMap(QueryDocumentSnapshot map) {
    return Praduct(
        id: map.id,
        title: map["title"],
        price: map["price"],
        color: Color(map["color"]));
  }
}
