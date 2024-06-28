import 'package:flutter/material.dart';

import 'package:dars_66/models/test.dart';

class UIComponents {
  static Widget buildTestQuestion(
    Test product,
    TextEditingController textEditingController,
    Function() onConfirm,
    Animation<Offset> offsetAnimation,
  ) {
    return SlideTransition(
      position: offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.misol,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Javobingizni kiriting',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onConfirm,
              child: Text('Tasdiqlash',
                  style: TextStyle(fontSize: 30, color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildResults(
      int control1, int control2, Function() onRestart, Function() onHome) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Text(
                  "To'g'ri Javoblar: $control1",
                  style: TextStyle(fontSize: 38, color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: Text(
                  "Not'g'ri Javoblar: $control2",
                  style: TextStyle(fontSize: 38, color: Colors.white),
                )),
          ),
          ElevatedButton(
            onPressed: onRestart,
            child: Text(
              'Restart',
              style: TextStyle(fontSize: 38, color: Colors.red),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: onHome,
            child: Text(
              'Home',
              style: TextStyle(fontSize: 38, color: Colors.yellow[800]),
            ),
          ),
        ],
      ),
    );
  }
}
