import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dars_66/controllers/test_controller.dart';
import 'package:dars_66/models/test.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testController = Provider.of<TestControllers>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Color.fromARGB(255, 243, 242, 240),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  // size: 25,
                ),
                onPressed: () {
                  _showAddEditDialog(context, testController);
                },
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: testController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No data available"),
            );
          }

          final misollar = snapshot.data!.docs;

          return ListView.builder(
            itemCount: misollar.length,
            itemBuilder: (context, index) {
              final product = Test.fromMap(misollar[index]);
              return ListTile(
                title: Text(product.misol),
                subtitle: Text(product.javob),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showAddEditDialog(context, testController, product);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteProduct(product.id, testController);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, TestControllers testController,
      [Test? product]) {
    final TextEditingController misolController = TextEditingController(
      text: product?.misol ?? '',
    );
    final TextEditingController javobController = TextEditingController(
      text: product?.javob ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            product == null ? "Yangi Savol Qo'shish" : "Savol ni O'zgartirish"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: misolController,
              decoration: InputDecoration(labelText: 'Misol'),
            ),
            TextField(
              controller: javobController,
              decoration: InputDecoration(labelText: 'Javob'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Bekor Qilish"),
          ),
          ElevatedButton(
            onPressed: () {
              if (product == null) {
                _addProduct(
                  misolController.text,
                  javobController.text,
                  testController,
                );
              } else {
                _editProduct(
                  product.id,
                  misolController.text,
                  javobController.text,
                  testController,
                );
              }
              Navigator.pop(context);
            },
            child: Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  void _addProduct(String misol, String javob, TestControllers testController) {
    final newProduct = Test(
      id: FirebaseFirestore.instance.collection('test').doc().id,
      misol: misol,
      javob: javob,
    );
    testController.addProduct(newProduct);
  }

  void _editProduct(
      String id, String misol, String javob, TestControllers testController) {
    final updatedProduct = Test(
      id: id,
      misol: misol,
      javob: javob,
    );
    testController.updateProduct(updatedProduct);
  }

  void _deleteProduct(String id, TestControllers testController) {
    testController.deleteProduct(id);
  }
}
