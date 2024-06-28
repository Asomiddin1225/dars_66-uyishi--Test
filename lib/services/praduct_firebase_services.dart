import 'package:cloud_firestore/cloud_firestore.dart';

class PraductFirebase {
  final _productCollection = FirebaseFirestore.instance.collection("products");


 Stream<QuerySnapshot> getPraducts ()async*{
  yield* _productCollection.snapshots();

 }

}