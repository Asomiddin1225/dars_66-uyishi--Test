import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_66/controllers/test_controller.dart';
import 'package:dars_66/models/test.dart';
import 'package:dars_66/views/widgets/helpers.dart';
import 'package:dars_66/views/widgets/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  int _control1 = 0;
  int _control2 = 0;
  int _currentIndex = 0;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateControl(int control1, int control2) {
    setState(() {
      _control1 = control1;
      _control2 = control2;
    });
  }

  void _updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  void _resetState(int control1, int control2, int currentIndex) {
    setState(() {
      _control1 = control1;
      _control2 = control2;
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final testController = Provider.of<TestControllers>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Dars 66",
          style: TextStyle(
            color: Color.fromARGB(255, 243, 242, 240),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
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
              child: Text("Maxsulot mavjud emas"),
            );
          }

          final misollar = snapshot.data!.docs;
          if (_currentIndex >= misollar.length) {
            return UIComponents.buildResults(
              _control1,
              _control2,
              () => TestHelpers.restartTest(_resetState),
              () => Navigator.pop(context),
            );
          }

          final product = Test.fromMap(misollar[_currentIndex]);

          return UIComponents.buildTestQuestion(
            product,
            _textEditingController,
            () {
              TestHelpers.checkAnswer(_textEditingController.text,
                  product.javob, _control1, _control2, _updateControl);
              TestHelpers.nextQuestion(
                  context, _controller, _currentIndex, _updateIndex);
              _textEditingController.clear();
            },
            _offsetAnimation,
          );
        },
      ),
    );
  }
}
