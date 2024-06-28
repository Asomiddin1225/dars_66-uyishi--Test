import 'package:dars_66/views/screens/test_screens.dart';
import 'package:dars_66/views/widgets/admin_screen.dart';
import 'package:flutter/material.dart';


class TestHome extends StatelessWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 45, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestScreen()),
                );
              },
              child: Text(
                'Boshlash',
                style: TextStyle(fontSize: 48, color: Colors.green),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text(
                'Admin',
                style: TextStyle(
                    fontSize: 48, color: Color.fromARGB(255, 15, 3, 123)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
