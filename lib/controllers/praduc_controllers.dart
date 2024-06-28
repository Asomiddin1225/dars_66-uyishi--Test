
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_66/models/praduc.dart';
import 'package:dars_66/services/praduct_firebase_services.dart';
import 'package:flutter/material.dart';

class PraductControllers extends ChangeNotifier {
  final _productsFirebase =PraductFirebase();
  final List<Praduct>_list=[];

  Stream<QuerySnapshot>get list{
    return _productsFirebase.getPraducts();
  }
  
}