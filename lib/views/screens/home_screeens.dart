import 'package:dars_66/controllers/praduc_controllers.dart';
import 'package:dars_66/models/praduc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final praductControllers = context.watch<PraductControllers>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Dars 66",
          style: TextStyle(
              color: const Color.fromARGB(255, 243, 242, 240), fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: praductControllers.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data == null) {
            return Center(
              child: Text("Maxsulod mavjud emas "),
            );
          }

          final products = snapshot.data!.docs;
          print(products[0]['title']);



          return ListView.builder(
           itemCount: products.length,
            itemBuilder: (context, index) {
              final product =Praduct.fromMap(products[index]);
              return ListTile(leading: CircleAvatar(
                backgroundColor: product.color,

              ),
              title: Text(product.title),
              subtitle: Text("\$${product.price}"),);
            },
          );
        },
      ),
    );
  }
}
